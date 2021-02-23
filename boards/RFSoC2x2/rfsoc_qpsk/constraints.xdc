## RFSoC2x2 Constraints

set_property PACKAGE_PIN AT9 [get_ports "lmk_reset[0]"]
set_property IOSTANDARD LVCMOS18 [get_ports "lmk_reset[0]"]

set_property PACKAGE_PIN AR12 [get_ports {leds_clk_lock[0]}];
set_property PACKAGE_PIN AT12 [get_ports {leds_clk_lock[1]}];
set_property IOSTANDARD LVCMOS18 [get_ports {leds_clk_lock[?]}];

set_property PACKAGE_PIN AP9 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports reset]