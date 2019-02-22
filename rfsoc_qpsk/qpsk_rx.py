from pynq import DefaultIP
from pynq import DefaultHierarchy
from pynq import Xlnk

import numpy as np


class QPSKRx(DefaultHierarchy):
    def __init__(self,
                 description,
                 pkt_dec=32,
                 pkt_sync=128,
                 pkt_rrc=512,
                 pkt_out=16):
        """Driver for our QPSK RX IP hierarchy.

        This encompasses the qpsk rx logic ("qpsk_core") and the DMAs for data
        transfer of exposed signals.
        """

        super().__init__(description)

        xlnk = Xlnk()
        self.buf_out = xlnk.cma_array(shape=(pkt_out * 2, ), dtype=np.int16)
        self.buf_dec = xlnk.cma_array(shape=(pkt_dec * 2, ), dtype=np.int16)
        self.buf_sync = xlnk.cma_array(shape=(pkt_sync * 2, ), dtype=np.int16)
        self.buf_rrc = xlnk.cma_array(shape=(pkt_rrc * 2, ), dtype=np.int16)

        # QPSK IP General Config
        self.axi_qpsk_rx.reset = 1
        self.axi_qpsk_rx.enable = 1
        self.axi_qpsk_rx.packetsize_out = pkt_out - 1
        self.axi_qpsk_rx.packetsize_dec = pkt_dec - 1
        self.axi_qpsk_rx.packetsize_sync = pkt_sync - 1
        self.axi_qpsk_rx.packetsize_rrc = pkt_rrc - 1
        self.axi_qpsk_rx.reset = 0

    def get_data(self):
        """Get a single buffer of final output data"""
        self.axi_qpsk_rx.transfer_out = 1
        self.axi_dma_rx.recvchannel.transfer(self.buf_out)
        self.axi_dma_rx.recvchannel.wait()
        self.axi_qpsk_rx.transfer_out = 0
        t_data = np.array(self.buf_out)
        c_data = t_data[::2] + 1j * t_data[1::2]
        return c_data

    def get_many_data(self, N=10):
        """Get N buffers of final output data"""
        return np.concatenate([self.get_data() for i in range(N)])

    def get_decimated(self):
        """Get a single buffer of samples after decimation"""
        self.axi_qpsk_rx.transfer_dec = 1
        self.axi_dma_rx_dec.recvchannel.transfer(self.buf_dec)
        self.axi_dma_rx_dec.recvchannel.wait()
        self.axi_qpsk_rx.transfer_dec = 0
        t_data = np.array(self.buf_dec)
        c_data = t_data[::2] + 1j * t_data[1::2]
        return c_data

    def get_many_decimated(self, N=10):
        """Get N buffers of samples after decimation"""
        return np.concatenate([self.get_decimated() for i in range(N)])

    def get_coarse_synced(self):
        """Get a single buffer of samples after coarse synchronisation"""
        self.axi_qpsk_rx.transfer_sync = 1
        self.axi_dma_rx_sync.recvchannel.transfer(self.buf_sync)
        self.axi_dma_rx_sync.recvchannel.wait()
        self.axi_qpsk_rx.transfer_sync = 0
        t_data = np.array(self.buf_sync)
        c_data = t_data[::2] + 1j * t_data[1::2]
        return c_data

    def get_many_coarse_synced(self, N=10):
        """Get N buffers of samples after coarse synchronisation"""
        return np.concatenate([self.get_coarse_synced() for i in range(N)])

    def get_rrced(self):
        """Get a single buffer of samples after RRC filtering"""
        self.axi_qpsk_rx.transfer_rrc = 1
        self.axi_dma_rx_rrc.recvchannel.transfer(self.buf_rrc)
        self.axi_dma_rx_rrc.recvchannel.wait()
        self.axi_qpsk_rx.transfer_rrc = 0
        t_data = np.array(self.buf_rrc)
        c_data = t_data[::2] + 1j * t_data[1::2]
        return c_data

    def get_many_rrced(self, N=10):
        """Get N buffers of samples after RRC filtering"""
        return np.concatenate([self.get_rrced() for i in range(N)])

    @staticmethod
    def checkhierarchy(description):
        if 'axi_dma_rx_rrc' in description['ip'] \
           and 'axi_dma_rx_sync' in description['ip'] \
           and 'axi_dma_rx_dec' in description['ip'] \
           and 'axi_dma_rx' in description['ip'] \
           and 'axi_qpsk_rx' in description['ip']:
            return True
        return False


class QPSKRxCore(DefaultIP):
    """Driver for QPSK RX's core logic IP

    Exposes all the configuration registers by name via data-driven properties
    """

    def __init__(self, description):
        super().__init__(description=description)

    bindto = ['UoS:RFSoC:axi_qpsk_rx:5.1']


# LUT of property addresses for our data-driven properties
_qpsk_props = [
    ("reset", 28),
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
    setattr(QPSKRxCore, name, _create_mmio_property(addr))
