# RFSoC ZCU111 QPSK Transceiver Demo

## Introduction
This repo contains all the files needed to build and run the RFSoC ZCU111 QPSK demonstrator that was presented at both FPL and XDF conferences in 2018. The design is a full QPSK transceiver, which transmits and receives randomly-generated pulse-shaped symbols with full carrier and timing synchronisation. [Pynq](https://github.com/xilinx/pynq) is used to visualise the data at both the DAC and ADC side of the RFSoC data converters, as well as visualising various DSP stages throughout transmit and receive signal path.

## Requirements
### Hardware
- Xilinx ZCU111 development board Rev-1.0
- Minimum 8GB Micro SD Card
- SMA connector
### Software
- Vivado Design Suite 2018.2
- System Generator for DSP
- MATLAB 2017b
- ZCU111 Pynq v2.4 Image

(All software builds have been Tested on Ubuntu 16.04)

## HowTo
### System Generator
The Tx and Rx IPs are in separate directories in `rfsoc_qpsk_demo/board/sysgen/` that can be opened using the appropriate System Generator dialogue. Due to the large amount of decimation and interpolation in both IPs, simulating the output can take an extraordinarily long time. A less extreme multirate system would simulate much faster! 

### Vivado
The project can be built with Vivado from the command line:
```sh
cd rfsoc_qpsk_demo/board/ZCU111/
source <Xilinx_dir>/Vivado/2018.2/settings64.sh
vivado -mode batch -nojournal -nolog -source write_project.tcl
```
Your ZCU111 board file must be in a place Vivado knows about (e.g. `<Vivado_dir>/2018.2/data/boards/board_files/`) otherwise Vivado will throw an error and stop building the project. The tcl file creates a new project and builds the IPI block design, but does not generate a bitstream as there is already a valid one in the repo.

## ToDo
- Write short tutorial on how to set up hardware and run the demo
- Remove second high performance port from PS IP and use a top-level AXI Interconnect IP to serve Rx and Tx hierarchies
- Clean up IPI design
- Profile Plotly client-side performance
- Upgrade to Vivado 2018.3

## Known Issues
### Vivado
- Various warnings during synthesis and implementation need to be addressed (this is mainly development guff and can mostly be ignored).
### System Generator
- Large rate changes makes simulating current project incredibly slow.
### Pynq
- Live plots are currently quite demanding of the client browser (but not the RFSoC). A hefty desktop helps a lot in the meantime!
### Other

## License 
[BSD 3-Clause](github.com/strath-sdr/rfsoc_qpsk_demo/LICENSE)
