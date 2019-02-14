//-----------------------------------------------------------------
// System Generator version 2018.2 Verilog source file.
//
// Copyright(C) 2018 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2018 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------

`include "conv_pkg.v"
module xlaxi_qpsk_tx_xfft_v9_1_i0_fd8bca78edfadbd22aa432a764c9b22b (ce,clk,in_im,in_re,op_im,op_re,start_frame_in,start_frame_out);

input ce;
input clk;
input[31:0] in_im;
input[31:0] in_re;
output[31:0] op_im;
output[31:0] op_re;
input[0:0] start_frame_in;
output[0:0] start_frame_out;
wire event_frame_started;
wire[63:0] m_axis_data_tdata_net;
wire m_axis_data_tlast;
wire m_axis_data_tvalid;
wire s_axis_config_tready;
wire[63:0] s_axis_data_tdata_net;
wire s_axis_data_tready;
  assign op_im = m_axis_data_tdata_net[63 : 32];
  assign op_re = m_axis_data_tdata_net[31 : 0];
  assign s_axis_data_tdata_net[63 : 32] = in_im;
  assign s_axis_data_tdata_net[31 : 0] = in_re;
  reg [9:0] start_frame_valid = 0;
  reg flag = 0;
  wire m_tvalid_d;
  wire m_tlast_d;
  reg start_frame_in_valid;
  wire [0:0] start_frame_out;
  wire [0:0] start_frame_out_1;
  //////INPUT SUBSYSTEM 
  always @(posedge clk)
  begin
  start_frame_valid <= start_frame_valid + (start_frame_in | (start_frame_valid != 0));
  if(start_frame_valid<=1023 && start_frame_valid>=0)
         start_frame_in_valid <= 1;
  else
         start_frame_in_valid <= 0;
  end
  ////OUTPUT SUBSYSTEM
  FDE u2 (.C(clk), .D(m_axis_data_tvalid), .Q(m_tvalid_d), .CE(ce));
  FDE u3 (.C(clk), .D(m_axis_data_tlast), .Q(m_tlast_d), .CE(ce));
  assign start_frame_out_1 = (~m_tvalid_d) && m_axis_data_tvalid;
  assign start_frame_out = start_frame_out_1 || (m_tlast_d && m_axis_data_tvalid);
  axi_qpsk_tx_xfft_v9_1_i0 axi_qpsk_tx_xfft_v9_1_i0_instance(
      .aclk(clk),
      .aclken(ce),
      .event_frame_started(event_frame_started),
      .m_axis_data_tdata(m_axis_data_tdata_net),
      .m_axis_data_tlast(m_axis_data_tlast),
      .m_axis_data_tready(1'b1),
      .m_axis_data_tvalid(m_axis_data_tvalid),
      .s_axis_config_tdata(16'b0000010101010111),
      .s_axis_config_tready(s_axis_config_tready),
      .s_axis_config_tvalid(1'b1),
      .s_axis_data_tdata(s_axis_data_tdata_net),
      .s_axis_data_tlast(1'b0),
      .s_axis_data_tready(s_axis_data_tready),
      .s_axis_data_tvalid(start_frame_in_valid)
    );

 endmodule
