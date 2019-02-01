import time
import threading
import pynq.lib.dma
from pynq import Xlnk
import numpy as np

class DmaGen():

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
        #file = open("/tmp/graph_periods.txt","w") 
        while not self.stopping:
            next_timer = time.time() + self.t
            self.callback(self.gen())
            sleep_time = next_timer - time.time()
            #file.write("{0},\t".format(time.time()-start_timer))
            if sleep_time > 0:
                time.sleep(sleep_time)
            #file.write("{0}\n".format(time.time()-start_timer))
        #file.close()

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