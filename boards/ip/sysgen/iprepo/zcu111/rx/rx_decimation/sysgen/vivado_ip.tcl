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
if {[lsearch $existingipslist axi_qpsk_rx_dec_c_counter_binary_v12_0_i0] < 0} {
create_ip -name c_counter_binary -version 12.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_dec_c_counter_binary_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_dec_c_counter_binary_v12_0_i0}
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

set_property -dict $params_list [get_ips axi_qpsk_rx_dec_c_counter_binary_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_dec_fifo_generator_i0] < 0} {
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name axi_qpsk_rx_dec_fifo_generator_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_dec_fifo_generator_i0}
lappend params_list CONFIG.almost_empty_flag {false}
lappend params_list CONFIG.almost_full_flag {false}
lappend params_list CONFIG.data_count {true}
lappend params_list CONFIG.data_count_width {9}
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
lappend params_list CONFIG.input_depth {512}
lappend params_list CONFIG.output_data_width {32}
lappend params_list CONFIG.output_depth {512}
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

set_property -dict $params_list [get_ips axi_qpsk_rx_dec_fifo_generator_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_dec_cic_compiler_v4_0_i0] < 0} {
create_ip -name cic_compiler -version 4.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_dec_cic_compiler_v4_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_dec_cic_compiler_v4_0_i0}
lappend params_list CONFIG.Clock_Frequency {200.0}
lappend params_list CONFIG.Differential_Delay {1}
lappend params_list CONFIG.Filter_Type {Decimation}
lappend params_list CONFIG.Fixed_Or_Initial_Rate {40}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.HAS_ACLKEN {true}
lappend params_list CONFIG.HAS_ARESETN {false}
lappend params_list CONFIG.HAS_DOUT_TREADY {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Input_Data_Width {16}
lappend params_list CONFIG.Input_Sample_Frequency {0.001}
lappend params_list CONFIG.Maximum_Rate {40}
lappend params_list CONFIG.Minimum_Rate {40}
lappend params_list CONFIG.Number_Of_Channels {1}
lappend params_list CONFIG.Number_Of_Stages {3}
lappend params_list CONFIG.Output_Data_Width {32}
lappend params_list CONFIG.Passband_Max {0.5}
lappend params_list CONFIG.Passband_Min {0.0}
lappend params_list CONFIG.Quantization {Full_Precision}
lappend params_list CONFIG.RateSpecification {Maximum_Possible}
lappend params_list CONFIG.Response_Magnitude {Normalized}
lappend params_list CONFIG.SamplePeriod {1}
lappend params_list CONFIG.Sample_Rate_Changes {Fixed}
lappend params_list CONFIG.Stopband_Max {1.0}
lappend params_list CONFIG.Stopband_Min {0.5}
lappend params_list CONFIG.Use_Streaming_Interface {true}
lappend params_list CONFIG.Use_Xtreme_DSP_Slice {true}

set_property -dict $params_list [get_ips axi_qpsk_rx_dec_cic_compiler_v4_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_dec_cic_compiler_v4_0_i1] < 0} {
create_ip -name cic_compiler -version 4.0 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_dec_cic_compiler_v4_0_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_dec_cic_compiler_v4_0_i1}
lappend params_list CONFIG.Clock_Frequency {200.0}
lappend params_list CONFIG.Differential_Delay {1}
lappend params_list CONFIG.Filter_Type {Decimation}
lappend params_list CONFIG.Fixed_Or_Initial_Rate {40}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.HAS_ACLKEN {true}
lappend params_list CONFIG.HAS_ARESETN {false}
lappend params_list CONFIG.HAS_DOUT_TREADY {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Input_Data_Width {16}
lappend params_list CONFIG.Input_Sample_Frequency {0.001}
lappend params_list CONFIG.Maximum_Rate {40}
lappend params_list CONFIG.Minimum_Rate {40}
lappend params_list CONFIG.Number_Of_Channels {1}
lappend params_list CONFIG.Number_Of_Stages {3}
lappend params_list CONFIG.Output_Data_Width {32}
lappend params_list CONFIG.Passband_Max {0.5}
lappend params_list CONFIG.Passband_Min {0.0}
lappend params_list CONFIG.Quantization {Full_Precision}
lappend params_list CONFIG.RateSpecification {Maximum_Possible}
lappend params_list CONFIG.Response_Magnitude {Normalized}
lappend params_list CONFIG.SamplePeriod {80}
lappend params_list CONFIG.Sample_Rate_Changes {Fixed}
lappend params_list CONFIG.Stopband_Max {1.0}
lappend params_list CONFIG.Stopband_Min {0.5}
lappend params_list CONFIG.Use_Streaming_Interface {true}
lappend params_list CONFIG.Use_Xtreme_DSP_Slice {true}

set_property -dict $params_list [get_ips axi_qpsk_rx_dec_cic_compiler_v4_0_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_dec_fir_compiler_v7_2_i0] < 0} {
create_ip -name fir_compiler -version 7.2 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_dec_fir_compiler_v7_2_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_dec_fir_compiler_v7_2_i0}
lappend params_list CONFIG.BestPrecision {true}
lappend params_list CONFIG.Blank_Output {false}
lappend params_list CONFIG.Channel_Sequence {Basic}
lappend params_list CONFIG.Clock_Frequency {300.0}
lappend params_list CONFIG.CoefficientSource {Vector}
lappend params_list CONFIG.CoefficientVector {binary:DD3C9359911E62BFDDBDF8C7D25856BF760BD3C5B622703FF66EB97E3C3168BF99FCD96C8DAE6DBF0DD9B5024338853F7A55B0891B8A7EBFD0C757A7CF3380BFDC8F9FC719B8973F45B71FD7486292BF268B0B485D2E8CBFCA5473816E79A83F20C65A19D7B4A5BF6AB6134C9F7B96BFB001703DDA43BB3F2EE42DE6F9E0BDBFE8836E91C0B5AFBF5735AC0C2267E33F5735AC0C2267E33FE8836E91C0B5AFBF2EE42DE6F9E0BDBFB001703DDA43BB3F6AB6134C9F7B96BF20C65A19D7B4A5BFCA5473816E79A83F268B0B485D2E8CBF45B71FD7486292BFDC8F9FC719B8973FD0C757A7CF3380BF7A55B0891B8A7EBF0DD9B5024338853F99FCD96C8DAE6DBFF66EB97E3C3168BF760BD3C5B622703FDDBDF8C7D25856BFDD3C9359911E62BF}
lappend params_list CONFIG.Coefficient_Buffer_Type {Automatic}
lappend params_list CONFIG.Coefficient_File {no_coe_file_loaded}
lappend params_list CONFIG.Coefficient_Fractional_Bits {15}
lappend params_list CONFIG.Coefficient_Reload {false}
lappend params_list CONFIG.Coefficient_Sets {1}
lappend params_list CONFIG.Coefficient_Sign {Signed}
lappend params_list CONFIG.Coefficient_Structure {Inferred}
lappend params_list CONFIG.Coefficient_Width {16}
lappend params_list CONFIG.ColumnConfig {1}
lappend params_list CONFIG.DATA_Has_TLAST {Not_Required}
lappend params_list CONFIG.DATA_TUSER_Width {1}
lappend params_list CONFIG.Data_Buffer_Type {Automatic}
lappend params_list CONFIG.Data_Fractional_Bits {14}
lappend params_list CONFIG.Data_Sign {Signed}
lappend params_list CONFIG.Data_Width {16}
lappend params_list CONFIG.Decimation_Rate {2}
lappend params_list CONFIG.DisplayReloadOrder {false}
lappend params_list CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate}
lappend params_list CONFIG.Filter_Selection {1}
lappend params_list CONFIG.Filter_Type {Decimation}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.Gen_MIF_Files {false}
lappend params_list CONFIG.Gen_MIF_from_COE {false}
lappend params_list CONFIG.Gen_MIF_from_Spec {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Has_ACLKEN {true}
lappend params_list CONFIG.Has_ARESETn {false}
lappend params_list CONFIG.Input_Buffer_Type {Automatic}
lappend params_list CONFIG.Inter_Column_Pipe_Length {4}
lappend params_list CONFIG.Interpolation_Rate {1}
lappend params_list CONFIG.M_DATA_Has_TREADY {false}
lappend params_list CONFIG.M_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.Multi_Column_Support {Automatic}
lappend params_list CONFIG.Num_Reload_Slots {1}
lappend params_list CONFIG.Number_Channels {1}
lappend params_list CONFIG.Number_Paths {1}
lappend params_list CONFIG.Optimization_Goal {Area}
lappend params_list CONFIG.Optimization_List {None}
lappend params_list CONFIG.Optimization_Selection {None}
lappend params_list CONFIG.Output_Buffer_Type {Automatic}
lappend params_list CONFIG.Output_Rounding_Mode {Full_Precision}
lappend params_list CONFIG.Output_Width {33}
lappend params_list CONFIG.Passband_Max {0.50000000}
lappend params_list CONFIG.Passband_Min {0.00000000}
lappend params_list CONFIG.Pattern_List {P4-0,P4-1,P4-2,P4-3,P4-4}
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
lappend params_list CONFIG.SamplePeriod {40}
lappend params_list CONFIG.Sample_Frequency {0.001}
lappend params_list CONFIG.Select_Pattern {All}
lappend params_list CONFIG.Stopband_Max {1.00000000}
lappend params_list CONFIG.Stopband_Min {0.50000000}
lappend params_list CONFIG.Zero_Pack_Factor {1}

set_property -dict $params_list [get_ips axi_qpsk_rx_dec_fir_compiler_v7_2_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist axi_qpsk_rx_dec_fir_compiler_v7_2_i1] < 0} {
create_ip -name fir_compiler -version 7.2 -vendor xilinx.com -library ip -module_name axi_qpsk_rx_dec_fir_compiler_v7_2_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {axi_qpsk_rx_dec_fir_compiler_v7_2_i1}
lappend params_list CONFIG.BestPrecision {true}
lappend params_list CONFIG.Blank_Output {false}
lappend params_list CONFIG.Channel_Sequence {Basic}
lappend params_list CONFIG.Clock_Frequency {300.0}
lappend params_list CONFIG.CoefficientSource {Vector}
lappend params_list CONFIG.CoefficientVector {binary:DD3C9359911E62BFDDBDF8C7D25856BF760BD3C5B622703FF66EB97E3C3168BF99FCD96C8DAE6DBF0DD9B5024338853F7A55B0891B8A7EBFD0C757A7CF3380BFDC8F9FC719B8973F45B71FD7486292BF268B0B485D2E8CBFCA5473816E79A83F20C65A19D7B4A5BF6AB6134C9F7B96BFB001703DDA43BB3F2EE42DE6F9E0BDBFE8836E91C0B5AFBF5735AC0C2267E33F5735AC0C2267E33FE8836E91C0B5AFBF2EE42DE6F9E0BDBFB001703DDA43BB3F6AB6134C9F7B96BF20C65A19D7B4A5BFCA5473816E79A83F268B0B485D2E8CBF45B71FD7486292BFDC8F9FC719B8973FD0C757A7CF3380BF7A55B0891B8A7EBF0DD9B5024338853F99FCD96C8DAE6DBFF66EB97E3C3168BF760BD3C5B622703FDDBDF8C7D25856BFDD3C9359911E62BF}
lappend params_list CONFIG.Coefficient_Buffer_Type {Automatic}
lappend params_list CONFIG.Coefficient_File {no_coe_file_loaded}
lappend params_list CONFIG.Coefficient_Fractional_Bits {15}
lappend params_list CONFIG.Coefficient_Reload {false}
lappend params_list CONFIG.Coefficient_Sets {1}
lappend params_list CONFIG.Coefficient_Sign {Signed}
lappend params_list CONFIG.Coefficient_Structure {Inferred}
lappend params_list CONFIG.Coefficient_Width {16}
lappend params_list CONFIG.ColumnConfig {1}
lappend params_list CONFIG.DATA_Has_TLAST {Not_Required}
lappend params_list CONFIG.DATA_TUSER_Width {1}
lappend params_list CONFIG.Data_Buffer_Type {Automatic}
lappend params_list CONFIG.Data_Fractional_Bits {14}
lappend params_list CONFIG.Data_Sign {Signed}
lappend params_list CONFIG.Data_Width {16}
lappend params_list CONFIG.Decimation_Rate {2}
lappend params_list CONFIG.DisplayReloadOrder {false}
lappend params_list CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate}
lappend params_list CONFIG.Filter_Selection {1}
lappend params_list CONFIG.Filter_Type {Decimation}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.Gen_MIF_Files {false}
lappend params_list CONFIG.Gen_MIF_from_COE {false}
lappend params_list CONFIG.Gen_MIF_from_Spec {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Has_ACLKEN {true}
lappend params_list CONFIG.Has_ARESETn {false}
lappend params_list CONFIG.Input_Buffer_Type {Automatic}
lappend params_list CONFIG.Inter_Column_Pipe_Length {4}
lappend params_list CONFIG.Interpolation_Rate {1}
lappend params_list CONFIG.M_DATA_Has_TREADY {false}
lappend params_list CONFIG.M_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.Multi_Column_Support {Automatic}
lappend params_list CONFIG.Num_Reload_Slots {1}
lappend params_list CONFIG.Number_Channels {1}
lappend params_list CONFIG.Number_Paths {1}
lappend params_list CONFIG.Optimization_Goal {Area}
lappend params_list CONFIG.Optimization_List {None}
lappend params_list CONFIG.Optimization_Selection {None}
lappend params_list CONFIG.Output_Buffer_Type {Automatic}
lappend params_list CONFIG.Output_Rounding_Mode {Full_Precision}
lappend params_list CONFIG.Output_Width {33}
lappend params_list CONFIG.Passband_Max {0.50000000}
lappend params_list CONFIG.Passband_Min {0.00000000}
lappend params_list CONFIG.Pattern_List {P4-0,P4-1,P4-2,P4-3,P4-4}
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
lappend params_list CONFIG.SamplePeriod {3200}
lappend params_list CONFIG.Sample_Frequency {0.001}
lappend params_list CONFIG.Select_Pattern {All}
lappend params_list CONFIG.Stopband_Max {1.00000000}
lappend params_list CONFIG.Stopband_Min {0.50000000}
lappend params_list CONFIG.Zero_Pack_Factor {1}

set_property -dict $params_list [get_ips axi_qpsk_rx_dec_fir_compiler_v7_2_i1]
}


validate_ip [get_ips]
