import time
import threading
import pynq.lib.dma
from pynq import Xlnk
import numpy as np
import ipywidgets as ipw


class DmaTimer():
    """Class for scheduling periodic callbacks.

    Timer class for periodically passing new data from a generator to a
    callback function. Useful for passing data from DMA transfers back to a
    visualisation function.
    """

    def __init__(self, callback, gen, t):
        """Create new dma-based data timer.

        callback: function to call with data chunk
        gen: function to call to return data chunk
             (usually a dma channel's transfer function)
        t: time between each generated data chunk
        """
        self.callback = callback
        self.gen = gen
        self.t = t

    def _do(self):
        """Generate new data and restart timer thread.

        Should never be run directly. use `start()` instead.
        """
        while not self.stopping:
            next_timer = time.time() + self.t
            self.callback(self.gen())
            sleep_time = next_timer - time.time()
            if sleep_time > 0:
                time.sleep(sleep_time)

    def start(self):
        """Start the data generator thread."""
        self.stopping = False

        thread = threading.Thread(target=self._do)
        thread.start()

    def stop(self):
        """Stop a running data generator thread.

        Does not need a lock, since the spawned timer thread will only read `self.stopping`.
        """
        self.stopping = True

    def get_widget(self):
        """Get ipywidget controls to stop and start the generator thread."""
        start_button = ipw.Button(description=u'\u25B6')
        start_button.on_click(lambda _: self.start())
        stop_button = ipw.Button(description=u'\u25A0')
        stop_button.on_click(lambda _: self.stop())
        return [start_button, stop_button]
