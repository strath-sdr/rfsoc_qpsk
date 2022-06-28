## RFSoC4x2 Constraints

set_property PACKAGE_PIN AR11    [get_ports {leds_clk_lock[0]}];
set_property PACKAGE_PIN AW10   [get_ports {leds_clk_lock[1]}];
set_property IOSTANDARD LVCMOS18 [get_ports {leds_clk_lock[0]}];
set_property IOSTANDARD LVCMOS18 [get_ports {leds_clk_lock[1]}];
