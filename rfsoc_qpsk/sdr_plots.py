"""Module providing a range of interactive plots for SDR applications"""

import numpy as np
import plotly.graph_objs as go
import ipywidgets as ipw
from contextlib import contextmanager

np.seterr(divide = 'ignore') 

class noop():
    """Dummpy context manager to suppress debug output"""

    def __enter__(self):
        return self

    def __exit__(self, *x):
        pass


def resample_none(data, step):
    """Don't resample."""
    return data


def resample_pick(data, step):
    """Resample by picking every `step`th value."""
    return data[::step]


def resample_average(data, step):
    """Resample by averaging every `step` values."""
    return [np.average(data[i:i + step]) for i in range(0, len(data), step)]


def resample_median(data, step):
    """Resample by computing the median over every `step` values."""
    return [np.median(data[i:i + step]) for i in range(0, len(data), step)]

class FastFigureWidget(go.FigureWidget):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
    @contextmanager
    def _fast_batch_anim(self, duration=0, easing="linear"):
        """Our own copy of basedatatypes.py batch_animate"""
        duration = self._animation_duration_validator.validate_coerce(duration)
        easing = self._animation_easing_validator.validate_coerce(easing)

        if self._in_batch_mode is True:
            yield
        else:
            try:
                self._in_batch_mode = True
                yield
            finally:
                self._in_batch_mode = False
                self._perform_batch_animate({
                    'transition': {
                        'duration': duration,
                        'easing': easing
                    },
                    'frame': {
                        'duration': duration,
                        'redraw': False, # This is our addition
                    },
                    'mode': 'immediate'
                })

class IQPlot():
    """I/Q signal plot.

    2D Plot.ly plot of complex I/Q data with resampling support for reducing
    kernel-client bandwidth.
    """

    def __init__(self,
                 data,
                 vpu=None,
                 xlabel=None,
                 ylabel=None,
                 aggregate_fun=None,
                 resampling_fun=None,
                 w=700,
                 h=500,
                 debug=False,
                 legend=None,
                 scaling=(250/32768),
                 x_start=0,
                 autosize=True,
                 x_range=None,
                 y_range=None):
        """Create new plot.

        Args:
            data (list): complex array of I/Q values -OR- array of complex
                array of I/Q values (if multiple data sets should be plotted)
            aggregate_fun (function): function to apply to data (otherwise
                                      will plot both components)
            resampling_fun (function): function to compress large data sets
                                       down to fit the actual pixel width of
                                       the graph.
            vpu (int): values per unit a.k.a sampling frequency (for scaling the
                X axis)
            w (int): width of the plot (in pixels)
            h (int): height of the plot (in pixels)
            debug (bool):  include Output widget with debug messages
            xlabel (str): x-axis annotation
            ylabel (str): y-axis annotation
            x_start (int): custom starting point for the x-axis
            y_range (tuple): optional fixed y-axis range
        """
        self.debug = debug
        self.w = w
        self.resampling_fun = resampling_fun
        self.aggregate_fun = aggregate_fun
        self.scaling = scaling
        self.autosize = autosize

        self.vpu = vpu if vpu else 1
        self.spacing = 1 / vpu  # spacing between two values in unit
        self.x_start = x_start

        # Find out if data is iterable
        if not hasattr(data, '__iter__'):
            raise ValueError('data is not iterable')

        # Check if data is a complex list
        if isinstance(data[0], complex):
            self.L = self.spacing * len(data)  # signal lenght in units
            self.y = [data*self.scaling]
        # Otherwise assume it's a list of complex lists
        else:
            self.L = self.spacing * len(data[0])
            self.y = [trace*self.scaling for trace in data]

        # Set up _data structure
        if aggregate_fun:
            self._data = [{} for i in range(len(self.y))]
        else:
            self._data = [{} for i in range(len(self.y) * 2)]

        # Add legend, if specified
        if not legend:
            self.legend = [''] * len(self.y)
        else:
            if isinstance(legend, str):
                self.legend = [legend]
            else:
                self.legend = legend

        layout = {
            'xaxis': {
                'rangeslider': {
                    'visible': False  # rangeslider and decimation don't mix
                },
                'title': xlabel
            },
            'yaxis': {
                'title': ylabel
            },
            'height': h,
            'legend': dict(orientation='h',yanchor='top',xanchor='center',y=1.1,x=0.5)
        }
        if autosize:
            layout['autosize'] = True
        else:
            layout['width'] = w
        

        self._data_regen()

        # Create widget
        self._plot = FastFigureWidget(layout=layout, data=self._data)

        # register resampling handler on zoom/pan
        if self.resampling_fun:
            self._plot.layout.on_change(self.resample, 'xaxis.range', 'width')
        
        if x_range:
            self._plot.layout.xaxis.autorange = False
            self._plot.layout.xaxis.range = x_range
            
        if y_range:
            self._plot.layout.yaxis.autorange = False
            self._plot.layout.yaxis.range = y_range

        if self.debug:
            self._status = ipw.Output()

    def _data_regen(self):
        """Regenerate structures for plots from raw input"""

        self.L = self.spacing * len(self.y[0])
        self.x = np.arange(0, self.L, self.spacing) + self.x_start
        
        if self.resampling_fun:
            step = len(self.y[0]) // self.w
            if step < 1:
                step = 1
            x = resample_pick(self.x, step)
            y = [
                self.resampling_fun(np.real(signal), step) +
                1j * np.array(self.resampling_fun(np.imag(signal), step))
                for signal in self.y
            ]
        else:
            x, y = self.x, self.y

        if self.aggregate_fun:
            for i, e in enumerate(self.y):
                self._data[i] = {
                    'x': x,
                    'y': self.aggregate_fun(y[i]),
                    'name': self.legend[i]
                }
        else:
            for i, e in enumerate(self.y):
                self._data[i] = {
                    'x': x,
                    'y': np.real(e),
                    'name': f'{self.legend[i]} In-phase'
                }
                self._data[i + 1] = {
                    'x': x,
                    'y': np.imag(e),
                    'name': f'{self.legend[i]} Quadrature'
                }

    def add_data(self, new_data, discard=True, scroll=False):
        """Add new data to plot.

        Args:
            new_data (list): New complex data to add
            discard (bool): Discard an equal amount of old data. Implies `scroll`.
            scroll (bool): Move the window of data to display right by the length
                of the new data.
        """
        n = len(new_data)
        self.y = np.concatenate((self.y, [new_data*self.scaling]), axis=1)
        if discard:
            self.y = np.delete(self.y, range(n), 1)

        self._data_regen()

        with self._plot._fast_batch_anim():
            xaxis = self._plot.layout.xaxis
            full_width = self.L
            if xaxis.range and xaxis.range[1] <= self.L:
                xwidth = xaxis.range[1] - xaxis.range[0]
                xaxis.range = (full_width - xwidth, full_width)

            for i, trace in enumerate(self._data):
                self._plot.data[i].x=trace['x']
                self._plot.data[i].y=trace['y']

    def resample(self, ignored_layout, x_range, plot_width):
        """Resample visible area from original data set.

        This dramatically speeds up rendering since not all points need to be
        transferred to the client.

        Args:
            ignored_layout (Plotly Layout): Ignored. Present so that this
                function can be used as a callback for `on_change()` events.
            x_range (tuple): Range X axis (in displayed units, not indices)
                currently visible. This is used to determine what range of
                data points to include in the plot.
            plot_width (int): Plot width in pixels. This is used to determine
                at what resolutions data points need to be included in the plot.
        """
        # left, right are the sample indices of the left and right view
        # boundary, respectively
        left, right = (int(x_range[0] / self.spacing),
                       min(int(x_range[1] / self.spacing) + 2, len(self.x)))

        # step is the stride length for skipping points when resampling.
        # step must be at least 1
        step = max((right - left) // plot_width, 1)

        # lo, hi define the range of points we'll actually render.
        # Extend the range of points to be rendered by one plot width to the
        # left and right, which allows panning.
        lo, hi = (max(0, left - plot_width * step),
                  min(len(self.x), right + plot_width * step))

        # Resample plot data
        # X axis is linear, no need to use a sophisticated resampling function
        x = resample_pick(self.x[lo:hi], step)
        y = [
            self.resampling_fun(np.real(signal[lo:hi]), step) +
            1j * np.array(self.resampling_fun(np.imag(signal[lo:hi]), step))
            for signal in self.y
        ]

        # Create an output context manager if self.debug is set
        output = self._status if self.debug else noop()

        # Dump some debug data
        with output:
            print(f'Zoomed to {left} - {right} / {x_range[0]} - {x_range[1]}')
            print(f'len(x) == {len(x)}, len(y) == {len(y)}')
            print(f'lo == {lo}, hi == {hi}, step == {step}')

        # Update plot
        with self._plot.batch_update():

            # If there is an aggregation function, we need to add only one
            # (aggregated) data set
            if self.aggregate_fun:
                for i, signal in enumerate(y):
                    self._plot.data[i].x = x
                    self._plot.data[i].y = self.aggregate_fun(signal)

            # If there is no aggregation function, add both I and Q data sets
            else:
                for i, signal in enumerate(y):
                    self._plot.data[2 * i].x = self._plot.data[2 * i + 1].x = x
                    self._plot.data[2 * i].y = np.real(signal)
                    self._plot.data[2 * i + 1].y = np.imag(signal)

        # autorange will mess up due to rounding errors
        self._plot.layout.xaxis.autorange = False

        # Dump some debug data
        with output:
            print(f'Plotted {len(self._plot.data[0].x)} points.')

    def selected_range(self):
        """Return a tuple with the limits of the selected X data range

        Returns:
            tuple: The limits of the selected X data range (in samples,
                not units).
        """
        xaxis = self._plot.layout.xaxis
        if xaxis.autorange:
            return (0, len(self.x) - 1)
        else:
            return (int(xaxis.range[0] / self.spacing),
                    int(xaxis.range[1] / self.spacing))

    def set_resampling_fun(self, fun):
        """Change resampling function and update plot.

        Args:
            fun (function): The function to be used for resampling.
        """
        self.resampling_fun = fun
        # Update plot with newly resampled data
        if self.resampling_fun:
            self.resample(self._plot.layout,
                          (self.selected_range()[0] * self.spacing,
                           self.selected_range()[1] * self.spacing),
                          self._plot.layout.width)

    def set_line_mode(self, markers=False, lines=True, shape=None, signal=-1):
        """Show or hide sample point markers.

        Args:
            markers (bool): Show (True) or hide (False) markers
            signal (int): Index of signal to modify (-1 for all)
        """
        mode = ('', 'lines', 'markers',
                'lines+markers')[int(markers) * 2 + int(lines)]

        if signal < 0:
            for trace in self._plot.data:
                trace.mode = mode
                trace.line = dict(shape=shape)
        else:
            self._plot.data[signal].mode = mode
            self._plot.data[signal].line = dict(shape=shape)

    def set_color(self, color, signal):
        """Set trace color.

        Args:
            color (str): Color to assign (e.g. 'green')
            signal (int): Index of signal to modify
        """
        self._plot.data[signal].marker.color = color

    def get_widget(self):
        """Return plot widget."""
        if self.debug:
            return ipw.VBox([self._plot, self._status])
        else:
            return self._plot


class IQTimePlot(IQPlot):
    """Plot an I/Q signal versus time."""

    def __init__(self, data, Fs, ylabel='Voltage (mV)', *args, **kwargs):
        """Create a new plot object parametrized for I/Q time series data."""
        super().__init__(data=data, vpu=Fs, xlabel='Time (s)', ylabel=ylabel, *args, **kwargs)
        self.set_line_mode(lines=True, markers=True)


class IQFreqPlot(IQPlot):
    """Plot an I/Q spectrum versus frequency."""

    def __init__(self,
                 data,
                 Fs,
                 ylabel='Power Spectral Density (dB/Hz)',
                 animation_period=250,
                 *args,
                 **kwargs):
        """Create a new plot object parametrized for I/Q spectrum data."""
        # Plot absolute component of frequency data
        #super().__init__(data=data[range(len(data)//2)],
        #                 aggregate_fun=abs, vpu=len(data)//2/Fs,
        #                 xlabel='f [Hz]', *args, **kwargs)
        self._Fs = Fs
        self.animation_period = animation_period

        self._ffts = [self._fft_from_raw(frame) for frame in data]
        init_data = self._avg_window()
        self._y_offset = -max(abs(self._avg_window()))

        def normalised_abs(c):
            return abs(c)+self._y_offset

        super().__init__(
            data=init_data,
            aggregate_fun=normalised_abs,
            vpu=len(init_data) / Fs,
            xlabel='Frequency (Hz)',
            ylabel=ylabel,
            x_start=(-Fs / 2),
            scaling=1,
            #y_range=yrange,
            *args,
            **kwargs)

    def _fft_from_raw(self, t_data):
        """Software based FFT of raw samples

            t_data (list): time domain data to FFT
        """
        # Remember that fft output here is complex
        data = np.fft.fftshift(np.fft.fft(t_data))
        data = np.array([abs(y)**2 / (self._Fs * len(data)) for y in data])
        # Be careful zeros in the data here with log functions
        data = 10 * np.where(data>0, np.log10(data), 0)
        return data

    def _avg_window(self):
        """Calculate sample-wise average of all FFTs in buffer"""

        avg_fft = np.average(np.transpose(self._ffts), axis=1)
        return avg_fft+1j*0

    def add_frame(self, frame):
        """Add a new frame (based on time domain data) to the averaged plot

            frame (list): new time domain samples to FFT and add to the plot
        """
        self._ffts = np.roll(self._ffts, 1, axis=0)
        self._ffts[0] = self._fft_from_raw(frame)

        self.y = [self._avg_window()]
        self._data_regen()

        with self._plot._fast_batch_anim(duration=self.animation_period):
            for i, trace in enumerate(self._data):
                self._plot.data[i].x=trace['x']
                self._plot.data[i].y=trace['y']


class IQConstellationPlot():
    """Plot Q versus I."""

    def __init__(self,
                 data,
                 plotrange=None,
                 fade=False,
                 w=700,
                 h=700,
                 autosize = True,
                 scaling=(250/32768),
                 debug=False):
        """Create new plot.

        Args:
            data (list): list of complex I/Q values
            plotrange (tuple): range of values to use from 'data'
            fade (bool): make older samples more transparent
            w (int): width of plot in pixels
            h (int): height of plot in pixels
        """
        self.fade = fade
        self.scaling = scaling
        self._data = list(data*self.scaling)
        self.autosize = autosize
        
        if not plotrange:
            plotrange = (0, len(data))

        self.lo, self.hi = plotrange

        maxaxis = max(np.absolute(self._data))
        self.axisrange = [-maxaxis, maxaxis]
        
        layout = {
            'hovermode': 'closest',
            'height': h,
            'autosize': autosize,
            'xaxis': {
                'range': self.axisrange,
                'title': 'In-phase (mV)'
             },
            'yaxis': {
                'range': self.axisrange,
                'title': 'Quadrature (mV)'
            }
        }
        
        if autosize:
            layout['autosize'] = True
        else:
            layout['width'] = w
            
        self._plot = FastFigureWidget(
            layout=layout,
            data=[{
                'mode':
                'markers',
                'x':
                [np.real(x) for x in self._data[plotrange[0]:plotrange[1]]],
                'y':
                [np.imag(x) for x in self._data[plotrange[0]:plotrange[1]]],
            }])
        self.update_fade()

    def update_fade(self):
        """Update marker opacity to fade out old data points"""
        n = len(self._plot.data[0].x)
        self._plot.data[0].marker.opacity = np.arange(0, 1, 1 / n)

    def set_range(self, lo, hi):
        """Update plotrange"""
        # Observe bounds
        lo = max(0, lo)
        hi = min(len(self._data), hi)
        self.lo, self.hi = lo, hi
        with self._plot._fast_batch_anim(duration=0):
            self._plot.data[0].x = [np.real(x) for x in self._data[lo:hi]]
            self._plot.data[0].y = [np.imag(x) for x in self._data[lo:hi]]
            if self.fade:
                self.update_fade()

    def add_data(self, new_data, discard=True, scroll=True):
        """Add new data to plot.

        Args:
            new_data (list): New complex data to add
            discard (bool): Discard an equal amount of old data. Implies `scroll`.
            scroll (bool): Move the window of data to display right by the length
                of the new data.
        """
        n = len(new_data)
        self._data = np.concatenate((self._data, new_data*self.scaling))
        if discard:
            self._data = np.delete(self._data, range(n))
            #self.set_range(self.lo, self.hi)
            with self._plot._fast_batch_anim(duration=0):
                self._plot.data[0].x = [np.real(x) for x in self._data[self.lo:self.hi]]
                self._plot.data[0].y = [np.imag(x) for x in self._data[self.lo:self.hi]]
                if self.fade:
                    self.update_fade()
        elif scroll:
            self.set_range(self.lo + n, self.hi + n)

    def get_widget(self):
        """Return plot widget"""
        return self._plot


class HWFreqPlot():
    """Plot frequency domain data from a hardware accelerated FFT"""

    def __init__(self,
                 data,
                 Fs,
                 animation_period=250,
                 xlabel='Frequency (Hz)',
                 ylabel='Power Spectral Density (dB/Hz)',
                 w=700,
                 h=500,
                 autosize=True,
                 debug=False):
        """Create new plot.

        Args:
            data (list): sequence of real FFT values
                         (with 0-Fs/2 first, then (-Fs/2)-0)
            Fs (int): sampling rate, used for x-axis units
            avg_n (int): number of raw FFT frames to average per plot frame
            xlabel (str): x-axis annotation
            ylabel (str): y-axis annotation
            w (int): width of plot in pixels
            h (int): height of plot in pixels
        """

        self._Fs = Fs
        self.animation_period = animation_period
        self._y = [self._psd_from_raw(frame) for frame in data]
        self._y_offset = -max(abs(np.average(np.transpose(self._y), axis=1)))
        self._x_data = np.arange(0, 1,
                                 1 / len(self._y[0])) * self._Fs - self._Fs / 2
        self.autosize = autosize
        
        self._data_regen()

        layout={
                'hovermode': 'closest',
                'height': h,
                'autosize': autosize,
                'xaxis': {
                    'title': xlabel,
                    'range': [min(self._x_data),
                              max(self._x_data)]
                },
                'yaxis': {
                    'title': ylabel,
                    #'range': [min(self._data), max(self._data)]
                }
        }
        
        if autosize:
            layout['autosize'] = True
        else:
            layout['width'] = w
        
        self._plot = FastFigureWidget(
            layout=layout,
            data=[{
                #'mode': 'markers',
                'x': self._x_data,
                'y': self._data,
            }])

    def _psd_from_raw(self, raw):
        """Create ordered PSD data from unordered FFT data"""
        halfIndex = round(len(raw) / 2)
        data = np.concatenate([raw[halfIndex:], raw[:halfIndex]])
        data = np.array([y**2/(self._Fs*len(data)) for y in data])
        # Be careful with input data containing zeros when using log!
        data = 10 * np.where(data>0, np.log10(data), 0)
        return data

    def _data_regen(self):
        """Regenerate averaged plot data"""
        self._data = np.average(np.transpose(self._y), axis=1) + self._y_offset

    def add_frame(self, frame):
        """Add a frame of FFT data to the plot

            frame: frame of unordered FFT data
        """
        self._y = np.roll(self._y, 1, axis=0)
        self._y[0] = self._psd_from_raw(frame)
        self._data_regen()

        xaxis = self._plot.layout.xaxis
        xwidth = xaxis.range[1] - xaxis.range[0]
        axis_lo, axis_hi = xaxis.range

        with self._plot._fast_batch_anim(duration=self.animation_period):
            self._plot.data[0].x = self._x_data
            self._plot.data[0].y = self._data

    def get_widget(self):
        """Return plot widget"""
        return self._plot
