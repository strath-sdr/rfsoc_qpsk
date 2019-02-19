from pynq import Overlay
import xrfclk
import xrfdc

import PynqQPSK.QpskRx
import PynqQPSK.QpskTx

class QpskOverlay(Overlay):
    def __init__(self, bitfile_name, **kwargs):


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
        xrfclk.set_all_ref_clks(204.8)

        # Set sane DAC defaults
        self.dac_tile.ShutDown()
        self.dac_tile.DynamicPLLConfig(xrfdc.XRF_CLK_SRC_PLL,204.8,204.8)
        self.dac_block.MixerSettings = {
           "Freq": 84,
           "CoarseMixFreq": xrfdc.XRF_DC_COARSE_MIX_SAMPLE_FREQ_BY_TWO,
           "CoarseMixMode": xrfdc.XRF_DC_COARSE_MIX_MODE_C2C_C2R,
           "FineMixerMode": xrfdc.XRF_DC_FINE_MIXER_MOD_COMPLX_TO_REAL}
        self.dac_tile.SetupFIFO(True)
        self.dac_tile.StartUp()

        # Set sane ADC defaults
        self.adc_tile.ShutDown()
        self.adc_tile.DynamicPLLConfig(xrfdc.XRF_CLK_SRC_PLL,204.8,1024)
        self.adc_block.MixerSettings = {
           "Freq": 84.000,
           "CoarseMixFreq": xrfdc.XRF_DC_COARSE_MIX_SAMPLE_FREQ_BY_TWO,
           "CoarseMixMode": 2,
           "FineMixerMode": 3,
           "EventSource": 2}
        self.adc_tile.SetupFIFO(True)
        self.adc_tile.StartUp()

Overlay = QpskOverlay
