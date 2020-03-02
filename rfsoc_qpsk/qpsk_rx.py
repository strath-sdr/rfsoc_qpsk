from pynq import DefaultIP
from pynq import DefaultHierarchy
from pynq import Xlnk

import numpy as np

from rfsoc_qpsk.dma_timer import DmaTimer


class QPSKRx(DefaultHierarchy):
    def __init__(self, description):
        super().__init__(description)
    
    def get_decimated(self):
        return self.qpsk_rx_dec.get_frame(self.dma_rx_dec)
        
    def get_coarse_synced(self):
        return self.qpsk_rx_csync.get_frame(self.dma_rx_csync)
    
    def get_rrced(self):
        return self.qpsk_rx_rrc.get_frame(self.dma_rx_rrc)
    
    def get_data(self):
        return self.qpsk_rx_tsync.get_frame(self.dma_rx_tsync)
        
    @staticmethod
    def checkhierarchy(description):
        if     'dma_rx_dec'    in description['ip'] \
           and 'qpsk_rx_dec'   in description['ip'] \
           and 'dma_rx_csync'   in description['ip'] \
           and 'qpsk_rx_csync' in description['ip'] \
           and 'dma_rx_rrc'   in description['ip'] \
           and 'qpsk_rx_rrc' in description['ip'] \
           and 'dma_rx_tsync'   in description['ip'] \
           and 'qpsk_rx_tsync' in description['ip']:
            return True
        return False

    
class DataInspector(DefaultIP):

    def __init__(self, description, pkt_size, buf_dtype=np.int16, buf_words_per_pkt=2):
        super().__init__(description)
        
        # Init config register
        self.reset = 1
        self.enable = 1
        self.pkt_size = pkt_size-1
        self.auto_restart = 0
        self.reset = 0
        
        # Init buffer
        xlnk = Xlnk()
        self.buf = xlnk.cma_array(shape=(pkt_size * buf_words_per_pkt, ), dtype=np.int16)
    
    def _process_frame(self, frame):
        # By default treat frame as interleaved IQ stream.
        return frame[::2] + 1j * frame[1::2]
    
    def get_frame(self, dma):
        self.transfer = 1
        dma.recvchannel.transfer(self.buf)
        dma.recvchannel.wait()
        self.transfer = 0
        frame = self._process_frame(np.array(self.buf))
        return frame


# Func to return a MMIO getter and setter based on a relative addr
def _create_mmio_property(addr):
    def _get(self):
        return self.read(addr)

    def _set(self, value):
        self.write(addr, value)

    return property(_get, _set)

    
# LUT of property addresses for our data-driven properties
_data_inspector_props = [
    ("reset",        0 ),
    ("pkt_size",     4 ),
    ("enable",       8 ),
    ("auto_restart", 12),
    ("transfer",     16)
]


# Generate getters and setters based on _data_inspector_props
for (name, addr) in _data_inspector_props:
    setattr(DataInspector, name, _create_mmio_property(addr))

    
class RxDecimator(DataInspector):
    def __init__(self, description):
        super().__init__(description, 32)
    
    bindto = ['UoS:SysGen:axi_qpsk_rx_dec:1.0']

    
class RxCSync(DataInspector):
    def __init__(self, description):
        super().__init__(description, 128)
    
    bindto = ['UoS:SysGen:axi_qpsk_rx_csync:1.0']
    
    
class RxRRC(DataInspector):
    def __init__(self, description):
        super().__init__(description, 512)
    
    bindto = ['UoS:SysGen:axi_qpsk_rx_rrc:1.0']
    
    
class RxTSync(DataInspector):
    def __init__(self, description):
        super().__init__(description, 16)
        # Set loop filter reset counter to 1 second
        # (@ 16kHz)
        self.sync_reset=0

    bindto = ['UoS:SysGen:axi_qpsk_rx_tsync:1.0']
setattr(RxTSync, 'sync_reset', _create_mmio_property(20))

