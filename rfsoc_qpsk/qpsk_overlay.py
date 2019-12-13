from pynq import Overlay
from pynq import Xlnk
import xrfclk
import xrfdc
import os
import numpy as np
import ipywidgets as ipw

from rfsoc_qpsk import dma_timer, sdr_plots, qpsk_rx, qpsk_tx


class TimerRegistry():
    """Helper class to track active timer threads.

    This can be used to help safely stop any orphaned DMA timers.
    Orphans appear when a cell is re-run while its DMA timer is active.
    """
    def __init__(self):
        self.registry = dict()

    def register_timers(self, key, timers):
        """Register a list of timers with the registry.

        This will safely stop any timers that were previously registered with
        the same key.

        key: String name for this timer group

        timers: List of DmaTimer objects
        """
        if key in self.registry:
            [timer.stop() for timer in self.registry[key]]
        self.registry[key] = timers


class QpskOverlay(Overlay):
    """Overlay subclass for rfsoc-qpsk.

    Performs initialisation (including RF components) and exposes them with
    more friendly names in a flatter hierarchy. Less typing for everyone.
    """
    def __init__(self, bitfile_name=None, init_rf_clks=True, dark_theme=False, presentation_mode=False, **kwargs):
        """Construct a new QpskOverlay

        bitfile_name: Optional. If left None, the 'rfsoc_qpsk.bit' bundled with this
                      rfsoc-qpsk package will be used.

        init_rf_clks: If true (default), the reference clocks are configured
                      for all tiles. If the clocks are already configured, set
                      to false for faster execution.

        dark_theme: Flat to enable a dark theme for plots

        presentation_mode: Flag to enable a dark theme with thick lines and
                           bigger font

        """

        # Generate default bitfile name
        if bitfile_name is None:
            this_dir = os.path.dirname(__file__)
            bitfile_name = os.path.join(this_dir, 'bitstream', 'rfsoc_qpsk.bit')

        # Set optional theming for dark mode
        if dark_theme:
            from IPython.display import display, HTML
            import plotly.io as pio

            # Apply plotly theming
            dark_template = pio.templates['plotly_dark']
            dark_template.layout.paper_bgcolor = 'rgb(0,0,0,0)'
            dark_template.layout.plot_bgcolor  = 'rgb(0,0,0,0)'
            dark_template.layout.legend.bgcolor = 'rgb(0,0,0,0)'
            pio.templates['dark_plot'] = dark_template
            pio.templates.default = 'dark_plot'

        # Set optional theming for presentation mode
        if presentation_mode:
            from IPython.display import display, HTML
            import plotly.io as pio

            # Apply plotly theming
            pio.templates.default = 'plotly_dark+presentation'

            # Force dark style for ipywidget tab background
            display(HTML("""
            <style>
            .jupyter-widgets.widget-tab > .widget-tab-contents {
              background: inherit !important;
            }
            </style>
            """))

        # Set FPD and LPD interface widths
        from pynq import MMIO
        fpd_cfg = MMIO(0xfd615000, 4)
        fpd_cfg.write(0, 0x00000A00)
        lpd_cfg = MMIO(0xff419000, 4)
        lpd_cfg.write(0, 0x00000000)

        # Create Overlay
        super().__init__(bitfile_name, **kwargs)

        # Extact in-use dataconverter objects with friendly names
        self.rf = self.usp_rf_data_converter_0
        self.dac_tile = self.rf.dac_tiles[1]
        self.dac_block = self.dac_tile.blocks[2]

        self.adc_tile = self.rf.adc_tiles[0]
        self.adc_block = self.adc_tile.blocks[0]

        # Start up LMX clock
        if init_rf_clks:
            xrfclk.set_all_ref_clks(409.6)

        # Set sane DAC defaults
        self.dac_tile.DynamicPLLConfig(1, 409.6, 1228.8)
        self.dac_block.NyquistZone = 2
        self.dac_block.MixerSettings = {
            'CoarseMixFreq':  xrfdc.COARSE_MIX_BYPASS,
            'EventSource':    xrfdc.EVNT_SRC_IMMEDIATE,
            'FineMixerScale': xrfdc.MIXER_SCALE_1P0,
            'Freq':           1000,
            'MixerMode':      xrfdc.MIXER_MODE_C2R,
            'MixerType':      xrfdc.MIXER_TYPE_FINE,
            'PhaseOffset':    0.0
        }
        self.dac_block.UpdateEvent(xrfdc.EVENT_MIXER)
        self.dac_tile.SetupFIFO(True)

        # Set sane ADC defaults
        self.adc_tile.DynamicPLLConfig(1, 409.6, 1228.8)
        self.adc_block.NyquistZone = 2
        self.adc_block.MixerSettings = {
            'CoarseMixFreq':  xrfdc.COARSE_MIX_BYPASS,
            'EventSource':    xrfdc.EVNT_SRC_TILE,
            'FineMixerScale': xrfdc.MIXER_SCALE_1P0,
            'Freq':           1000,
            'MixerMode':      xrfdc.MIXER_MODE_R2C,
            'MixerType':      xrfdc.MIXER_TYPE_FINE,
            'PhaseOffset':    0.0
        }
        self.adc_block.UpdateEvent(xrfdc.EVENT_MIXER)
        self.adc_tile.SetupFIFO(True)

        # Touch RX and TX drivers for strict evaluation
        self.qpsk_tx.qpsk_tx.enable=1
        self.qpsk_rx.qpsk_rx_dec.enable=1
        self.qpsk_rx.qpsk_rx_csync.enable=1
        self.qpsk_rx.qpsk_rx_rrc.enable=1
        self.qpsk_rx.qpsk_rx_tsync.enable=1

        self.timers = TimerRegistry()

    def plot_group(self, group_name, domains, get_time_data, fs, get_freq_data=None, get_const_data=None):
        """Create a group of plots for a given set of data generators.
            
        group_name: String name for plot group (used to register timers with
                    the TimerRegistry)

        domains:    List of plot types to generate. Select from:
                    ['time','time-binary','frequency','constellation'].

        fs:         Sampling frequency. Used for time axis scaling

        get_time_data: Callback function that returns a buffer of time domain
                       samples

        get_freq_data: Optional callback that returns a buffer of frequency
                       domain samples. When not specified, a software FFT will
                       be performed on the get_time_data callback instead.

        get_const_data: Optional callback that returns a buffer of time-domain
                        data for any constellation plots. When not specified,
                        the get_time_data callback will be used.

        """
        plots = []
        
        def many(f, n=4):
            return np.concatenate([f() for _ in range(n)])
        
        for domain in domains:
            
            if domain=='frequency':
                
                # HW accelerated FFT
                if get_freq_data != None:
                    f_plot = sdr_plots.HWFreqPlot(
                                [get_freq_data() for _ in range(4)],
                                fs, animation_period=100, w=700)
                    f_dt = dma_timer.DmaTimer(f_plot.add_frame, get_freq_data, 0.3)
                # SW FFT
                else:
                    f_plot = sdr_plots.IQFreqPlot(
                                [many(get_time_data) for _ in range(4)],
                                fs, x_range=(-2000,2000), animation_period=100, w=700)
                    f_dt = dma_timer.DmaTimer(f_plot.add_frame, lambda:many(get_time_data), 0.3)
                plots.append(dict(title='Frequency domain', plot=f_plot, control=f_dt))
            
            elif domain=='time' or domain=='time-binary':
                if domain=='time-binary':
                    iq_plot = sdr_plots.IQTimePlot(many(get_time_data), fs, w=700, scaling=1, ylabel='Symbol value')
                    iq_plot.set_line_mode(lines=True, markers=True, shape='hvh')
                    iq_plot.get_widget().layout.yaxis.dtick=1
                else:
                    iq_plot = sdr_plots.IQTimePlot(many(get_time_data), fs, w=700)
                    iq_plot.set_line_mode(markers=False)
                iq_dt = dma_timer.DmaTimer(iq_plot.add_data, get_time_data, 0.05)
                plots.append(dict(title='Time domain', plot=iq_plot, control=iq_dt))
            
            elif domain=='constellation':
                c_plot = sdr_plots.IQConstellationPlot(many(get_const_data or get_time_data, n=10), h=550, fade=True)
                c_dt = dma_timer.DmaTimer(c_plot.add_data, get_const_data or get_time_data, 0.05)
                plots.append(dict(title='Constellation', plot=c_plot, control=c_dt,
                                  layout=ipw.Layout(width='550px', margin='auto')))
                
        self.timers.register_timers(group_name, list(map(lambda tab: tab['control'], plots)))
        return QpskOverlay.tab_plots(plots)
        
    @staticmethod
    def tab_plots(tabs):
        """Helper function to generate a Tab widget given a list of definitions.

        tabs: A list of dicts describing a single tab. Each element needs three
              keys: 'plot' with a SdrPlot object, 'control' with a DmaTimer
                    object, and 'title' with a string.
        """
        widgets = []
        titles  = []

        for tab in tabs:
            widgets.append(ipw.VBox([
                tab['plot'].get_widget(),tab['control'].get_widget()
                ],layout=tab.get('layout',ipw.Layout())))
            titles.append(tab['title'])

        tab_widget = ipw.Tab(widgets)
        for i, title in enumerate(titles):
            tab_widget.set_title(i, title)
        
        QpskOverlay._tab_load_resizer_callback(tab_widget)

        return tab_widget

    @staticmethod
    def _tab_load_resizer_callback(tabs):
        """Helper function to handle relative widths for plots in hidden tabs"""
        display(tabs)

        out = ipw.Output()
        display(out)

        @out.capture()
        def callback(change):
            plot = tabs.children[change['new']].children[0]
            plot.layout.autosize = False
            plot.layout.autosize = True

        tabs.observe(callback, names='selected_index')

Overlay = QpskOverlay
