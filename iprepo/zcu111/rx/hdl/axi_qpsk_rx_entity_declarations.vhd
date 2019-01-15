-------------------------------------------------------------------
-- System Generator version 2018.2 VHDL source file.
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
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity axi_qpsk_rx_xldelay is
   generic(width        : integer := -1;
           latency      : integer := -1;
           reg_retiming : integer :=  0;
           reset        : integer :=  0);
   port(d       : in std_logic_vector (width-1 downto 0);
        ce      : in std_logic;
        clk     : in std_logic;
        en      : in std_logic;
        rst     : in std_logic;
        q       : out std_logic_vector (width-1 downto 0));

end axi_qpsk_rx_xldelay;

architecture behavior of axi_qpsk_rx_xldelay is
   component synth_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component; -- end component synth_reg

   component synth_reg_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;

   signal internal_ce  : std_logic;

begin
   internal_ce  <= ce and en;

   srl_delay: if ((reg_retiming = 0) and (reset = 0)) or (latency < 1) generate
     synth_reg_srl_inst : synth_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => '0',
         clk => clk,
         o   => q);
   end generate srl_delay;

   reg_delay: if ((reg_retiming = 1) or (reset = 1)) and (latency >= 1) generate
     synth_reg_reg_inst : synth_reg_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => rst,
         clk => clk,
         o   => q);
   end generate reg_delay;
end architecture behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_a5eb79e2b1 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_a5eb79e2b1;
architecture behavior of sysgen_logical_a5eb79e2b1
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


entity axi_qpsk_rx_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end axi_qpsk_rx_xlregister;

architecture behavior of axi_qpsk_rx_xlregister is

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


entity axi_qpsk_rx_xlslice is
    generic (
        new_msb      : integer := 9;           -- position of new msb
        new_lsb      : integer := 1;           -- position of new lsb
        x_width      : integer := 16;          -- Width of x input
        y_width      : integer := 8);          -- Width of y output
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end axi_qpsk_rx_xlslice;

architecture behavior of axi_qpsk_rx_xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_concat_66bc51e78d is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_66bc51e78d;
architecture behavior of sysgen_concat_66bc51e78d
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
entity sysgen_constant_766b7584dc is
  port (
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_766b7584dc;
architecture behavior of sysgen_constant_766b7584dc
is
begin
  op <= "0000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_addsub_9be80d1a82 is
  port (
    a : in std_logic_vector((20 - 1) downto 0);
    b : in std_logic_vector((20 - 1) downto 0);
    mode : in std_logic_vector((1 - 1) downto 0);
    s : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_addsub_9be80d1a82;
architecture behavior of sysgen_addsub_9be80d1a82
is
  signal a_17_32: signed((20 - 1) downto 0);
  signal b_17_35: signed((20 - 1) downto 0);
  signal mode_17_48: boolean;
  type array_type_op_mem_91_20 is array (0 to (1 - 1)) of signed((20 - 1) downto 0);
  signal op_mem_91_20: array_type_op_mem_91_20 := (
    0 => "00000000000000000000");
  signal op_mem_91_20_front_din: signed((20 - 1) downto 0);
  signal op_mem_91_20_back: signed((20 - 1) downto 0);
  signal op_mem_91_20_push_front_pop_back_en: std_logic;
  type array_type_cout_mem_92_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal cout_mem_92_22: array_type_cout_mem_92_22 := (
    0 => "0");
  signal cout_mem_92_22_front_din: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_back: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_push_front_pop_back_en: std_logic;
  signal prev_mode_93_22_next: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22_reg_i: std_logic_vector((3 - 1) downto 0);
  signal prev_mode_93_22_reg_o: std_logic_vector((3 - 1) downto 0);
  signal not_68_25: boolean;
  signal bool_68_25: boolean;
  signal bool_68_7: boolean;
  signal cast_internal_s_69_5_addsub_a: signed((21 - 1) downto 0);
  signal cast_internal_s_69_5_addsub_b: signed((21 - 1) downto 0);
  signal internal_s_69_5_addsub: signed((21 - 1) downto 0);
  signal cast_internal_s_83_3_convert: signed((20 - 1) downto 0);
  signal prev_mode_93_22_next_x_000000: unsigned((3 - 1) downto 0);
begin
  a_17_32 <= std_logic_vector_to_signed(a);
  b_17_35 <= std_logic_vector_to_signed(b);
  mode_17_48 <= ((mode) = "1");
  op_mem_91_20_back <= op_mem_91_20(0);
  proc_op_mem_91_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_91_20_push_front_pop_back_en = '1')) then
        op_mem_91_20(0) <= op_mem_91_20_front_din;
      end if;
    end if;
  end process proc_op_mem_91_20;
  cout_mem_92_22_back <= cout_mem_92_22(0);
  proc_cout_mem_92_22: process (clk)
  is
    variable i_x_000000: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cout_mem_92_22_push_front_pop_back_en = '1')) then
        cout_mem_92_22(0) <= cout_mem_92_22_front_din;
      end if;
    end if;
  end process proc_cout_mem_92_22;
  prev_mode_93_22_reg_i <= unsigned_to_std_logic_vector(prev_mode_93_22_next);
  prev_mode_93_22 <= std_logic_vector_to_unsigned(prev_mode_93_22_reg_o);
  prev_mode_93_22_reg_inst: entity work.synth_reg_w_init
    generic map (
      init_index => 2, 
      init_value => b"010", 
      latency => 1, 
      width => 3)
    port map (
      ce => ce, 
      clk => clk, 
      clr => clr, 
      i => prev_mode_93_22_reg_i, 
      o => prev_mode_93_22_reg_o);
  not_68_25 <=  not mode_17_48;
  bool_68_25 <= not_68_25 and true;
  bool_68_7 <= false or bool_68_25;
  cast_internal_s_69_5_addsub_a <= s2s_cast(a_17_32, 18, 21, 18);
  cast_internal_s_69_5_addsub_b <= s2s_cast(b_17_35, 18, 21, 18);
  proc_internal_s_69_5_addsub: process (bool_68_7, cast_internal_s_69_5_addsub_a, cast_internal_s_69_5_addsub_b)
  is
  begin
    if bool_68_7 then
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a + cast_internal_s_69_5_addsub_b);
    else 
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a - cast_internal_s_69_5_addsub_b);
    end if;
  end process proc_internal_s_69_5_addsub;
  cast_internal_s_83_3_convert <= s2s_cast(internal_s_69_5_addsub, 18, 20, 18);
  op_mem_91_20_push_front_pop_back_en <= '0';
  cout_mem_92_22_push_front_pop_back_en <= '0';
  prev_mode_93_22_next_x_000000 <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(mode_17_48)), 0, 3, 0);
  prev_mode_93_22_next <= prev_mode_93_22_next_x_000000;
  s <= signed_to_std_logic_vector(cast_internal_s_83_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_addsub_049491c9fe is
  port (
    a : in std_logic_vector((15 - 1) downto 0);
    b : in std_logic_vector((15 - 1) downto 0);
    mode : in std_logic_vector((1 - 1) downto 0);
    s : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_addsub_049491c9fe;
architecture behavior of sysgen_addsub_049491c9fe
is
  signal a_17_32: signed((15 - 1) downto 0);
  signal b_17_35: signed((15 - 1) downto 0);
  signal mode_17_48: boolean;
  type array_type_op_mem_91_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_91_20: array_type_op_mem_91_20 := (
    0 => "000000000000000");
  signal op_mem_91_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_91_20_back: signed((15 - 1) downto 0);
  signal op_mem_91_20_push_front_pop_back_en: std_logic;
  type array_type_cout_mem_92_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal cout_mem_92_22: array_type_cout_mem_92_22 := (
    0 => "0");
  signal cout_mem_92_22_front_din: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_back: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_push_front_pop_back_en: std_logic;
  signal prev_mode_93_22_next: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22_reg_i: std_logic_vector((3 - 1) downto 0);
  signal prev_mode_93_22_reg_o: std_logic_vector((3 - 1) downto 0);
  signal not_68_25: boolean;
  signal bool_68_25: boolean;
  signal bool_68_7: boolean;
  signal cast_internal_s_69_5_addsub_a: signed((16 - 1) downto 0);
  signal cast_internal_s_69_5_addsub_b: signed((16 - 1) downto 0);
  signal internal_s_69_5_addsub: signed((16 - 1) downto 0);
  signal cast_internal_s_83_3_convert: signed((15 - 1) downto 0);
  signal prev_mode_93_22_next_x_000000: unsigned((3 - 1) downto 0);
begin
  a_17_32 <= std_logic_vector_to_signed(a);
  b_17_35 <= std_logic_vector_to_signed(b);
  mode_17_48 <= ((mode) = "1");
  op_mem_91_20_back <= op_mem_91_20(0);
  proc_op_mem_91_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_91_20_push_front_pop_back_en = '1')) then
        op_mem_91_20(0) <= op_mem_91_20_front_din;
      end if;
    end if;
  end process proc_op_mem_91_20;
  cout_mem_92_22_back <= cout_mem_92_22(0);
  proc_cout_mem_92_22: process (clk)
  is
    variable i_x_000000: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cout_mem_92_22_push_front_pop_back_en = '1')) then
        cout_mem_92_22(0) <= cout_mem_92_22_front_din;
      end if;
    end if;
  end process proc_cout_mem_92_22;
  prev_mode_93_22_reg_i <= unsigned_to_std_logic_vector(prev_mode_93_22_next);
  prev_mode_93_22 <= std_logic_vector_to_unsigned(prev_mode_93_22_reg_o);
  prev_mode_93_22_reg_inst: entity work.synth_reg_w_init
    generic map (
      init_index => 2, 
      init_value => b"010", 
      latency => 1, 
      width => 3)
    port map (
      ce => ce, 
      clk => clk, 
      clr => clr, 
      i => prev_mode_93_22_reg_i, 
      o => prev_mode_93_22_reg_o);
  not_68_25 <=  not mode_17_48;
  bool_68_25 <= not_68_25 and true;
  bool_68_7 <= false or bool_68_25;
  cast_internal_s_69_5_addsub_a <= s2s_cast(a_17_32, 12, 16, 12);
  cast_internal_s_69_5_addsub_b <= s2s_cast(b_17_35, 12, 16, 12);
  proc_internal_s_69_5_addsub: process (bool_68_7, cast_internal_s_69_5_addsub_a, cast_internal_s_69_5_addsub_b)
  is
  begin
    if bool_68_7 then
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a + cast_internal_s_69_5_addsub_b);
    else 
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a - cast_internal_s_69_5_addsub_b);
    end if;
  end process proc_internal_s_69_5_addsub;
  cast_internal_s_83_3_convert <= s2s_cast(internal_s_69_5_addsub, 12, 15, 12);
  op_mem_91_20_push_front_pop_back_en <= '0';
  cout_mem_92_22_push_front_pop_back_en <= '0';
  prev_mode_93_22_next_x_000000 <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(mode_17_48)), 0, 3, 0);
  prev_mode_93_22_next <= prev_mode_93_22_next_x_000000;
  s <= signed_to_std_logic_vector(cast_internal_s_83_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_8a3c490755 is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_8a3c490755;
architecture behavior of sysgen_constant_8a3c490755
is
begin
  op <= "00001111101011011100";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_inverter_2be377593a is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_inverter_2be377593a;
architecture behavior of sysgen_inverter_2be377593a
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
entity sysgen_logical_853283f4e6 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_853283f4e6;
architecture behavior of sysgen_logical_853283f4e6
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 xor d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_41b19789a3 is
  port (
    ip : in std_logic_vector((15 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_41b19789a3;
architecture behavior of sysgen_shift_41b19789a3
is
  signal ip_1_23: signed((15 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 14, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_5c7fcca31d is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_5c7fcca31d;
architecture behavior of sysgen_constant_5c7fcca31d
is
begin
  op <= "00000111111101010111";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_3b7c852278 is
  port (
    ip : in std_logic_vector((15 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_3b7c852278;
architecture behavior of sysgen_shift_3b7c852278
is
  signal ip_1_23: signed((15 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 15, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_819de9fa19 is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_819de9fa19;
architecture behavior of sysgen_constant_819de9fa19
is
begin
  op <= "00000011111111101011";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_e43195c749 is
  port (
    ip : in std_logic_vector((15 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_e43195c749;
architecture behavior of sysgen_shift_e43195c749
is
  signal ip_1_23: signed((15 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_27_3_rsh: signed((16 - 1) downto 0);
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_27_3_rsh <= s2s_cast(ip_1_23, 12, 16, 12);
  cast_internal_ip_33_3_convert <= s2s_cast(cast_internal_ip_27_3_rsh, 16, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_b72a705628 is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_b72a705628;
architecture behavior of sysgen_constant_b72a705628
is
begin
  op <= "00000001111111111101";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_1239abb7a8 is
  port (
    ip : in std_logic_vector((15 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_1239abb7a8;
architecture behavior of sysgen_shift_1239abb7a8
is
  signal ip_1_23: signed((15 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_27_3_rsh: signed((17 - 1) downto 0);
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_27_3_rsh <= s2s_cast(ip_1_23, 12, 17, 12);
  cast_internal_ip_33_3_convert <= s2s_cast(cast_internal_ip_27_3_rsh, 17, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_0880909ffe is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_0880909ffe;
architecture behavior of sysgen_constant_0880909ffe
is
begin
  op <= "00000001000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_3c96ef04d0 is
  port (
    ip : in std_logic_vector((15 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_3c96ef04d0;
architecture behavior of sysgen_shift_3c96ef04d0
is
  signal ip_1_23: signed((15 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_27_3_rsh: signed((18 - 1) downto 0);
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_27_3_rsh <= s2s_cast(ip_1_23, 12, 18, 12);
  cast_internal_ip_33_3_convert <= s2s_cast(cast_internal_ip_27_3_rsh, 18, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_9dc06ea2a0 is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_9dc06ea2a0;
architecture behavior of sysgen_constant_9dc06ea2a0
is
begin
  op <= "00000000100000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_955cb48bd0 is
  port (
    ip : in std_logic_vector((15 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_955cb48bd0;
architecture behavior of sysgen_shift_955cb48bd0
is
  signal ip_1_23: signed((15 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_27_3_rsh: signed((19 - 1) downto 0);
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_27_3_rsh <= s2s_cast(ip_1_23, 12, 19, 12);
  cast_internal_ip_33_3_convert <= s2s_cast(cast_internal_ip_27_3_rsh, 19, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_addsub_1d223d9e75 is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((20 - 1) downto 0);
    mode : in std_logic_vector((1 - 1) downto 0);
    s : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_addsub_1d223d9e75;
architecture behavior of sysgen_addsub_1d223d9e75
is
  signal a_17_32: signed((16 - 1) downto 0);
  signal b_17_35: signed((20 - 1) downto 0);
  signal mode_17_48: boolean;
  type array_type_op_mem_91_20 is array (0 to (1 - 1)) of signed((20 - 1) downto 0);
  signal op_mem_91_20: array_type_op_mem_91_20 := (
    0 => "00000000000000000000");
  signal op_mem_91_20_front_din: signed((20 - 1) downto 0);
  signal op_mem_91_20_back: signed((20 - 1) downto 0);
  signal op_mem_91_20_push_front_pop_back_en: std_logic;
  type array_type_cout_mem_92_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal cout_mem_92_22: array_type_cout_mem_92_22 := (
    0 => "0");
  signal cout_mem_92_22_front_din: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_back: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_push_front_pop_back_en: std_logic;
  signal prev_mode_93_22_next: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22_reg_i: std_logic_vector((3 - 1) downto 0);
  signal prev_mode_93_22_reg_o: std_logic_vector((3 - 1) downto 0);
  signal not_68_25: boolean;
  signal bool_68_25: boolean;
  signal bool_68_7: boolean;
  signal cast_internal_s_69_5_addsub_a: signed((21 - 1) downto 0);
  signal cast_internal_s_69_5_addsub_b: signed((21 - 1) downto 0);
  signal internal_s_69_5_addsub: signed((21 - 1) downto 0);
  signal cast_internal_s_83_3_convert: signed((20 - 1) downto 0);
  signal prev_mode_93_22_next_x_000000: unsigned((3 - 1) downto 0);
begin
  a_17_32 <= std_logic_vector_to_signed(a);
  b_17_35 <= std_logic_vector_to_signed(b);
  mode_17_48 <= ((mode) = "1");
  op_mem_91_20_back <= op_mem_91_20(0);
  proc_op_mem_91_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_91_20_push_front_pop_back_en = '1')) then
        op_mem_91_20(0) <= op_mem_91_20_front_din;
      end if;
    end if;
  end process proc_op_mem_91_20;
  cout_mem_92_22_back <= cout_mem_92_22(0);
  proc_cout_mem_92_22: process (clk)
  is
    variable i_x_000000: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cout_mem_92_22_push_front_pop_back_en = '1')) then
        cout_mem_92_22(0) <= cout_mem_92_22_front_din;
      end if;
    end if;
  end process proc_cout_mem_92_22;
  prev_mode_93_22_reg_i <= unsigned_to_std_logic_vector(prev_mode_93_22_next);
  prev_mode_93_22 <= std_logic_vector_to_unsigned(prev_mode_93_22_reg_o);
  prev_mode_93_22_reg_inst: entity work.synth_reg_w_init
    generic map (
      init_index => 2, 
      init_value => b"010", 
      latency => 1, 
      width => 3)
    port map (
      ce => ce, 
      clk => clk, 
      clr => clr, 
      i => prev_mode_93_22_reg_i, 
      o => prev_mode_93_22_reg_o);
  not_68_25 <=  not mode_17_48;
  bool_68_25 <= not_68_25 and true;
  bool_68_7 <= false or bool_68_25;
  cast_internal_s_69_5_addsub_a <= s2s_cast(a_17_32, 14, 21, 18);
  cast_internal_s_69_5_addsub_b <= s2s_cast(b_17_35, 18, 21, 18);
  proc_internal_s_69_5_addsub: process (bool_68_7, cast_internal_s_69_5_addsub_a, cast_internal_s_69_5_addsub_b)
  is
  begin
    if bool_68_7 then
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a + cast_internal_s_69_5_addsub_b);
    else 
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a - cast_internal_s_69_5_addsub_b);
    end if;
  end process proc_internal_s_69_5_addsub;
  cast_internal_s_83_3_convert <= s2s_cast(internal_s_69_5_addsub, 18, 20, 18);
  op_mem_91_20_push_front_pop_back_en <= '0';
  cout_mem_92_22_push_front_pop_back_en <= '0';
  prev_mode_93_22_next_x_000000 <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(mode_17_48)), 0, 3, 0);
  prev_mode_93_22_next <= prev_mode_93_22_next_x_000000;
  s <= signed_to_std_logic_vector(cast_internal_s_83_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_addsub_d5fefdfebc is
  port (
    a : in std_logic_vector((19 - 1) downto 0);
    b : in std_logic_vector((15 - 1) downto 0);
    mode : in std_logic_vector((1 - 1) downto 0);
    s : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_addsub_d5fefdfebc;
architecture behavior of sysgen_addsub_d5fefdfebc
is
  signal a_17_32: signed((19 - 1) downto 0);
  signal b_17_35: signed((15 - 1) downto 0);
  signal mode_17_48: boolean;
  type array_type_op_mem_91_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_91_20: array_type_op_mem_91_20 := (
    0 => "000000000000000");
  signal op_mem_91_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_91_20_back: signed((15 - 1) downto 0);
  signal op_mem_91_20_push_front_pop_back_en: std_logic;
  type array_type_cout_mem_92_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal cout_mem_92_22: array_type_cout_mem_92_22 := (
    0 => "0");
  signal cout_mem_92_22_front_din: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_back: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_push_front_pop_back_en: std_logic;
  signal prev_mode_93_22_next: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22_reg_i: std_logic_vector((3 - 1) downto 0);
  signal prev_mode_93_22_reg_o: std_logic_vector((3 - 1) downto 0);
  signal not_68_25: boolean;
  signal bool_68_25: boolean;
  signal bool_68_7: boolean;
  signal cast_internal_s_69_5_addsub_a: signed((20 - 1) downto 0);
  signal cast_internal_s_69_5_addsub_b: signed((20 - 1) downto 0);
  signal internal_s_69_5_addsub: signed((20 - 1) downto 0);
  signal cast_internal_s_83_3_convert: signed((15 - 1) downto 0);
  signal prev_mode_93_22_next_x_000000: unsigned((3 - 1) downto 0);
begin
  a_17_32 <= std_logic_vector_to_signed(a);
  b_17_35 <= std_logic_vector_to_signed(b);
  mode_17_48 <= ((mode) = "1");
  op_mem_91_20_back <= op_mem_91_20(0);
  proc_op_mem_91_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_91_20_push_front_pop_back_en = '1')) then
        op_mem_91_20(0) <= op_mem_91_20_front_din;
      end if;
    end if;
  end process proc_op_mem_91_20;
  cout_mem_92_22_back <= cout_mem_92_22(0);
  proc_cout_mem_92_22: process (clk)
  is
    variable i_x_000000: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cout_mem_92_22_push_front_pop_back_en = '1')) then
        cout_mem_92_22(0) <= cout_mem_92_22_front_din;
      end if;
    end if;
  end process proc_cout_mem_92_22;
  prev_mode_93_22_reg_i <= unsigned_to_std_logic_vector(prev_mode_93_22_next);
  prev_mode_93_22 <= std_logic_vector_to_unsigned(prev_mode_93_22_reg_o);
  prev_mode_93_22_reg_inst: entity work.synth_reg_w_init
    generic map (
      init_index => 2, 
      init_value => b"010", 
      latency => 1, 
      width => 3)
    port map (
      ce => ce, 
      clk => clk, 
      clr => clr, 
      i => prev_mode_93_22_reg_i, 
      o => prev_mode_93_22_reg_o);
  not_68_25 <=  not mode_17_48;
  bool_68_25 <= not_68_25 and true;
  bool_68_7 <= false or bool_68_25;
  cast_internal_s_69_5_addsub_a <= s2s_cast(a_17_32, 14, 20, 14);
  cast_internal_s_69_5_addsub_b <= s2s_cast(b_17_35, 12, 20, 14);
  proc_internal_s_69_5_addsub: process (bool_68_7, cast_internal_s_69_5_addsub_a, cast_internal_s_69_5_addsub_b)
  is
  begin
    if bool_68_7 then
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a + cast_internal_s_69_5_addsub_b);
    else 
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a - cast_internal_s_69_5_addsub_b);
    end if;
  end process proc_internal_s_69_5_addsub;
  cast_internal_s_83_3_convert <= s2s_cast(internal_s_69_5_addsub, 14, 15, 12);
  op_mem_91_20_push_front_pop_back_en <= '0';
  cout_mem_92_22_push_front_pop_back_en <= '0';
  prev_mode_93_22_next_x_000000 <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(mode_17_48)), 0, 3, 0);
  prev_mode_93_22_next <= prev_mode_93_22_next_x_000000;
  s <= signed_to_std_logic_vector(cast_internal_s_83_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_335dcdd784 is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_335dcdd784;
architecture behavior of sysgen_constant_335dcdd784
is
begin
  op <= "00110010010000111111";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_ebeed46c83 is
  port (
    ip : in std_logic_vector((19 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_ebeed46c83;
architecture behavior of sysgen_shift_ebeed46c83
is
  signal ip_1_23: signed((19 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 14, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_b154b9238b is
  port (
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_b154b9238b;
architecture behavior of sysgen_constant_b154b9238b
is
begin
  op <= "00011101101011000110";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_8463c36d4f is
  port (
    ip : in std_logic_vector((15 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_8463c36d4f;
architecture behavior of sysgen_shift_8463c36d4f
is
  signal ip_1_23: signed((15 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 13, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_014707fac5 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((38 - 1) downto 0);
    y : out std_logic_vector((38 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_014707fac5;
architecture behavior of sysgen_mux_014707fac5
is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((38 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((38 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= cast(d0_1_24, 14, 38, 28, xlSigned);
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
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


entity convert_func_call_axi_qpsk_rx_xlconvert is
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
end convert_func_call_axi_qpsk_rx_xlconvert ;

architecture behavior of convert_func_call_axi_qpsk_rx_xlconvert is
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


entity axi_qpsk_rx_xlconvert  is
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

end axi_qpsk_rx_xlconvert ;

architecture behavior of axi_qpsk_rx_xlconvert  is

    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;

    component convert_func_call_axi_qpsk_rx_xlconvert 
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
      convert : convert_func_call_axi_qpsk_rx_xlconvert 
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_689a393bb6 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((22 - 1) downto 0);
    y : out std_logic_vector((22 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_689a393bb6;
architecture behavior of sysgen_mux_689a393bb6
is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((22 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((22 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= cast(d0_1_24, 14, 22, 14, xlSigned);
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_432822c268 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_432822c268;
architecture behavior of sysgen_constant_432822c268
is
begin
  op <= "1";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_86ab61f740 is
  port (
    op : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_86ab61f740;
architecture behavior of sysgen_constant_86ab61f740
is
begin
  op <= "111111111";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_33b72c42a8 is
  port (
    a : in std_logic_vector((9 - 1) downto 0);
    b : in std_logic_vector((9 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_33b72c42a8;
architecture behavior of sysgen_relational_33b72c42a8
is
  signal a_1_31: unsigned((9 - 1) downto 0);
  signal b_1_34: unsigned((9 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_39926d6db9 is
  port (
    a : in std_logic_vector((30 - 1) downto 0);
    b : in std_logic_vector((30 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_39926d6db9;
architecture behavior of sysgen_relational_39926d6db9
is
  signal a_1_31: signed((30 - 1) downto 0);
  signal b_1_34: signed((30 - 1) downto 0);
  signal result_18_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_signed(a);
  b_1_34 <= std_logic_vector_to_signed(b);
  result_18_3_rel <= a_1_31 > b_1_34;
  op <= boolean_to_vector(result_18_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_412e8aeba1 is
  port (
    ip : in std_logic_vector((26 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_412e8aeba1;
architecture behavior of sysgen_shift_412e8aeba1
is
  signal ip_1_23: signed((26 - 1) downto 0);
  signal en_1_27: boolean;
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((16 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "0000000000000000");
  signal op_mem_46_20_front_din: signed((16 - 1) downto 0);
  signal op_mem_46_20_back: signed((16 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((16 - 1) downto 0);
  signal op_mem_shift_join_53_3: signed((16 - 1) downto 0);
  signal op_mem_shift_join_53_3_en: std_logic;
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  en_1_27 <= ((en) = "1");
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 24, 16, 14);
  proc_if_53_3: process (cast_internal_ip_33_3_convert, en_1_27)
  is
  begin
    if en_1_27 then
      op_mem_shift_join_53_3_en <= '1';
    else 
      op_mem_shift_join_53_3_en <= '0';
    end if;
    op_mem_shift_join_53_3 <= cast_internal_ip_33_3_convert;
  end process proc_if_53_3;
  op_mem_46_20_front_din <= op_mem_shift_join_53_3;
  op_mem_46_20_push_front_pop_back_en <= op_mem_shift_join_53_3_en;
  op <= signed_to_std_logic_vector(op_mem_46_20_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_addsub_78a1e4d5fa is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((15 - 1) downto 0);
    mode : in std_logic_vector((1 - 1) downto 0);
    s : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_addsub_78a1e4d5fa;
architecture behavior of sysgen_addsub_78a1e4d5fa
is
  signal a_17_32: signed((16 - 1) downto 0);
  signal b_17_35: signed((15 - 1) downto 0);
  signal mode_17_48: boolean;
  type array_type_op_mem_91_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_91_20: array_type_op_mem_91_20 := (
    0 => "000000000000000");
  signal op_mem_91_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_91_20_back: signed((15 - 1) downto 0);
  signal op_mem_91_20_push_front_pop_back_en: std_logic;
  type array_type_cout_mem_92_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal cout_mem_92_22: array_type_cout_mem_92_22 := (
    0 => "0");
  signal cout_mem_92_22_front_din: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_back: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_push_front_pop_back_en: std_logic;
  signal prev_mode_93_22_next: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22_reg_i: std_logic_vector((3 - 1) downto 0);
  signal prev_mode_93_22_reg_o: std_logic_vector((3 - 1) downto 0);
  signal not_68_25: boolean;
  signal bool_68_25: boolean;
  signal bool_68_7: boolean;
  signal cast_internal_s_69_5_addsub_a: signed((18 - 1) downto 0);
  signal cast_internal_s_69_5_addsub_b: signed((18 - 1) downto 0);
  signal internal_s_69_5_addsub: signed((18 - 1) downto 0);
  signal cast_internal_s_83_3_convert: signed((15 - 1) downto 0);
  signal prev_mode_93_22_next_x_000000: unsigned((3 - 1) downto 0);
begin
  a_17_32 <= std_logic_vector_to_signed(a);
  b_17_35 <= std_logic_vector_to_signed(b);
  mode_17_48 <= ((mode) = "1");
  op_mem_91_20_back <= op_mem_91_20(0);
  proc_op_mem_91_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_91_20_push_front_pop_back_en = '1')) then
        op_mem_91_20(0) <= op_mem_91_20_front_din;
      end if;
    end if;
  end process proc_op_mem_91_20;
  cout_mem_92_22_back <= cout_mem_92_22(0);
  proc_cout_mem_92_22: process (clk)
  is
    variable i_x_000000: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cout_mem_92_22_push_front_pop_back_en = '1')) then
        cout_mem_92_22(0) <= cout_mem_92_22_front_din;
      end if;
    end if;
  end process proc_cout_mem_92_22;
  prev_mode_93_22_reg_i <= unsigned_to_std_logic_vector(prev_mode_93_22_next);
  prev_mode_93_22 <= std_logic_vector_to_unsigned(prev_mode_93_22_reg_o);
  prev_mode_93_22_reg_inst: entity work.synth_reg_w_init
    generic map (
      init_index => 2, 
      init_value => b"010", 
      latency => 1, 
      width => 3)
    port map (
      ce => ce, 
      clk => clk, 
      clr => clr, 
      i => prev_mode_93_22_reg_i, 
      o => prev_mode_93_22_reg_o);
  not_68_25 <=  not mode_17_48;
  bool_68_25 <= not_68_25 and true;
  bool_68_7 <= false or bool_68_25;
  cast_internal_s_69_5_addsub_a <= s2s_cast(a_17_32, 14, 18, 14);
  cast_internal_s_69_5_addsub_b <= s2s_cast(b_17_35, 12, 18, 14);
  proc_internal_s_69_5_addsub: process (bool_68_7, cast_internal_s_69_5_addsub_a, cast_internal_s_69_5_addsub_b)
  is
  begin
    if bool_68_7 then
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a + cast_internal_s_69_5_addsub_b);
    else 
      internal_s_69_5_addsub <= (cast_internal_s_69_5_addsub_a - cast_internal_s_69_5_addsub_b);
    end if;
  end process proc_internal_s_69_5_addsub;
  cast_internal_s_83_3_convert <= s2s_cast(internal_s_69_5_addsub, 14, 15, 12);
  op_mem_91_20_push_front_pop_back_en <= '0';
  cout_mem_92_22_push_front_pop_back_en <= '0';
  prev_mode_93_22_next_x_000000 <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(mode_17_48)), 0, 3, 0);
  prev_mode_93_22_next <= prev_mode_93_22_next_x_000000;
  s <= signed_to_std_logic_vector(cast_internal_s_83_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_b3626a6de7 is
  port (
    ip : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((15 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_b3626a6de7;
architecture behavior of sysgen_shift_b3626a6de7
is
  signal ip_1_23: signed((16 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((15 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "000000000000000");
  signal op_mem_46_20_front_din: signed((15 - 1) downto 0);
  signal op_mem_46_20_back: signed((15 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((15 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 14, 15, 12);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_concat_2f4e7d13ad is
  port (
    in0 : in std_logic_vector((16 - 1) downto 0);
    in1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_2f4e7d13ad;
architecture behavior of sysgen_concat_2f4e7d13ad
is
  signal in0_1_23: unsigned((16 - 1) downto 0);
  signal in1_1_27: unsigned((16 - 1) downto 0);
  signal y_2_1_concat: unsigned((32 - 1) downto 0);
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
entity sysgen_reinterpret_2b0fa1c5bb is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_2b0fa1c5bb;
architecture behavior of sysgen_reinterpret_2b0fa1c5bb
is
  signal input_port_1_40: signed((16 - 1) downto 0);
  signal output_port_5_5_force: unsigned((16 - 1) downto 0);
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
entity sysgen_constant_4a1c0a5c6e is
  port (
    op : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_4a1c0a5c6e;
architecture behavior of sysgen_constant_4a1c0a5c6e
is
begin
  op <= "11111111111";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_b04b39890e is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_b04b39890e;
architecture behavior of sysgen_logical_b04b39890e
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
entity sysgen_mcode_block_cc2ba69160 is
  port (
    axiwrite : in std_logic_vector((1 - 1) downto 0);
    tlast : in std_logic_vector((1 - 1) downto 0);
    dcount : in std_logic_vector((1 - 1) downto 0);
    axiauto : in std_logic_vector((1 - 1) downto 0);
    re : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_cc2ba69160;
architecture behavior of sysgen_mcode_block_cc2ba69160
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
  signal re_join_14_13: unsigned((1 - 1) downto 0);
  signal state_join_14_13: unsigned((2 - 1) downto 0);
  signal rel_22_16: boolean;
  signal re_join_22_13: unsigned((1 - 1) downto 0);
  signal state_join_22_13: unsigned((2 - 1) downto 0);
  signal rel_30_16: boolean;
  signal rel_30_33: boolean;
  signal bool_30_16: boolean;
  signal re_join_30_13: unsigned((1 - 1) downto 0);
  signal state_join_30_13: unsigned((2 - 1) downto 0);
  signal re_join_11_5: unsigned((1 - 1) downto 0);
  signal state_join_11_5: unsigned((2 - 1) downto 0);
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
      re_join_14_13 <= std_logic_vector_to_unsigned("1");
      state_join_14_13 <= std_logic_vector_to_unsigned("01");
    else 
      re_join_14_13 <= std_logic_vector_to_unsigned("0");
      state_join_14_13 <= state_9_5;
    end if;
  end process proc_if_14_13;
  rel_22_16 <= tlast_1_33 = std_logic_vector_to_unsigned("1");
  proc_if_22_13: process (rel_22_16, state_9_5)
  is
  begin
    if rel_22_16 then
      re_join_22_13 <= std_logic_vector_to_unsigned("0");
      state_join_22_13 <= std_logic_vector_to_unsigned("10");
    else 
      re_join_22_13 <= std_logic_vector_to_unsigned("1");
      state_join_22_13 <= state_9_5;
    end if;
  end process proc_if_22_13;
  rel_30_16 <= axiwrite_1_23 = std_logic_vector_to_unsigned("0");
  rel_30_33 <= axiauto_1_48 = std_logic_vector_to_unsigned("1");
  bool_30_16 <= rel_30_16 or rel_30_33;
  proc_if_30_13: process (bool_30_16, state_9_5)
  is
  begin
    if bool_30_16 then
      re_join_30_13 <= std_logic_vector_to_unsigned("0");
      state_join_30_13 <= std_logic_vector_to_unsigned("00");
    else 
      re_join_30_13 <= std_logic_vector_to_unsigned("0");
      state_join_30_13 <= state_9_5;
    end if;
  end process proc_if_30_13;
  proc_switch_11_5: process (re_join_14_13, re_join_22_13, re_join_30_13, state_9_5, state_join_14_13, state_join_22_13, state_join_30_13)
  is
  begin
    case state_9_5 is 
      when "00" =>
        re_join_11_5 <= re_join_14_13;
        state_join_11_5 <= state_join_14_13;
      when "01" =>
        re_join_11_5 <= re_join_22_13;
        state_join_11_5 <= state_join_22_13;
      when "10" =>
        re_join_11_5 <= re_join_30_13;
        state_join_11_5 <= state_join_30_13;
      when others =>
        re_join_11_5 <= std_logic_vector_to_unsigned("0");
        state_join_11_5 <= std_logic_vector_to_unsigned("00");
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
entity sysgen_relational_14537c6392 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((11 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_14537c6392;
architecture behavior of sysgen_relational_14537c6392
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
entity sysgen_relational_8fd2049cdd is
  port (
    a : in std_logic_vector((32 - 1) downto 0);
    b : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_8fd2049cdd;
architecture behavior of sysgen_relational_8fd2049cdd
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
entity sysgen_relational_fc947ff06d is
  port (
    a : in std_logic_vector((12 - 1) downto 0);
    b : in std_logic_vector((11 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_fc947ff06d;
architecture behavior of sysgen_relational_fc947ff06d
is
  signal a_1_31: unsigned((12 - 1) downto 0);
  signal b_1_34: unsigned((11 - 1) downto 0);
  signal cast_22_17: unsigned((12 - 1) downto 0);
  signal result_22_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_22_17 <= u2u_cast(b_1_34, 0, 12, 0);
  result_22_3_rel <= a_1_31 >= cast_22_17;
  op <= boolean_to_vector(result_22_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_cee7ed0ed3 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_cee7ed0ed3;
architecture behavior of sysgen_logical_cee7ed0ed3
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal d2_1_30: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  d2_1_30 <= d2(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27 and d2_1_30;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_5939c83eda is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_5939c83eda;
architecture behavior of sysgen_logical_5939c83eda
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  type array_type_latency_pipe_5_26 is array (0 to (1 - 1)) of std_logic;
  signal latency_pipe_5_26: array_type_latency_pipe_5_26 := (
    0 => '0');
  signal latency_pipe_5_26_front_din: std_logic;
  signal latency_pipe_5_26_back: std_logic;
  signal latency_pipe_5_26_push_front_pop_back_en: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  latency_pipe_5_26_back <= latency_pipe_5_26(0);
  proc_latency_pipe_5_26: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (latency_pipe_5_26_push_front_pop_back_en = '1')) then
        latency_pipe_5_26(0) <= latency_pipe_5_26_front_din;
      end if;
    end if;
  end process proc_latency_pipe_5_26;
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  latency_pipe_5_26_front_din <= fully_2_1_bit;
  latency_pipe_5_26_push_front_pop_back_en <= '1';
  y <= std_logic_to_vector(latency_pipe_5_26_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_3b0583e07f is
  port (
    ip : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((17 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_3b0583e07f;
architecture behavior of sysgen_shift_3b0583e07f
is
  signal ip_1_23: signed((32 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((17 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "00000000000000000");
  signal op_mem_46_20_front_din: signed((17 - 1) downto 0);
  signal op_mem_46_20_back: signed((17 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((17 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 29, 17, 14);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_2a2162dd1a is
  port (
    ip : in std_logic_vector((37 - 1) downto 0);
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_2a2162dd1a;
architecture behavior of sysgen_shift_2a2162dd1a
is
  signal ip_1_23: signed((37 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((16 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "0000000000000000");
  signal op_mem_46_20_front_din: signed((16 - 1) downto 0);
  signal op_mem_46_20_back: signed((16 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((16 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 32, 16, 14);
  op_mem_46_20_front_din <= cast_internal_ip_33_3_convert;
  op_mem_46_20_push_front_pop_back_en <= '1';
  op <= signed_to_std_logic_vector(op_mem_46_20_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_9048a82ea4 is
  port (
    ip : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_9048a82ea4;
architecture behavior of sysgen_shift_9048a82ea4
is
  signal ip_1_23: signed((32 - 1) downto 0);
  type array_type_op_mem_46_20 is array (0 to (1 - 1)) of signed((16 - 1) downto 0);
  signal op_mem_46_20: array_type_op_mem_46_20 := (
    0 => "0000000000000000");
  signal op_mem_46_20_front_din: signed((16 - 1) downto 0);
  signal op_mem_46_20_back: signed((16 - 1) downto 0);
  signal op_mem_46_20_push_front_pop_back_en: std_logic;
  signal cast_internal_ip_33_3_convert: signed((16 - 1) downto 0);
begin
  ip_1_23 <= std_logic_vector_to_signed(ip);
  op_mem_46_20_back <= op_mem_46_20(0);
  proc_op_mem_46_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_46_20_push_front_pop_back_en = '1')) then
        op_mem_46_20(0) <= op_mem_46_20_front_din;
      end if;
    end if;
  end process proc_op_mem_46_20;
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 28, 16, 14);
  op_mem_46_20_front_din <= cast_internal_ip_33_3_convert;
  op_mem_46_20_push_front_pop_back_en <= '1';
  op <= signed_to_std_logic_vector(op_mem_46_20_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_3fbbbda527 is
  port (
    op : out std_logic_vector((26 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_3fbbbda527;
architecture behavior of sysgen_constant_3fbbbda527
is
begin
  op <= "01000000000000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_a8a74738be is
  port (
    op : out std_logic_vector((30 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_a8a74738be;
architecture behavior of sysgen_constant_a8a74738be
is
begin
  op <= "100000000000000000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_7e5186e255 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((30 - 1) downto 0);
    d1 : in std_logic_vector((29 - 1) downto 0);
    y : out std_logic_vector((29 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_7e5186e255;
architecture behavior of sysgen_mux_7e5186e255
is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((30 - 1) downto 0);
  signal d1_1_27: std_logic_vector((29 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((30 - 1) downto 0);
  signal cast_unregy_13_5_convert: std_logic_vector((29 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= cast(d1_1_27, 24, 30, 24, xlUnsigned);
    end case;
  end process proc_switch_6_1;
  cast_unregy_13_5_convert <= cast(unregy_join_6_1, 24, 29, 24, xlUnsigned);
  y <= cast_unregy_13_5_convert;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_b397dac787 is
  port (
    a : in std_logic_vector((30 - 1) downto 0);
    b : in std_logic_vector((30 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_b397dac787;
architecture behavior of sysgen_relational_b397dac787
is
  signal a_1_31: unsigned((30 - 1) downto 0);
  signal b_1_34: unsigned((30 - 1) downto 0);
  signal result_18_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_18_3_rel <= a_1_31 > b_1_34;
  op <= boolean_to_vector(result_18_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity axi_qpsk_rx_axi_lite_interface is 
    port(
        transfer_sync : out std_logic_vector(31 downto 0);
        transfer_rrc : out std_logic_vector(31 downto 0);
        transfer_dec : out std_logic_vector(31 downto 0);
        transfer : out std_logic_vector(31 downto 0);
        auto_restart_sync : out std_logic_vector(31 downto 0);
        auto_restart_rrc : out std_logic_vector(31 downto 0);
        auto_restart_dec : out std_logic_vector(31 downto 0);
        auto_restart : out std_logic_vector(31 downto 0);
        rxreset : out std_logic_vector(31 downto 0);
        packetsize_sync : out std_logic_vector(31 downto 0);
        packetsize_rrc : out std_logic_vector(31 downto 0);
        packetsize_dec : out std_logic_vector(31 downto 0);
        packetsizerf : out std_logic_vector(31 downto 0);
        enable : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        axi_qpsk_rx_aclk : in std_logic;
        axi_qpsk_rx_aresetn : in std_logic;
        axi_qpsk_rx_s_axi_awaddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_rx_s_axi_awvalid : in std_logic;
        axi_qpsk_rx_s_axi_awready : out std_logic;
        axi_qpsk_rx_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axi_qpsk_rx_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axi_qpsk_rx_s_axi_wvalid : in std_logic;
        axi_qpsk_rx_s_axi_wready : out std_logic;
        axi_qpsk_rx_s_axi_bresp : out std_logic_vector(1 downto 0);
        axi_qpsk_rx_s_axi_bvalid : out std_logic;
        axi_qpsk_rx_s_axi_bready : in std_logic;
        axi_qpsk_rx_s_axi_araddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_rx_s_axi_arvalid : in std_logic;
        axi_qpsk_rx_s_axi_arready : out std_logic;
        axi_qpsk_rx_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axi_qpsk_rx_s_axi_rresp : out std_logic_vector(1 downto 0);
        axi_qpsk_rx_s_axi_rvalid : out std_logic;
        axi_qpsk_rx_s_axi_rready : in std_logic
    );
end axi_qpsk_rx_axi_lite_interface;
architecture structural of axi_qpsk_rx_axi_lite_interface is 
component axi_qpsk_rx_axi_lite_interface_verilog is
    port(
        transfer_sync : out std_logic_vector(31 downto 0);
        transfer_rrc : out std_logic_vector(31 downto 0);
        transfer_dec : out std_logic_vector(31 downto 0);
        transfer : out std_logic_vector(31 downto 0);
        auto_restart_sync : out std_logic_vector(31 downto 0);
        auto_restart_rrc : out std_logic_vector(31 downto 0);
        auto_restart_dec : out std_logic_vector(31 downto 0);
        auto_restart : out std_logic_vector(31 downto 0);
        rxreset : out std_logic_vector(31 downto 0);
        packetsize_sync : out std_logic_vector(31 downto 0);
        packetsize_rrc : out std_logic_vector(31 downto 0);
        packetsize_dec : out std_logic_vector(31 downto 0);
        packetsizerf : out std_logic_vector(31 downto 0);
        enable : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        axi_qpsk_rx_aclk : in std_logic;
        axi_qpsk_rx_aresetn : in std_logic;
        axi_qpsk_rx_s_axi_awaddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_rx_s_axi_awvalid : in std_logic;
        axi_qpsk_rx_s_axi_awready : out std_logic;
        axi_qpsk_rx_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axi_qpsk_rx_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axi_qpsk_rx_s_axi_wvalid : in std_logic;
        axi_qpsk_rx_s_axi_wready : out std_logic;
        axi_qpsk_rx_s_axi_bresp : out std_logic_vector(1 downto 0);
        axi_qpsk_rx_s_axi_bvalid : out std_logic;
        axi_qpsk_rx_s_axi_bready : in std_logic;
        axi_qpsk_rx_s_axi_araddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_rx_s_axi_arvalid : in std_logic;
        axi_qpsk_rx_s_axi_arready : out std_logic;
        axi_qpsk_rx_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axi_qpsk_rx_s_axi_rresp : out std_logic_vector(1 downto 0);
        axi_qpsk_rx_s_axi_rvalid : out std_logic;
        axi_qpsk_rx_s_axi_rready : in std_logic
    );
end component;
begin
inst : axi_qpsk_rx_axi_lite_interface_verilog
    port map(
    transfer_sync => transfer_sync,
    transfer_rrc => transfer_rrc,
    transfer_dec => transfer_dec,
    transfer => transfer,
    auto_restart_sync => auto_restart_sync,
    auto_restart_rrc => auto_restart_rrc,
    auto_restart_dec => auto_restart_dec,
    auto_restart => auto_restart,
    rxreset => rxreset,
    packetsize_sync => packetsize_sync,
    packetsize_rrc => packetsize_rrc,
    packetsize_dec => packetsize_dec,
    packetsizerf => packetsizerf,
    enable => enable,
    clk => clk,
    axi_qpsk_rx_aclk => axi_qpsk_rx_aclk,
    axi_qpsk_rx_aresetn => axi_qpsk_rx_aresetn,
    axi_qpsk_rx_s_axi_awaddr => axi_qpsk_rx_s_axi_awaddr,
    axi_qpsk_rx_s_axi_awvalid => axi_qpsk_rx_s_axi_awvalid,
    axi_qpsk_rx_s_axi_awready => axi_qpsk_rx_s_axi_awready,
    axi_qpsk_rx_s_axi_wdata => axi_qpsk_rx_s_axi_wdata,
    axi_qpsk_rx_s_axi_wstrb => axi_qpsk_rx_s_axi_wstrb,
    axi_qpsk_rx_s_axi_wvalid => axi_qpsk_rx_s_axi_wvalid,
    axi_qpsk_rx_s_axi_wready => axi_qpsk_rx_s_axi_wready,
    axi_qpsk_rx_s_axi_bresp => axi_qpsk_rx_s_axi_bresp,
    axi_qpsk_rx_s_axi_bvalid => axi_qpsk_rx_s_axi_bvalid,
    axi_qpsk_rx_s_axi_bready => axi_qpsk_rx_s_axi_bready,
    axi_qpsk_rx_s_axi_araddr => axi_qpsk_rx_s_axi_araddr,
    axi_qpsk_rx_s_axi_arvalid => axi_qpsk_rx_s_axi_arvalid,
    axi_qpsk_rx_s_axi_arready => axi_qpsk_rx_s_axi_arready,
    axi_qpsk_rx_s_axi_rdata => axi_qpsk_rx_s_axi_rdata,
    axi_qpsk_rx_s_axi_rresp => axi_qpsk_rx_s_axi_rresp,
    axi_qpsk_rx_s_axi_rvalid => axi_qpsk_rx_s_axi_rvalid,
    axi_qpsk_rx_s_axi_rready => axi_qpsk_rx_s_axi_rready
);
end structural;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

-------------------------------------------------------------------
 -- System Generator VHDL source file.
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
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;

entity axi_qpsk_rx_xladdsub is 
   generic (
     core_name0: string := "";
     a_width: integer := 16;
     a_bin_pt: integer := 4;
     a_arith: integer := xlUnsigned;
     c_in_width: integer := 16;
     c_in_bin_pt: integer := 4;
     c_in_arith: integer := xlUnsigned;
     c_out_width: integer := 16;
     c_out_bin_pt: integer := 4;
     c_out_arith: integer := xlUnsigned;
     b_width: integer := 8;
     b_bin_pt: integer := 2;
     b_arith: integer := xlUnsigned;
     s_width: integer := 17;
     s_bin_pt: integer := 4;
     s_arith: integer := xlUnsigned;
     rst_width: integer := 1;
     rst_bin_pt: integer := 0;
     rst_arith: integer := xlUnsigned;
     en_width: integer := 1;
     en_bin_pt: integer := 0;
     en_arith: integer := xlUnsigned;
     full_s_width: integer := 17;
     full_s_arith: integer := xlUnsigned;
     mode: integer := xlAddMode;
     extra_registers: integer := 0;
     latency: integer := 0;
     quantization: integer := xlTruncate;
     overflow: integer := xlWrap;
     c_latency: integer := 0;
     c_output_width: integer := 17;
     c_has_c_in : integer := 0;
     c_has_c_out : integer := 0
   );
   port (
     a: in std_logic_vector(a_width - 1 downto 0);
     b: in std_logic_vector(b_width - 1 downto 0);
     c_in : in std_logic_vector (0 downto 0) := "0";
     ce: in std_logic;
     clr: in std_logic := '0';
     clk: in std_logic;
     rst: in std_logic_vector(rst_width - 1 downto 0) := "0";
     en: in std_logic_vector(en_width - 1 downto 0) := "1";
     c_out : out std_logic_vector (0 downto 0);
     s: out std_logic_vector(s_width - 1 downto 0)
   );
 end axi_qpsk_rx_xladdsub;
 
 architecture behavior of axi_qpsk_rx_xladdsub is 
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
 
 function format_input(inp: std_logic_vector; old_width, delta, new_arith,
 new_width: integer)
 return std_logic_vector
 is
 variable vec: std_logic_vector(old_width-1 downto 0);
 variable padded_inp: std_logic_vector((old_width + delta)-1 downto 0);
 variable result: std_logic_vector(new_width-1 downto 0);
 begin
 vec := inp;
 if (delta > 0) then
 padded_inp := pad_LSB(vec, old_width+delta);
 result := extend_MSB(padded_inp, new_width, new_arith);
 else
 result := extend_MSB(vec, new_width, new_arith);
 end if;
 return result;
 end;
 
 constant full_s_bin_pt: integer := fractional_bits(a_bin_pt, b_bin_pt);
 constant full_a_width: integer := full_s_width;
 constant full_b_width: integer := full_s_width;
 
 signal full_a: std_logic_vector(full_a_width - 1 downto 0);
 signal full_b: std_logic_vector(full_b_width - 1 downto 0);
 signal core_s: std_logic_vector(full_s_width - 1 downto 0);
 signal conv_s: std_logic_vector(s_width - 1 downto 0);
 signal temp_cout : std_logic;
 signal internal_clr: std_logic;
 signal internal_ce: std_logic;
 signal extra_reg_ce: std_logic;
 signal override: std_logic;
 signal logic1: std_logic_vector(0 downto 0);


 component axi_qpsk_rx_c_addsub_v12_0_i0
    port ( 
    a: in std_logic_vector(19 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(19 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i1
    port ( 
    a: in std_logic_vector(19 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(19 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i2
    port ( 
    a: in std_logic_vector(21 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(21 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i3
    port ( 
    a: in std_logic_vector(43 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(43 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i4
    port ( 
    a: in std_logic_vector(23 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(23 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i5
    port ( 
    a: in std_logic_vector(22 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(22 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i6
    port ( 
    a: in std_logic_vector(20 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(20 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i7
    port ( 
    a: in std_logic_vector(39 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(39 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i8
    port ( 
    a: in std_logic_vector(31 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(31 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i9
    port ( 
    a: in std_logic_vector(30 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(30 - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_c_addsub_v12_0_i10
    port ( 
    a: in std_logic_vector(40 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(40 - 1 downto 0) 
 		  ); 
 end component;

begin
 internal_clr <= (clr or (rst(0))) and ce;
 internal_ce <= ce and en(0);
 logic1(0) <= '1';
 addsub_process: process (a, b, core_s)
 begin
 full_a <= format_input (a, a_width, b_bin_pt - a_bin_pt, a_arith,
 full_a_width);
 full_b <= format_input (b, b_width, a_bin_pt - b_bin_pt, b_arith,
 full_b_width);
 conv_s <= convert_type (core_s, full_s_width, full_s_bin_pt, full_s_arith,
 s_width, s_bin_pt, s_arith, quantization, overflow);
 end process addsub_process;


 comp0: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i0")) generate 
  core_instance0:axi_qpsk_rx_c_addsub_v12_0_i0
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp1: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i1")) generate 
  core_instance1:axi_qpsk_rx_c_addsub_v12_0_i1
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp2: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i2")) generate 
  core_instance2:axi_qpsk_rx_c_addsub_v12_0_i2
   port map ( 
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp3: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i3")) generate 
  core_instance3:axi_qpsk_rx_c_addsub_v12_0_i3
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp4: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i4")) generate 
  core_instance4:axi_qpsk_rx_c_addsub_v12_0_i4
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp5: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i5")) generate 
  core_instance5:axi_qpsk_rx_c_addsub_v12_0_i5
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp6: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i6")) generate 
  core_instance6:axi_qpsk_rx_c_addsub_v12_0_i6
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp7: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i7")) generate 
  core_instance7:axi_qpsk_rx_c_addsub_v12_0_i7
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp8: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i8")) generate 
  core_instance8:axi_qpsk_rx_c_addsub_v12_0_i8
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp9: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i9")) generate 
  core_instance9:axi_qpsk_rx_c_addsub_v12_0_i9
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp10: if ((core_name0 = "axi_qpsk_rx_c_addsub_v12_0_i10")) generate 
  core_instance10:axi_qpsk_rx_c_addsub_v12_0_i10
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

latency_test: if (extra_registers > 0) generate
 override_test: if (c_latency > 1) generate
 override_pipe: synth_reg
 generic map (
 width => 1,
 latency => c_latency
 )
 port map (
 i => logic1,
 ce => internal_ce,
 clr => internal_clr,
 clk => clk,
 o(0) => override);
 extra_reg_ce <= ce and en(0) and override;
 end generate override_test;
 no_override: if ((c_latency = 0) or (c_latency = 1)) generate
 extra_reg_ce <= ce and en(0);
 end generate no_override;
 extra_reg: synth_reg
 generic map (
 width => s_width,
 latency => extra_registers
 )
 port map (
 i => conv_s,
 ce => extra_reg_ce,
 clr => internal_clr,
 clk => clk,
 o => s
 );
 cout_test: if (c_has_c_out = 1) generate
 c_out_extra_reg: synth_reg
 generic map (
 width => 1,
 latency => extra_registers
 )
 port map (
 i(0) => temp_cout,
 ce => extra_reg_ce,
 clr => internal_clr,
 clk => clk,
 o => c_out
 );
 end generate cout_test;
 end generate;
 
 latency_s: if ((latency = 0) or (extra_registers = 0)) generate
 s <= conv_s;
 end generate latency_s;
 latency0: if (((latency = 0) or (extra_registers = 0)) and
 (c_has_c_out = 1)) generate
 c_out(0) <= temp_cout;
 end generate latency0;
 tie_dangling_cout: if (c_has_c_out = 0) generate
 c_out <= "0";
 end generate tie_dangling_cout;
 end architecture behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

-------------------------------------------------------------------
 -- System Generator VHDL source file.
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
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;

entity axi_qpsk_rx_xlcmult is 
   generic (
     core_name0: string := "";
     a_width: integer := 4;
     a_bin_pt: integer := 2;
     a_arith: integer := xlSigned;
     b_width: integer := 4;
     b_bin_pt: integer := 2;
     b_arith: integer := xlSigned;
     p_width: integer := 8;
     p_bin_pt: integer := 2;
     p_arith: integer := xlSigned;
     rst_width: integer := 1;
     rst_bin_pt: integer := 0;
     rst_arith: integer := xlUnsigned;
     en_width: integer := 1;
     en_bin_pt: integer := 0;
     en_arith: integer := xlUnsigned;
     multsign: integer := xlSigned;
     quantization: integer := xlTruncate;
     overflow: integer := xlWrap;
     extra_registers: integer := 0;
     c_a_width: integer := 7;
     c_b_width: integer := 7;
     c_a_type: integer := 0;
     c_b_type: integer := 0;
     c_type: integer := 0;
     const_bin_pt: integer := 1;
     zero_const : integer := 0;
     c_output_width: integer := 16
   );
   port (
     a: in std_logic_vector(a_width - 1 downto 0);
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     core_ce: in std_logic:= '0';
     core_clr: in std_logic:= '0';
     core_clk: in std_logic:= '0';
     rst: in std_logic_vector(rst_width - 1 downto 0);
     en: in std_logic_vector(en_width - 1 downto 0);
     p: out std_logic_vector(p_width - 1 downto 0)
   );
 end axi_qpsk_rx_xlcmult;
 
 architecture behavior of axi_qpsk_rx_xlcmult is
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
 signal tmp_a: std_logic_vector(c_a_width - 1 downto 0);
 signal tmp_p: std_logic_vector(c_output_width - 1 downto 0);
 signal conv_p: std_logic_vector(p_width - 1 downto 0);
 -- synthesis translate_off
 signal real_a, real_p: real;
 -- synthesis translate_on
 signal nd: std_logic;
 signal internal_ce: std_logic;
 signal internal_clr: std_logic;
 signal internal_core_ce: std_logic;


 component axi_qpsk_rx_mult_gen_v12_0_i1
    port ( 
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_mult_gen_v12_0_i2
    port ( 
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_mult_gen_v12_0_i3
    port ( 
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_mult_gen_v12_0_i4
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_mult_gen_v12_0_i6
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_mult_gen_v12_0_i7
    port ( 
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_mult_gen_v12_0_i8
    port ( 
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

begin
 -- synthesis translate_off
 -- synthesis translate_on
 input_process: process(a)
 variable tmp_p_bin_pt, tmp_p_arith: integer;
 begin
 tmp_a <= zero_ext(a, c_a_width);
 end process;
 output_process: process(tmp_p)
 begin
 conv_p <= convert_type(tmp_p, c_output_width, a_bin_pt+b_bin_pt, multsign,
 p_width, p_bin_pt, p_arith, quantization, overflow);
 end process;
 internal_ce <= ce and en(0);
 internal_core_ce <= core_ce and en(0);
 internal_clr <= (clr or rst(0)) and ce;
 nd <= internal_ce;


 comp0: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i1")) generate 
  core_instance0:axi_qpsk_rx_mult_gen_v12_0_i1
   port map ( 
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp1: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i2")) generate 
  core_instance1:axi_qpsk_rx_mult_gen_v12_0_i2
   port map ( 
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp2: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i3")) generate 
  core_instance2:axi_qpsk_rx_mult_gen_v12_0_i3
   port map ( 
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp3: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i4")) generate 
  core_instance3:axi_qpsk_rx_mult_gen_v12_0_i4
   port map ( 
      sclr => internal_clr,
      clk => clk,
      ce => internal_ce,
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp4: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i6")) generate 
  core_instance4:axi_qpsk_rx_mult_gen_v12_0_i6
   port map ( 
      sclr => internal_clr,
      clk => clk,
      ce => internal_ce,
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp5: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i7")) generate 
  core_instance5:axi_qpsk_rx_mult_gen_v12_0_i7
   port map ( 
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp6: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i8")) generate 
  core_instance6:axi_qpsk_rx_mult_gen_v12_0_i8
   port map ( 
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

latency_gt_0: if (extra_registers > 0) and (zero_const = 0)
 generate
 reg: synth_reg
 generic map (
 width => p_width,
 latency => extra_registers
 )
 port map (
 i => conv_p,
 ce => internal_ce,
 clr => internal_clr,
 clk => clk,
 o => p
 );
 end generate;
 latency0: if ( (extra_registers = 0) and (zero_const = 0) )
 generate
 p <= conv_p;
 end generate latency0;
 zero_constant: if (zero_const = 1)
 generate
 p <= integer_to_std_logic_vector(0,p_width,p_arith);
 end generate zero_constant;
 end architecture behavior;

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

entity axi_qpsk_rx_xlcounter_free is 
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
 end axi_qpsk_rx_xlcounter_free;
 
 architecture behavior of axi_qpsk_rx_xlcounter_free is


 component axi_qpsk_rx_c_counter_binary_v12_0_i0
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


 comp0: if ((core_name0 = "axi_qpsk_rx_c_counter_binary_v12_0_i0")) generate 
  core_instance0:axi_qpsk_rx_c_counter_binary_v12_0_i0
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

entity axi_qpsk_rx_xlfifogen_u is 
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
 end axi_qpsk_rx_xlfifogen_u;
 
 architecture behavior of axi_qpsk_rx_xlfifogen_u is
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
 


 component axi_qpsk_rx_fifo_generator_i0
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

 component axi_qpsk_rx_fifo_generator_i1
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
 

 comp0: if ((core_name0 = "axi_qpsk_rx_fifo_generator_i0")) generate 
  core_instance0:axi_qpsk_rx_fifo_generator_i0
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

 comp1: if ((core_name0 = "axi_qpsk_rx_fifo_generator_i1")) generate 
  core_instance1:axi_qpsk_rx_fifo_generator_i1
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
 
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfast_fourier_transform_63ed7b037d3533d17c19a6ba47478754 is 
  port(
    ce:in std_logic;
    clk:in std_logic;
    event_data_in_channel_halt:out std_logic;
    event_data_out_channel_halt:out std_logic;
    event_frame_started:out std_logic;
    event_status_channel_halt:out std_logic;
    event_tlast_missing:out std_logic;
    event_tlast_unexpected:out std_logic;
    m_axis_data_tdata_xn_im_0:out std_logic_vector(25 downto 0);
    m_axis_data_tdata_xn_re_0:out std_logic_vector(25 downto 0);
    m_axis_data_tlast:out std_logic;
    m_axis_data_tready:in std_logic;
    m_axis_data_tuser_xk_index:out std_logic_vector(8 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_config_tdata_fwd_inv:in std_logic_vector(0 downto 0);
    s_axis_config_tready:out std_logic;
    s_axis_config_tvalid:in std_logic;
    s_axis_data_tdata_xn_im_0:in std_logic_vector(15 downto 0);
    s_axis_data_tdata_xn_re_0:in std_logic_vector(15 downto 0);
    s_axis_data_tlast:in std_logic;
    s_axis_data_tready:out std_logic;
    s_axis_data_tvalid:in std_logic
  );
end xlfast_fourier_transform_63ed7b037d3533d17c19a6ba47478754; 

architecture behavior of xlfast_fourier_transform_63ed7b037d3533d17c19a6ba47478754  is
  component axi_qpsk_rx_xfft_v9_1_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      event_data_in_channel_halt:out std_logic;
      event_data_out_channel_halt:out std_logic;
      event_frame_started:out std_logic;
      event_status_channel_halt:out std_logic;
      event_tlast_missing:out std_logic;
      event_tlast_unexpected:out std_logic;
      m_axis_data_tdata:out std_logic_vector(63 downto 0);
      m_axis_data_tlast:out std_logic;
      m_axis_data_tready:in std_logic;
      m_axis_data_tuser:out std_logic_vector(15 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_config_tdata:in std_logic_vector(7 downto 0);
      s_axis_config_tready:out std_logic;
      s_axis_config_tvalid:in std_logic;
      s_axis_data_tdata:in std_logic_vector(31 downto 0);
      s_axis_data_tlast:in std_logic;
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal m_axis_data_tdata_net: std_logic_vector(63 downto 0) := (others=>'0');
signal m_axis_data_tuser_net: std_logic_vector(15 downto 0) := (others=>'0');
signal s_axis_config_tdata_net: std_logic_vector(7 downto 0) := (others=>'0');
signal s_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
begin
  m_axis_data_tdata_xn_im_0 <= m_axis_data_tdata_net(57 downto 32);
  m_axis_data_tdata_xn_re_0 <= m_axis_data_tdata_net(25 downto 0);
  m_axis_data_tuser_xk_index <= m_axis_data_tuser_net(8 downto 0);
  s_axis_config_tdata_net(0 downto 0) <= s_axis_config_tdata_fwd_inv;
  s_axis_data_tdata_net(31 downto 16) <= s_axis_data_tdata_xn_im_0;
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_xn_re_0;
  axi_qpsk_rx_xfft_v9_1_i0_instance : axi_qpsk_rx_xfft_v9_1_i0
    port map(
      aclk=>clk,
      aclken=>ce,
      event_data_in_channel_halt=>event_data_in_channel_halt,
      event_data_out_channel_halt=>event_data_out_channel_halt,
      event_frame_started=>event_frame_started,
      event_status_channel_halt=>event_status_channel_halt,
      event_tlast_missing=>event_tlast_missing,
      event_tlast_unexpected=>event_tlast_unexpected,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tlast=>m_axis_data_tlast,
      m_axis_data_tready=>m_axis_data_tready,
      m_axis_data_tuser=>m_axis_data_tuser_net,
      m_axis_data_tvalid=>m_axis_data_tvalid,
      s_axis_config_tdata=>s_axis_config_tdata_net,
      s_axis_config_tready=>s_axis_config_tready,
      s_axis_config_tvalid=>s_axis_config_tvalid,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tlast=>s_axis_data_tlast,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>s_axis_data_tvalid
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlaxi_qpsk_rx_cmpy_v6_0_i0_9e7e05098c985ce10daa9179eb0c35f1 is 
  port(
    a_im:in std_logic_vector(15 downto 0);
    a_re:in std_logic_vector(15 downto 0);
    b_im:in std_logic_vector(15 downto 0);
    b_re:in std_logic_vector(15 downto 0);
    ce:in std_logic;
    ce_25600:in std_logic;
    clk:in std_logic;
    clk_25600:in std_logic;
    p_im:out std_logic_vector(32 downto 0);
    p_re:out std_logic_vector(32 downto 0)
  );
end xlaxi_qpsk_rx_cmpy_v6_0_i0_9e7e05098c985ce10daa9179eb0c35f1; 

architecture behavior of xlaxi_qpsk_rx_cmpy_v6_0_i0_9e7e05098c985ce10daa9179eb0c35f1  is
  component axi_qpsk_rx_cmpy_v6_0_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_dout_tdata:out std_logic_vector(79 downto 0);
      m_axis_dout_tvalid:out std_logic;
      s_axis_a_tdata:in std_logic_vector(31 downto 0);
      s_axis_a_tvalid:in std_logic;
      s_axis_b_tdata:in std_logic_vector(31 downto 0);
      s_axis_b_tvalid:in std_logic
    );
end component;
signal m_axis_dout_tdata_net: std_logic_vector(79 downto 0) := (others=>'0');
signal p_im_ps_net: std_logic_vector(32 downto 0) := (others=>'0');
signal p_re_ps_net: std_logic_vector(32 downto 0) := (others=>'0');
signal m_axis_dout_tvalid: std_logic := '0';
signal s_axis_a_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal s_axis_b_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
begin
  p_im_ps_net <= m_axis_dout_tdata_net(72 downto 40);
  p_re_ps_net <= m_axis_dout_tdata_net(32 downto 0);
  s_axis_a_tdata_net(31 downto 16) <= a_im;
  s_axis_a_tdata_net(15 downto 0) <= a_re;
  s_axis_b_tdata_net(31 downto 16) <= b_im;
  s_axis_b_tdata_net(15 downto 0) <= b_re;
  p_im_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 33,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => p_im_ps_net,
        ce => ce_25600,
        clr => '0',
        clk => clk_25600, 
        o => p_im
    );
  p_re_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 33,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => p_re_ps_net,
        ce => ce_25600,
        clr => '0',
        clk => clk_25600, 
        o => p_re
    );
  axi_qpsk_rx_cmpy_v6_0_i0_instance : axi_qpsk_rx_cmpy_v6_0_i0
    port map(
      aclk=>clk,
      aclken=>ce,
      m_axis_dout_tdata=>m_axis_dout_tdata_net,
      m_axis_dout_tvalid=>m_axis_dout_tvalid,
      s_axis_a_tdata=>s_axis_a_tdata_net,
      s_axis_a_tvalid=>ce,
      s_axis_b_tdata=>s_axis_b_tdata_net,
      s_axis_b_tvalid=>ce
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlaxi_qpsk_rx_cmpy_v6_0_i1_e12f1df6f5f130a6b47388b563218dc6 is 
  port(
    a_im:in std_logic_vector(18 downto 0);
    a_re:in std_logic_vector(18 downto 0);
    b_im:in std_logic_vector(18 downto 0);
    b_re:in std_logic_vector(18 downto 0);
    ce:in std_logic;
    ce_25600:in std_logic;
    clk:in std_logic;
    clk_25600:in std_logic;
    p_im:out std_logic_vector(38 downto 0);
    p_re:out std_logic_vector(38 downto 0)
  );
end xlaxi_qpsk_rx_cmpy_v6_0_i1_e12f1df6f5f130a6b47388b563218dc6; 

architecture behavior of xlaxi_qpsk_rx_cmpy_v6_0_i1_e12f1df6f5f130a6b47388b563218dc6  is
  component axi_qpsk_rx_cmpy_v6_0_i1
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_dout_tdata:out std_logic_vector(79 downto 0);
      m_axis_dout_tvalid:out std_logic;
      s_axis_a_tdata:in std_logic_vector(47 downto 0);
      s_axis_a_tvalid:in std_logic;
      s_axis_b_tdata:in std_logic_vector(47 downto 0);
      s_axis_b_tvalid:in std_logic
    );
end component;
signal m_axis_dout_tdata_net: std_logic_vector(79 downto 0) := (others=>'0');
signal p_im_ps_net: std_logic_vector(38 downto 0) := (others=>'0');
signal p_re_ps_net: std_logic_vector(38 downto 0) := (others=>'0');
signal m_axis_dout_tvalid: std_logic := '0';
signal s_axis_a_tdata_net: std_logic_vector(47 downto 0) := (others=>'0');
signal s_axis_b_tdata_net: std_logic_vector(47 downto 0) := (others=>'0');
begin
  p_im_ps_net <= m_axis_dout_tdata_net(78 downto 40);
  p_re_ps_net <= m_axis_dout_tdata_net(38 downto 0);
  s_axis_a_tdata_net(42 downto 24) <= a_im;
  s_axis_a_tdata_net(18 downto 0) <= a_re;
  s_axis_b_tdata_net(42 downto 24) <= b_im;
  s_axis_b_tdata_net(18 downto 0) <= b_re;
  p_im_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 39,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => p_im_ps_net,
        ce => ce_25600,
        clr => '0',
        clk => clk_25600, 
        o => p_im
    );
  p_re_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 39,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => p_re_ps_net,
        ce => ce_25600,
        clr => '0',
        clk => clk_25600, 
        o => p_re
    );
  axi_qpsk_rx_cmpy_v6_0_i1_instance : axi_qpsk_rx_cmpy_v6_0_i1
    port map(
      aclk=>clk,
      aclken=>ce,
      m_axis_dout_tdata=>m_axis_dout_tdata_net,
      m_axis_dout_tvalid=>m_axis_dout_tvalid,
      s_axis_a_tdata=>s_axis_a_tdata_net,
      s_axis_a_tvalid=>ce,
      s_axis_b_tdata=>s_axis_b_tdata_net,
      s_axis_b_tvalid=>ce
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlaxi_qpsk_rx_cmpy_v6_0_i0_ba1bc0fdc1f2157be504e38e5fb295b9 is 
  port(
    a_im:in std_logic_vector(15 downto 0);
    a_re:in std_logic_vector(15 downto 0);
    b_im:in std_logic_vector(15 downto 0);
    b_re:in std_logic_vector(15 downto 0);
    ce:in std_logic;
    ce_6400:in std_logic;
    clk:in std_logic;
    clk_6400:in std_logic;
    p_im:out std_logic_vector(32 downto 0);
    p_re:out std_logic_vector(32 downto 0)
  );
end xlaxi_qpsk_rx_cmpy_v6_0_i0_ba1bc0fdc1f2157be504e38e5fb295b9; 

architecture behavior of xlaxi_qpsk_rx_cmpy_v6_0_i0_ba1bc0fdc1f2157be504e38e5fb295b9  is
  component axi_qpsk_rx_cmpy_v6_0_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_dout_tdata:out std_logic_vector(79 downto 0);
      m_axis_dout_tvalid:out std_logic;
      s_axis_a_tdata:in std_logic_vector(31 downto 0);
      s_axis_a_tvalid:in std_logic;
      s_axis_b_tdata:in std_logic_vector(31 downto 0);
      s_axis_b_tvalid:in std_logic
    );
end component;
signal m_axis_dout_tdata_net: std_logic_vector(79 downto 0) := (others=>'0');
signal p_im_ps_net: std_logic_vector(32 downto 0) := (others=>'0');
signal p_re_ps_net: std_logic_vector(32 downto 0) := (others=>'0');
signal m_axis_dout_tvalid: std_logic := '0';
signal s_axis_a_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal s_axis_b_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
begin
  p_im_ps_net <= m_axis_dout_tdata_net(72 downto 40);
  p_re_ps_net <= m_axis_dout_tdata_net(32 downto 0);
  s_axis_a_tdata_net(31 downto 16) <= a_im;
  s_axis_a_tdata_net(15 downto 0) <= a_re;
  s_axis_b_tdata_net(31 downto 16) <= b_im;
  s_axis_b_tdata_net(15 downto 0) <= b_re;
  p_im_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 33,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => p_im_ps_net,
        ce => ce_6400,
        clr => '0',
        clk => clk_6400, 
        o => p_im
    );
  p_re_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 33,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => p_re_ps_net,
        ce => ce_6400,
        clr => '0',
        clk => clk_6400, 
        o => p_re
    );
  axi_qpsk_rx_cmpy_v6_0_i0_instance : axi_qpsk_rx_cmpy_v6_0_i0
    port map(
      aclk=>clk,
      aclken=>ce,
      m_axis_dout_tdata=>m_axis_dout_tdata_net,
      m_axis_dout_tvalid=>m_axis_dout_tvalid,
      s_axis_a_tdata=>s_axis_a_tdata_net,
      s_axis_a_tvalid=>ce,
      s_axis_b_tdata=>s_axis_b_tdata_net,
      s_axis_b_tvalid=>ce
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlcic_compiler_37f18edfc02d40b346aaebf9efc006db is 
  port(
    ce:in std_logic;
    ce_40:in std_logic;
    ce_logic_1:in std_logic;
    clk:in std_logic;
    clk_40:in std_logic;
    clk_logic_1:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(31 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic
  );
end xlcic_compiler_37f18edfc02d40b346aaebf9efc006db; 

architecture behavior of xlcic_compiler_37f18edfc02d40b346aaebf9efc006db  is
  component axi_qpsk_rx_cic_compiler_v4_0_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net_captured: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net_or_captured_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_40_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_40_net <= en and ce_40;
  m_axis_data_tdata_real_ps_net_or_captured_net <= m_axis_data_tdata_real_ps_net or m_axis_data_tdata_real_ps_net_captured;
m_axis_data_tdata_real_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net_or_captured_net,
        ce => internal_en_40_net,
        clr => '0',
        clk => clk_40, 
        o => m_axis_data_tdata_real
    );
m_axis_data_tdata_real_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_40, 
        o => m_axis_data_tdata_real_ps_net_captured
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_40_net,
        clr => '0',
        clk => clk_40, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_40, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_cic_compiler_v4_0_i0_instance : axi_qpsk_rx_cic_compiler_v4_0_i0
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_1
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlcic_compiler_af10703a295672242f03d669604ee1f7 is 
  port(
    ce:in std_logic;
    ce_3200:in std_logic;
    ce_80:in std_logic;
    ce_logic_80:in std_logic;
    clk:in std_logic;
    clk_3200:in std_logic;
    clk_80:in std_logic;
    clk_logic_80:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(31 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic
  );
end xlcic_compiler_af10703a295672242f03d669604ee1f7; 

architecture behavior of xlcic_compiler_af10703a295672242f03d669604ee1f7  is
  component axi_qpsk_rx_cic_compiler_v4_0_i1
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net_captured: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net_or_captured_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_3200_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_3200_net <= en and ce_3200;
  m_axis_data_tdata_real_ps_net_or_captured_net <= m_axis_data_tdata_real_ps_net or m_axis_data_tdata_real_ps_net_captured;
m_axis_data_tdata_real_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net_or_captured_net,
        ce => internal_en_3200_net,
        clr => '0',
        clk => clk_3200, 
        o => m_axis_data_tdata_real
    );
m_axis_data_tdata_real_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_3200, 
        o => m_axis_data_tdata_real_ps_net_captured
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_3200_net,
        clr => '0',
        clk => clk_3200, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_3200, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_cic_compiler_v4_0_i1_instance : axi_qpsk_rx_cic_compiler_v4_0_i1
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_80
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_01d1aeffd197140cfb09270a59cd8fdf is 
  port(
    ce:in std_logic;
    ce_40:in std_logic;
    ce_80:in std_logic;
    ce_logic_40:in std_logic;
    clk:in std_logic;
    clk_40:in std_logic;
    clk_80:in std_logic;
    clk_logic_40:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(32 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_01d1aeffd197140cfb09270a59cd8fdf; 

architecture behavior of xlfir_compiler_01d1aeffd197140cfb09270a59cd8fdf  is
  component axi_qpsk_rx_fir_compiler_v7_2_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(39 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(39 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(32 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_80_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(32 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_80_net <= en and ce_80;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 33,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_80_net,
        clr => '0',
        clk => clk_80, 
        o => m_axis_data_tdata_real
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_80_net,
        clr => '0',
        clk => clk_80, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_80, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_fir_compiler_v7_2_i0_instance : axi_qpsk_rx_fir_compiler_v7_2_i0
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_40
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_5c7307251e097c00a189135eeeb98bca is 
  port(
    ce:in std_logic;
    ce_3200:in std_logic;
    ce_6400:in std_logic;
    ce_logic_3200:in std_logic;
    clk:in std_logic;
    clk_3200:in std_logic;
    clk_6400:in std_logic;
    clk_logic_3200:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(32 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_5c7307251e097c00a189135eeeb98bca; 

architecture behavior of xlfir_compiler_5c7307251e097c00a189135eeeb98bca  is
  component axi_qpsk_rx_fir_compiler_v7_2_i1
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(39 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(39 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(32 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_6400_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(32 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_6400_net <= en and ce_6400;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 33,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_6400_net,
        clr => '0',
        clk => clk_6400, 
        o => m_axis_data_tdata_real
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_6400_net,
        clr => '0',
        clk => clk_6400, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_6400, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_fir_compiler_v7_2_i1_instance : axi_qpsk_rx_fir_compiler_v7_2_i1
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_3200
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_3916ee27bcf977f17f8b73d96f6228bd is 
  port(
    ce:in std_logic;
    ce_12800:in std_logic;
    ce_6400:in std_logic;
    ce_logic_6400:in std_logic;
    clk:in std_logic;
    clk_12800:in std_logic;
    clk_6400:in std_logic;
    clk_logic_6400:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(31 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_3916ee27bcf977f17f8b73d96f6228bd; 

architecture behavior of xlfir_compiler_3916ee27bcf977f17f8b73d96f6228bd  is
  component axi_qpsk_rx_fir_compiler_v7_2_i2
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_12800_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_12800_net <= en and ce_12800;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_12800_net,
        clr => '0',
        clk => clk_12800, 
        o => m_axis_data_tdata_real
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_12800_net,
        clr => '0',
        clk => clk_12800, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_12800, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_fir_compiler_v7_2_i2_instance : axi_qpsk_rx_fir_compiler_v7_2_i2
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_6400
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_67a914d3e02be7d68a6298218071ca32 is 
  port(
    ce:in std_logic;
    ce_12800:in std_logic;
    ce_25600:in std_logic;
    ce_logic_12800:in std_logic;
    clk:in std_logic;
    clk_12800:in std_logic;
    clk_25600:in std_logic;
    clk_logic_12800:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(31 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_67a914d3e02be7d68a6298218071ca32; 

architecture behavior of xlfir_compiler_67a914d3e02be7d68a6298218071ca32  is
  component axi_qpsk_rx_fir_compiler_v7_2_i3
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_25600_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_25600_net <= en and ce_25600;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_25600_net,
        clr => '0',
        clk => clk_25600, 
        o => m_axis_data_tdata_real
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_25600_net,
        clr => '0',
        clk => clk_25600, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_25600, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_fir_compiler_v7_2_i3_instance : axi_qpsk_rx_fir_compiler_v7_2_i3
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_12800
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_0014b67889914168a9f41e931b693b4c is 
  port(
    ce:in std_logic;
    ce_6400:in std_logic;
    ce_logic_6400:in std_logic;
    clk:in std_logic;
    clk_6400:in std_logic;
    clk_logic_6400:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(36 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(17 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_0014b67889914168a9f41e931b693b4c; 

architecture behavior of xlfir_compiler_0014b67889914168a9f41e931b693b4c  is
  component axi_qpsk_rx_fir_compiler_v7_2_i4
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(39 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(23 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(39 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(36 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(23 downto 0) := (others=>'0');
signal internal_en_6400_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(36 downto 0);
  s_axis_data_tdata_net(17 downto 0) <= s_axis_data_tdata_real;
  internal_en_6400_net <= en and ce_6400;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 37,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_6400_net,
        clr => '0',
        clk => clk_6400, 
        o => m_axis_data_tdata_real
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_6400_net,
        clr => '0',
        clk => clk_6400, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_6400, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_fir_compiler_v7_2_i4_instance : axi_qpsk_rx_fir_compiler_v7_2_i4
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_6400
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_041b08792fd78d36a48b07a12d3328a2 is 
  port(
    ce:in std_logic;
    ce_3200:in std_logic;
    ce_6400:in std_logic;
    ce_logic_6400:in std_logic;
    clk:in std_logic;
    clk_3200:in std_logic;
    clk_6400:in std_logic;
    clk_logic_6400:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(31 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_041b08792fd78d36a48b07a12d3328a2; 

architecture behavior of xlfir_compiler_041b08792fd78d36a48b07a12d3328a2  is
  component axi_qpsk_rx_fir_compiler_v7_2_i5
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_3200_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_3200_net <= en and ce_3200;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_3200_net,
        clr => '0',
        clk => clk_3200, 
        o => m_axis_data_tdata_real
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_3200_net,
        clr => '0',
        clk => clk_3200, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_3200, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_fir_compiler_v7_2_i5_instance : axi_qpsk_rx_fir_compiler_v7_2_i5
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_6400
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_c0378ac8a16c56d90cd5cf68473618a1 is 
  port(
    ce:in std_logic;
    ce_1600:in std_logic;
    ce_3200:in std_logic;
    ce_logic_3200:in std_logic;
    clk:in std_logic;
    clk_1600:in std_logic;
    clk_3200:in std_logic;
    clk_logic_3200:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(31 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_c0378ac8a16c56d90cd5cf68473618a1; 

architecture behavior of xlfir_compiler_c0378ac8a16c56d90cd5cf68473618a1  is
  component axi_qpsk_rx_fir_compiler_v7_2_i6
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_en_1600_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_en_1600_net <= en and ce_1600;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_1600_net,
        clr => '0',
        clk => clk_1600, 
        o => m_axis_data_tdata_real
    );
  m_axis_data_tvalid_ps_net_or_captured_net <= m_axis_data_tvalid_ps_net or m_axis_data_tvalid_ps_net_captured;
m_axis_data_tvalid_ps_net_synchronizer_1 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => m_axis_data_tvalid_ps_net_or_captured_net,
        ce => internal_en_1600_net,
        clr => '0',
        clk => clk_1600, 
        o(0) => m_axis_data_tvalid
    );
m_axis_data_tvalid_ps_net_synchronizer_2 : entity work.synth_reg_w_init
    generic map(
        width => 1,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i(0) => '1',
        ce => m_axis_data_tvalid_ps_net,
        clr => '0',
        clk => clk_1600, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_rx_fir_compiler_v7_2_i6_instance : axi_qpsk_rx_fir_compiler_v7_2_i6
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_3200
    );
end behavior;



library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

-------------------------------------------------------------------
 -- System Generator VHDL source file.
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
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;

entity axi_qpsk_rx_xlmult is 
   generic (
     core_name0: string := "";
     a_width: integer := 4;
     a_bin_pt: integer := 2;
     a_arith: integer := xlSigned;
     b_width: integer := 4;
     b_bin_pt: integer := 1;
     b_arith: integer := xlSigned;
     p_width: integer := 8;
     p_bin_pt: integer := 2;
     p_arith: integer := xlSigned;
     rst_width: integer := 1;
     rst_bin_pt: integer := 0;
     rst_arith: integer := xlUnsigned;
     en_width: integer := 1;
     en_bin_pt: integer := 0;
     en_arith: integer := xlUnsigned;
     quantization: integer := xlTruncate;
     overflow: integer := xlWrap;
     extra_registers: integer := 0;
     c_a_width: integer := 7;
     c_b_width: integer := 7;
     c_type: integer := 0;
     c_a_type: integer := 0;
     c_b_type: integer := 0;
     c_pipelined: integer := 1;
     c_baat: integer := 4;
     multsign: integer := xlSigned;
     c_output_width: integer := 16
   );
   port (
     a: in std_logic_vector(a_width - 1 downto 0);
     b: in std_logic_vector(b_width - 1 downto 0);
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     core_ce: in std_logic := '0';
     core_clr: in std_logic := '0';
     core_clk: in std_logic := '0';
     rst: in std_logic_vector(rst_width - 1 downto 0);
     en: in std_logic_vector(en_width - 1 downto 0);
     p: out std_logic_vector(p_width - 1 downto 0)
   );
 end  axi_qpsk_rx_xlmult;
 
 architecture behavior of axi_qpsk_rx_xlmult is
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


 component axi_qpsk_rx_mult_gen_v12_0_i0
    port ( 
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_mult_gen_v12_0_i5
    port ( 
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

signal tmp_a: std_logic_vector(c_a_width - 1 downto 0);
 signal conv_a: std_logic_vector(c_a_width - 1 downto 0);
 signal tmp_b: std_logic_vector(c_b_width - 1 downto 0);
 signal conv_b: std_logic_vector(c_b_width - 1 downto 0);
 signal tmp_p: std_logic_vector(c_output_width - 1 downto 0);
 signal conv_p: std_logic_vector(p_width - 1 downto 0);
 -- synthesis translate_off
 signal real_a, real_b, real_p: real;
 -- synthesis translate_on
 signal rfd: std_logic;
 signal rdy: std_logic;
 signal nd: std_logic;
 signal internal_ce: std_logic;
 signal internal_clr: std_logic;
 signal internal_core_ce: std_logic;
 begin
 -- synthesis translate_off
 -- synthesis translate_on
 internal_ce <= ce and en(0);
 internal_core_ce <= core_ce and en(0);
 internal_clr <= (clr or rst(0)) and ce;
 nd <= internal_ce;
 input_process: process (a,b)
 begin
 tmp_a <= zero_ext(a, c_a_width);
 tmp_b <= zero_ext(b, c_b_width);
 end process;
 output_process: process (tmp_p)
 begin
 conv_p <= convert_type(tmp_p, c_output_width, a_bin_pt+b_bin_pt, multsign,
 p_width, p_bin_pt, p_arith, quantization, overflow);
 end process;


 comp0: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i0")) generate 
  core_instance0:axi_qpsk_rx_mult_gen_v12_0_i0
   port map ( 
        a => tmp_a,
        p => tmp_p,
        b => tmp_b
  ); 
   end generate;

 comp1: if ((core_name0 = "axi_qpsk_rx_mult_gen_v12_0_i5")) generate 
  core_instance1:axi_qpsk_rx_mult_gen_v12_0_i5
   port map ( 
        a => tmp_a,
        clk => clk,
        ce => internal_ce,
        sclr => internal_clr,
        p => tmp_p,
        b => tmp_b
  ); 
   end generate;

latency_gt_0: if (extra_registers > 0) generate
 reg: synth_reg
 generic map (
 width => p_width,
 latency => extra_registers
 )
 port map (
 i => conv_p,
 ce => internal_ce,
 clr => internal_clr,
 clk => clk,
 o => p
 );
 end generate;
 latency_eq_0: if (extra_registers = 0) generate
 p <= conv_p;
 end generate;
 end architecture behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;

entity axi_qpsk_rx_xlsprom is 
   generic (
     core_name0: string := "";
     c_width: integer := 12;             -- equal to data_width
     c_address_width: integer := 4;      -- Block RAM address width (might not
                                         -- be equal to addr_width, but
                                         -- addr_width <= c_address_width)
     latency: integer := 1
   );
   port (
     addr: in std_logic_vector(c_address_width - 1 downto 0);
     en: in std_logic_vector(0 downto 0);
     rst: in std_logic_vector(0 downto 0);
     ce: in std_logic;
     clk: in std_logic;
     data: out std_logic_vector(c_width - 1 downto 0)
   );
 end axi_qpsk_rx_xlsprom;
 
 architecture behavior of axi_qpsk_rx_xlsprom is
 component synth_reg
 generic (
 width: integer;
 latency: integer
 );
 port (
 i: in std_logic_vector(width - 1 downto 0);
 ce: in std_logic;
 clr: in std_logic;
 clk: in std_logic;
 o: out std_logic_vector(width - 1 downto 0)
 );
 end component;
 
 signal core_addr: std_logic_vector(c_address_width - 1 downto 0);
 signal core_data_out: std_logic_vector(c_width - 1 downto 0);
 signal core_ce, sinit: std_logic;


 component axi_qpsk_rx_blk_mem_gen_i0
    port ( 
      addra: in std_logic_vector(c_address_width - 1 downto 0);
      clka: in std_logic;
      ena: in std_logic;
      douta: out std_logic_vector(c_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_blk_mem_gen_i1
    port ( 
      addra: in std_logic_vector(c_address_width - 1 downto 0);
      clka: in std_logic;
      ena: in std_logic;
      douta: out std_logic_vector(c_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_blk_mem_gen_i2
    port ( 
      addra: in std_logic_vector(c_address_width - 1 downto 0);
      clka: in std_logic;
      ena: in std_logic;
      douta: out std_logic_vector(c_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_blk_mem_gen_i3
    port ( 
      addra: in std_logic_vector(c_address_width - 1 downto 0);
      clka: in std_logic;
      ena: in std_logic;
      douta: out std_logic_vector(c_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_blk_mem_gen_i4
    port ( 
      addra: in std_logic_vector(c_address_width - 1 downto 0);
      clka: in std_logic;
      ena: in std_logic;
      douta: out std_logic_vector(c_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_rx_blk_mem_gen_i5
    port ( 
      addra: in std_logic_vector(c_address_width - 1 downto 0);
      clka: in std_logic;
      ena: in std_logic;
      douta: out std_logic_vector(c_width - 1 downto 0) 
 		  ); 
 end component;

begin
 core_addr <= addr;
 core_ce <= ce and en(0);
 sinit <= rst(0) and ce;


 comp0: if ((core_name0 = "axi_qpsk_rx_blk_mem_gen_i0")) generate 
  core_instance0:axi_qpsk_rx_blk_mem_gen_i0
   port map ( 
        addra => core_addr,
        clka => clk,
        ena => core_ce,
        douta => core_data_out
  ); 
   end generate;

 comp1: if ((core_name0 = "axi_qpsk_rx_blk_mem_gen_i1")) generate 
  core_instance1:axi_qpsk_rx_blk_mem_gen_i1
   port map ( 
        addra => core_addr,
        clka => clk,
        ena => core_ce,
        douta => core_data_out
  ); 
   end generate;

 comp2: if ((core_name0 = "axi_qpsk_rx_blk_mem_gen_i2")) generate 
  core_instance2:axi_qpsk_rx_blk_mem_gen_i2
   port map ( 
        addra => core_addr,
        clka => clk,
        ena => core_ce,
        douta => core_data_out
  ); 
   end generate;

 comp3: if ((core_name0 = "axi_qpsk_rx_blk_mem_gen_i3")) generate 
  core_instance3:axi_qpsk_rx_blk_mem_gen_i3
   port map ( 
        addra => core_addr,
        clka => clk,
        ena => core_ce,
        douta => core_data_out
  ); 
   end generate;

 comp4: if ((core_name0 = "axi_qpsk_rx_blk_mem_gen_i4")) generate 
  core_instance4:axi_qpsk_rx_blk_mem_gen_i4
   port map ( 
        addra => core_addr,
        clka => clk,
        ena => core_ce,
        douta => core_data_out
  ); 
   end generate;

 comp5: if ((core_name0 = "axi_qpsk_rx_blk_mem_gen_i5")) generate 
  core_instance5:axi_qpsk_rx_blk_mem_gen_i5
   port map ( 
        addra => core_addr,
        clka => clk,
        ena => core_ce,
        douta => core_data_out
  ); 
   end generate;

latency_test: if (latency > 1) generate
 reg: synth_reg
 generic map (
 width => c_width,
 latency => latency - 1
 )
 port map (
 i => core_data_out,
 ce => core_ce,
 clr => '0',
 clk => clk,
 o => data
 );
 end generate;
 
 latency_1: if (latency <= 1) generate
 data <= core_data_out;
 end generate;
 end behavior;

