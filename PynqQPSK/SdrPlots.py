import numpy as np
import plotly.graph_objs as go
import ipywidgets as ipw

class noop():
    """Dummpy context manager to suppress debug output"""
    def __enter__(self): return self
    def __exit__(self, *x): pass


def resample_none(data, step):
    """Don't resample."""
    return data

def resample_pick(data, step):
    """Resample by picking every `step`th value."""
    return data[::step]

def resample_average(data, step):
    """Resample by averaging every `step` values."""
    return [np.average(data[i:i+step]) for i in range(0, len(data), step)]

def resample_median(data, step):
    """Resample by computing the median over every `step` values."""
    return [np.median(data[i:i+step]) for i in range(0, len(data), step)]

class IQPlot():
    """I/Q signal plot.

    2D Plot.ly plot of complex I/Q data with resampling support for reducing
    kernel-client bandwidth.
    """
    def __init__(self, data, 
                 gate_fun=None, vpu=None, xlabel=None, ylabel=None, aggregate_fun=None,
                 resampling_fun=None, w=700, h=500, debug=False, legend=None, x_start=0, y_range=None):
        """Create new plot.

        Args:
            data (list): complex array of I/Q values -OR- array of complex
                array of I/Q values (if multiple data sets should be plotted)
            fun (function): function to apply to data (otherwise will plot both
                components)
            vpu (int): values per unit a.k.a sampling frequency (for scaling the
                X axis)
            w (int): width of the plot (in pixels)
            h (int): height of the plot (in pixels)
            debug (bool):  include Output widget with debug messages
        """
        self.debug = debug
        self.w = w
        self.resampling_fun = resampling_fun
        self.aggregate_fun = aggregate_fun

        self.vpu = vpu if vpu else 1
        self.spacing = 1/vpu            # spacing between two values in unit

        # Find out if data is iterable
        if not hasattr(data, '__iter__'):
            raise ValueError('data is not iterable')

        # Check if data is a complex list
        if isinstance(data[0], complex):
            self.L = self.spacing * len(data)    # signal lenght in units
            self.y = [data]
        # Otherwise assume it's a list of complex lists
        else:
            self.L = self.spacing * len(data[0])
            self.y = data

        # Set up _data structure
        if aggregate_fun:
            self._data = [{} for i in range(len(self.y))]
        else:
            self._data = [{} for i in range(len(self.y)*2)]

        self.x = np.arange(0, self.L, self.spacing) + x_start

        # Add legend, if specified
        if not legend:
            self.legend = [''] * len(self.y)
        else:
            if isinstance(legend, str):
                self.legend = [legend]
            else:
                self.legend = legend

        layout={
            'xaxis': {
                'rangeslider': {
                    'visible': False   # rangeslider and decimation don't mix
                },
                'title': xlabel
            },
            'yaxis':{'title': ylabel},
            'width': w,
            'height': h
        }

        self.data_regen()

        # Create widget
        self._plot = go.FigureWidget(layout=layout, data=self._data)

        # register resampling handler on zoom/pan
        if self.resampling_fun:
            self._plot.layout.on_change(self.resample, 'xaxis.range', 'width')

        if y_range:
            self._plot.layout.yaxis.autorange = False
            self._plot.layout.yaxis.range = y_range

        if self.debug:
            self._status = ipw.Output()


    def data_regen(self):

        self.L = self.spacing * len(self.y[0])
        self.x = np.arange(0, self.L, self.spacing)

        if self.resampling_fun:
            step = len(self.y[0])//self.w
            if step<1:
                step=1
            x = resample_pick(self.x, step)
            y =[self.resampling_fun(np.real(signal), step) + 1j *
                    np.array(self.resampling_fun(np.imag(signal), step))
                    for signal in self.y]
        else:
            x, y = self.x, self.y

        if self.aggregate_fun:
            for i, e in enumerate(self.y):
                self._data[i]={'x': x, 'y': self.aggregate_fun(y[i]), 'name': self.legend[i]}
        else:
            for i, e in enumerate(self.y):
                self._data[i]={'x': x, 'y': np.real(e),
                             'name': f'{self.legend[i]} I'}
                self._data[i+1]={'x': x, 'y': np.imag(e),
                             'name': f'{self.legend[i]} Q'}

    def add_data(self, new_data, discard=True, scroll=True):
        """Add new data to plot.

        Args:
            new_data (list): New complex data to add
            discard (bool): Discard an equal amount of old data. Implies `scroll`.
            scroll (bool): Move the window of data to display right by the length
                of the new data.
        """
        n = len(new_data)
        self.y = np.concatenate((self.y,[new_data]),axis=1)
        if discard:
             self.y=np.delete(self.y, range(n), 1)

        self.data_regen()

        xaxis = self._plot.layout.xaxis
        full_width = self.L
        if xaxis.range[1] <= self.L:
            xwidth = xaxis.range[1] - xaxis.range[0]
            xaxis.range = (full_width - xwidth, full_width)

        self._plot.update(data=self._data)

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
        left, right = (int(x_range[0]/self.spacing),
                       min(int(x_range[1]/self.spacing)+2, len(self.x)))

        # step is the stride length for skipping points when resampling.
        # step must be at least 1
        step = max((right-left)//plot_width, 1)

        # lo, hi define the range of points we'll actually render.
        # Extend the range of points to be rendered by one plot width to the
        # left and right, which allows panning.
        lo, hi = (max(0, left-plot_width*step),
                  min(len(self.x), right+plot_width*step))

        # Resample plot data
        # X axis is linear, no need to use a sophisticated resampling function
        x = resample_pick(self.x[lo:hi], step)
        y = [self.resampling_fun(np.real(signal[lo:hi]), step) + 1j *
             np.array(self.resampling_fun(np.imag(signal[lo:hi]), step))
             for signal in self.y]

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
                    self._plot.data[2*i].x = self._plot.data[2*i+1].x = x
                    self._plot.data[2*i].y = np.real(signal)
                    self._plot.data[2*i+1].y = np.imag(signal)

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
            return (0, len(self.x)-1)
        else:
            return (int(xaxis.range[0]/self.spacing),
                    int(xaxis.range[1]/self.spacing))

    def set_resampling_fun(self, fun):
        """Change resampling function and update plot.

        Args:
            fun (function): The function to be used for resampling.
        """
        self.resampling_fun = fun
        # Update plot with newly resampled data
        if self.resampling_fun:
            self.resample(self._plot.layout,
                          (self.selected_range()[0]*self.spacing,
                           self.selected_range()[1]*self.spacing),
                          self._plot.layout.width)

    def set_line_mode(self, markers=False, lines=True, signal=-1):
        """Show or hide sample point markers.

        Args:
            markers (bool): Show (True) or hide (False) markers
            signal (int): Index of signal to modify (-1 for all)
        """
        mode = ('', 'lines', 'markers', 'lines+markers')[int(markers)*2+int(lines)]

        if signal < 0:
            for trace in self._plot.data:
                trace.mode = mode
        else:
            self._plot.data[signal].mode = mode

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

    def __init__(self, data, Fs, *args, **kwargs):
        """Create a new plot object parametrized for I/Q time series data."""
        super().__init__(data=data, vpu=Fs, xlabel='t [s]', *args, **kwargs)

class IQFreqPlot(IQPlot):
    """Plot an I/Q spectrum versus frequency."""

    def __init__(self, data, Fs, avg_n=4, ylabel='PSD [dB/Hz]', *args, **kwargs):
        """Create a new plot object parametrized for I/Q spectrum data."""
        # Plot absolute component of frequency data
        #super().__init__(data=data[range(len(data)//2)],
        #                 aggregate_fun=abs, vpu=len(data)//2/Fs,
        #                 xlabel='f [Hz]', *args, **kwargs)
        self._Fs = Fs

        f_data = self.fft_from_raw(data)

        self._ffts = [f_data for i in range(avg_n)]

        yrange = [abs(min(f_data))*1.2,abs(max(f_data))*1.2]

        super().__init__(data=self.avg_window(),
                         aggregate_fun=abs, vpu=len(data)/Fs,
                         xlabel='f [Hz]', ylabel='PSD [dB/Hz]', x_start =(-len(data)/2), y_range=yrange, *args, **kwargs)

    def fft_from_raw(self, t_data):
        data = np.fft.fftshift(np.fft.fft(t_data))
        data = [y**2/(self._Fs*len(data)) for y in data]
        data = 20*np.log10(data)
        return data

    def avg_window(self):
        return np.average(np.transpose(self._ffts),axis=1)

    def add_frame(self, frame):
        self._ffts = np.roll(self._ffts, 1, axis=0)
        self._ffts[0] = self.fft_from_raw(frame)

        self.y = [self.avg_window()]
        self.data_regen()

        self._plot.update(data=self._data)

class IQConstellationPlot():
    """Plot Q versus I."""

    def __init__(self, data, plotrange=None, fade=False, w=700, h=700, debug=False):
        """Create new plot.

        Args:
            data (sequence): Sequence of complex I/Q values
            plotrange (tuple): Range of values to use from 'data'
        """
        self._data = list(data)
        self.fade = fade

        if not plotrange:
            plotrange = (0, len(data))

        self.lo, self.hi = plotrange

        maxaxis = max(np.absolute(data))
        self.axisrange = [-maxaxis, maxaxis]

        self._plot = go.FigureWidget(
            layout={
                'hovermode': 'closest',
                'width': w,
                'height': h,
                'xaxis': {
                    'range': self.axisrange
                },
                'yaxis': {
                    'range': self.axisrange
                }
            },
            data=[
                {
                    'mode': 'markers',
                    'x': [np.real(x) for x in self._data[plotrange[0]:plotrange[1]]],
                    'y': [np.imag(x) for x in self._data[plotrange[0]:plotrange[1]]],
                }
        ])
        self.update_fade()


    def update_fade(self):
        """Update marker opacity to fade out old data points"""
        n = len(self._plot.data[0].x)
        self._plot.data[0].marker.opacity = np.arange(0, 1, 1/n)


    def set_range(self, lo, hi):
        """Update plotrange"""
        # Observe bounds
        lo = max(0, lo)
        hi = min(len(self._data), hi)
        self.lo, self.hi = lo, hi
        with self._plot.batch_update():
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
        self._data = np.concatenate((self._data,new_data))
        if discard:
            self._data=np.delete(self._data, range(n))
            #self.set_range(self.lo, self.hi)
            self._plot.update(data=[
                {
                    'mode': 'markers',
                    'x': [np.real(x) for x in self._data[self.lo:self.hi]],
                    'y': [np.imag(x) for x in self._data[self.lo:self.hi]]
                }])
        elif scroll:
            self.set_range(self.lo + n, self.hi + n)

    def get_widget(self):
        """Return plot widget"""
        return self._plot


class HWFreqPlot():
    """Plot FFT from HW"""

    def __init__(self, data, Fs, avg_n=1, xlabel='f [Hz]', ylabel='PSD [dB/Hz]', w=700, h=500, debug=False):
        """Create new plot.

        Args:
            data (sequence): Sequence of real FFT values
            (with 0-Fs/2 first, then (-Fs/2)-0)
        """

        self._Fs = Fs
        y = self.psd_from_raw(data)
        self._y = [y for i in range(avg_n)]
        self._x_data = np.arange(0,1,1/len(self._y[0]))*self._Fs - self._Fs/2

        self.data_regen()

        self._plot = go.FigureWidget(
            layout={
                'hovermode': 'closest',
                'width': w,
                'height': h,
                'xaxis': {
                    'title': xlabel,
                    'range': [min(self._x_data), max(self._x_data)]
                },
                'yaxis': {
                    'title': ylabel,
                    #'range': [min(self._data), max(self._data)]
                    'range': [-100, 10]
                }
            },
            data=[
                {
                    #'mode': 'markers',
                    'x': self._x_data,
                    'y': self._data,
                }
        ])

    def psd_from_raw(self, raw):
        halfIndex = round(len(raw)/2)
        data = list(np.concatenate([raw[halfIndex:],raw[:halfIndex]]))
        #data = [y**2/(self._Fs*len(data)) for y in data]
        data = 20*np.log10(data)
        data = data - 180
        return data

    def data_regen(self):
        self._data = np.average(np.transpose(self._y),axis=1)
        #self._data=self._y[0]

    def add_frame(self, frame):
        self._y = np.roll(self._y, 1, axis=0)
        self._y[0] = self.psd_from_raw(frame)
        self.data_regen()

        xaxis = self._plot.layout.xaxis
        xwidth = xaxis.range[1] - xaxis.range[0]
        axis_lo, axis_hi = xaxis.range


        self._plot.update(
            data=[
                {
                    #'mode': 'markers',
                    'x': self._x_data,
                    'y': self._data,
                }
        ])


        ##Assigment twice is a dirty hack to ensure we get a redraw
        #xaxis.range = (axis_lo+1/len(self._y[0]), axis_hi)
        #xaxis.range = (axis_lo, axis_hi)

    def get_widget(self):
        """Return plot widget"""
        return self._plot
