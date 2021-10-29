<img src="strathsdr_banner.png" width="100%">

# RFSoC QPSK Transceiver
This repository is only compatible with [PYNQ images v2.7](https://github.com/Xilinx/PYNQ/releases) for the [ZCU111](https://www.xilinx.com/products/boards-and-kits/zcu111.html) and [RFSoC2x2](http://rfsoc-pynq.io/).

## Introduction
This repo contains all the files needed to build and run the RFSoC QPSK demonstrator that was published in [IEEE Access](https://ieeexplore.ieee.org/document/9139483) and was presented at both [FPL](https://fpl2018.org/) and [XDF](http://www.xilinx.com/xdf) conferences in 2018. The design is a full QPSK transceiver, which transmits and receives randomly-generated pulse-shaped symbols with full carrier and timing synchronisation. [PYNQ](https://github.com/xilinx/pynq) is used to visualise the data at both the DAC and ADC side of the RFSoC data converters, as well as visualising various DSP stages throughout the transmit and receive signal path.

<p align="center">
  <img src="demonstration.gif" />
<p/>

## Quick Start
Follow the instructions below to install the QPSK demonstrator on your development board. **You will need to give your board access to the internet**.
* Power on your RFSoC2x2 or ZCU111 development board with an SD Card containing a fresh PYNQ v2.7 image.
* Navigate to Jupyter Labs by opening a browser (preferably Chrome) and connecting to `http://<board_ip_address>:9090/lab`.
* We need to open a terminal in Jupyter Lab. Firstly, open a launcher window as shown in the figure below:

<p align="center">
  <img src="../master/open_jupyter_launcher.jpg" width="50%" height="50%" />
<p/>

* Now open a terminal in Jupyter as illustrated below:

<p align="center">
  <img src="../master/open_terminal_window.jpg" width="50%" height="50%" />
<p/>

* Now simply install the QPSK demonstrator through PIP by executing the following command in the terminal:

```sh
pip3 install git+https://github.com/strath-sdr/rfsoc_qpsk
```

Once installation has complete, you will find the QPSK demonstrator notebooks located in the jupyter home workspace in the `qpsk-demonstrator` folder.

This repository uses Voila to create simple web applications using Jupyter notebooks. Your RFSoC2x2 or ZCU111 development board should already be preinstalled with a version of Voila and no further setup is required.

## Using the Project Files
The following software is required to use the project files in this repository.
- Vivado Design Suite 2020.1
- System Generator for DSP
- MATLAB R2020a

### System Generator
The Tx and Rx IPs are in separate directories in `rfsoc_qpsk/boards/ip/sysgen/` that can be opened using the appropriate System Generator dialogue. Due to the large amount of decimation and interpolation in both IPs, simulating the output can take an extraordinarily long time. A less extreme multirate system would simulate much faster! 

### Vivado
This project can be built with Vivado from the command line. Open Vivado 2020.1 and execute the following into the tcl console:

```sh
cd /<repository-location>/boards/<board-name>/rfsoc_qpsk/
```

Now that we have moved into the correct directory, make the Vivado project by running the make commands below sequentially.

```sh
make project
make block_design
make bitstream_file
```

Alternatively, you can run the entire project build by executing the following into the tcl console:
```sh
make all
```

## License 
[BSD 3-Clause](../../blob/master/LICENSE)
