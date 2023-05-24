all: bitstream clean

block_design:
	vivado -mode batch -source make_block_design.tcl -notrace

bitstream:
	$(MAKE) block_design
	vivado -mode batch -source make_bitstream.tcl -notrace

clean:
	rm -rf block_design *.jou *.log NA .Xil || true