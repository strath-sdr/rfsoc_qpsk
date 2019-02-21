from pynq import Overlay
import xrfclk
import xrfdc
import os

import PynqQPSK.QpskRx
import PynqQPSK.QpskTx

class QpskOverlay(Overlay):
    def __init__(self, bitfile_name=None, **kwargs):

        # Generate default bitfile name
        if bitfile_name is None:
            this_dir = os.path.dirname(__file__)
            bitfile_name = os.path.join(this_dir, 'bitstream', 'base.bit')

        # Set FPD and LPD interface widths
        from pynq import MMIO
        fpd_cfg = MMIO(0xfd615000,4)
        fpd_cfg.write(0,0x00000A00)
        lpd_cfg = MMIO(0xff419000,4)
        lpd_cfg.write(0,0x00000000)

        # Create Overlay
        super().__init__(bitfile_name, **kwargs)

        # Extact in-use dataconverter objects with friendly names
        self.rf = self.usp_rf_data_converter_0
        self.dac_tile  = self.rf.dac_tiles[1]
        self.dac_block = self.dac_tile.blocks[2]

        self.adc_tile  = self.rf.adc_tiles[0]
        self.adc_block = self.adc_tile.blocks[0]

        # Start up LMX clock
        xrfclk.set_all_ref_clks(409.6)

        # Set sane DAC defaults
        self.dac_tile.ShutDown()
        self.dac_tile.DynamicPLLConfig(1,409.6,1024)
        self.dac_block.MixerSettings = {
                'CoarseMixFreq':  0x10, #COARSE_MIX_BYPASS
                'EventSource':    0x00, #IMMEDIATE
                'FineMixerScale': 0x01, #SCALE_1P0
                'Freq':           84.0,
                'MixerMode':      0x02, #MODE_C2R
                'MixerType':      0x02, #TYPE_FINE         
                'PhaseOffset':     0.0
        }
        self.dac_tile.SetupFIFO(True)
        self.dac_tile.StartUp()

        # Set sane ADC defaults
        self.adc_tile.ShutDown()
        self.adc_tile.DynamicPLLConfig(1,409.6,1024)
        self.adc_block.MixerSettings = {
                'CoarseMixFreq':  0x10, #COARSE_MIX_BYPASS
                'EventSource':    0x02, #TILE
                'FineMixerScale': 0x01, #SCALE_1P0
                'Freq': 84.0,
                'MixerMode':      0x03, #MODE_R2C
                'MixerType':      0x02, #TYPE_FINE
                'PhaseOffset': 0.0
        }
        self.adc_tile.SetupFIFO(True)
        self.adc_tile.StartUp()

Overlay = QpskOverlay
