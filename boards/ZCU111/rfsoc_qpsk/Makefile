overlay_name := rfsoc_qpsk
design_name := block_design

all: project block_design bitstream_file

project:
	vivado -mode batch -source make_project.tcl -notrace

block_design:
	vivado -mode batch -source make_block_design.tcl -notrace

bitstream_file:
	vivado -mode batch -source make_bitstream.tcl -notrace