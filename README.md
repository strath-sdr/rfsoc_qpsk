# University of Strathclyde - SDR LAB
## RFSoC ZCU111 QPSK Demo

### Introduction
This repo contains the files for the RFSoC ZCU111 QPSK demonstrator we presented at both FPL and XDF conferences in 2018.

### Requirements
#### Hardware
- Xilinx ZCU111 development board
- Minimum 8GB Micro SD Card
- SMA connector
#### Software
- Vivado Design Suite 2018.2
- System Generator for DSP
- MATLAB 2017b
- ZCU111 Pynq Image

(All software builds have been Tested on Ubuntu 16.04)


### ToDo
- Write short tutorial on how to set up hardware and run the demo
- Remove second high performance port from PS IP and use a top-level AXI Interconnect IP to serve Rx and Tx hierarchies
- Clean up IPI design
- Profile Plotly client-side performance

### Known Issues
#### Vivado
#### System Generator
- Large rate changes makes simulating current project incredibly slow.
#### Pynq
- Live plots are currently quite demanding of the client browser (but not the RFSoC). A hefty desktop helps a lot in the meantime!
#### Other
