<img src="https://www.strath.ac.uk/media/1newwebsite/webteam/logos/xUoS_Logo_Horizontal.png.pagespeed.ic.M6gv_BmDx1.png" width="350">

# RFSoC QPSK Transceiver 

## Introduction
This repo contains all the files needed to build and run the RFSoC QPSK demonstrator that was presented at both [FPL](https://fpl2018.org/) and [XDF](http://www.xilinx.com/xdf) conferences in 2018. The design is a full QPSK transceiver, which transmits and receives randomly-generated pulse-shaped symbols with full carrier and timing synchronisation. [PYNQ](https://github.com/xilinx/pynq) is used to visualise the data at both the DAC and ADC side of the RFSoC data converters, as well as visualising various DSP stages throughout the transmit and receive signal path.

<p align="center">
  <img src="https://github.com/strath-sdr/rfsoc_qpsk_demo/blob/master/img/constellation_small.gif" width="400" height="400" />
<p/>

## Quick Start
Open a terminal in Jupyter Labs and run:
```sh
pip3 install --upgrade git+https://github.com/strath-sdr/rfsocqpsk.git

jupyter labextension install @jupyter-widgets/jupyterlab-manager@0.38
jupyter labextension install plotlywidget@0.7.1
jupyter labextension install @jupyterlab/plotly-extension@0.18
```
This repository is only compatible with [PYNQ image v2.4](https://github.com/Xilinx/PYNQ/releases) for [ZCU111](https://www.xilinx.com/products/boards-and-kits/zcu111.html) 

Use Chrome if possible — the rendering performance is important.

## ZCU111 Setup
We use DAC2 from tile 229 to transmit and ADC0 from tile 224 to receive. These correspond to connections J5 and J4 on the HW-FMC-XM500 daughter board respectively. SW6 on the ZCU111 must be set to boot from SD card (as shown in the image below).

<p align="center">
<img src="https://github.com/strath-sdr/rfsoc_qpsk_demo/blob/master/img/rfsoc_setup.png" width="800">
<p/>

## Using the Project Files
All software builds have been tested on Ubuntu 16.04
#### Requirements
- Vivado Design Suite 2018.3
- System Generator for DSP
- MATLAB 2017b

### System Generator
The Tx and Rx IPs are in separate directories in `rfsoc_qpsk_demo/board/sysgen/` that can be opened using the appropriate System Generator dialogue. Due to the large amount of decimation and interpolation in both IPs, simulating the output can take an extraordinarily long time. A less extreme multirate system would simulate much faster! 

### Vivado
This project can be built with Vivado from the command line:
```sh
cd rfsoc_qpsk_demo/board/ZCU111/
source <Xilinx_dir>/Vivado/2018.3/settings64.sh
vivado -mode batch -nojournal -nolog -source write_project.tcl
```
The tcl file creates a new project and builds the IPI block design, but does not generate a bitstream as there is already a valid one in the repo.

## Known Issues
- Live plots are currently quite demanding of the client browser (but not the RFSoC). A hefty desktop helps a lot in the meantime!
- There is a large drop in gain between the ADC and the final output

## License 
[BSD 3-Clause](github.com/strath-sdr/rfsoc_qpsk_demo/LICENSE)
