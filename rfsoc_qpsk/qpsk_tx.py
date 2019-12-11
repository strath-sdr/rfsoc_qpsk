from pynq import DefaultIP
from pynq import DefaultHierarchy
from pynq import Xlnk
import numpy as np


class QPSKTx(DefaultHierarchy):
    def __init__(self, description, pkt_sym=16, pkt_time=128, pkt_fft=1024):
        """Driver for our QPSK TX IP hierarchy

        This encompasses the qpsk tx logic and the DMAs for data
        transfer of exposed signals.
        """

        super().__init__(description)

        xlnk = Xlnk()
        self.buf_fft = xlnk.cma_array(shape=(pkt_fft, ), dtype=np.uint32)
        self.buf_sym = xlnk.cma_array(shape=(pkt_sym, ), dtype=np.uint8)
        self.buf_time = xlnk.cma_array(shape=(pkt_time * 2, ), dtype=np.int16)

        # QPSK IP General Config
        self.qpsk_tx.lfsr_rst = 1
        self.qpsk_tx.enable = 1
        self.qpsk_tx.packetsize_rf = 1024
        self.set_gain(1)
        self.qpsk_tx.lfsr_rst = 0

        # QPSK IP Symbol Config
        self.qpsk_tx.reset_symbol = 1
        self.qpsk_tx.packetsize_symbol = pkt_sym - 1
        self.qpsk_tx.reset_symbol = 0
        self.qpsk_tx.autorestart_symbol = 0

        # QPSK IP FFT Config
        self.qpsk_tx.reset_fft = 1
        self.qpsk_tx.packetsize_fft = pkt_fft - 1
        self.qpsk_tx.reset_fft = 0
        self.qpsk_tx.autorestart_fft = 0

        ## QPSK IP Time Config
        self.qpsk_tx.reset_time = 1
        self.qpsk_tx.packetsize_time = pkt_time - 1
        self.qpsk_tx.reset_time = 0
        self.qpsk_tx.autorestart_time = 0

    def set_gain(self, normalized_gain):
        scaling_factor = 0.65
        gain = np.uint32( round(normalized_gain * scaling_factor * (2**32 - 1)) )
        self.qpsk_tx.mmio.array[44>>2] = gain

    def get_shaped_fft(self):
        """Get a single buffer of FFT data from the pulse shaped signal
        """
        self.qpsk_tx.transfer_fft = 1
        self.dma_tx_fft.recvchannel.transfer(self.buf_fft)
        self.dma_tx_fft.recvchannel.wait()
        self.qpsk_tx.transfer_fft = 0
        return np.array(self.buf_fft)

    def get_shaped_time(self):
        """Get a single buffer of time domain data from the pulse shaped signal
        """
        self.qpsk_tx.transfer_time = 1
        self.dma_tx_time.recvchannel.transfer(self.buf_time)
        self.dma_tx_time.recvchannel.wait()
        self.qpsk_tx.transfer_time = 0
        t_data = np.array(self.buf_time)
        c_data = t_data[::2] + 1j * t_data[1::2]
        return c_data

    def get_many_shaped_time(self, N=10):
        """Get N buffers of time domain data from the pulse shaped signal
        """
        return np.concatenate([self.get_shaped_time() for i in range(N)])

    def get_symbols(self):
        """Get a single buffer of raw QPSK symbols
        """

        def raw_to_i(raw):
            i = raw & 0b0011
            if i == 3:
                return -1
            else:
                return 1

        def raw_to_q(raw):
            i = (raw & 0b1100) >> 2
            if i == 3:
                return -1
            else:
                return 1

        self.qpsk_tx.transfer_symbol = 1
        self.dma_tx_symbol.recvchannel.transfer(self.buf_sym)
        self.dma_tx_symbol.recvchannel.wait()
        self.qpsk_tx.transfer_symbol = 0

        raw_data = np.array(self.buf_sym)
        c_data = np.array([raw_to_i(e) + 1j * raw_to_q(e) for e in raw_data])
        return c_data

    def get_many_symbols(self, N=10):
        """Get N buffers of raw QPSK symbols
        """
        return np.concatenate([self.get_symbols() for i in range(N)])

    @staticmethod
    def checkhierarchy(description):
        if 'dma_tx_fft' in description['ip'] \
           and 'dma_tx_time' in description['ip'] \
           and 'dma_tx_symbol' in description['ip'] \
           and 'qpsk_tx' in description['ip']:
            return True
        return False


class QPSKTxCore(DefaultIP):
    """Driver for QPSK TX's core logic IP

    Exposes all the configuration registers by name via data-driven properties
    """

    def __init__(self, description):
        super().__init__(description=description)

    bindto = ['UoS:RFSoC:axi_qpsk_tx:5.1']


# LUT of property addresses for our data-driven properties
_qpsk_props = [("transfer_symbol", 0), ("transfer_fft", 4),
               ("transfer_time", 60), ("reset_symbol", 8), ("reset_fft", 12),
               ("reset_time", 48), ("packetsize_symbol", 16),
               ("packetsize_rf", 20), ("packetsize_fft", 24),
               ("packetsize_time", 52), ("autorestart_symbol", 36),
               ("autorestart_fft", 40), ("autorestart_time", 56),
               ("lfsr_rst", 28), ("enable", 32), ("output_gain", 44)]


# Func to return a MMIO getter and setter based on a relative addr
def _create_mmio_property(addr):
    def _get(self):
        return self.read(addr)

    def _set(self, value):
        self.write(addr, value)

    return property(_get, _set)


# Generate getters and setters based on _qpsk_props
for (name, addr) in _qpsk_props:
    setattr(QPSKTxCore, name, _create_mmio_property(addr))
