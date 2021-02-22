#-----------------------------------------------------------------
# System Generator version 2020.1 IP Tcl source file.
#
# Copyright(C) 2020 by Xilinx, Inc.  All rights reserved.  This
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
# text at all times.  (c) Copyright 1995-2020 Xilinx, Inc.  All rights
# reserved.
#-----------------------------------------------------------------

set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_c_counter_binary_v12_0_i0] < 0} {
create_ip -name c_counter_binary -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_c_counter_binary_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_c_counter_binary_v12_0_i0}
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

set_property -dict $params_list [get_ips axi_qpsk_tx_c_counter_binary_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_fifo_generator_i0] < 0} {
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name axi_qpsk_tx_fifo_generator_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_fifo_generator_i0}
lappend params_list CONFIG.almost_empty_flag {false}
lappend params_list CONFIG.almost_full_flag {false}
lappend params_list CONFIG.data_count {true}
lappend params_list CONFIG.data_count_width {12}
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
lappend params_list CONFIG.input_depth {4096}
lappend params_list CONFIG.output_data_width {32}
lappend params_list CONFIG.output_depth {4096}
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

set_property -dict $params_list [get_ips axi_qpsk_tx_fifo_generator_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_mult_gen_v12_0_i0] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_mult_gen_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_mult_gen_v12_0_i0}
lappend params_list CONFIG.ccmimp {Distributed_Memory}
lappend params_list CONFIG.clockenable {false}
lappend params_list CONFIG.constvalue {858993459}
lappend params_list CONFIG.internaluser {0}
lappend params_list CONFIG.multtype {Constant_Coefficient_Multiplier}
lappend params_list CONFIG.outputwidthhigh {63}
lappend params_list CONFIG.outputwidthlow {0}
lappend params_list CONFIG.pipestages {0}
lappend params_list CONFIG.portatype {Unsigned}
lappend params_list CONFIG.portawidth {32}
lappend params_list CONFIG.portbtype {Unsigned}
lappend params_list CONFIG.portbwidth {32}
lappend params_list CONFIG.syncclear {false}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips axi_qpsk_tx_mult_gen_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_c_addsub_v12_0_i0] < 0} {
create_ip -name c_addsub -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_c_addsub_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_c_addsub_v12_0_i0}
lappend params_list CONFIG.AINIT_Value {0}
lappend params_list CONFIG.A_Type {Unsigned}
lappend params_list CONFIG.A_Width {65}
lappend params_list CONFIG.Add_Mode {Add}
lappend params_list CONFIG.B_Constant {false}
lappend params_list CONFIG.B_Type {Unsigned}
lappend params_list CONFIG.B_Value {0}
lappend params_list CONFIG.B_Width {65}
lappend params_list CONFIG.Borrow_Sense {Active_Low}
lappend params_list CONFIG.Bypass {false}
lappend params_list CONFIG.Bypass_CE_Priority {Bypass_Overrides_CE}
lappend params_list CONFIG.Bypass_Sense {Active_Low}
lappend params_list CONFIG.CE {true}
lappend params_list CONFIG.C_In {false}
lappend params_list CONFIG.C_Out {false}
lappend params_list CONFIG.Implementation {Fabric}
lappend params_list CONFIG.Latency {1}
lappend params_list CONFIG.Out_Width {65}
lappend params_list CONFIG.SCLR {false}
lappend params_list CONFIG.SINIT {false}
lappend params_list CONFIG.SINIT_Value {0}
lappend params_list CONFIG.SSET {false}
lappend params_list CONFIG.Sync_CE_Priority {Sync_Overrides_CE}
lappend params_list CONFIG.Sync_Ctrl_Priority {Reset_Overrides_Set}

set_property -dict $params_list [get_ips axi_qpsk_tx_c_addsub_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_c_counter_binary_v12_0_i1] < 0} {
create_ip -name c_counter_binary -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_c_counter_binary_v12_0_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_c_counter_binary_v12_0_i1}
lappend params_list CONFIG.ainit_value {0}
lappend params_list CONFIG.ce {true}
lappend params_list CONFIG.count_mode {UP}
lappend params_list CONFIG.fb_latency {0}
lappend params_list CONFIG.final_count_value {1}
lappend params_list CONFIG.implementation {Fabric}
lappend params_list CONFIG.increment_value {1}
lappend params_list CONFIG.latency {1}
lappend params_list CONFIG.load {false}
lappend params_list CONFIG.output_width {10}
lappend params_list CONFIG.restrict_count {false}
lappend params_list CONFIG.sclr {false}
lappend params_list CONFIG.sinit {true}
lappend params_list CONFIG.sinit_value {0}
lappend params_list CONFIG.sset {false}
lappend params_list CONFIG.sync_ce_priority {Sync_Overrides_CE}
lappend params_list CONFIG.sync_threshold_output {false}
lappend params_list CONFIG.syncctrlpriority {Reset_Overrides_Set}

set_property -dict $params_list [get_ips axi_qpsk_tx_c_counter_binary_v12_0_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_xfft_v9_1_i0] < 0} {
create_ip -name xfft -version 9.1 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_xfft_v9_1_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_xfft_v9_1_i0}
lappend params_list CONFIG.aclken {true}
lappend params_list CONFIG.aresetn {false}
lappend params_list CONFIG.butterfly_type {use_xtremedsp_slices}
lappend params_list CONFIG.channels {1}
lappend params_list CONFIG.complex_mult_type {use_mults_performance}
lappend params_list CONFIG.cyclic_prefix_insertion {false}
lappend params_list CONFIG.data_format {fixed_point}
lappend params_list CONFIG.implementation_options {pipelined_streaming_io}
lappend params_list CONFIG.input_width {32}
lappend params_list CONFIG.memory_options_data {block_ram}
lappend params_list CONFIG.memory_options_hybrid {false}
lappend params_list CONFIG.memory_options_phase_factors {block_ram}
lappend params_list CONFIG.memory_options_reorder {block_ram}
lappend params_list CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {3}
lappend params_list CONFIG.output_ordering {natural_order}
lappend params_list CONFIG.ovflo {false}
lappend params_list CONFIG.phase_factor_width {32}
lappend params_list CONFIG.rounding_modes {convergent_rounding}
lappend params_list CONFIG.run_time_configurable_transform_length {false}
lappend params_list CONFIG.scaling_options {scaled}
lappend params_list CONFIG.target_clock_frequency {250}
lappend params_list CONFIG.target_data_throughput {50}
lappend params_list CONFIG.throttle_scheme {nonrealtime}
lappend params_list CONFIG.transform_length {1024}
lappend params_list CONFIG.xk_index {false}

set_property -dict $params_list [get_ips axi_qpsk_tx_xfft_v9_1_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_fifo_generator_i1] < 0} {
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name axi_qpsk_tx_fifo_generator_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_fifo_generator_i1}
lappend params_list CONFIG.almost_empty_flag {false}
lappend params_list CONFIG.almost_full_flag {false}
lappend params_list CONFIG.data_count {true}
lappend params_list CONFIG.data_count_width {13}
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
lappend params_list CONFIG.input_depth {8192}
lappend params_list CONFIG.output_data_width {32}
lappend params_list CONFIG.output_depth {8192}
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

set_property -dict $params_list [get_ips axi_qpsk_tx_fifo_generator_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_fifo_generator_i2] < 0} {
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name axi_qpsk_tx_fifo_generator_i2
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_fifo_generator_i2}
lappend params_list CONFIG.almost_empty_flag {false}
lappend params_list CONFIG.almost_full_flag {false}
lappend params_list CONFIG.data_count {true}
lappend params_list CONFIG.data_count_width {12}
lappend params_list CONFIG.disable_timing_violations {false}
lappend params_list CONFIG.dout_reset_value {0}
lappend params_list CONFIG.enable_ecc {false}
lappend params_list CONFIG.enable_reset_synchronization {true}
lappend params_list CONFIG.enable_safety_circuit {false}
lappend params_list CONFIG.fifo_implementation {Common_Clock_Block_RAM}
lappend params_list CONFIG.full_flags_reset_value {0}
lappend params_list CONFIG.inject_dbit_error {false}
lappend params_list CONFIG.inject_sbit_error {false}
lappend params_list CONFIG.input_data_width {4}
lappend params_list CONFIG.input_depth {4096}
lappend params_list CONFIG.output_data_width {4}
lappend params_list CONFIG.output_depth {4096}
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

set_property -dict $params_list [get_ips axi_qpsk_tx_fifo_generator_i2]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_cic_compiler_v4_0_i0] < 0} {
create_ip -name cic_compiler -version 4.0 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_cic_compiler_v4_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_cic_compiler_v4_0_i0}
lappend params_list CONFIG.Clock_Frequency {200.0}
lappend params_list CONFIG.Differential_Delay {1}
lappend params_list CONFIG.Filter_Type {Interpolation}
lappend params_list CONFIG.Fixed_Or_Initial_Rate {3200}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.HAS_ACLKEN {true}
lappend params_list CONFIG.HAS_ARESETN {true}
lappend params_list CONFIG.HAS_DOUT_TREADY {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Input_Data_Width {16}
lappend params_list CONFIG.Input_Sample_Frequency {0.001}
lappend params_list CONFIG.Maximum_Rate {3200}
lappend params_list CONFIG.Minimum_Rate {3200}
lappend params_list CONFIG.Number_Of_Channels {1}
lappend params_list CONFIG.Number_Of_Stages {5}
lappend params_list CONFIG.Output_Data_Width {63}
lappend params_list CONFIG.Passband_Max {0.5}
lappend params_list CONFIG.Passband_Min {0.0}
lappend params_list CONFIG.Quantization {Full_Precision}
lappend params_list CONFIG.RateSpecification {Maximum_Possible}
lappend params_list CONFIG.Response_Magnitude {Normalized}
lappend params_list CONFIG.SamplePeriod {3200}
lappend params_list CONFIG.Sample_Rate_Changes {Fixed}
lappend params_list CONFIG.Stopband_Max {1.0}
lappend params_list CONFIG.Stopband_Min {0.5}
lappend params_list CONFIG.Use_Streaming_Interface {true}
lappend params_list CONFIG.Use_Xtreme_DSP_Slice {true}

set_property -dict $params_list [get_ips axi_qpsk_tx_cic_compiler_v4_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_mult_gen_v12_0_i1] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_mult_gen_v12_0_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_mult_gen_v12_0_i1}
lappend params_list CONFIG.ccmimp {Distributed_Memory}
lappend params_list CONFIG.clockenable {false}
lappend params_list CONFIG.constvalue {21990}
lappend params_list CONFIG.internaluser {0}
lappend params_list CONFIG.multtype {Constant_Coefficient_Multiplier}
lappend params_list CONFIG.outputwidthhigh {32}
lappend params_list CONFIG.outputwidthlow {0}
lappend params_list CONFIG.pipestages {0}
lappend params_list CONFIG.portatype {Signed}
lappend params_list CONFIG.portawidth {17}
lappend params_list CONFIG.portbtype {Unsigned}
lappend params_list CONFIG.portbwidth {16}
lappend params_list CONFIG.syncclear {false}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips axi_qpsk_tx_mult_gen_v12_0_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_fir_compiler_v7_2_i0] < 0} {
create_ip -name fir_compiler -version 7.2 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_fir_compiler_v7_2_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_fir_compiler_v7_2_i0}
lappend params_list CONFIG.BestPrecision {true}
lappend params_list CONFIG.Blank_Output {false}
lappend params_list CONFIG.Channel_Sequence {Basic}
lappend params_list CONFIG.Clock_Frequency {300.0}
lappend params_list CONFIG.CoefficientSource {Vector}
lappend params_list CONFIG.CoefficientVector {binary:24D19A9D22D648BFEF39E38FF3EE6B3F642839EFA70A733FD00CC1003ACD563F28B2FB79CABB6EBFEE49F25A606977BF9DF780878F0758BFD22A420024397A3F6277E7495EBB853F8F525FDBA055743F5DC24B95BABC82BFC01E781561DC95BF554F3D8C5E3593BF111EE85DD1AA683FE86288F3A1B7A03F61C88012B217A83F365561DC352A9B3F45E08FAEFE289CBFFF93A275D0CCB5BF165FD7E82770B9BFA37A6D7A3972A0BFF97330F0F472BE3F1C9B4DDB38E6D33F9A7EA1C51A2FDE3FC1E1E2C33018E13F9A7EA1C51A2FDE3F1C9B4DDB38E6D33FF97330F0F472BE3FA37A6D7A3972A0BF165FD7E82770B9BFFF93A275D0CCB5BF45E08FAEFE289CBF365561DC352A9B3F61C88012B217A83FE86288F3A1B7A03F111EE85DD1AA683F554F3D8C5E3593BFC01E781561DC95BF5DC24B95BABC82BF8F525FDBA055743F6277E7495EBB853FD22A420024397A3F9DF780878F0758BFEE49F25A606977BF28B2FB79CABB6EBFD00CC1003ACD563F642839EFA70A733FEF39E38FF3EE6B3F24D19A9D22D648BF}
lappend params_list CONFIG.Coefficient_Buffer_Type {Automatic}
lappend params_list CONFIG.Coefficient_Fanout {false}
lappend params_list CONFIG.Coefficient_File {no_coe_file_loaded}
lappend params_list CONFIG.Coefficient_Fractional_Bits {15}
lappend params_list CONFIG.Coefficient_Reload {false}
lappend params_list CONFIG.Coefficient_Sets {1}
lappend params_list CONFIG.Coefficient_Sign {Signed}
lappend params_list CONFIG.Coefficient_Structure {Inferred}
lappend params_list CONFIG.Coefficient_Width {16}
lappend params_list CONFIG.ColumnConfig {1}
lappend params_list CONFIG.Control_Broadcast_Fanout {false}
lappend params_list CONFIG.Control_Column_Fanout {false}
lappend params_list CONFIG.Control_LUT_Pipeline {false}
lappend params_list CONFIG.Control_Path_Fanout {false}
lappend params_list CONFIG.DATA_Has_TLAST {Not_Required}
lappend params_list CONFIG.DATA_TUSER_Width {1}
lappend params_list CONFIG.Data_Buffer_Type {Automatic}
lappend params_list CONFIG.Data_Fractional_Bits {0}
lappend params_list CONFIG.Data_Path_Broadcast {false}
lappend params_list CONFIG.Data_Path_Fanout {false}
lappend params_list CONFIG.Data_Sign {Signed}
lappend params_list CONFIG.Data_Width {16}
lappend params_list CONFIG.Decimation_Rate {1}
lappend params_list CONFIG.Disable_Half_Band_Centre_Tap {false}
lappend params_list CONFIG.DisplayReloadOrder {false}
lappend params_list CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate}
lappend params_list CONFIG.Filter_Selection {1}
lappend params_list CONFIG.Filter_Type {Interpolation}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.Gen_MIF_Files {false}
lappend params_list CONFIG.Gen_MIF_from_COE {false}
lappend params_list CONFIG.Gen_MIF_from_Spec {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Has_ACLKEN {true}
lappend params_list CONFIG.Has_ARESETn {true}
lappend params_list CONFIG.Input_Buffer_Type {Automatic}
lappend params_list CONFIG.Inter_Column_Pipe_Length {4}
lappend params_list CONFIG.Interpolation_Rate {4}
lappend params_list CONFIG.M_DATA_Has_TREADY {false}
lappend params_list CONFIG.M_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.Multi_Column_Support {Automatic}
lappend params_list CONFIG.No_BRAM_Read_First_Mode {false}
lappend params_list CONFIG.No_SRL_Attributes {false}
lappend params_list CONFIG.Num_Reload_Slots {1}
lappend params_list CONFIG.Number_Channels {1}
lappend params_list CONFIG.Number_Paths {1}
lappend params_list CONFIG.Optimal_Column_Lengths {false}
lappend params_list CONFIG.Optimization_Goal {Area}
lappend params_list CONFIG.Optimization_List {None}
lappend params_list CONFIG.Optimization_Selection {None}
lappend params_list CONFIG.Other {false}
lappend params_list CONFIG.Output_Buffer_Type {Automatic}
lappend params_list CONFIG.Output_Rounding_Mode {Full_Precision}
lappend params_list CONFIG.Output_Width {31}
lappend params_list CONFIG.Passband_Max {0.50000000}
lappend params_list CONFIG.Passband_Min {0.00000000}
lappend params_list CONFIG.Pattern_List {P4-0,P4-1,P4-2,P4-3,P4-4}
lappend params_list CONFIG.Pre_Adder_Pipeline {false}
lappend params_list CONFIG.Preference_For_Other_Storage {Automatic}
lappend params_list CONFIG.Quantization {Quantize_Only}
lappend params_list CONFIG.RateSpecification {Maximum_Possible}
lappend params_list CONFIG.Rate_Change_Type {Integer}
lappend params_list CONFIG.Reload_File {no_coe_file_loaded}
lappend params_list CONFIG.Reset_Data_Vector {true}
lappend params_list CONFIG.S_CONFIG_Method {Single}
lappend params_list CONFIG.S_CONFIG_Sync_Mode {On_Vector}
lappend params_list CONFIG.S_DATA_Has_FIFO {false}
lappend params_list CONFIG.S_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.SamplePeriod {51200}
lappend params_list CONFIG.Sample_Frequency {0.001}
lappend params_list CONFIG.Select_Pattern {All}
lappend params_list CONFIG.Stopband_Max {1.00000000}
lappend params_list CONFIG.Stopband_Min {0.50000000}
lappend params_list CONFIG.Zero_Pack_Factor {1}

set_property -dict $params_list [get_ips axi_qpsk_tx_fir_compiler_v7_2_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_fir_compiler_v7_2_i1] < 0} {
create_ip -name fir_compiler -version 7.2 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_fir_compiler_v7_2_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_fir_compiler_v7_2_i1}
lappend params_list CONFIG.BestPrecision {true}
lappend params_list CONFIG.Blank_Output {false}
lappend params_list CONFIG.Channel_Sequence {Basic}
lappend params_list CONFIG.Clock_Frequency {300.0}
lappend params_list CONFIG.CoefficientSource {Vector}
lappend params_list CONFIG.CoefficientVector {binary:6616AAF46CE529BF000000000000000067223EE06DE0423F0000000000000000D665E45F672256BF0000000000000000017930360458663F0000000000000000B39AD3F93E6C74BF000000000000000017F5CB22DC66813F000000000000000078914769BF3B8CBF0000000000000000B405175B433B963F00000000000000005A68BCE78165A1BF00000000000000009A9E90387921AC3F000000000000000092C930E698C4B9BF0000000000000000E526E892D440D43F000000000000E03FE526E892D440D43F000000000000000092C930E698C4B9BF00000000000000009A9E90387921AC3F00000000000000005A68BCE78165A1BF0000000000000000B405175B433B963F000000000000000078914769BF3B8CBF000000000000000017F5CB22DC66813F0000000000000000B39AD3F93E6C74BF0000000000000000017930360458663F0000000000000000D665E45F672256BF000000000000000067223EE06DE0423F00000000000000006616AAF46CE529BF}
lappend params_list CONFIG.Coefficient_Buffer_Type {Automatic}
lappend params_list CONFIG.Coefficient_Fanout {false}
lappend params_list CONFIG.Coefficient_File {no_coe_file_loaded}
lappend params_list CONFIG.Coefficient_Fractional_Bits {15}
lappend params_list CONFIG.Coefficient_Reload {false}
lappend params_list CONFIG.Coefficient_Sets {1}
lappend params_list CONFIG.Coefficient_Sign {Signed}
lappend params_list CONFIG.Coefficient_Structure {Inferred}
lappend params_list CONFIG.Coefficient_Width {16}
lappend params_list CONFIG.ColumnConfig {1}
lappend params_list CONFIG.Control_Broadcast_Fanout {false}
lappend params_list CONFIG.Control_Column_Fanout {false}
lappend params_list CONFIG.Control_LUT_Pipeline {false}
lappend params_list CONFIG.Control_Path_Fanout {false}
lappend params_list CONFIG.DATA_Has_TLAST {Not_Required}
lappend params_list CONFIG.DATA_TUSER_Width {1}
lappend params_list CONFIG.Data_Buffer_Type {Automatic}
lappend params_list CONFIG.Data_Fractional_Bits {15}
lappend params_list CONFIG.Data_Path_Broadcast {false}
lappend params_list CONFIG.Data_Path_Fanout {false}
lappend params_list CONFIG.Data_Sign {Signed}
lappend params_list CONFIG.Data_Width {16}
lappend params_list CONFIG.Decimation_Rate {1}
lappend params_list CONFIG.Disable_Half_Band_Centre_Tap {false}
lappend params_list CONFIG.DisplayReloadOrder {false}
lappend params_list CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate}
lappend params_list CONFIG.Filter_Selection {1}
lappend params_list CONFIG.Filter_Type {Interpolation}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.Gen_MIF_Files {false}
lappend params_list CONFIG.Gen_MIF_from_COE {false}
lappend params_list CONFIG.Gen_MIF_from_Spec {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Has_ACLKEN {true}
lappend params_list CONFIG.Has_ARESETn {true}
lappend params_list CONFIG.Input_Buffer_Type {Automatic}
lappend params_list CONFIG.Inter_Column_Pipe_Length {4}
lappend params_list CONFIG.Interpolation_Rate {2}
lappend params_list CONFIG.M_DATA_Has_TREADY {false}
lappend params_list CONFIG.M_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.Multi_Column_Support {Automatic}
lappend params_list CONFIG.No_BRAM_Read_First_Mode {false}
lappend params_list CONFIG.No_SRL_Attributes {false}
lappend params_list CONFIG.Num_Reload_Slots {1}
lappend params_list CONFIG.Number_Channels {1}
lappend params_list CONFIG.Number_Paths {1}
lappend params_list CONFIG.Optimal_Column_Lengths {false}
lappend params_list CONFIG.Optimization_Goal {Area}
lappend params_list CONFIG.Optimization_List {None}
lappend params_list CONFIG.Optimization_Selection {None}
lappend params_list CONFIG.Other {false}
lappend params_list CONFIG.Output_Buffer_Type {Automatic}
lappend params_list CONFIG.Output_Rounding_Mode {Full_Precision}
lappend params_list CONFIG.Output_Width {32}
lappend params_list CONFIG.Passband_Max {0.50000000}
lappend params_list CONFIG.Passband_Min {0.00000000}
lappend params_list CONFIG.Pattern_List {P4-0,P4-1,P4-2,P4-3,P4-4}
lappend params_list CONFIG.Pre_Adder_Pipeline {false}
lappend params_list CONFIG.Preference_For_Other_Storage {Automatic}
lappend params_list CONFIG.Quantization {Quantize_Only}
lappend params_list CONFIG.RateSpecification {Maximum_Possible}
lappend params_list CONFIG.Rate_Change_Type {Integer}
lappend params_list CONFIG.Reload_File {no_coe_file_loaded}
lappend params_list CONFIG.Reset_Data_Vector {true}
lappend params_list CONFIG.S_CONFIG_Method {Single}
lappend params_list CONFIG.S_CONFIG_Sync_Mode {On_Vector}
lappend params_list CONFIG.S_DATA_Has_FIFO {false}
lappend params_list CONFIG.S_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.SamplePeriod {12800}
lappend params_list CONFIG.Sample_Frequency {0.001}
lappend params_list CONFIG.Select_Pattern {All}
lappend params_list CONFIG.Stopband_Max {1.00000000}
lappend params_list CONFIG.Stopband_Min {0.50000000}
lappend params_list CONFIG.Zero_Pack_Factor {1}

set_property -dict $params_list [get_ips axi_qpsk_tx_fir_compiler_v7_2_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_fir_compiler_v7_2_i2] < 0} {
create_ip -name fir_compiler -version 7.2 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_fir_compiler_v7_2_i2
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_fir_compiler_v7_2_i2}
lappend params_list CONFIG.BestPrecision {true}
lappend params_list CONFIG.Blank_Output {false}
lappend params_list CONFIG.Channel_Sequence {Basic}
lappend params_list CONFIG.Clock_Frequency {300.0}
lappend params_list CONFIG.CoefficientSource {Vector}
lappend params_list CONFIG.CoefficientVector {binary:4315F467D9AC40BF3C37840BB94C52BFA579E2E8AFED50BFB34D8F4F361D433F822992A4F8FB693F4AB1E105DD36723F4ADD05C351A3623FB610BA294B3964BFEE7E466C783276BFC83F29B6258464BFAF89261C080A743F31F2CB233C4D833F0E7B60102581723F0BAD8FB9F0DC7DBFC466578824228DBF4A07B0FB82617ABF27A5102EDE65873F9D3E8AD2A3BB953FB5C22C76653B823FE068362FFEE191BFD66FAA4925849FBF9E112B8E7EC087BF464CC637B54F9B3F5A50F5DA98B1A63FA5210F82FF088E3F7B9C4EB54DFFA4BFE4EFB1F2BF8DB0BF05AD8A1C8BED92BF2CFF19F501B2B03F5993F1055A82B93F3B6547B730CE993F0E5849BD3628BDBFC1D61FB7B810C7BF21E89B5BBEFFA9BFE4AF4B1CC7D8D03F44453CDB2713E33F0D75BF55C4A1E73F44453CDB2713E33FE4AF4B1CC7D8D03F21E89B5BBEFFA9BFC1D61FB7B810C7BF0E5849BD3628BDBF3B6547B730CE993F5993F1055A82B93F2CFF19F501B2B03F05AD8A1C8BED92BFE4EFB1F2BF8DB0BF7B9C4EB54DFFA4BFA5210F82FF088E3F5A50F5DA98B1A63F464CC637B54F9B3F9E112B8E7EC087BFD66FAA4925849FBFE068362FFEE191BFB5C22C76653B823F9D3E8AD2A3BB953F27A5102EDE65873F4A07B0FB82617ABFC466578824228DBF0BAD8FB9F0DC7DBF0E7B60102581723F31F2CB233C4D833FAF89261C080A743FC83F29B6258464BFEE7E466C783276BFB610BA294B3964BF4ADD05C351A3623F4AB1E105DD36723F822992A4F8FB693FB34D8F4F361D433FA579E2E8AFED50BF3C37840BB94C52BF4315F467D9AC40BF}
lappend params_list CONFIG.Coefficient_Buffer_Type {Automatic}
lappend params_list CONFIG.Coefficient_Fanout {false}
lappend params_list CONFIG.Coefficient_File {no_coe_file_loaded}
lappend params_list CONFIG.Coefficient_Fractional_Bits {15}
lappend params_list CONFIG.Coefficient_Reload {false}
lappend params_list CONFIG.Coefficient_Sets {1}
lappend params_list CONFIG.Coefficient_Sign {Signed}
lappend params_list CONFIG.Coefficient_Structure {Inferred}
lappend params_list CONFIG.Coefficient_Width {16}
lappend params_list CONFIG.ColumnConfig {1}
lappend params_list CONFIG.Control_Broadcast_Fanout {false}
lappend params_list CONFIG.Control_Column_Fanout {false}
lappend params_list CONFIG.Control_LUT_Pipeline {false}
lappend params_list CONFIG.Control_Path_Fanout {false}
lappend params_list CONFIG.DATA_Has_TLAST {Not_Required}
lappend params_list CONFIG.DATA_TUSER_Width {1}
lappend params_list CONFIG.Data_Buffer_Type {Automatic}
lappend params_list CONFIG.Data_Fractional_Bits {15}
lappend params_list CONFIG.Data_Path_Broadcast {false}
lappend params_list CONFIG.Data_Path_Fanout {false}
lappend params_list CONFIG.Data_Sign {Signed}
lappend params_list CONFIG.Data_Width {16}
lappend params_list CONFIG.Decimation_Rate {1}
lappend params_list CONFIG.Disable_Half_Band_Centre_Tap {false}
lappend params_list CONFIG.DisplayReloadOrder {false}
lappend params_list CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate}
lappend params_list CONFIG.Filter_Selection {1}
lappend params_list CONFIG.Filter_Type {Interpolation}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.Gen_MIF_Files {false}
lappend params_list CONFIG.Gen_MIF_from_COE {false}
lappend params_list CONFIG.Gen_MIF_from_Spec {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Has_ACLKEN {true}
lappend params_list CONFIG.Has_ARESETn {true}
lappend params_list CONFIG.Input_Buffer_Type {Automatic}
lappend params_list CONFIG.Inter_Column_Pipe_Length {4}
lappend params_list CONFIG.Interpolation_Rate {2}
lappend params_list CONFIG.M_DATA_Has_TREADY {false}
lappend params_list CONFIG.M_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.Multi_Column_Support {Automatic}
lappend params_list CONFIG.No_BRAM_Read_First_Mode {false}
lappend params_list CONFIG.No_SRL_Attributes {false}
lappend params_list CONFIG.Num_Reload_Slots {1}
lappend params_list CONFIG.Number_Channels {1}
lappend params_list CONFIG.Number_Paths {1}
lappend params_list CONFIG.Optimal_Column_Lengths {false}
lappend params_list CONFIG.Optimization_Goal {Area}
lappend params_list CONFIG.Optimization_List {None}
lappend params_list CONFIG.Optimization_Selection {None}
lappend params_list CONFIG.Other {false}
lappend params_list CONFIG.Output_Buffer_Type {Automatic}
lappend params_list CONFIG.Output_Rounding_Mode {Full_Precision}
lappend params_list CONFIG.Output_Width {33}
lappend params_list CONFIG.Passband_Max {0.50000000}
lappend params_list CONFIG.Passband_Min {0.00000000}
lappend params_list CONFIG.Pattern_List {P4-0,P4-1,P4-2,P4-3,P4-4}
lappend params_list CONFIG.Pre_Adder_Pipeline {false}
lappend params_list CONFIG.Preference_For_Other_Storage {Automatic}
lappend params_list CONFIG.Quantization {Quantize_Only}
lappend params_list CONFIG.RateSpecification {Maximum_Possible}
lappend params_list CONFIG.Rate_Change_Type {Integer}
lappend params_list CONFIG.Reload_File {no_coe_file_loaded}
lappend params_list CONFIG.Reset_Data_Vector {true}
lappend params_list CONFIG.S_CONFIG_Method {Single}
lappend params_list CONFIG.S_CONFIG_Sync_Mode {On_Vector}
lappend params_list CONFIG.S_DATA_Has_FIFO {false}
lappend params_list CONFIG.S_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.SamplePeriod {6400}
lappend params_list CONFIG.Sample_Frequency {0.001}
lappend params_list CONFIG.Select_Pattern {All}
lappend params_list CONFIG.Stopband_Max {1.00000000}
lappend params_list CONFIG.Stopband_Min {0.50000000}
lappend params_list CONFIG.Zero_Pack_Factor {1}

set_property -dict $params_list [get_ips axi_qpsk_tx_fir_compiler_v7_2_i2]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_tx_mult_gen_v12_0_i2] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_tx_mult_gen_v12_0_i2
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_tx_mult_gen_v12_0_i2}
lappend params_list CONFIG.clockenable {false}
lappend params_list CONFIG.multiplier_construction {Use_Mults}
lappend params_list CONFIG.optgoal {Speed}
lappend params_list CONFIG.outputwidthhigh {47}
lappend params_list CONFIG.pipestages {0}
lappend params_list CONFIG.portatype {Unsigned}
lappend params_list CONFIG.portawidth {32}
lappend params_list CONFIG.portbtype {Signed}
lappend params_list CONFIG.portbwidth {16}
lappend params_list CONFIG.sclrcepriority {CE_Overrides_SCLR}
lappend params_list CONFIG.syncclear {false}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips axi_qpsk_tx_mult_gen_v12_0_i2]
}


validate_ip [get_ips]
