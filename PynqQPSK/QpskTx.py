import pynq
from pynq import DefaultIP
from pynq import DefaultHierarchy
from pynq import Xlnk
import numpy as np

class QPSK_TX(DefaultHierarchy):

    def __init__(self, description, pkt_sym=16, pkt_time=128, pkt_fft=1024):
        """Driver for our QPSK TX IP hierarchy

        This encompasses the qpsk tx logic and the DMAs for data
        transfer of exposed signals.
        """

        super().__init__(description)

        xlnk = Xlnk()
        self.buf_fft = xlnk.cma_array(shape=(pkt_fft,), dtype=np.uint32)
        self.buf_sym = xlnk.cma_array(shape=(pkt_sym,), dtype=np.uint8)
        self.buf_time = xlnk.cma_array(shape=(pkt_time*2,), dtype=np.int16)

        # QPSK IP General Config
        self.axi_qpsk_tx.lfsr_rst = 1
        self.axi_qpsk_tx.enable = 1
        self.axi_qpsk_tx.packetsize_rf = 1024
        self.axi_qpsk_tx.lfsr_rst = 0
        self.axi_qpsk_tx.output_gain = 2**32-1

        # QPSK IP Symbol Config
        self.axi_qpsk_tx.reset_symbol = 1
        self.axi_qpsk_tx.packetsize_symbol = pkt_sym-1
        self.axi_qpsk_tx.reset_symbol = 0
        self.axi_qpsk_tx.autorestart_symbol = 0

        # QPSK IP FFT Config
        self.axi_qpsk_tx.reset_fft = 1
        self.axi_qpsk_tx.packetsize_fft = pkt_fft-1
        self.axi_qpsk_tx.reset_fft = 0
        self.axi_qpsk_tx.autorestart_fft = 0

        ## QPSK IP Time Config
        self.axi_qpsk_tx.reset_time = 1
        self.axi_qpsk_tx.packetsize_time = pkt_time-1
        self.axi_qpsk_tx.reset_time = 0
        self.axi_qpsk_tx.autorestart_time = 0

    def getShapedFFT(self):
        """Get a single buffer of FFT data from the pulse shaped signal
        """
        self.axi_qpsk_tx.transfer_fft=1
        self.axi_dma_fft.recvchannel.transfer(self.buf_fft)
        self.axi_dma_fft.recvchannel.wait()
        self.axi_qpsk_tx.transfer_fft=0
        return np.array(self.buf_fft)

    def getShapedTime(self):
        """Get a single buffer of time domain data from the pulse shaped signal
        """
        self.axi_qpsk_tx.transfer_time=1
        self.axi_dma_time.recvchannel.transfer(self.buf_time)
        self.axi_dma_time.recvchannel.wait()
        self.axi_qpsk_tx.transfer_time=0
        t_data = np.array(self.buf_time)
        c_data = t_data[::2] + 1j*t_data[1::2]
        return c_data

    def getManyShapedTime(self, N=10):
        """Get N buffers of time domain data from the pulse shaped signal
        """
        return np.concatenate([self.getShapedTime() for i in range(N)])

    def getSymbols(self):
        """Get a single buffer of raw QPSK symbols
        """

        def raw_to_i(raw):
           i = raw & 0b0011
           if i==3:
               return -1
           else:
               return 1

        def raw_to_q(raw):
           i = (raw & 0b1100) >> 2
           if i==3:
               return -1
           else:
               return 1

        self.axi_qpsk_tx.transfer_symbol=1
        self.axi_dma_symbol.recvchannel.transfer(self.buf_sym)
        self.axi_dma_symbol.recvchannel.wait()
        self.axi_qpsk_tx.transfer_symbol=0

        raw_data = np.array(self.buf_sym)
        c_data = [raw_to_i(e)+1j*raw_to_q(e) for e in raw_data]
        return c_data

    def getManySymbols(self, N=10):
        """Get N buffers of raw QPSK symbols
        """
        return np.concatenate([self.getSymbols() for i in range(N)])

    @staticmethod
    def checkhierarchy(description):
        if 'axi_dma_fft' in description['ip'] \
           and 'axi_dma_time' in description['ip'] \
           and 'axi_dma_symbol' in description['ip'] \
           and 'axi_qpsk_tx' in description['ip']:
            return True
        return False

class QPSK_TX_Core(DefaultIP):
    """Driver for QPSK TX's core logic IP

    Exposes all the configuration registers by name via data-driven properties
    """
    def __init__(self, description):
        super().__init__(description=description)

    bindto = ['UoS:RFSoC:axi_qpsk_tx:5.1']

# LUT of property addresses for our data-driven properties
_qpsk_props = [("transfer_symbol", 0),
              ("transfer_fft", 4),
              ("transfer_time", 60),
              ("reset_symbol", 8),
              ("reset_fft", 12),
              ("reset_time", 48),
              ("packetsize_symbol", 16),
              ("packetsize_rf", 20),
              ("packetsize_fft", 24),
              ("packetsize_time", 52),
              ("autorestart_symbol", 36),
              ("autorestart_fft", 40),
              ("autorestart_time", 56),
              ("lfsr_rst", 28),
              ("enable", 32),
              ("output_gain", 44)
             ]

# Func to return a MMIO getter and setter based on a relative addr
def _create_mmio_property(addr):
    def _get(self):
        return self.read(addr)

    def _set(self, value):
        self.write(addr, value)

    return property(_get, _set)

# Generate getters and setters based on _qpsk_props
for (name, addr) in _qpsk_props:
    setattr(QPSK_TX_Core, name, _create_mmio_property(addr))

