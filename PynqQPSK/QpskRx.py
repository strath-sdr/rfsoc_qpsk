import pynq
from pynq import DefaultIP
from pynq import DefaultHierarchy
from pynq import Xlnk
import numpy as np

class QPSK_RX(DefaultHierarchy):

    def __init__(self, description, pkt_dec=32, pkt_sync=128, pkt_rrc=512, pkt_out=16):
        """Driver for our QPSK RX IP hierarchy

        This encompasses the qpsk tx logic ("qpsk_core") and the DMAs for data
        transfer of exposed signals.

        """

        super().__init__(description)

        xlnk = Xlnk()
        self.buf_out = xlnk.cma_array(shape=(pkt_out*2,), dtype=np.int16)
        self.buf_dec = xlnk.cma_array(shape=(pkt_dec*2,), dtype=np.int16)
        self.buf_sync = xlnk.cma_array(shape=(pkt_sync*2,), dtype=np.int16)
        self.buf_rrc = xlnk.cma_array(shape=(pkt_rrc*2,), dtype=np.int16)

        # QPSK IP General Config
        self.axi_qpsk_rx.reset = 1
        self.axi_qpsk_rx.enable = 1
        self.axi_qpsk_rx.packetsize_out = pkt_out-1
        self.axi_qpsk_rx.packetsize_dec = pkt_dec-1
        self.axi_qpsk_rx.packetsize_sync = pkt_sync-1
        self.axi_qpsk_rx.packetsize_rrc = pkt_rrc-1
        self.axi_qpsk_rx.reset = 0

    def getData(self):
        """Get a single buffer of data
        """
        self.axi_qpsk_rx.transfer_out = 1
        self.axi_dma_rx.recvchannel.transfer(self.buf_out)
        self.axi_dma_rx.recvchannel.wait()
        self.axi_qpsk_rx.transfer_out = 0
        t_data = np.array(self.buf_out)
        c_data = t_data[::2] + 1j*t_data[1::2]
        return c_data

    def getManyData(self, N=10):
        """Get N buffers of raw QPSK symbols
        """
        return np.concatenate([self.getData() for i in range(N)])

    def getDecimated(self):
        """Get a single buffer of data
        """
        self.axi_qpsk_rx.transfer_dec = 1
        self.axi_dma_rx_dec.recvchannel.transfer(self.buf_dec)
        self.axi_dma_rx_dec.recvchannel.wait()
        self.axi_qpsk_rx.transfer_dec = 0
        t_data = np.array(self.buf_dec)
        c_data = t_data[::2] + 1j*t_data[1::2]
        return c_data

    def getManyDecimated(self, N=10):
        """Get N buffers of raw QPSK symbols
        """
        return np.concatenate([self.getDecimated() for i in range(N)])

    def getCoarseSynced(self):
        """Get a single buffer of data
        """
        self.axi_qpsk_rx.transfer_sync = 1
        self.axi_dma_rx_sync.recvchannel.transfer(self.buf_sync)
        self.axi_dma_rx_sync.recvchannel.wait()
        self.axi_qpsk_rx.transfer_sync = 0
        t_data = np.array(self.buf_sync)
        c_data = t_data[::2] + 1j*t_data[1::2]
        return c_data

    def getManyCoarseSynced(self, N=10):
        """Get N buffers of raw QPSK symbols
        """
        return np.concatenate([self.getCoarseSynced() for i in range(N)])


    def getRRCed(self):
        """Get a single buffer of data
        """
        self.axi_qpsk_rx.transfer_rrc = 1
        self.axi_dma_rx_rrc.recvchannel.transfer(self.buf_rrc)
        self.axi_dma_rx_rrc.recvchannel.wait()
        self.axi_qpsk_rx.transfer_rrc = 0
        t_data = np.array(self.buf_rrc)
        c_data = t_data[::2] + 1j*t_data[1::2]
        return c_data

    def getManyRRCed(self, N=10):
        """Get N buffers of raw QPSK symbols
        """
        return np.concatenate([self.getRRCed() for i in range(N)])

    @staticmethod
    def checkhierarchy(description):
        if 'axi_dma_rx_rrc' in description['ip'] \
           and 'axi_dma_rx_sync' in description['ip'] \
           and 'axi_dma_rx_dec' in description['ip'] \
           and 'axi_qpsk_rx' in description['ip']:
            return True
        return False

class QPSK_RX_Core(DefaultIP):
    """Driver for QPSK RX's core logic IP

    Exposes all the configuration registers by name via data-driven properties
    """
    def __init__(self, description):
        super().__init__(description=description)

    bindto = ['UoS:RFSoC:axi_qpsk_rx:5.1']

# LUT of property addresses for our data-driven properties
_qpsk_props = [("reset", 28),
               ("enable", 32),

               ("packetsize_out", 20),
               ("transfer_out", 40),
               ("autorestart_out", 36),

               ("packetsize_dec", 44),
               ("transfer_dec", 52),
               ("autorestart_dec", 48),

               ("packetsize_sync", 68),
               ("transfer_sync", 76),
               ("autorestart_sync", 72),

               ("packetsize_rrc", 56),
               ("transfer_rrc", 64),
               ("autorestart_rrc", 60),
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
    setattr(QPSK_RX_Core, name, _create_mmio_property(addr))

