import time
import threading
import pynq.lib.dma
from pynq import Xlnk
import numpy as np
import ipywidgets as ipw

class DmaTimer():

    def __init__(self, callback, gen, t):
        """Create new dma-based data generator.

        callback: function to call with data chunk
        gen: function to call to return data chunk
             (usually a dma channel's transfer function
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

    def getControls(self):
        start_button = ipw.Button(description=u'\u25B6')
        start_button.on_click(lambda _: self.start())
        stop_button = ipw.Button(description=u'\u25A0')
        stop_button.on_click(lambda _: self.stop())
        return [start_button, stop_button]
