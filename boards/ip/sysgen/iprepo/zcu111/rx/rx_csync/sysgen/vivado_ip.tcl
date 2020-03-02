#-----------------------------------------------------------------
# System Generator version 2018.3 IP Tcl source file.
#
# Copyright(C) 2018 by Xilinx, Inc.  All rights reserved.  This
# text/file contains proprietary, confidential information of Xilinx,
# Inc., is distributed under license from Xilinx, Inc., and may be used,
# copied and/or disclosed only pursuant to the terms of a valid license
# agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
# this text/file solely for design, simulation, implementation and
# creation of design files limited to Xilinx devices or technologies.
# Use with non-Xilinx devices or technologies is expressly prohibited
# and immediately terminates your license unless covered by a separate
# agreement.
#
# Xilinx is providing this design, code, or information "as is" solely
# for use in developing programs and solutions for Xilinx devices.  By
# providing this design, code, or information as one possible
# implementation of this feature, application or standard, Xilinx is
# making no representation that this implementation is free from any
# claims of infringement.  You are responsible for obtaining any rights
# you may require for your implementation.  Xilinx expressly disclaims
# any warranty whatsoever with respect to the adequacy of the
# implementation, including but not limited to warranties of
# merchantability or fitness for a particular purpose.
#
# Xilinx products are not intended for use in life support appliances,
# devices, or systems.  Use in such applications is expressly prohibited.
#
# Any modifications that are made to the source code are done at the user's
# sole risk and will be unsupported.
#
# This copyright and support notice must be retained as part of this
# text at all times.  (c) Copyright 1995-2018 Xilinx, Inc.  All rights
# reserved.
#-----------------------------------------------------------------

set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_xfft_v9_1_i0] < 0} {
create_ip -name xfft -version 9.1 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_xfft_v9_1_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_xfft_v9_1_i0}
lappend params_list CONFIG.aclken {true}
lappend params_list CONFIG.aresetn {false}
lappend params_list CONFIG.butterfly_type {use_luts}
lappend params_list CONFIG.channels {1}
lappend params_list CONFIG.complex_mult_type {use_mults_resources}
lappend params_list CONFIG.cyclic_prefix_insertion {false}
lappend params_list CONFIG.data_format {fixed_point}
lappend params_list CONFIG.implementation_options {pipelined_streaming_io}
lappend params_list CONFIG.input_width {16}
lappend params_list CONFIG.memory_options_data {block_ram}
lappend params_list CONFIG.memory_options_hybrid {false}
lappend params_list CONFIG.memory_options_phase_factors {block_ram}
lappend params_list CONFIG.memory_options_reorder {block_ram}
lappend params_list CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {2}
lappend params_list CONFIG.output_ordering {natural_order}
lappend params_list CONFIG.ovflo {false}
lappend params_list CONFIG.phase_factor_width {16}
lappend params_list CONFIG.rounding_modes {truncation}
lappend params_list CONFIG.run_time_configurable_transform_length {false}
lappend params_list CONFIG.scaling_options {unscaled}
lappend params_list CONFIG.target_clock_frequency {250}
lappend params_list CONFIG.target_data_throughput {50}
lappend params_list CONFIG.throttle_scheme {nonrealtime}
lappend params_list CONFIG.transform_length {512}
lappend params_list CONFIG.xk_index {true}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_xfft_v9_1_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_cmpy_v6_0_i0] < 0} {
create_ip -name cmpy -version 6.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_cmpy_v6_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_cmpy_v6_0_i0}
lappend params_list CONFIG.ACLKEN {true}
lappend params_list CONFIG.APortWidth {16}
lappend params_list CONFIG.ARESETN {false}
lappend params_list CONFIG.ATUSERWidth {1}
lappend params_list CONFIG.BPortWidth {16}
lappend params_list CONFIG.BTUSERWidth {1}
lappend params_list CONFIG.CTRLTUSERWidth {1}
lappend params_list CONFIG.FlowControl {NonBlocking}
lappend params_list CONFIG.HasATLAST {false}
lappend params_list CONFIG.HasATUSER {false}
lappend params_list CONFIG.HasBTLAST {false}
lappend params_list CONFIG.HasBTUSER {false}
lappend params_list CONFIG.HasCTRLTLAST {false}
lappend params_list CONFIG.HasCTRLTUSER {false}
lappend params_list CONFIG.LatencyConfig {Manual}
lappend params_list CONFIG.MinimumLatency {4}
lappend params_list CONFIG.MultType {Use_Mults}
lappend params_list CONFIG.OptimizeGoal {Performance}
lappend params_list CONFIG.OutTLASTBehv {Null}
lappend params_list CONFIG.OutputWidth {33}
lappend params_list CONFIG.RoundMode {Truncate}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_cmpy_v6_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_cmpy_v6_0_i1] < 0} {
create_ip -name cmpy -version 6.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_cmpy_v6_0_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_cmpy_v6_0_i1}
lappend params_list CONFIG.ACLKEN {true}
lappend params_list CONFIG.APortWidth {19}
lappend params_list CONFIG.ARESETN {false}
lappend params_list CONFIG.ATUSERWidth {1}
lappend params_list CONFIG.BPortWidth {19}
lappend params_list CONFIG.BTUSERWidth {1}
lappend params_list CONFIG.CTRLTUSERWidth {1}
lappend params_list CONFIG.FlowControl {NonBlocking}
lappend params_list CONFIG.HasATLAST {false}
lappend params_list CONFIG.HasATUSER {false}
lappend params_list CONFIG.HasBTLAST {false}
lappend params_list CONFIG.HasBTUSER {false}
lappend params_list CONFIG.HasCTRLTLAST {false}
lappend params_list CONFIG.HasCTRLTUSER {false}
lappend params_list CONFIG.LatencyConfig {Manual}
lappend params_list CONFIG.MinimumLatency {6}
lappend params_list CONFIG.MultType {Use_Mults}
lappend params_list CONFIG.OptimizeGoal {Performance}
lappend params_list CONFIG.OutTLASTBehv {Null}
lappend params_list CONFIG.OutputWidth {39}
lappend params_list CONFIG.RoundMode {Truncate}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_cmpy_v6_0_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_blk_mem_gen_i0] < 0} {
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_blk_mem_gen_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_blk_mem_gen_i0}
lappend params_list CONFIG.algorithm {Minimum_Area}
lappend params_list CONFIG.assume_synchronous_clk {false}
lappend params_list CONFIG.byte_size {9}
lappend params_list CONFIG.collision_warnings {ALL}
lappend params_list CONFIG.disable_collision_warnings {false}
lappend params_list CONFIG.ecc {false}
lappend params_list CONFIG.en_safety_ckt {false}
lappend params_list CONFIG.enable_a {Use_ENA_Pin}
lappend params_list CONFIG.enable_b {Always_Enabled}
lappend params_list CONFIG.error_injection_type {Single_Bit_Error_Injection}
lappend params_list CONFIG.fill_remaining_memory_locations {false}
lappend params_list CONFIG.load_init_file {TRUE}
lappend params_list CONFIG.memory_type {Single_Port_ROM}
lappend params_list CONFIG.operating_mode_a {WRITE_FIRST}
lappend params_list CONFIG.operating_mode_b {WRITE_FIRST}
lappend params_list CONFIG.output_reset_value_a {0}
lappend params_list CONFIG.output_reset_value_b {0}
lappend params_list CONFIG.pipeline_stages {0}
lappend params_list CONFIG.primitive {8kx2}
lappend params_list CONFIG.read_width_a {19}
lappend params_list CONFIG.read_width_b {19}
lappend params_list CONFIG.register_porta_output_of_memory_core {false}
lappend params_list CONFIG.register_porta_output_of_memory_primitives {false}
lappend params_list CONFIG.register_portb_output_of_memory_core {false}
lappend params_list CONFIG.register_portb_output_of_memory_primitives {false}
lappend params_list CONFIG.remaining_memory_locations {0}
lappend params_list CONFIG.reset_type {SYNC}
lappend params_list CONFIG.use_byte_write_enable {false}
lappend params_list CONFIG.use_error_injection_pins {false}
lappend params_list CONFIG.use_regcea_pin {false}
lappend params_list CONFIG.use_regceb_pin {false}
lappend params_list CONFIG.use_rsta_pin {false}
lappend params_list CONFIG.use_rstb_pin {false}
lappend params_list CONFIG.write_depth_a {512}
lappend params_list CONFIG.write_width_a {19}
lappend params_list CONFIG.write_width_b {19}
lappend params_list CONFIG.coe_file {../axi_qpsk_rx_csync_blk_mem_gen_i0_vivado.coe}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_blk_mem_gen_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_c_addsub_v12_0_i0] < 0} {
create_ip -name c_addsub -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_c_addsub_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_c_addsub_v12_0_i0}
lappend params_list CONFIG.AINIT_Value {0}
lappend params_list CONFIG.A_Type {Signed}
lappend params_list CONFIG.A_Width {22}
lappend params_list CONFIG.Add_Mode {Add}
lappend params_list CONFIG.B_Constant {false}
lappend params_list CONFIG.B_Type {Signed}
lappend params_list CONFIG.B_Value {0}
lappend params_list CONFIG.B_Width {22}
lappend params_list CONFIG.Borrow_Sense {Active_Low}
lappend params_list CONFIG.Bypass {false}
lappend params_list CONFIG.Bypass_CE_Priority {Bypass_Overrides_CE}
lappend params_list CONFIG.Bypass_Sense {Active_Low}
lappend params_list CONFIG.CE {false}
lappend params_list CONFIG.C_In {false}
lappend params_list CONFIG.C_Out {false}
lappend params_list CONFIG.Implementation {Fabric}
lappend params_list CONFIG.Latency {0}
lappend params_list CONFIG.Out_Width {22}
lappend params_list CONFIG.SCLR {false}
lappend params_list CONFIG.SINIT {false}
lappend params_list CONFIG.SINIT_Value {0}
lappend params_list CONFIG.SSET {false}
lappend params_list CONFIG.Sync_CE_Priority {Sync_Overrides_CE}
lappend params_list CONFIG.Sync_Ctrl_Priority {Reset_Overrides_Set}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_c_addsub_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_mult_gen_v12_0_i0] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_mult_gen_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_mult_gen_v12_0_i0}
lappend params_list CONFIG.ccmimp {Distributed_Memory}
lappend params_list CONFIG.clockenable {true}
lappend params_list CONFIG.constvalue {262}
lappend params_list CONFIG.internaluser {0}
lappend params_list CONFIG.multtype {Constant_Coefficient_Multiplier}
lappend params_list CONFIG.outputwidthhigh {29}
lappend params_list CONFIG.outputwidthlow {0}
lappend params_list CONFIG.pipestages {1}
lappend params_list CONFIG.portatype {Signed}
lappend params_list CONFIG.portawidth {19}
lappend params_list CONFIG.portbtype {Unsigned}
lappend params_list CONFIG.portbwidth {11}
lappend params_list CONFIG.syncclear {true}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_mult_gen_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_blk_mem_gen_i1] < 0} {
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_blk_mem_gen_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_blk_mem_gen_i1}
lappend params_list CONFIG.algorithm {Minimum_Area}
lappend params_list CONFIG.assume_synchronous_clk {false}
lappend params_list CONFIG.byte_size {9}
lappend params_list CONFIG.collision_warnings {ALL}
lappend params_list CONFIG.disable_collision_warnings {false}
lappend params_list CONFIG.ecc {false}
lappend params_list CONFIG.en_safety_ckt {false}
lappend params_list CONFIG.enable_a {Use_ENA_Pin}
lappend params_list CONFIG.enable_b {Always_Enabled}
lappend params_list CONFIG.error_injection_type {Single_Bit_Error_Injection}
lappend params_list CONFIG.fill_remaining_memory_locations {false}
lappend params_list CONFIG.load_init_file {TRUE}
lappend params_list CONFIG.memory_type {Single_Port_ROM}
lappend params_list CONFIG.operating_mode_a {WRITE_FIRST}
lappend params_list CONFIG.operating_mode_b {WRITE_FIRST}
lappend params_list CONFIG.output_reset_value_a {0}
lappend params_list CONFIG.output_reset_value_b {0}
lappend params_list CONFIG.pipeline_stages {0}
lappend params_list CONFIG.primitive {8kx2}
lappend params_list CONFIG.read_width_a {16}
lappend params_list CONFIG.read_width_b {16}
lappend params_list CONFIG.register_porta_output_of_memory_core {false}
lappend params_list CONFIG.register_porta_output_of_memory_primitives {false}
lappend params_list CONFIG.register_portb_output_of_memory_core {false}
lappend params_list CONFIG.register_portb_output_of_memory_primitives {false}
lappend params_list CONFIG.remaining_memory_locations {0}
lappend params_list CONFIG.reset_type {SYNC}
lappend params_list CONFIG.use_byte_write_enable {false}
lappend params_list CONFIG.use_error_injection_pins {false}
lappend params_list CONFIG.use_regcea_pin {false}
lappend params_list CONFIG.use_regceb_pin {false}
lappend params_list CONFIG.use_rsta_pin {false}
lappend params_list CONFIG.use_rstb_pin {false}
lappend params_list CONFIG.write_depth_a {1024}
lappend params_list CONFIG.write_width_a {16}
lappend params_list CONFIG.write_width_b {16}
lappend params_list CONFIG.coe_file {../axi_qpsk_rx_csync_blk_mem_gen_i1_vivado.coe}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_blk_mem_gen_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_blk_mem_gen_i2] < 0} {
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_blk_mem_gen_i2
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_blk_mem_gen_i2}
lappend params_list CONFIG.algorithm {Minimum_Area}
lappend params_list CONFIG.assume_synchronous_clk {false}
lappend params_list CONFIG.byte_size {9}
lappend params_list CONFIG.collision_warnings {ALL}
lappend params_list CONFIG.disable_collision_warnings {false}
lappend params_list CONFIG.ecc {false}
lappend params_list CONFIG.en_safety_ckt {false}
lappend params_list CONFIG.enable_a {Use_ENA_Pin}
lappend params_list CONFIG.enable_b {Always_Enabled}
lappend params_list CONFIG.error_injection_type {Single_Bit_Error_Injection}
lappend params_list CONFIG.fill_remaining_memory_locations {false}
lappend params_list CONFIG.load_init_file {TRUE}
lappend params_list CONFIG.memory_type {Single_Port_ROM}
lappend params_list CONFIG.operating_mode_a {WRITE_FIRST}
lappend params_list CONFIG.operating_mode_b {WRITE_FIRST}
lappend params_list CONFIG.output_reset_value_a {0}
lappend params_list CONFIG.output_reset_value_b {0}
lappend params_list CONFIG.pipeline_stages {0}
lappend params_list CONFIG.primitive {8kx2}
lappend params_list CONFIG.read_width_a {16}
lappend params_list CONFIG.read_width_b {16}
lappend params_list CONFIG.register_porta_output_of_memory_core {false}
lappend params_list CONFIG.register_porta_output_of_memory_primitives {false}
lappend params_list CONFIG.register_portb_output_of_memory_core {false}
lappend params_list CONFIG.register_portb_output_of_memory_primitives {false}
lappend params_list CONFIG.remaining_memory_locations {0}
lappend params_list CONFIG.reset_type {SYNC}
lappend params_list CONFIG.use_byte_write_enable {false}
lappend params_list CONFIG.use_error_injection_pins {false}
lappend params_list CONFIG.use_regcea_pin {false}
lappend params_list CONFIG.use_regceb_pin {false}
lappend params_list CONFIG.use_rsta_pin {false}
lappend params_list CONFIG.use_rstb_pin {false}
lappend params_list CONFIG.write_depth_a {1024}
lappend params_list CONFIG.write_width_a {16}
lappend params_list CONFIG.write_width_b {16}
lappend params_list CONFIG.coe_file {../axi_qpsk_rx_csync_blk_mem_gen_i2_vivado.coe}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_blk_mem_gen_i2]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_mult_gen_v12_0_i1] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_mult_gen_v12_0_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_mult_gen_v12_0_i1}
lappend params_list CONFIG.clockenable {true}
lappend params_list CONFIG.multiplier_construction {Use_Mults}
lappend params_list CONFIG.optgoal {Speed}
lappend params_list CONFIG.outputwidthhigh {29}
lappend params_list CONFIG.pipestages {3}
lappend params_list CONFIG.portatype {Signed}
lappend params_list CONFIG.portawidth {15}
lappend params_list CONFIG.portbtype {Signed}
lappend params_list CONFIG.portbwidth {15}
lappend params_list CONFIG.sclrcepriority {CE_Overrides_SCLR}
lappend params_list CONFIG.syncclear {true}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_mult_gen_v12_0_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_c_counter_binary_v12_0_i0] < 0} {
create_ip -name c_counter_binary -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_c_counter_binary_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_c_counter_binary_v12_0_i0}
lappend params_list CONFIG.ainit_value {0}
lappend params_list CONFIG.ce {true}
lappend params_list CONFIG.count_mode {UP}
lappend params_list CONFIG.fb_latency {0}
lappend params_list CONFIG.final_count_value {1}
lappend params_list CONFIG.implementation {Fabric}
lappend params_list CONFIG.increment_value {1}
lappend params_list CONFIG.latency {1}
lappend params_list CONFIG.load {false}
lappend params_list CONFIG.output_width {32}
lappend params_list CONFIG.restrict_count {false}
lappend params_list CONFIG.sclr {false}
lappend params_list CONFIG.sinit {true}
lappend params_list CONFIG.sinit_value {0}
lappend params_list CONFIG.sset {false}
lappend params_list CONFIG.sync_ce_priority {Sync_Overrides_CE}
lappend params_list CONFIG.sync_threshold_output {false}
lappend params_list CONFIG.syncctrlpriority {Reset_Overrides_Set}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_c_counter_binary_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_csync_fifo_generator_i0] < 0} {
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name axi_qpsk_rx_csync_fifo_generator_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_csync_fifo_generator_i0}
lappend params_list CONFIG.almost_empty_flag {false}
lappend params_list CONFIG.almost_full_flag {false}
lappend params_list CONFIG.data_count {true}
lappend params_list CONFIG.data_count_width {10}
lappend params_list CONFIG.disable_timing_violations {false}
lappend params_list CONFIG.dout_reset_value {0}
lappend params_list CONFIG.enable_ecc {false}
lappend params_list CONFIG.enable_reset_synchronization {true}
lappend params_list CONFIG.enable_safety_circuit {false}
lappend params_list CONFIG.fifo_implementation {Common_Clock_Block_RAM}
lappend params_list CONFIG.full_flags_reset_value {0}
lappend params_list CONFIG.inject_dbit_error {false}
lappend params_list CONFIG.inject_sbit_error {false}
lappend params_list CONFIG.input_data_width {32}
lappend params_list CONFIG.input_depth {1024}
lappend params_list CONFIG.output_data_width {32}
lappend params_list CONFIG.output_depth {1024}
lappend params_list CONFIG.overflow_flag {false}
lappend params_list CONFIG.overflow_sense {Active_High}
lappend params_list CONFIG.performance_options {Standard_FIFO}
lappend params_list CONFIG.programmable_empty_type {No_Programmable_Empty_Threshold}
lappend params_list CONFIG.programmable_full_type {No_Programmable_Full_Threshold}
lappend params_list CONFIG.reset_pin {true}
lappend params_list CONFIG.underflow_flag {false}
lappend params_list CONFIG.underflow_sense {Active_High}
lappend params_list CONFIG.use_dout_reset {true}
lappend params_list CONFIG.use_embedded_registers {false}
lappend params_list CONFIG.use_extra_logic {false}
lappend params_list CONFIG.valid_flag {false}
lappend params_list CONFIG.valid_sense {Active_High}
lappend params_list CONFIG.write_acknowledge_flag {false}
lappend params_list CONFIG.write_acknowledge_sense {Active_High}

set_property -dict $params_list [get_ips axi_qpsk_rx_csync_fifo_generator_i0]
}


validate_ip [get_ips]
