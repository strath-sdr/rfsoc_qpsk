-------------------------------------------------------------------
-- System Generator version 2018.3 VHDL source file.
--
-- Copyright(C) 2018 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2018 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_concat_4cbc566218 is
  port (
    in0 : in std_logic_vector((4 - 1) downto 0);
    in1 : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_4cbc566218;
architecture behavior of sysgen_concat_4cbc566218
is
  signal in0_1_23: unsigned((4 - 1) downto 0);
  signal in1_1_27: unsigned((4 - 1) downto 0);
  signal y_2_1_concat: unsigned((8 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlregister.vhd
--
--  Description   : VHDL description of an arbitrary wide register.
--                  Unlike the delay block, an initial value is
--                  specified and is considered valid at the start
--                  of simulation.  The register is only one word
--                  deep.
--
--  Mod. History  : Removed valid bit logic from wrapper.
--                : Changed VHDL to use a bit_vector generic for its
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity qpsk_tx_symbol_gen_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end qpsk_tx_symbol_gen_xlregister;

architecture behavior of qpsk_tx_symbol_gen_xlregister is

   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component; -- end synth_reg_w_init

   -- synthesis translate_off
   signal real_d, real_q           : real;    -- For debugging info ports
   -- synthesis translate_on
   signal internal_clr             : std_logic;
   signal internal_ce              : std_logic;

begin

   internal_clr <= rst(0) and ce;
   internal_ce  <= en(0) and ce;

   -- Synthesizable behavioral model
   synth_reg_inst : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_ce,
                clr => internal_clr,
                clk => clk,
                o   => q);

end architecture behavior;


library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_4012dc8d9e is
  port (
    input_port : in std_logic_vector((4 - 1) downto 0);
    output_port : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_4012dc8d9e;
architecture behavior of sysgen_reinterpret_4012dc8d9e
is
  signal input_port_1_40: signed((4 - 1) downto 0);
  signal output_port_5_5_force: unsigned((4 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_signed(input_port);
  output_port_5_5_force <= signed_to_unsigned(input_port_1_40);
  output_port <= unsigned_to_std_logic_vector(output_port_5_5_force);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

--$Header: /devl/xcs/repo/env/Jobs/sysgen/src/xbs/blocks/xlconvert/hdl/xlconvert.vhd,v 1.1 2004/11/22 00:17:30 rosty Exp $
---------------------------------------------------------------------
--
--  Filename      : xlconvert.vhd
--
--  Description   : VHDL description of a fixed point converter block that
--                  converts the input to a new output type.

--
---------------------------------------------------------------------


---------------------------------------------------------------------
--
--  Entity        : xlconvert
--
--  Architecture  : behavior
--
--  Description   : Top level VHDL description of fixed point conver block.
--
---------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity convert_func_call_qpsk_tx_symbol_gen_xlconvert is
    generic (
        din_width    : integer := 16;            -- Width of input
        din_bin_pt   : integer := 4;             -- Binary point of input
        din_arith    : integer := xlUnsigned;    -- Type of arith of input
        dout_width   : integer := 8;             -- Width of output
        dout_bin_pt  : integer := 2;             -- Binary point of output
        dout_arith   : integer := xlUnsigned;    -- Type of arith of output
        quantization : integer := xlTruncate;    -- xlRound or xlTruncate
        overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        result : out std_logic_vector (dout_width-1 downto 0));
end convert_func_call_qpsk_tx_symbol_gen_xlconvert ;

architecture behavior of convert_func_call_qpsk_tx_symbol_gen_xlconvert is
begin
    -- Convert to output type and do saturation arith.
    result <= convert_type(din, din_width, din_bin_pt, din_arith,
                           dout_width, dout_bin_pt, dout_arith,
                           quantization, overflow);
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity qpsk_tx_symbol_gen_xlconvert  is
    generic (
        din_width    : integer := 16;            -- Width of input
        din_bin_pt   : integer := 4;             -- Binary point of input
        din_arith    : integer := xlUnsigned;    -- Type of arith of input
        dout_width   : integer := 8;             -- Width of output
        dout_bin_pt  : integer := 2;             -- Binary point of output
        dout_arith   : integer := xlUnsigned;    -- Type of arith of output
        en_width     : integer := 1;
        en_bin_pt    : integer := 0;
        en_arith     : integer := xlUnsigned;
        bool_conversion : integer :=0;           -- if one, convert ufix_1_0 to
                                                 -- bool
        latency      : integer := 0;             -- Ouput delay clk cycles
        quantization : integer := xlTruncate;    -- xlRound or xlTruncate
        overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        en  : in std_logic_vector (en_width-1 downto 0);
        ce  : in std_logic;
        clr : in std_logic;
        clk : in std_logic;
        dout : out std_logic_vector (dout_width-1 downto 0));

end qpsk_tx_symbol_gen_xlconvert ;

architecture behavior of qpsk_tx_symbol_gen_xlconvert  is

    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;

    component convert_func_call_qpsk_tx_symbol_gen_xlconvert 
        generic (
            din_width    : integer := 16;            -- Width of input
            din_bin_pt   : integer := 4;             -- Binary point of input
            din_arith    : integer := xlUnsigned;    -- Type of arith of input
            dout_width   : integer := 8;             -- Width of output
            dout_bin_pt  : integer := 2;             -- Binary point of output
            dout_arith   : integer := xlUnsigned;    -- Type of arith of output
            quantization : integer := xlTruncate;    -- xlRound or xlTruncate
            overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
        port (
            din : in std_logic_vector (din_width-1 downto 0);
            result : out std_logic_vector (dout_width-1 downto 0));
    end component;


    -- synthesis translate_off
--    signal real_din, real_dout : real;    -- For debugging info ports
    -- synthesis translate_on
    signal result : std_logic_vector(dout_width-1 downto 0);
    signal internal_ce : std_logic;

begin

    -- Debugging info for internal full precision variables
    -- synthesis translate_off
--     real_din <= to_real(din, din_bin_pt, din_arith);
--     real_dout <= to_real(dout, dout_bin_pt, dout_arith);
    -- synthesis translate_on

    internal_ce <= ce and en(0);

    bool_conversion_generate : if (bool_conversion = 1)
    generate
      result <= din;
    end generate; --bool_conversion_generate

    std_conversion_generate : if (bool_conversion = 0)
    generate
      -- Workaround for XST bug
      convert : convert_func_call_qpsk_tx_symbol_gen_xlconvert 
        generic map (
          din_width   => din_width,
          din_bin_pt  => din_bin_pt,
          din_arith   => din_arith,
          dout_width  => dout_width,
          dout_bin_pt => dout_bin_pt,
          dout_arith  => dout_arith,
          quantization => quantization,
          overflow     => overflow)
        port map (
          din => din,
          result => result);
    end generate; --std_conversion_generate

    latency_test : if (latency > 0) generate
        reg : synth_reg
            generic map (
              width => dout_width,
              latency => latency
            )
            port map (
              i => result,
              ce => internal_ce,
              clr => clr,
              clk => clk,
              o => dout
            );
    end generate;

    latency0 : if (latency = 0)
    generate
        dout <= result;
    end generate latency0;

end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlslice.vhd
--
--  Description   : VHDL description of a block that sets the output to a
--                  specified range of the input bits. The output is always
--                  set to an unsigned type with it's binary point at zero.
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity qpsk_tx_symbol_gen_xlslice is
    generic (
        new_msb      : integer := 9;           -- position of new msb
        new_lsb      : integer := 1;           -- position of new lsb
        x_width      : integer := 16;          -- Width of x input
        y_width      : integer := 8);          -- Width of y output
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end qpsk_tx_symbol_gen_xlslice;

architecture behavior of qpsk_tx_symbol_gen_xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_c8c4086527 is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_c8c4086527;
architecture behavior of sysgen_constant_c8c4086527
is
begin
  op <= "01";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_b8e3a467cb is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_b8e3a467cb;
architecture behavior of sysgen_constant_b8e3a467cb
is
begin
  op <= "11";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_9bb83b0c60 is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((2 - 1) downto 0);
    d1 : in std_logic_vector((2 - 1) downto 0);
    d2 : in std_logic_vector((2 - 1) downto 0);
    d3 : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_9bb83b0c60;
architecture behavior of sysgen_mux_9bb83b0c60
is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((2 - 1) downto 0);
  signal d1_1_27: std_logic_vector((2 - 1) downto 0);
  signal d2_1_30: std_logic_vector((2 - 1) downto 0);
  signal d3_1_33: std_logic_vector((2 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((2 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_concat_2c273a2ba5 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_2c273a2ba5;
architecture behavior of sysgen_concat_2c273a2ba5
is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((1 - 1) downto 0);
  signal y_2_1_concat: unsigned((2 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_inverter_af11c886ea is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_inverter_af11c886ea;
architecture behavior of sysgen_inverter_af11c886ea
is
  signal ip_1_26: boolean;
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of boolean;
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => false);
  signal op_mem_22_20_front_din: boolean;
  signal op_mem_22_20_back: boolean;
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: boolean;
begin
  ip_1_26 <= ((ip) = "1");
  op_mem_22_20_back <= op_mem_22_20(0);
  proc_op_mem_22_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_20_push_front_pop_back_en = '1')) then
        op_mem_22_20(0) <= op_mem_22_20_front_din;
      end if;
    end if;
  end process proc_op_mem_22_20;
  internal_ip_12_1_bitnot <= ((not boolean_to_vector(ip_1_26)) = "1");
  op_mem_22_20_push_front_pop_back_en <= '0';
  op <= boolean_to_vector(internal_ip_12_1_bitnot);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_lfsr_d7aeaa8912 is
  port (
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    dout : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_lfsr_d7aeaa8912;
architecture behavior of sysgen_lfsr_d7aeaa8912
is
  signal rst_1_59: boolean;
  signal en_1_63: boolean;
  signal lfsr0_2_19_next: unsigned((1 - 1) downto 0);
  signal lfsr0_2_19: unsigned((1 - 1) downto 0) := "1";
  signal lfsr0_2_19_rst: std_logic;
  signal lfsr1_3_19_next: unsigned((1 - 1) downto 0);
  signal lfsr1_3_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr1_3_19_rst: std_logic;
  signal lfsr2_4_19_next: unsigned((1 - 1) downto 0);
  signal lfsr2_4_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr2_4_19_rst: std_logic;
  signal lfsr3_5_19_next: unsigned((1 - 1) downto 0);
  signal lfsr3_5_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr3_5_19_rst: std_logic;
  signal lfsr4_6_19_next: unsigned((1 - 1) downto 0);
  signal lfsr4_6_19: unsigned((1 - 1) downto 0) := "1";
  signal lfsr4_6_19_rst: std_logic;
  signal lfsr5_7_19_next: unsigned((1 - 1) downto 0);
  signal lfsr5_7_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr5_7_19_rst: std_logic;
  signal lfsr6_8_19_next: unsigned((1 - 1) downto 0);
  signal lfsr6_8_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr6_8_19_rst: std_logic;
  signal lfsr7_9_19_next: unsigned((1 - 1) downto 0);
  signal lfsr7_9_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr7_9_19_rst: std_logic;
  signal lfsr8_10_19_next: unsigned((1 - 1) downto 0);
  signal lfsr8_10_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr8_10_19_rst: std_logic;
  signal lfsr9_11_19_next: unsigned((1 - 1) downto 0);
  signal lfsr9_11_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr9_11_19_rst: std_logic;
  signal bit_27_35: unsigned((1 - 1) downto 0);
  signal bit_27_22: unsigned((1 - 1) downto 0);
  signal temp_27_1_bitnot: unsigned((1 - 1) downto 0);
  signal lfsr1_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_13_1_rst: std_logic;
  signal lfsr3_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_13_1_rst: std_logic;
  signal lfsr8_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_13_1_rst: std_logic;
  signal lfsr9_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_13_1_rst: std_logic;
  signal lfsr7_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_13_1_rst: std_logic;
  signal lfsr2_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_13_1_rst: std_logic;
  signal lfsr4_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_13_1_rst: std_logic;
  signal lfsr5_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_13_1_rst: std_logic;
  signal lfsr0_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_13_1_rst: std_logic;
  signal lfsr6_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_13_1_rst: std_logic;
begin
  rst_1_59 <= ((rst) = "1");
  en_1_63 <= ((en) = "1");
  proc_lfsr0_2_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr0_2_19_rst = '1')) then
        lfsr0_2_19 <= "1";
      elsif (ce = '1') then 
        lfsr0_2_19 <= lfsr0_2_19_next;
      end if;
    end if;
  end process proc_lfsr0_2_19;
  proc_lfsr1_3_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr1_3_19_rst = '1')) then
        lfsr1_3_19 <= "0";
      elsif (ce = '1') then 
        lfsr1_3_19 <= lfsr1_3_19_next;
      end if;
    end if;
  end process proc_lfsr1_3_19;
  proc_lfsr2_4_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr2_4_19_rst = '1')) then
        lfsr2_4_19 <= "0";
      elsif (ce = '1') then 
        lfsr2_4_19 <= lfsr2_4_19_next;
      end if;
    end if;
  end process proc_lfsr2_4_19;
  proc_lfsr3_5_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr3_5_19_rst = '1')) then
        lfsr3_5_19 <= "0";
      elsif (ce = '1') then 
        lfsr3_5_19 <= lfsr3_5_19_next;
      end if;
    end if;
  end process proc_lfsr3_5_19;
  proc_lfsr4_6_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr4_6_19_rst = '1')) then
        lfsr4_6_19 <= "1";
      elsif (ce = '1') then 
        lfsr4_6_19 <= lfsr4_6_19_next;
      end if;
    end if;
  end process proc_lfsr4_6_19;
  proc_lfsr5_7_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr5_7_19_rst = '1')) then
        lfsr5_7_19 <= "0";
      elsif (ce = '1') then 
        lfsr5_7_19 <= lfsr5_7_19_next;
      end if;
    end if;
  end process proc_lfsr5_7_19;
  proc_lfsr6_8_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr6_8_19_rst = '1')) then
        lfsr6_8_19 <= "0";
      elsif (ce = '1') then 
        lfsr6_8_19 <= lfsr6_8_19_next;
      end if;
    end if;
  end process proc_lfsr6_8_19;
  proc_lfsr7_9_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr7_9_19_rst = '1')) then
        lfsr7_9_19 <= "0";
      elsif (ce = '1') then 
        lfsr7_9_19 <= lfsr7_9_19_next;
      end if;
    end if;
  end process proc_lfsr7_9_19;
  proc_lfsr8_10_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr8_10_19_rst = '1')) then
        lfsr8_10_19 <= "0";
      elsif (ce = '1') then 
        lfsr8_10_19 <= lfsr8_10_19_next;
      end if;
    end if;
  end process proc_lfsr8_10_19;
  proc_lfsr9_11_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr9_11_19_rst = '1')) then
        lfsr9_11_19 <= "0";
      elsif (ce = '1') then 
        lfsr9_11_19 <= lfsr9_11_19_next;
      end if;
    end if;
  end process proc_lfsr9_11_19;
  bit_27_35 <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(lfsr9_11_19) xor unsigned_to_std_logic_vector(lfsr4_6_19));
  bit_27_22 <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(lfsr1_3_19) xor unsigned_to_std_logic_vector(bit_27_35));
  temp_27_1_bitnot <= std_logic_vector_to_unsigned(not unsigned_to_std_logic_vector(bit_27_22));
  proc_if_25_1: process (en_1_63, lfsr0_2_19, lfsr1_3_19, lfsr2_4_19, lfsr3_5_19, lfsr4_6_19, lfsr5_7_19, lfsr6_8_19, lfsr7_9_19, lfsr8_10_19, lfsr9_11_19, temp_27_1_bitnot)
  is
  begin
    if en_1_63 then
      lfsr1_join_25_1 <= lfsr0_2_19;
      lfsr3_join_25_1 <= lfsr2_4_19;
      lfsr8_join_25_1 <= lfsr7_9_19;
      lfsr9_join_25_1 <= lfsr8_10_19;
      lfsr7_join_25_1 <= lfsr6_8_19;
      lfsr2_join_25_1 <= lfsr1_3_19;
      lfsr4_join_25_1 <= lfsr3_5_19;
      lfsr5_join_25_1 <= lfsr4_6_19;
      lfsr0_join_25_1 <= temp_27_1_bitnot;
      lfsr6_join_25_1 <= lfsr5_7_19;
    else 
      lfsr1_join_25_1 <= lfsr1_3_19;
      lfsr3_join_25_1 <= lfsr3_5_19;
      lfsr8_join_25_1 <= lfsr8_10_19;
      lfsr9_join_25_1 <= lfsr9_11_19;
      lfsr7_join_25_1 <= lfsr7_9_19;
      lfsr2_join_25_1 <= lfsr2_4_19;
      lfsr4_join_25_1 <= lfsr4_6_19;
      lfsr5_join_25_1 <= lfsr5_7_19;
      lfsr0_join_25_1 <= lfsr0_2_19;
      lfsr6_join_25_1 <= lfsr6_8_19;
    end if;
  end process proc_if_25_1;
  proc_if_13_1: process (lfsr0_join_25_1, lfsr1_join_25_1, lfsr2_join_25_1, lfsr3_join_25_1, lfsr4_join_25_1, lfsr5_join_25_1, lfsr6_join_25_1, lfsr7_join_25_1, lfsr8_join_25_1, lfsr9_join_25_1, rst_1_59)
  is
  begin
    if rst_1_59 then
      lfsr1_join_13_1_rst <= '1';
    else 
      lfsr1_join_13_1_rst <= '0';
    end if;
    lfsr1_join_13_1 <= lfsr1_join_25_1;
    if rst_1_59 then
      lfsr3_join_13_1_rst <= '1';
    else 
      lfsr3_join_13_1_rst <= '0';
    end if;
    lfsr3_join_13_1 <= lfsr3_join_25_1;
    if rst_1_59 then
      lfsr8_join_13_1_rst <= '1';
    else 
      lfsr8_join_13_1_rst <= '0';
    end if;
    lfsr8_join_13_1 <= lfsr8_join_25_1;
    if rst_1_59 then
      lfsr9_join_13_1_rst <= '1';
    else 
      lfsr9_join_13_1_rst <= '0';
    end if;
    lfsr9_join_13_1 <= lfsr9_join_25_1;
    if rst_1_59 then
      lfsr7_join_13_1_rst <= '1';
    else 
      lfsr7_join_13_1_rst <= '0';
    end if;
    lfsr7_join_13_1 <= lfsr7_join_25_1;
    if rst_1_59 then
      lfsr2_join_13_1_rst <= '1';
    else 
      lfsr2_join_13_1_rst <= '0';
    end if;
    lfsr2_join_13_1 <= lfsr2_join_25_1;
    if rst_1_59 then
      lfsr4_join_13_1_rst <= '1';
    else 
      lfsr4_join_13_1_rst <= '0';
    end if;
    lfsr4_join_13_1 <= lfsr4_join_25_1;
    if rst_1_59 then
      lfsr5_join_13_1_rst <= '1';
    else 
      lfsr5_join_13_1_rst <= '0';
    end if;
    lfsr5_join_13_1 <= lfsr5_join_25_1;
    if rst_1_59 then
      lfsr0_join_13_1_rst <= '1';
    else 
      lfsr0_join_13_1_rst <= '0';
    end if;
    lfsr0_join_13_1 <= lfsr0_join_25_1;
    if rst_1_59 then
      lfsr6_join_13_1_rst <= '1';
    else 
      lfsr6_join_13_1_rst <= '0';
    end if;
    lfsr6_join_13_1 <= lfsr6_join_25_1;
  end process proc_if_13_1;
  lfsr0_2_19_next <= lfsr0_join_25_1;
  lfsr0_2_19_rst <= lfsr0_join_13_1_rst;
  lfsr1_3_19_next <= lfsr1_join_25_1;
  lfsr1_3_19_rst <= lfsr1_join_13_1_rst;
  lfsr2_4_19_next <= lfsr2_join_25_1;
  lfsr2_4_19_rst <= lfsr2_join_13_1_rst;
  lfsr3_5_19_next <= lfsr3_join_25_1;
  lfsr3_5_19_rst <= lfsr3_join_13_1_rst;
  lfsr4_6_19_next <= lfsr4_join_25_1;
  lfsr4_6_19_rst <= lfsr4_join_13_1_rst;
  lfsr5_7_19_next <= lfsr5_join_25_1;
  lfsr5_7_19_rst <= lfsr5_join_13_1_rst;
  lfsr6_8_19_next <= lfsr6_join_25_1;
  lfsr6_8_19_rst <= lfsr6_join_13_1_rst;
  lfsr7_9_19_next <= lfsr7_join_25_1;
  lfsr7_9_19_rst <= lfsr7_join_13_1_rst;
  lfsr8_10_19_next <= lfsr8_join_25_1;
  lfsr8_10_19_rst <= lfsr8_join_13_1_rst;
  lfsr9_11_19_next <= lfsr9_join_25_1;
  lfsr9_11_19_rst <= lfsr9_join_13_1_rst;
  dout <= unsigned_to_std_logic_vector(lfsr9_11_19);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_lfsr_84c7de9677 is
  port (
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    dout : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_lfsr_84c7de9677;
architecture behavior of sysgen_lfsr_84c7de9677
is
  signal rst_1_59: boolean;
  signal en_1_63: boolean;
  signal lfsr0_2_19_next: unsigned((1 - 1) downto 0);
  signal lfsr0_2_19: unsigned((1 - 1) downto 0) := "1";
  signal lfsr0_2_19_rst: std_logic;
  signal lfsr1_3_19_next: unsigned((1 - 1) downto 0);
  signal lfsr1_3_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr1_3_19_rst: std_logic;
  signal lfsr2_4_19_next: unsigned((1 - 1) downto 0);
  signal lfsr2_4_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr2_4_19_rst: std_logic;
  signal lfsr3_5_19_next: unsigned((1 - 1) downto 0);
  signal lfsr3_5_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr3_5_19_rst: std_logic;
  signal lfsr4_6_19_next: unsigned((1 - 1) downto 0);
  signal lfsr4_6_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr4_6_19_rst: std_logic;
  signal lfsr5_7_19_next: unsigned((1 - 1) downto 0);
  signal lfsr5_7_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr5_7_19_rst: std_logic;
  signal lfsr6_8_19_next: unsigned((1 - 1) downto 0);
  signal lfsr6_8_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr6_8_19_rst: std_logic;
  signal lfsr7_9_19_next: unsigned((1 - 1) downto 0);
  signal lfsr7_9_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr7_9_19_rst: std_logic;
  signal lfsr8_10_19_next: unsigned((1 - 1) downto 0);
  signal lfsr8_10_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr8_10_19_rst: std_logic;
  signal lfsr9_11_19_next: unsigned((1 - 1) downto 0);
  signal lfsr9_11_19: unsigned((1 - 1) downto 0) := "0";
  signal lfsr9_11_19_rst: std_logic;
  signal bit_27_35: unsigned((1 - 1) downto 0);
  signal bit_27_22: unsigned((1 - 1) downto 0);
  signal temp_27_1_bitnot: unsigned((1 - 1) downto 0);
  signal lfsr9_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_13_1_rst: std_logic;
  signal lfsr4_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_13_1_rst: std_logic;
  signal lfsr2_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_13_1_rst: std_logic;
  signal lfsr3_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_13_1_rst: std_logic;
  signal lfsr8_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_13_1_rst: std_logic;
  signal lfsr7_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_13_1_rst: std_logic;
  signal lfsr6_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_13_1_rst: std_logic;
  signal lfsr5_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_13_1_rst: std_logic;
  signal lfsr1_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_13_1_rst: std_logic;
  signal lfsr0_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_13_1_rst: std_logic;
begin
  rst_1_59 <= ((rst) = "1");
  en_1_63 <= ((en) = "1");
  proc_lfsr0_2_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr0_2_19_rst = '1')) then
        lfsr0_2_19 <= "1";
      elsif (ce = '1') then 
        lfsr0_2_19 <= lfsr0_2_19_next;
      end if;
    end if;
  end process proc_lfsr0_2_19;
  proc_lfsr1_3_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr1_3_19_rst = '1')) then
        lfsr1_3_19 <= "0";
      elsif (ce = '1') then 
        lfsr1_3_19 <= lfsr1_3_19_next;
      end if;
    end if;
  end process proc_lfsr1_3_19;
  proc_lfsr2_4_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr2_4_19_rst = '1')) then
        lfsr2_4_19 <= "0";
      elsif (ce = '1') then 
        lfsr2_4_19 <= lfsr2_4_19_next;
      end if;
    end if;
  end process proc_lfsr2_4_19;
  proc_lfsr3_5_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr3_5_19_rst = '1')) then
        lfsr3_5_19 <= "0";
      elsif (ce = '1') then 
        lfsr3_5_19 <= lfsr3_5_19_next;
      end if;
    end if;
  end process proc_lfsr3_5_19;
  proc_lfsr4_6_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr4_6_19_rst = '1')) then
        lfsr4_6_19 <= "0";
      elsif (ce = '1') then 
        lfsr4_6_19 <= lfsr4_6_19_next;
      end if;
    end if;
  end process proc_lfsr4_6_19;
  proc_lfsr5_7_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr5_7_19_rst = '1')) then
        lfsr5_7_19 <= "0";
      elsif (ce = '1') then 
        lfsr5_7_19 <= lfsr5_7_19_next;
      end if;
    end if;
  end process proc_lfsr5_7_19;
  proc_lfsr6_8_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr6_8_19_rst = '1')) then
        lfsr6_8_19 <= "0";
      elsif (ce = '1') then 
        lfsr6_8_19 <= lfsr6_8_19_next;
      end if;
    end if;
  end process proc_lfsr6_8_19;
  proc_lfsr7_9_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr7_9_19_rst = '1')) then
        lfsr7_9_19 <= "0";
      elsif (ce = '1') then 
        lfsr7_9_19 <= lfsr7_9_19_next;
      end if;
    end if;
  end process proc_lfsr7_9_19;
  proc_lfsr8_10_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr8_10_19_rst = '1')) then
        lfsr8_10_19 <= "0";
      elsif (ce = '1') then 
        lfsr8_10_19 <= lfsr8_10_19_next;
      end if;
    end if;
  end process proc_lfsr8_10_19;
  proc_lfsr9_11_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (lfsr9_11_19_rst = '1')) then
        lfsr9_11_19 <= "0";
      elsif (ce = '1') then 
        lfsr9_11_19 <= lfsr9_11_19_next;
      end if;
    end if;
  end process proc_lfsr9_11_19;
  bit_27_35 <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(lfsr9_11_19) xor unsigned_to_std_logic_vector(lfsr4_6_19));
  bit_27_22 <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(lfsr1_3_19) xor unsigned_to_std_logic_vector(bit_27_35));
  temp_27_1_bitnot <= std_logic_vector_to_unsigned(not unsigned_to_std_logic_vector(bit_27_22));
  proc_if_25_1: process (en_1_63, lfsr0_2_19, lfsr1_3_19, lfsr2_4_19, lfsr3_5_19, lfsr4_6_19, lfsr5_7_19, lfsr6_8_19, lfsr7_9_19, lfsr8_10_19, lfsr9_11_19, temp_27_1_bitnot)
  is
  begin
    if en_1_63 then
      lfsr9_join_25_1 <= lfsr8_10_19;
      lfsr4_join_25_1 <= lfsr3_5_19;
      lfsr2_join_25_1 <= lfsr1_3_19;
      lfsr3_join_25_1 <= lfsr2_4_19;
      lfsr8_join_25_1 <= lfsr7_9_19;
      lfsr7_join_25_1 <= lfsr6_8_19;
      lfsr6_join_25_1 <= lfsr5_7_19;
      lfsr5_join_25_1 <= lfsr4_6_19;
      lfsr1_join_25_1 <= lfsr0_2_19;
      lfsr0_join_25_1 <= temp_27_1_bitnot;
    else 
      lfsr9_join_25_1 <= lfsr9_11_19;
      lfsr4_join_25_1 <= lfsr4_6_19;
      lfsr2_join_25_1 <= lfsr2_4_19;
      lfsr3_join_25_1 <= lfsr3_5_19;
      lfsr8_join_25_1 <= lfsr8_10_19;
      lfsr7_join_25_1 <= lfsr7_9_19;
      lfsr6_join_25_1 <= lfsr6_8_19;
      lfsr5_join_25_1 <= lfsr5_7_19;
      lfsr1_join_25_1 <= lfsr1_3_19;
      lfsr0_join_25_1 <= lfsr0_2_19;
    end if;
  end process proc_if_25_1;
  proc_if_13_1: process (lfsr0_join_25_1, lfsr1_join_25_1, lfsr2_join_25_1, lfsr3_join_25_1, lfsr4_join_25_1, lfsr5_join_25_1, lfsr6_join_25_1, lfsr7_join_25_1, lfsr8_join_25_1, lfsr9_join_25_1, rst_1_59)
  is
  begin
    if rst_1_59 then
      lfsr9_join_13_1_rst <= '1';
    else 
      lfsr9_join_13_1_rst <= '0';
    end if;
    lfsr9_join_13_1 <= lfsr9_join_25_1;
    if rst_1_59 then
      lfsr4_join_13_1_rst <= '1';
    else 
      lfsr4_join_13_1_rst <= '0';
    end if;
    lfsr4_join_13_1 <= lfsr4_join_25_1;
    if rst_1_59 then
      lfsr2_join_13_1_rst <= '1';
    else 
      lfsr2_join_13_1_rst <= '0';
    end if;
    lfsr2_join_13_1 <= lfsr2_join_25_1;
    if rst_1_59 then
      lfsr3_join_13_1_rst <= '1';
    else 
      lfsr3_join_13_1_rst <= '0';
    end if;
    lfsr3_join_13_1 <= lfsr3_join_25_1;
    if rst_1_59 then
      lfsr8_join_13_1_rst <= '1';
    else 
      lfsr8_join_13_1_rst <= '0';
    end if;
    lfsr8_join_13_1 <= lfsr8_join_25_1;
    if rst_1_59 then
      lfsr7_join_13_1_rst <= '1';
    else 
      lfsr7_join_13_1_rst <= '0';
    end if;
    lfsr7_join_13_1 <= lfsr7_join_25_1;
    if rst_1_59 then
      lfsr6_join_13_1_rst <= '1';
    else 
      lfsr6_join_13_1_rst <= '0';
    end if;
    lfsr6_join_13_1 <= lfsr6_join_25_1;
    if rst_1_59 then
      lfsr5_join_13_1_rst <= '1';
    else 
      lfsr5_join_13_1_rst <= '0';
    end if;
    lfsr5_join_13_1 <= lfsr5_join_25_1;
    if rst_1_59 then
      lfsr1_join_13_1_rst <= '1';
    else 
      lfsr1_join_13_1_rst <= '0';
    end if;
    lfsr1_join_13_1 <= lfsr1_join_25_1;
    if rst_1_59 then
      lfsr0_join_13_1_rst <= '1';
    else 
      lfsr0_join_13_1_rst <= '0';
    end if;
    lfsr0_join_13_1 <= lfsr0_join_25_1;
  end process proc_if_13_1;
  lfsr0_2_19_next <= lfsr0_join_25_1;
  lfsr0_2_19_rst <= lfsr0_join_13_1_rst;
  lfsr1_3_19_next <= lfsr1_join_25_1;
  lfsr1_3_19_rst <= lfsr1_join_13_1_rst;
  lfsr2_4_19_next <= lfsr2_join_25_1;
  lfsr2_4_19_rst <= lfsr2_join_13_1_rst;
  lfsr3_5_19_next <= lfsr3_join_25_1;
  lfsr3_5_19_rst <= lfsr3_join_13_1_rst;
  lfsr4_6_19_next <= lfsr4_join_25_1;
  lfsr4_6_19_rst <= lfsr4_join_13_1_rst;
  lfsr5_7_19_next <= lfsr5_join_25_1;
  lfsr5_7_19_rst <= lfsr5_join_13_1_rst;
  lfsr6_8_19_next <= lfsr6_join_25_1;
  lfsr6_8_19_rst <= lfsr6_join_13_1_rst;
  lfsr7_9_19_next <= lfsr7_join_25_1;
  lfsr7_9_19_rst <= lfsr7_join_13_1_rst;
  lfsr8_10_19_next <= lfsr8_join_25_1;
  lfsr8_10_19_rst <= lfsr8_join_13_1_rst;
  lfsr9_11_19_next <= lfsr9_join_25_1;
  lfsr9_11_19_rst <= lfsr9_join_13_1_rst;
  dout <= unsigned_to_std_logic_vector(lfsr9_11_19);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_1f748ed6a3 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_1f748ed6a3;
architecture behavior of sysgen_logical_1f748ed6a3
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_8c4040f65a is
  port (
    a : in std_logic_vector((32 - 1) downto 0);
    b : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_8c4040f65a;
architecture behavior of sysgen_relational_8c4040f65a
is
  signal a_1_31: unsigned((32 - 1) downto 0);
  signal b_1_34: unsigned((32 - 1) downto 0);
  signal result_16_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_16_3_rel <= a_1_31 < b_1_34;
  op <= boolean_to_vector(result_16_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_concat_1db22441e5 is
  port (
    in0 : in std_logic_vector((2 - 1) downto 0);
    in1 : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_1db22441e5;
architecture behavior of sysgen_concat_1db22441e5
is
  signal in0_1_23: unsigned((2 - 1) downto 0);
  signal in1_1_27: unsigned((2 - 1) downto 0);
  signal y_2_1_concat: unsigned((4 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_4e3293e801 is
  port (
    input_port : in std_logic_vector((2 - 1) downto 0);
    output_port : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_4e3293e801;
architecture behavior of sysgen_reinterpret_4e3293e801
is
  signal input_port_1_40: signed((2 - 1) downto 0);
  signal output_port_5_5_force: unsigned((2 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_signed(input_port);
  output_port_5_5_force <= signed_to_unsigned(input_port_1_40);
  output_port <= unsigned_to_std_logic_vector(output_port_5_5_force);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_1acb71f782 is
  port (
    op : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_1acb71f782;
architecture behavior of sysgen_constant_1acb71f782
is
begin
  op <= "00001000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_735c50577b is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_735c50577b;
architecture behavior of sysgen_logical_735c50577b
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_a61fffe920 is
  port (
    axiwrite : in std_logic_vector((1 - 1) downto 0);
    tlast : in std_logic_vector((1 - 1) downto 0);
    dcount : in std_logic_vector((1 - 1) downto 0);
    axiauto : in std_logic_vector((1 - 1) downto 0);
    re : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_a61fffe920;
architecture behavior of sysgen_mcode_block_a61fffe920
is
  signal axiwrite_1_23: unsigned((1 - 1) downto 0);
  signal tlast_1_33: unsigned((1 - 1) downto 0);
  signal dcount_1_40: unsigned((1 - 1) downto 0);
  signal axiauto_1_48: unsigned((1 - 1) downto 0);
  signal state_9_5_next: unsigned((2 - 1) downto 0);
  signal state_9_5: unsigned((2 - 1) downto 0) := "00";
  signal rel_14_16: boolean;
  signal rel_14_33: boolean;
  signal rel_14_48: boolean;
  signal bool_14_16: boolean;
  signal state_join_14_13: unsigned((2 - 1) downto 0);
  signal re_join_14_13: unsigned((1 - 1) downto 0);
  signal rel_22_16: boolean;
  signal state_join_22_13: unsigned((2 - 1) downto 0);
  signal re_join_22_13: unsigned((1 - 1) downto 0);
  signal rel_30_16: boolean;
  signal rel_30_33: boolean;
  signal bool_30_16: boolean;
  signal state_join_30_13: unsigned((2 - 1) downto 0);
  signal re_join_30_13: unsigned((1 - 1) downto 0);
  signal state_join_11_5: unsigned((2 - 1) downto 0);
  signal re_join_11_5: unsigned((1 - 1) downto 0);
begin
  axiwrite_1_23 <= std_logic_vector_to_unsigned(axiwrite);
  tlast_1_33 <= std_logic_vector_to_unsigned(tlast);
  dcount_1_40 <= std_logic_vector_to_unsigned(dcount);
  axiauto_1_48 <= std_logic_vector_to_unsigned(axiauto);
  proc_state_9_5: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        state_9_5 <= state_9_5_next;
      end if;
    end if;
  end process proc_state_9_5;
  rel_14_16 <= axiwrite_1_23 = std_logic_vector_to_unsigned("1");
  rel_14_33 <= dcount_1_40 = std_logic_vector_to_unsigned("1");
  rel_14_48 <= tlast_1_33 = std_logic_vector_to_unsigned("0");
  bool_14_16 <= rel_14_16 and rel_14_33 and rel_14_48;
  proc_if_14_13: process (bool_14_16, state_9_5)
  is
  begin
    if bool_14_16 then
      state_join_14_13 <= std_logic_vector_to_unsigned("01");
      re_join_14_13 <= std_logic_vector_to_unsigned("1");
    else 
      state_join_14_13 <= state_9_5;
      re_join_14_13 <= std_logic_vector_to_unsigned("0");
    end if;
  end process proc_if_14_13;
  rel_22_16 <= tlast_1_33 = std_logic_vector_to_unsigned("1");
  proc_if_22_13: process (rel_22_16, state_9_5)
  is
  begin
    if rel_22_16 then
      state_join_22_13 <= std_logic_vector_to_unsigned("10");
      re_join_22_13 <= std_logic_vector_to_unsigned("0");
    else 
      state_join_22_13 <= state_9_5;
      re_join_22_13 <= std_logic_vector_to_unsigned("1");
    end if;
  end process proc_if_22_13;
  rel_30_16 <= axiwrite_1_23 = std_logic_vector_to_unsigned("0");
  rel_30_33 <= axiauto_1_48 = std_logic_vector_to_unsigned("1");
  bool_30_16 <= rel_30_16 or rel_30_33;
  proc_if_30_13: process (bool_30_16, state_9_5)
  is
  begin
    if bool_30_16 then
      state_join_30_13 <= std_logic_vector_to_unsigned("00");
      re_join_30_13 <= std_logic_vector_to_unsigned("0");
    else 
      state_join_30_13 <= state_9_5;
      re_join_30_13 <= std_logic_vector_to_unsigned("0");
    end if;
  end process proc_if_30_13;
  proc_switch_11_5: process (re_join_14_13, re_join_22_13, re_join_30_13, state_9_5, state_join_14_13, state_join_22_13, state_join_30_13)
  is
  begin
    case state_9_5 is 
      when "00" =>
        state_join_11_5 <= state_join_14_13;
        re_join_11_5 <= re_join_14_13;
      when "01" =>
        state_join_11_5 <= state_join_22_13;
        re_join_11_5 <= re_join_22_13;
      when "10" =>
        state_join_11_5 <= state_join_30_13;
        re_join_11_5 <= re_join_30_13;
      when others =>
        state_join_11_5 <= std_logic_vector_to_unsigned("00");
        re_join_11_5 <= std_logic_vector_to_unsigned("0");
    end case;
  end process proc_switch_11_5;
  state_9_5_next <= state_join_11_5;
  re <= unsigned_to_std_logic_vector(re_join_11_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_fb64b2795b is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((11 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_fb64b2795b;
architecture behavior of sysgen_relational_fb64b2795b
is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((11 - 1) downto 0);
  signal cast_22_12: unsigned((11 - 1) downto 0);
  signal result_22_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_22_12 <= u2u_cast(a_1_31, 0, 11, 0);
  result_22_3_rel <= cast_22_12 >= b_1_34;
  op <= boolean_to_vector(result_22_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity qpsk_tx_symbol_gen_axi_lite_interface is 
    port(
        transfersymbol : out std_logic_vector(31 downto 0);
        resetsymbol : out std_logic_vector(31 downto 0);
        packetsizesymbol : out std_logic_vector(31 downto 0);
        lfsr_rst : out std_logic_vector(31 downto 0);
        enable : out std_logic_vector(31 downto 0);
        autorestartsymbol : out std_logic_vector(31 downto 0);
        packetsizerf : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        qpsk_tx_symbol_gen_aclk : in std_logic;
        qpsk_tx_symbol_gen_aresetn : in std_logic;
        qpsk_tx_symbol_gen_s_axi_awaddr : in std_logic_vector(6-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_awvalid : in std_logic;
        qpsk_tx_symbol_gen_s_axi_awready : out std_logic;
        qpsk_tx_symbol_gen_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_wvalid : in std_logic;
        qpsk_tx_symbol_gen_s_axi_wready : out std_logic;
        qpsk_tx_symbol_gen_s_axi_bresp : out std_logic_vector(1 downto 0);
        qpsk_tx_symbol_gen_s_axi_bvalid : out std_logic;
        qpsk_tx_symbol_gen_s_axi_bready : in std_logic;
        qpsk_tx_symbol_gen_s_axi_araddr : in std_logic_vector(6-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_arvalid : in std_logic;
        qpsk_tx_symbol_gen_s_axi_arready : out std_logic;
        qpsk_tx_symbol_gen_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_rresp : out std_logic_vector(1 downto 0);
        qpsk_tx_symbol_gen_s_axi_rvalid : out std_logic;
        qpsk_tx_symbol_gen_s_axi_rready : in std_logic
    );
end qpsk_tx_symbol_gen_axi_lite_interface;
architecture structural of qpsk_tx_symbol_gen_axi_lite_interface is 
component qpsk_tx_symbol_gen_axi_lite_interface_verilog is
    port(
        transfersymbol : out std_logic_vector(31 downto 0);
        resetsymbol : out std_logic_vector(31 downto 0);
        packetsizesymbol : out std_logic_vector(31 downto 0);
        lfsr_rst : out std_logic_vector(31 downto 0);
        enable : out std_logic_vector(31 downto 0);
        autorestartsymbol : out std_logic_vector(31 downto 0);
        packetsizerf : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        qpsk_tx_symbol_gen_aclk : in std_logic;
        qpsk_tx_symbol_gen_aresetn : in std_logic;
        qpsk_tx_symbol_gen_s_axi_awaddr : in std_logic_vector(6-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_awvalid : in std_logic;
        qpsk_tx_symbol_gen_s_axi_awready : out std_logic;
        qpsk_tx_symbol_gen_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_wvalid : in std_logic;
        qpsk_tx_symbol_gen_s_axi_wready : out std_logic;
        qpsk_tx_symbol_gen_s_axi_bresp : out std_logic_vector(1 downto 0);
        qpsk_tx_symbol_gen_s_axi_bvalid : out std_logic;
        qpsk_tx_symbol_gen_s_axi_bready : in std_logic;
        qpsk_tx_symbol_gen_s_axi_araddr : in std_logic_vector(6-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_arvalid : in std_logic;
        qpsk_tx_symbol_gen_s_axi_arready : out std_logic;
        qpsk_tx_symbol_gen_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        qpsk_tx_symbol_gen_s_axi_rresp : out std_logic_vector(1 downto 0);
        qpsk_tx_symbol_gen_s_axi_rvalid : out std_logic;
        qpsk_tx_symbol_gen_s_axi_rready : in std_logic
    );
end component;
begin
inst : qpsk_tx_symbol_gen_axi_lite_interface_verilog
    port map(
    transfersymbol => transfersymbol,
    resetsymbol => resetsymbol,
    packetsizesymbol => packetsizesymbol,
    lfsr_rst => lfsr_rst,
    enable => enable,
    autorestartsymbol => autorestartsymbol,
    packetsizerf => packetsizerf,
    clk => clk,
    qpsk_tx_symbol_gen_aclk => qpsk_tx_symbol_gen_aclk,
    qpsk_tx_symbol_gen_aresetn => qpsk_tx_symbol_gen_aresetn,
    qpsk_tx_symbol_gen_s_axi_awaddr => qpsk_tx_symbol_gen_s_axi_awaddr,
    qpsk_tx_symbol_gen_s_axi_awvalid => qpsk_tx_symbol_gen_s_axi_awvalid,
    qpsk_tx_symbol_gen_s_axi_awready => qpsk_tx_symbol_gen_s_axi_awready,
    qpsk_tx_symbol_gen_s_axi_wdata => qpsk_tx_symbol_gen_s_axi_wdata,
    qpsk_tx_symbol_gen_s_axi_wstrb => qpsk_tx_symbol_gen_s_axi_wstrb,
    qpsk_tx_symbol_gen_s_axi_wvalid => qpsk_tx_symbol_gen_s_axi_wvalid,
    qpsk_tx_symbol_gen_s_axi_wready => qpsk_tx_symbol_gen_s_axi_wready,
    qpsk_tx_symbol_gen_s_axi_bresp => qpsk_tx_symbol_gen_s_axi_bresp,
    qpsk_tx_symbol_gen_s_axi_bvalid => qpsk_tx_symbol_gen_s_axi_bvalid,
    qpsk_tx_symbol_gen_s_axi_bready => qpsk_tx_symbol_gen_s_axi_bready,
    qpsk_tx_symbol_gen_s_axi_araddr => qpsk_tx_symbol_gen_s_axi_araddr,
    qpsk_tx_symbol_gen_s_axi_arvalid => qpsk_tx_symbol_gen_s_axi_arvalid,
    qpsk_tx_symbol_gen_s_axi_arready => qpsk_tx_symbol_gen_s_axi_arready,
    qpsk_tx_symbol_gen_s_axi_rdata => qpsk_tx_symbol_gen_s_axi_rdata,
    qpsk_tx_symbol_gen_s_axi_rresp => qpsk_tx_symbol_gen_s_axi_rresp,
    qpsk_tx_symbol_gen_s_axi_rvalid => qpsk_tx_symbol_gen_s_axi_rvalid,
    qpsk_tx_symbol_gen_s_axi_rready => qpsk_tx_symbol_gen_s_axi_rready
);
end structural;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
 --
 --  Filename      : xlcounter_rst.vhd
 --
 --  Created       : 1/31/01
 --  Modified      :
 --
 --  Description   : VHDL wrapper for a counter. This wrapper
 --                  uses the Binary Counter CoreGenerator core.
 --
 ---------------------------------------------------------------------
 
 
 ---------------------------------------------------------------------
 --
 --  Entity        : xlcounter
 --
 --  Architecture  : behavior
 --
 --  Description   : Top level VHDL description of a counter.
 --
 ---------------------------------------------------------------------
 
 library IEEE;
 use IEEE.std_logic_1164.all;

entity qpsk_tx_symbol_gen_xlcounter_free is 
   generic (
     core_name0: string := "";
     op_width: integer := 5;
     op_arith: integer := xlSigned
   );
   port (
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     op: out std_logic_vector(op_width - 1 downto 0);
     up: in std_logic_vector(0 downto 0) := (others => '0');
     load: in std_logic_vector(0 downto 0) := (others => '0');
     din: in std_logic_vector(op_width - 1 downto 0) := (others => '0');
     en: in std_logic_vector(0 downto 0);
     rst: in std_logic_vector(0 downto 0)
   );
 end qpsk_tx_symbol_gen_xlcounter_free;
 
 architecture behavior of qpsk_tx_symbol_gen_xlcounter_free is


 component qpsk_tx_symbol_gen_c_counter_binary_v12_0_i0
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0) 
 		  ); 
 end component;

-- synthesis translate_off
   constant zeroVec: std_logic_vector(op_width - 1 downto 0) := (others => '0');
   constant oneVec: std_logic_vector(op_width - 1 downto 0) := (others => '1');
   constant zeroStr: string(1 to op_width) :=
     std_logic_vector_to_bin_string(zeroVec);
   constant oneStr: string(1 to op_width) :=
     std_logic_vector_to_bin_string(oneVec);
 -- synthesis translate_on
 
   signal core_sinit: std_logic;
   signal core_ce: std_logic;
   signal op_net: std_logic_vector(op_width - 1 downto 0);
 begin
   core_ce <= ce and en(0);
   core_sinit <= (clr or rst(0)) and ce;
   op <= op_net;


 comp0: if ((core_name0 = "qpsk_tx_symbol_gen_c_counter_binary_v12_0_i0")) generate 
  core_instance0:qpsk_tx_symbol_gen_c_counter_binary_v12_0_i0
   port map ( 
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
  ); 
   end generate;

end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
 --
 --  Entity        : xlfifogen
 --
 --  Architecture  : behavior
 --
 --  Description   : Top level VHDL description of a fifo block
 --
 ---------------------------------------------------------------------
 
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;
 use ieee.std_logic_unsigned.all;

entity qpsk_tx_symbol_gen_xlfifogen_u is 
   generic (
     core_name0: string := "";
     data_width: integer := -1;
     data_count_width: integer := -1;
     percent_full_width: integer := -1;
     has_ae : integer := 0;
     has_af : integer := 0;
     extra_registers: integer := 0;
     has_rst : boolean := false
   );
   port (
     din: in std_logic_vector(data_width - 1 downto 0);
     we: in std_logic;
     we_ce: in std_logic;
     re: in std_logic;
     re_ce: in std_logic;
     rst: in std_logic;
     en: in std_logic;
     ce: in std_logic;
     clk: in std_logic;
     empty: out std_logic;
     full: out std_logic;
     percent_full: out std_logic_vector(percent_full_width - 1 downto 0);
     dcount: out std_logic_vector(data_count_width - 1 downto 0);
     ae: out std_logic;
     af: out std_logic;
     dout: out std_logic_vector(data_width - 1 downto 0)
   );
 end qpsk_tx_symbol_gen_xlfifogen_u;
 
 architecture behavior of qpsk_tx_symbol_gen_xlfifogen_u is
 component synth_reg
 generic (
 width: integer := 16;
 latency: integer := 5
 );
 port (
 i: in std_logic_vector(width - 1 downto 0);
 ce: in std_logic;
 clr: in std_logic;
 clk: in std_logic;
 o: out std_logic_vector(width - 1 downto 0)
 );
 end component;
 


 component qpsk_tx_symbol_gen_fifo_generator_i0
    port ( 
      clk: in std_logic;
      srst: in std_logic;
      din: in std_logic_vector(data_width - 1 downto 0);
      wr_en: in std_logic;
      rd_en: in std_logic;
      dout: out std_logic_vector(data_width - 1 downto 0);
      full: out std_logic;
      empty: out std_logic;
      data_count: out std_logic_vector(data_count_width - 1 downto 0) 
 		  ); 
 end component;

  signal rd_en: std_logic;
   signal wr_en: std_logic;
   signal srst: std_logic;
   signal core_full: std_logic;
   signal core_dcount: std_logic_vector(data_count_width - 1 downto 0);
   signal srst_vec: std_logic_vector(0 downto 0);
   signal dout_net: std_logic_vector(data_width - 1 downto 0);
   signal count: integer; 
   signal empty_net: std_logic; 
   signal ae_net: std_logic; 
   signal af_net: std_logic; 
 
 begin
 

 comp0: if ((core_name0 = "qpsk_tx_symbol_gen_fifo_generator_i0")) generate 
  core_instance0:qpsk_tx_symbol_gen_fifo_generator_i0
   port map ( 
        clk => clk,
        srst => srst,
        din => din,
        wr_en => wr_en,
        rd_en => rd_en,
        full => core_full,
        dout => dout_net,
        empty => empty_net
,
        data_count => core_dcount
  ); 
   end generate;

-- Process to remap data count from 0000->1111 when fifo is full.
   modify_count: process(core_full, core_dcount) is
   begin
     if core_full = '1' then
       percent_full <= (others => '1');
     else
       percent_full <= core_dcount(data_count_width-1 downto data_count_width-percent_full_width);
     end if;
   end process modify_count;
   
   
   --Zero ae/af if these signals are not specified on the core
   terminate_core_ae: if has_ae /= 1 generate
   begin
     ae <= '0';
   end generate terminate_core_ae;
   terminate_core_af: if has_af /= 1 generate
   begin
     af <= '0';
   end generate terminate_core_af;
latency_gt_0: if (extra_registers > 0) generate
   reg: synth_reg
     generic map (
       width => 1,
       latency => extra_registers
     )
     port map (
       i => std_logic_to_vector(rst),
       ce => ce,
       clr => '0',
       clk => clk,
       o => srst_vec
     );
     srst <= srst_vec(0);
 end generate;
 
 latency_eq_0: if (extra_registers = 0) generate
   srst <= rst and ce;
 end generate;
 
    process (dout_net, empty_net, core_full, core_dcount, ae_net, af_net, re, we, en, re_ce, we_ce) is 
    begin 
        dout <= dout_net; 
        empty <= empty_net; 
        full <= core_full; 
        dcount <= core_dcount;
        ae <= ae_net;
        af <= af_net;
        rd_en <= re and en and re_ce;
        wr_en <= we and en and we_ce;
    end process; 
 end  behavior;
 
