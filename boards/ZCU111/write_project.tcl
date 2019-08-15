# Vivado 2018.3
# RFSoC QPSK Transceiver Demo
# Copyright (c) 2019, Louise Crockett, Josh Goldsmith, David Northcote, and Craig Ramsay
# All rights reserved

set origin_dir "."
set iprepo_dir $origin_dir/../ip

create_project rfsoc_qpsk $origin_dir/rfsoc_pynq -part xczu28dr-ffvg1517-2-e
set_property board_part xilinx.com:zcu111:part0:1.1 [current_project]
set_property  ip_repo_paths $iprepo_dir [current_project]
set_property target_language VHDL [current_project]
update_ip_catalog
source $origin_dir/block_design.tcl
make_wrapper -files [get_files $origin_dir/rfsoc_pynq/rfsoc_qpsk.srcs/sources_1/bd/block_design/block_design.bd] -top
add_files -norecurse $origin_dir/rfsoc_pynq/rfsoc_qpsk.srcs/sources_1/bd/block_design/hdl/block_design_wrapper.vhd
update_compile_order -fileset sources_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
file copy -force $origin_dir/rfsoc_pynq/rfsoc_qpsk.runs/impl_1/block_design_wrapper.bit $origin_dir/rfsoc_qpsk/bitstream/rfsoc_qpsk.bit
file copy -force $origin_dir/rfsoc_pynq/rfsoc_qpsk.srcs/sources_1/bd/block_design/hw_handoff/block_design.hwh $origin_dir/rfsoc_qpsk/bitstream/rfsoc_qpsk.hwh
