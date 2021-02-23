-------------------------------------------------------------------
-- System Generator version 2020.1 VHDL source file.
--
-- Copyright(C) 2020 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2020 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xldsamp.vhd
--
--  Description   : VHDL description of a block that is inserted into the
--                  data path to down sample the data betwen two blocks
--                  where the period is different between two blocks.
--
--  Mod. History  : Changed clock timing on the down sampler.  The
--                  destination enable is delayed by one system clock
--                  cycle and held until the next consecutive source
--                  enable pulse.  This change allows downsampler data
--                  transitions to occur on the rising clock edge when
--                  the destination ce is asserted.
--                : Added optional latency is the downsampler.  Note, if
--                  the latency is greater than 0, no shutter is used.
--                : Removed valid bit logic from wrapper
--
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


-- synthesis translate_off
library unisim;
use unisim.vcomponents.all;
-- synthesis translate_on

entity axi_qpsk_tx_xldsamp is
  generic (
    d_width: integer := 12;
    d_bin_pt: integer := 0;
    d_arith: integer := xlUnsigned;
    q_width: integer := 12;
    q_bin_pt: integer := 0;
    q_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    rst_width: integer := 1;
    rst_bin_pt: integer := 0;
    rst_arith: integer := xlUnsigned;
    ds_ratio: integer := 2;
    phase: integer := 0;
    latency: integer := 1
  );
  port (
    d: in std_logic_vector(d_width - 1 downto 0);
    src_clk: in std_logic;
    src_ce: in std_logic;
    src_clr: in std_logic;
    dest_clk: in std_logic;
    dest_ce: in std_logic;
    dest_clr: in std_logic;
    en: in std_logic_vector(en_width - 1 downto 0);
    rst: in std_logic_vector(rst_width - 1 downto 0);
    q: out std_logic_vector(q_width - 1 downto 0)
  );
end axi_qpsk_tx_xldsamp;

architecture struct of axi_qpsk_tx_xldsamp is
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
  end component; -- end synth_reg

  component synth_reg_reg
     generic (width       : integer;
              latency     : integer);
     port (i       : in std_logic_vector(width-1 downto 0);
           ce      : in std_logic;
           clr     : in std_logic;
           clk     : in std_logic;
           o       : out std_logic_vector(width-1 downto 0));
  end component;

  component fdse
    port (
      q: out   std_ulogic;
      d: in    std_ulogic;
      c: in    std_ulogic;
      s: in    std_ulogic;
      ce: in    std_ulogic
    );
  end component; -- end fdse
  attribute syn_black_box of fdse: component is true;
  attribute fpga_dont_touch of fdse: component is "true";

  signal adjusted_dest_ce: std_logic;
  signal adjusted_dest_ce_w_en: std_logic;
  signal dest_ce_w_en: std_logic;
  signal smpld_d: std_logic_vector(d_width-1 downto 0);
  signal sclr:std_logic;
begin
  -- An 'adjusted' destination clock enable signal must be generated for
  -- the zero latency and double registered down-sampler implementations.
  -- For both cases, it is necassary to adjust the timing of the clock
  -- enable so that it is asserted at the start of the sample period,
  -- instead of the end.  This is realized using an fdse prim. to register
  -- the destination clock enable.  The fdse itself is enabled with the
  -- source clock enable.  Enabling the fdse holds the adjusted CE high
  -- for the duration of the fast sample period and is needed to satisfy
  -- the multicycle constraint if the input data is running at a non-system
  -- rate.
  adjusted_ce_needed: if ((latency = 0) or (phase /= (ds_ratio - 1))) generate
    dest_ce_reg: fdse
      port map (
        q => adjusted_dest_ce,
        d => dest_ce,
        c => src_clk,
        s => sclr,
        ce => src_ce
      );
  end generate; -- adjusted_ce_needed

  -- A shutter (mux/reg pair) is used to implement a 0 latency downsampler.
  -- The shutter uses the adjusted destination clock enable to select between
  -- the current input and the sampled input.
  latency_eq_0: if (latency = 0) generate
    shutter_d_reg: synth_reg
      generic map (
        width => d_width,
        latency => 1
      )
      port map (
        i => d,
        ce => adjusted_dest_ce,
        clr => sclr,
        clk => src_clk,
        o => smpld_d
      );

    -- Mux selects current input value or register value.
    shutter_mux: process (adjusted_dest_ce, d, smpld_d)
    begin
	  if adjusted_dest_ce = '0' then
        q <= smpld_d;
      else
        q <= d;
      end if;
    end process; -- end select_mux
  end generate; -- end latency_eq_0

  -- A more efficient downsampler can be implemented if a latency > 0 is
  -- allowed.  There are two possible implementations, depending on the
  -- requested sampling phase.  A double register downsampler is needed
  -- for all cases except when the sample phase is the last input frame
  -- of the sample period.  In this case, only one register is needed.

  latency_gt_0: if (latency > 0) generate
    -- The first register in the double reg implementation is used to
    -- sample the correct frame (phase) of the input data.  Both the
    -- data and valid bit must be sampled.
    dbl_reg_test: if (phase /= (ds_ratio-1)) generate
        smpl_d_reg: synth_reg_reg
          generic map (
            width => d_width,
            latency => 1
          )
          port map (
            i => d,
            ce => adjusted_dest_ce_w_en,
            clr => sclr,
            clk => src_clk,
            o => smpld_d
          );
    end generate; -- end dbl_reg_test

    sngl_reg_test: if (phase = (ds_ratio -1)) generate
      smpld_d <= d;
    end generate; -- sngl_reg_test

    -- The latency pipe captures the sampled data and the END of the sample
    -- period.  Note that if the requested sample phase is the last input
    -- frame in the period, the first register (smpl_reg) is not needed.
    latency_pipe: synth_reg_reg
      generic map (
        width => d_width,
        latency => latency
      )
      port map (
        i => smpld_d,
        ce => dest_ce_w_en,
        clr => sclr,
        clk => dest_clk,
        o => q
      );
  end generate; -- end latency_gt_0

  -- Signal assignments
  dest_ce_w_en <= dest_ce and en(0);
  adjusted_dest_ce_w_en <= adjusted_dest_ce and en(0);
  sclr <= (src_clr or rst(0)) and dest_ce;
end architecture struct;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_663a092771 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_663a092771;
architecture behavior of sysgen_logical_663a092771
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


entity axi_qpsk_tx_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end axi_qpsk_tx_xlregister;

architecture behavior of axi_qpsk_tx_xlregister is

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
entity sysgen_reinterpret_e279805292 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_e279805292;
architecture behavior of sysgen_reinterpret_e279805292
is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

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


entity axi_qpsk_tx_xlslice is
    generic (
        new_msb      : integer := 9;           -- position of new msb
        new_lsb      : integer := 1;           -- position of new lsb
        x_width      : integer := 16;          -- Width of x input
        y_width      : integer := 8);          -- Width of y output
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end axi_qpsk_tx_xlslice;

architecture behavior of axi_qpsk_tx_xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_concat_28acae67a2 is
  port (
    in0 : in std_logic_vector((16 - 1) downto 0);
    in1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_28acae67a2;
architecture behavior of sysgen_concat_28acae67a2
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
entity sysgen_reinterpret_9de9bdef69 is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_9de9bdef69;
architecture behavior of sysgen_reinterpret_9de9bdef69
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
entity sysgen_constant_90890dc395 is
  port (
    op : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_90890dc395;
architecture behavior of sysgen_constant_90890dc395
is
begin
  op <= "11111111111";
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


entity convert_func_call_axi_qpsk_tx_xlconvert is
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
end convert_func_call_axi_qpsk_tx_xlconvert ;

architecture behavior of convert_func_call_axi_qpsk_tx_xlconvert is
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


entity axi_qpsk_tx_xlconvert  is
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

end axi_qpsk_tx_xlconvert ;

architecture behavior of axi_qpsk_tx_xlconvert  is

    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;

    component convert_func_call_axi_qpsk_tx_xlconvert 
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
      convert : convert_func_call_axi_qpsk_tx_xlconvert 
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
entity sysgen_inverter_c1e7f57146 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_inverter_c1e7f57146;
architecture behavior of sysgen_inverter_c1e7f57146
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
entity sysgen_logical_5d21ffa8a3 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_5d21ffa8a3;
architecture behavior of sysgen_logical_5d21ffa8a3
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
entity sysgen_mcode_block_e08ab9cdc1 is
  port (
    axiwrite : in std_logic_vector((1 - 1) downto 0);
    tlast : in std_logic_vector((1 - 1) downto 0);
    dcount : in std_logic_vector((1 - 1) downto 0);
    axiauto : in std_logic_vector((1 - 1) downto 0);
    re : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_e08ab9cdc1;
architecture behavior of sysgen_mcode_block_e08ab9cdc1
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
entity sysgen_relational_0e1ea12591 is
  port (
    a : in std_logic_vector((12 - 1) downto 0);
    b : in std_logic_vector((11 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_0e1ea12591;
architecture behavior of sysgen_relational_0e1ea12591
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
entity sysgen_relational_a95127c338 is
  port (
    a : in std_logic_vector((32 - 1) downto 0);
    b : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_a95127c338;
architecture behavior of sysgen_relational_a95127c338
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
entity sysgen_abs_8da227a85b is
  port (
    a : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_abs_8da227a85b;
architecture behavior of sysgen_abs_8da227a85b
is
  signal a_16_25: signed((32 - 1) downto 0);
  type array_type_op_mem_48_20 is array (0 to (1 - 1)) of unsigned((32 - 1) downto 0);
  signal op_mem_48_20: array_type_op_mem_48_20 := (
    0 => "00000000000000000000000000000000");
  signal op_mem_48_20_front_din: unsigned((32 - 1) downto 0);
  signal op_mem_48_20_back: unsigned((32 - 1) downto 0);
  signal op_mem_48_20_push_front_pop_back_en: std_logic;
  signal cast_34_28: signed((33 - 1) downto 0);
  signal internal_ip_34_13_neg: signed((33 - 1) downto 0);
  signal cast_31_8: signed((33 - 1) downto 0);
  signal rel_31_8: boolean;
  signal internal_ip_join_31_5: signed((33 - 1) downto 0);
  signal internal_ip_join_28_1: signed((33 - 1) downto 0);
  signal cast_internal_ip_40_3_convert: unsigned((32 - 1) downto 0);
begin
  a_16_25 <= std_logic_vector_to_signed(a);
  op_mem_48_20_back <= op_mem_48_20(0);
  proc_op_mem_48_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_48_20_push_front_pop_back_en = '1')) then
        op_mem_48_20(0) <= op_mem_48_20_front_din;
      end if;
    end if;
  end process proc_op_mem_48_20;
  cast_34_28 <= s2s_cast(a_16_25, 31, 33, 31);
  internal_ip_34_13_neg <=  -cast_34_28;
  cast_31_8 <= s2s_cast(a_16_25, 31, 33, 31);
  rel_31_8 <= cast_31_8 >= std_logic_vector_to_signed("000000000000000000000000000000000");
  proc_if_31_5: process (a_16_25, internal_ip_34_13_neg, rel_31_8)
  is
  begin
    if rel_31_8 then
      internal_ip_join_31_5 <= s2s_cast(a_16_25, 31, 33, 31);
    else 
      internal_ip_join_31_5 <= internal_ip_34_13_neg;
    end if;
  end process proc_if_31_5;
  proc_if_28_1: process (internal_ip_join_31_5)
  is
  begin
    if false then
      internal_ip_join_28_1 <= std_logic_vector_to_signed("000000000000000000000000000000000");
    else 
      internal_ip_join_28_1 <= internal_ip_join_31_5;
    end if;
  end process proc_if_28_1;
  cast_internal_ip_40_3_convert <= s2u_cast(internal_ip_join_28_1, 31, 32, 31);
  op_mem_48_20_front_din <= cast_internal_ip_40_3_convert;
  op_mem_48_20_push_front_pop_back_en <= '1';
  op <= unsigned_to_std_logic_vector(op_mem_48_20_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_8381b2b165 is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_8381b2b165;
architecture behavior of sysgen_constant_8381b2b165
is
begin
  op <= "00000000000000000000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_f8b183ceaf is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_f8b183ceaf;
architecture behavior of sysgen_constant_f8b183ceaf
is
begin
  op <= "00000000000000000000000000000001";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity axi_qpsk_tx_xldelay is
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

end axi_qpsk_tx_xldelay;

architecture behavior of axi_qpsk_tx_xldelay is
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
entity sysgen_mux_176ff5c7ea is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((32 - 1) downto 0);
    d1 : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_176ff5c7ea;
architecture behavior of sysgen_mux_176ff5c7ea
is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((32 - 1) downto 0);
  signal d1_1_27: std_logic_vector((32 - 1) downto 0);
  type array_type_pipe_16_22 is array (0 to (1 - 1)) of std_logic_vector((32 - 1) downto 0);
  signal pipe_16_22: array_type_pipe_16_22 := (
    0 => "00000000000000000000000000000000");
  signal pipe_16_22_front_din: std_logic_vector((32 - 1) downto 0);
  signal pipe_16_22_back: std_logic_vector((32 - 1) downto 0);
  signal pipe_16_22_push_front_pop_back_en: std_logic;
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((32 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  pipe_16_22_back <= pipe_16_22(0);
  proc_pipe_16_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (pipe_16_22_push_front_pop_back_en = '1')) then
        pipe_16_22(0) <= pipe_16_22_front_din;
      end if;
    end if;
  end process proc_pipe_16_22;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  pipe_16_22_front_din <= unregy_join_6_1;
  pipe_16_22_push_front_pop_back_en <= '1';
  y <= pipe_16_22_back;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_65cbd99078 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((32 - 1) downto 0);
    d1 : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_65cbd99078;
architecture behavior of sysgen_mux_65cbd99078
is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((32 - 1) downto 0);
  signal d1_1_27: std_logic_vector((32 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((32 - 1) downto 0);
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
entity sysgen_relational_46acfc6ff8 is
  port (
    a : in std_logic_vector((10 - 1) downto 0);
    b : in std_logic_vector((10 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_46acfc6ff8;
architecture behavior of sysgen_relational_46acfc6ff8
is
  signal a_1_31: unsigned((10 - 1) downto 0);
  signal b_1_34: unsigned((10 - 1) downto 0);
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
entity sysgen_relational_b0e3e92102 is
  port (
    a : in std_logic_vector((32 - 1) downto 0);
    b : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_b0e3e92102;
architecture behavior of sysgen_relational_b0e3e92102
is
  signal a_1_31: unsigned((32 - 1) downto 0);
  signal b_1_34: unsigned((32 - 1) downto 0);
  type array_type_op_mem_37_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_37_22: array_type_op_mem_37_22 := (
    0 => false);
  signal op_mem_37_22_front_din: boolean;
  signal op_mem_37_22_back: boolean;
  signal op_mem_37_22_push_front_pop_back_en: std_logic;
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  op_mem_37_22_back <= op_mem_37_22(0);
  proc_op_mem_37_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_37_22_push_front_pop_back_en = '1')) then
        op_mem_37_22(0) <= op_mem_37_22_front_din;
      end if;
    end if;
  end process proc_op_mem_37_22;
  result_12_3_rel <= a_1_31 = b_1_34;
  op_mem_37_22_front_din <= result_12_3_rel;
  op_mem_37_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_37_22_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_bbde368b86 is
  port (
    op : out std_logic_vector((10 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_bbde368b86;
architecture behavior of sysgen_constant_bbde368b86
is
begin
  op <= "0000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_3ffa54be4f is
  port (
    op : out std_logic_vector((13 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_3ffa54be4f;
architecture behavior of sysgen_constant_3ffa54be4f
is
begin
  op <= "0111111111111";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_0a85190278 is
  port (
    axiwrite : in std_logic_vector((1 - 1) downto 0);
    tlast : in std_logic_vector((1 - 1) downto 0);
    dcount : in std_logic_vector((1 - 1) downto 0);
    axiauto : in std_logic_vector((1 - 1) downto 0);
    sof : in std_logic_vector((1 - 1) downto 0);
    re : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_0a85190278;
architecture behavior of sysgen_mcode_block_0a85190278
is
  signal axiwrite_1_31: unsigned((1 - 1) downto 0);
  signal tlast_1_41: unsigned((1 - 1) downto 0);
  signal dcount_1_48: unsigned((1 - 1) downto 0);
  signal axiauto_1_56: unsigned((1 - 1) downto 0);
  signal sof_1_65: unsigned((1 - 1) downto 0);
  signal state_9_5_next: unsigned((2 - 1) downto 0);
  signal state_9_5: unsigned((2 - 1) downto 0) := "00";
  signal rel_14_16: boolean;
  signal rel_14_33: boolean;
  signal rel_14_48: boolean;
  signal rel_14_62: boolean;
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
  axiwrite_1_31 <= std_logic_vector_to_unsigned(axiwrite);
  tlast_1_41 <= std_logic_vector_to_unsigned(tlast);
  dcount_1_48 <= std_logic_vector_to_unsigned(dcount);
  axiauto_1_56 <= std_logic_vector_to_unsigned(axiauto);
  sof_1_65 <= std_logic_vector_to_unsigned(sof);
  proc_state_9_5: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        state_9_5 <= state_9_5_next;
      end if;
    end if;
  end process proc_state_9_5;
  rel_14_16 <= axiwrite_1_31 = std_logic_vector_to_unsigned("1");
  rel_14_33 <= dcount_1_48 = std_logic_vector_to_unsigned("1");
  rel_14_48 <= tlast_1_41 = std_logic_vector_to_unsigned("0");
  rel_14_62 <= sof_1_65 = std_logic_vector_to_unsigned("1");
  bool_14_16 <= rel_14_16 and rel_14_33 and rel_14_48 and rel_14_62;
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
  rel_22_16 <= tlast_1_41 = std_logic_vector_to_unsigned("1");
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
  rel_30_16 <= axiwrite_1_31 = std_logic_vector_to_unsigned("0");
  rel_30_33 <= axiauto_1_56 = std_logic_vector_to_unsigned("1");
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
entity sysgen_relational_ef12a990fa is
  port (
    a : in std_logic_vector((13 - 1) downto 0);
    b : in std_logic_vector((13 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_ef12a990fa;
architecture behavior of sysgen_relational_ef12a990fa
is
  signal a_1_31: unsigned((13 - 1) downto 0);
  signal b_1_34: unsigned((13 - 1) downto 0);
  signal result_22_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_22_3_rel <= a_1_31 >= b_1_34;
  op <= boolean_to_vector(result_22_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

----------------------------------------------------------------------------
--
--  Filename      : xlusamp.vhd
--
--  Description   : VHDL description of an up sampler.  The input signal
--                  has a larger period than the output signal's period
--                  and the blocks's period is set on the Simulink mask
--                  GUI.
--
--  Assumptions   : Input size, bin_pt, etc. are the same as the output
--
--  Mod. History  : Removed the shutter from the upsampler.  A mux is used
--                  to zero pad the data samples.  The mux select line is
--                  generated by registering the source enable signal
--                  when the destination ce is asserted.
--                : Removed valid bits from wrapper.
--
----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


-- synthesis translate_off
library unisim;
use unisim.vcomponents.all;
-- synthesis translate_on

entity axi_qpsk_tx_xlusamp is

    generic (
             d_width      : integer := 5;          -- Width of d input
             d_bin_pt     : integer := 2;          -- Binary point of input d
             d_arith      : integer := xlUnsigned; -- Type of arith of d input
             q_width      : integer := 5;          -- Width of q output
             q_bin_pt     : integer := 2;          -- Binary point of output q
             q_arith      : integer := xlUnsigned; -- Type of arith of output
             en_width     : integer := 1;
             en_bin_pt    : integer := 0;
             en_arith     : integer := xlUnsigned;
             sampling_ratio     : integer := 2;
             latency      : integer := 1;
             copy_samples : integer := 0);         -- if 0, output q = 0
                                                   -- when ce = 0, else sample
                                                   -- is held until next clk

    port (
          d        : in std_logic_vector (d_width-1 downto 0);
          src_clk  : in std_logic;
          src_ce   : in std_logic;
          src_clr  : in std_logic;
          dest_clk : in std_logic;
          dest_ce  : in std_logic;
          dest_clr : in std_logic;
          en       : in std_logic_vector(en_width-1 downto 0);
          q        : out std_logic_vector (q_width-1 downto 0)
         );
end axi_qpsk_tx_xlusamp;

architecture struct of axi_qpsk_tx_xlusamp is
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
    end component; -- end synth_reg

    component FDSE
        port (q  : out   std_ulogic;
              d  : in    std_ulogic;
              c  : in    std_ulogic;
              s  : in    std_ulogic;
              ce : in    std_ulogic);
    end component; -- end FDSE

    attribute syn_black_box of FDSE : component is true;
    attribute fpga_dont_touch of FDSE : component is "true";

    signal zero    : std_logic_vector (d_width-1 downto 0);
    signal mux_sel : std_logic;
    signal sampled_d  : std_logic_vector (d_width-1 downto 0);
    signal internal_ce : std_logic;

begin


   -- If zero padding is required, a mux is used to switch between data input
   -- and zeros.  The mux select is generated by registering the source enable
   -- signal.  This register is enabled by the destination enable signal. This
   -- has the effect of holding the select line high until the next consecutive
   -- destination enable pulse, and thereby satisfying the timing constraints.
   -- Signal assignments

   -- register the source enable signal with the register enabled
   -- by the destination enable
   sel_gen : FDSE
       port map (q  => mux_sel,
           d  => src_ce,
            c  => src_clk,
            s  => src_clr,
            ce => dest_ce);
  -- Generate the user enable
  internal_ce <= src_ce and en(0);

  copy_samples_false : if (copy_samples = 0) generate

      -- signal assignments
      zero <= (others => '0');

      -- purpose: latency is 0 and copy_samples is 0
      -- type   : combinational
      -- inputs : mux_sel, d, zero
      -- outputs: q
      gen_q_cp_smpls_0_and_lat_0: if (latency = 0) generate
        cp_smpls_0_and_lat_0: process (mux_sel, d, zero)
        begin  -- process cp_smpls_0_and_lat_0
          if (mux_sel = '1') then
            q <= d;
          else
            q <= zero;
          end if;
        end process cp_smpls_0_and_lat_0;
      end generate; -- end gen_q_cp_smpls_0_and_lat_0

      gen_q_cp_smpls_0_and_lat_gt_0: if (latency > 0) generate
        sampled_d_reg: synth_reg
          generic map (
            width => d_width,
            latency => latency
          )

          port map (
            i => d,
            ce => internal_ce,
            clr => src_clr,
            clk => src_clk,
            o => sampled_d
          );

        gen_q_check_mux_sel: process (mux_sel, sampled_d, zero)
        begin
          if (mux_sel = '1') then
            q <= sampled_d;
          else
            q <= zero;
          end if;
        end process gen_q_check_mux_sel;
      end generate; -- end gen_q_cp_smpls_0_and_lat_gt_0
   end generate; -- end copy_samples_false

   -- If zero padding is not required, we can short the upsampler data inputs
   -- to the upsampler data outputs when latency is 0.
   -- This option uses no hardware resources.

   copy_samples_true : if (copy_samples = 1) generate

     gen_q_cp_smpls_1_and_lat_0: if (latency = 0) generate
       q <= d;
     end generate; -- end gen_q_cp_smpls_1_and_lat_0

     gen_q_cp_smpls_1_and_lat_gt_0: if (latency > 0) generate
       q <= sampled_d;
       sampled_d_reg2: synth_reg
         generic map (
           width => d_width,
           latency => latency
         )

         port map (
           i => d,
           ce => internal_ce,
           clr => src_clr,
           clk => src_clk,
           o => sampled_d
         );
     end generate; -- end gen_q_cp_smpls_1_and_lat_gt_0
   end generate; -- end copy_samples_true
end architecture struct;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_5cb195ab66 is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_5cb195ab66;
architecture behavior of sysgen_constant_5cb195ab66
is
begin
  op <= "01";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_a1a2f7fd15 is
  port (
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_a1a2f7fd15;
architecture behavior of sysgen_constant_a1a2f7fd15
is
begin
  op <= "11";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_609d5856bc is
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
end sysgen_mux_609d5856bc;
architecture behavior of sysgen_mux_609d5856bc
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
entity sysgen_concat_80b6e9eb85 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_80b6e9eb85;
architecture behavior of sysgen_concat_80b6e9eb85
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
entity sysgen_lfsr_55445eadaa is
  port (
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    dout : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_lfsr_55445eadaa;
architecture behavior of sysgen_lfsr_55445eadaa
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
  signal lfsr8_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_13_1_rst: std_logic;
  signal lfsr9_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_13_1_rst: std_logic;
  signal lfsr1_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_13_1_rst: std_logic;
  signal lfsr6_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_13_1_rst: std_logic;
  signal lfsr7_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_13_1_rst: std_logic;
  signal lfsr0_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_13_1_rst: std_logic;
  signal lfsr3_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_13_1_rst: std_logic;
  signal lfsr4_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_13_1_rst: std_logic;
  signal lfsr2_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_13_1_rst: std_logic;
  signal lfsr5_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_13_1_rst: std_logic;
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
      lfsr8_join_25_1 <= lfsr7_9_19;
      lfsr9_join_25_1 <= lfsr8_10_19;
      lfsr1_join_25_1 <= lfsr0_2_19;
      lfsr6_join_25_1 <= lfsr5_7_19;
      lfsr7_join_25_1 <= lfsr6_8_19;
      lfsr0_join_25_1 <= temp_27_1_bitnot;
      lfsr3_join_25_1 <= lfsr2_4_19;
      lfsr4_join_25_1 <= lfsr3_5_19;
      lfsr2_join_25_1 <= lfsr1_3_19;
      lfsr5_join_25_1 <= lfsr4_6_19;
    else 
      lfsr8_join_25_1 <= lfsr8_10_19;
      lfsr9_join_25_1 <= lfsr9_11_19;
      lfsr1_join_25_1 <= lfsr1_3_19;
      lfsr6_join_25_1 <= lfsr6_8_19;
      lfsr7_join_25_1 <= lfsr7_9_19;
      lfsr0_join_25_1 <= lfsr0_2_19;
      lfsr3_join_25_1 <= lfsr3_5_19;
      lfsr4_join_25_1 <= lfsr4_6_19;
      lfsr2_join_25_1 <= lfsr2_4_19;
      lfsr5_join_25_1 <= lfsr5_7_19;
    end if;
  end process proc_if_25_1;
  proc_if_13_1: process (lfsr0_join_25_1, lfsr1_join_25_1, lfsr2_join_25_1, lfsr3_join_25_1, lfsr4_join_25_1, lfsr5_join_25_1, lfsr6_join_25_1, lfsr7_join_25_1, lfsr8_join_25_1, lfsr9_join_25_1, rst_1_59)
  is
  begin
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
      lfsr1_join_13_1_rst <= '1';
    else 
      lfsr1_join_13_1_rst <= '0';
    end if;
    lfsr1_join_13_1 <= lfsr1_join_25_1;
    if rst_1_59 then
      lfsr6_join_13_1_rst <= '1';
    else 
      lfsr6_join_13_1_rst <= '0';
    end if;
    lfsr6_join_13_1 <= lfsr6_join_25_1;
    if rst_1_59 then
      lfsr7_join_13_1_rst <= '1';
    else 
      lfsr7_join_13_1_rst <= '0';
    end if;
    lfsr7_join_13_1 <= lfsr7_join_25_1;
    if rst_1_59 then
      lfsr0_join_13_1_rst <= '1';
    else 
      lfsr0_join_13_1_rst <= '0';
    end if;
    lfsr0_join_13_1 <= lfsr0_join_25_1;
    if rst_1_59 then
      lfsr3_join_13_1_rst <= '1';
    else 
      lfsr3_join_13_1_rst <= '0';
    end if;
    lfsr3_join_13_1 <= lfsr3_join_25_1;
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
      lfsr5_join_13_1_rst <= '1';
    else 
      lfsr5_join_13_1_rst <= '0';
    end if;
    lfsr5_join_13_1 <= lfsr5_join_25_1;
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
entity sysgen_lfsr_f6789c65e0 is
  port (
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    dout : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_lfsr_f6789c65e0;
architecture behavior of sysgen_lfsr_f6789c65e0
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
  signal lfsr7_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_25_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr7_join_13_1_rst: std_logic;
  signal lfsr3_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr3_join_13_1_rst: std_logic;
  signal lfsr2_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr2_join_13_1_rst: std_logic;
  signal lfsr4_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr4_join_13_1_rst: std_logic;
  signal lfsr0_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr0_join_13_1_rst: std_logic;
  signal lfsr9_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr9_join_13_1_rst: std_logic;
  signal lfsr1_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr1_join_13_1_rst: std_logic;
  signal lfsr6_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr6_join_13_1_rst: std_logic;
  signal lfsr8_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr8_join_13_1_rst: std_logic;
  signal lfsr5_join_13_1: unsigned((1 - 1) downto 0);
  signal lfsr5_join_13_1_rst: std_logic;
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
      lfsr7_join_25_1 <= lfsr6_8_19;
      lfsr3_join_25_1 <= lfsr2_4_19;
      lfsr2_join_25_1 <= lfsr1_3_19;
      lfsr4_join_25_1 <= lfsr3_5_19;
      lfsr0_join_25_1 <= temp_27_1_bitnot;
      lfsr9_join_25_1 <= lfsr8_10_19;
      lfsr1_join_25_1 <= lfsr0_2_19;
      lfsr6_join_25_1 <= lfsr5_7_19;
      lfsr8_join_25_1 <= lfsr7_9_19;
      lfsr5_join_25_1 <= lfsr4_6_19;
    else 
      lfsr7_join_25_1 <= lfsr7_9_19;
      lfsr3_join_25_1 <= lfsr3_5_19;
      lfsr2_join_25_1 <= lfsr2_4_19;
      lfsr4_join_25_1 <= lfsr4_6_19;
      lfsr0_join_25_1 <= lfsr0_2_19;
      lfsr9_join_25_1 <= lfsr9_11_19;
      lfsr1_join_25_1 <= lfsr1_3_19;
      lfsr6_join_25_1 <= lfsr6_8_19;
      lfsr8_join_25_1 <= lfsr8_10_19;
      lfsr5_join_25_1 <= lfsr5_7_19;
    end if;
  end process proc_if_25_1;
  proc_if_13_1: process (lfsr0_join_25_1, lfsr1_join_25_1, lfsr2_join_25_1, lfsr3_join_25_1, lfsr4_join_25_1, lfsr5_join_25_1, lfsr6_join_25_1, lfsr7_join_25_1, lfsr8_join_25_1, lfsr9_join_25_1, rst_1_59)
  is
  begin
    if rst_1_59 then
      lfsr7_join_13_1_rst <= '1';
    else 
      lfsr7_join_13_1_rst <= '0';
    end if;
    lfsr7_join_13_1 <= lfsr7_join_25_1;
    if rst_1_59 then
      lfsr3_join_13_1_rst <= '1';
    else 
      lfsr3_join_13_1_rst <= '0';
    end if;
    lfsr3_join_13_1 <= lfsr3_join_25_1;
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
      lfsr0_join_13_1_rst <= '1';
    else 
      lfsr0_join_13_1_rst <= '0';
    end if;
    lfsr0_join_13_1 <= lfsr0_join_25_1;
    if rst_1_59 then
      lfsr9_join_13_1_rst <= '1';
    else 
      lfsr9_join_13_1_rst <= '0';
    end if;
    lfsr9_join_13_1 <= lfsr9_join_25_1;
    if rst_1_59 then
      lfsr1_join_13_1_rst <= '1';
    else 
      lfsr1_join_13_1_rst <= '0';
    end if;
    lfsr1_join_13_1 <= lfsr1_join_25_1;
    if rst_1_59 then
      lfsr6_join_13_1_rst <= '1';
    else 
      lfsr6_join_13_1_rst <= '0';
    end if;
    lfsr6_join_13_1 <= lfsr6_join_25_1;
    if rst_1_59 then
      lfsr8_join_13_1_rst <= '1';
    else 
      lfsr8_join_13_1_rst <= '0';
    end if;
    lfsr8_join_13_1 <= lfsr8_join_25_1;
    if rst_1_59 then
      lfsr5_join_13_1_rst <= '1';
    else 
      lfsr5_join_13_1_rst <= '0';
    end if;
    lfsr5_join_13_1 <= lfsr5_join_25_1;
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
entity sysgen_concat_e5f3597034 is
  port (
    in0 : in std_logic_vector((2 - 1) downto 0);
    in1 : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_e5f3597034;
architecture behavior of sysgen_concat_e5f3597034
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
entity sysgen_reinterpret_ca28820f31 is
  port (
    input_port : in std_logic_vector((2 - 1) downto 0);
    output_port : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_ca28820f31;
architecture behavior of sysgen_reinterpret_ca28820f31
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
entity sysgen_constant_2128b184d2 is
  port (
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_2128b184d2;
architecture behavior of sysgen_constant_2128b184d2
is
begin
  op <= "0000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_ede921e440 is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_ede921e440;
architecture behavior of sysgen_delay_ede921e440
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_1_8_24_next: std_logic;
  signal op_mem_1_8_24: std_logic := '0';
  signal op_mem_1_8_24_rst: std_logic;
  signal op_mem_1_8_24_en: std_logic;
  signal op_mem_2_8_24_next: std_logic;
  signal op_mem_2_8_24: std_logic := '0';
  signal op_mem_2_8_24_rst: std_logic;
  signal op_mem_2_8_24_en: std_logic;
  signal op_mem_3_8_24_next: std_logic;
  signal op_mem_3_8_24: std_logic := '0';
  signal op_mem_3_8_24_rst: std_logic;
  signal op_mem_3_8_24_en: std_logic;
  signal op_mem_4_8_24_next: std_logic;
  signal op_mem_4_8_24: std_logic := '0';
  signal op_mem_4_8_24_rst: std_logic;
  signal op_mem_4_8_24_en: std_logic;
  signal op_mem_5_8_24_next: std_logic;
  signal op_mem_5_8_24: std_logic := '0';
  signal op_mem_5_8_24_rst: std_logic;
  signal op_mem_5_8_24_en: std_logic;
  signal op_mem_6_8_24_next: std_logic;
  signal op_mem_6_8_24: std_logic := '0';
  signal op_mem_6_8_24_rst: std_logic;
  signal op_mem_6_8_24_en: std_logic;
  signal op_mem_7_8_24_next: std_logic;
  signal op_mem_7_8_24: std_logic := '0';
  signal op_mem_7_8_24_rst: std_logic;
  signal op_mem_7_8_24_en: std_logic;
  signal op_mem_8_8_24_next: std_logic;
  signal op_mem_8_8_24: std_logic := '0';
  signal op_mem_8_8_24_rst: std_logic;
  signal op_mem_8_8_24_en: std_logic;
  signal op_mem_9_8_24_next: std_logic;
  signal op_mem_9_8_24: std_logic := '0';
  signal op_mem_9_8_24_rst: std_logic;
  signal op_mem_9_8_24_en: std_logic;
  signal op_mem_10_8_24_next: std_logic;
  signal op_mem_10_8_24: std_logic := '0';
  signal op_mem_10_8_24_rst: std_logic;
  signal op_mem_10_8_24_en: std_logic;
  signal op_mem_11_8_24_next: std_logic;
  signal op_mem_11_8_24: std_logic := '0';
  signal op_mem_11_8_24_rst: std_logic;
  signal op_mem_11_8_24_en: std_logic;
  signal op_mem_12_8_24_next: std_logic;
  signal op_mem_12_8_24: std_logic := '0';
  signal op_mem_12_8_24_rst: std_logic;
  signal op_mem_12_8_24_en: std_logic;
  signal op_mem_13_8_24_next: std_logic;
  signal op_mem_13_8_24: std_logic := '0';
  signal op_mem_13_8_24_rst: std_logic;
  signal op_mem_13_8_24_en: std_logic;
  signal op_mem_14_8_24_next: std_logic;
  signal op_mem_14_8_24: std_logic := '0';
  signal op_mem_14_8_24_rst: std_logic;
  signal op_mem_14_8_24_en: std_logic;
  signal op_mem_15_8_24_next: std_logic;
  signal op_mem_15_8_24: std_logic := '0';
  signal op_mem_15_8_24_rst: std_logic;
  signal op_mem_15_8_24_en: std_logic;
  signal op_mem_16_8_24_next: std_logic;
  signal op_mem_16_8_24: std_logic := '0';
  signal op_mem_16_8_24_rst: std_logic;
  signal op_mem_16_8_24_en: std_logic;
  signal op_mem_17_8_24_next: std_logic;
  signal op_mem_17_8_24: std_logic := '0';
  signal op_mem_17_8_24_rst: std_logic;
  signal op_mem_17_8_24_en: std_logic;
  signal op_mem_18_8_24_next: std_logic;
  signal op_mem_18_8_24: std_logic := '0';
  signal op_mem_18_8_24_rst: std_logic;
  signal op_mem_18_8_24_en: std_logic;
  signal op_mem_19_8_24_next: std_logic;
  signal op_mem_19_8_24: std_logic := '0';
  signal op_mem_19_8_24_rst: std_logic;
  signal op_mem_19_8_24_en: std_logic;
  signal op_mem_20_8_24_next: std_logic;
  signal op_mem_20_8_24: std_logic := '0';
  signal op_mem_20_8_24_rst: std_logic;
  signal op_mem_20_8_24_en: std_logic;
  signal op_mem_21_8_24_next: std_logic;
  signal op_mem_21_8_24: std_logic := '0';
  signal op_mem_21_8_24_rst: std_logic;
  signal op_mem_21_8_24_en: std_logic;
  signal op_mem_22_8_24_next: std_logic;
  signal op_mem_22_8_24: std_logic := '0';
  signal op_mem_22_8_24_rst: std_logic;
  signal op_mem_22_8_24_en: std_logic;
  signal op_mem_23_8_24_next: std_logic;
  signal op_mem_23_8_24: std_logic := '0';
  signal op_mem_23_8_24_rst: std_logic;
  signal op_mem_23_8_24_en: std_logic;
  signal op_mem_20_join_10_5: std_logic;
  signal op_mem_20_join_10_5_en: std_logic;
  signal op_mem_20_join_10_5_rst: std_logic;
  signal op_mem_21_join_10_5: std_logic;
  signal op_mem_21_join_10_5_en: std_logic;
  signal op_mem_21_join_10_5_rst: std_logic;
  signal op_mem_3_join_10_5: std_logic;
  signal op_mem_3_join_10_5_en: std_logic;
  signal op_mem_3_join_10_5_rst: std_logic;
  signal op_mem_7_join_10_5: std_logic;
  signal op_mem_7_join_10_5_en: std_logic;
  signal op_mem_7_join_10_5_rst: std_logic;
  signal op_mem_18_join_10_5: std_logic;
  signal op_mem_18_join_10_5_en: std_logic;
  signal op_mem_18_join_10_5_rst: std_logic;
  signal op_mem_16_join_10_5: std_logic;
  signal op_mem_16_join_10_5_en: std_logic;
  signal op_mem_16_join_10_5_rst: std_logic;
  signal op_mem_8_join_10_5: std_logic;
  signal op_mem_8_join_10_5_en: std_logic;
  signal op_mem_8_join_10_5_rst: std_logic;
  signal op_mem_23_join_10_5: std_logic;
  signal op_mem_23_join_10_5_en: std_logic;
  signal op_mem_23_join_10_5_rst: std_logic;
  signal op_mem_15_join_10_5: std_logic;
  signal op_mem_15_join_10_5_en: std_logic;
  signal op_mem_15_join_10_5_rst: std_logic;
  signal op_mem_4_join_10_5: std_logic;
  signal op_mem_4_join_10_5_en: std_logic;
  signal op_mem_4_join_10_5_rst: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
  signal op_mem_2_join_10_5: std_logic;
  signal op_mem_2_join_10_5_en: std_logic;
  signal op_mem_2_join_10_5_rst: std_logic;
  signal op_mem_13_join_10_5: std_logic;
  signal op_mem_13_join_10_5_en: std_logic;
  signal op_mem_13_join_10_5_rst: std_logic;
  signal op_mem_10_join_10_5: std_logic;
  signal op_mem_10_join_10_5_en: std_logic;
  signal op_mem_10_join_10_5_rst: std_logic;
  signal op_mem_12_join_10_5: std_logic;
  signal op_mem_12_join_10_5_en: std_logic;
  signal op_mem_12_join_10_5_rst: std_logic;
  signal op_mem_19_join_10_5: std_logic;
  signal op_mem_19_join_10_5_en: std_logic;
  signal op_mem_19_join_10_5_rst: std_logic;
  signal op_mem_22_join_10_5: std_logic;
  signal op_mem_22_join_10_5_en: std_logic;
  signal op_mem_22_join_10_5_rst: std_logic;
  signal op_mem_6_join_10_5: std_logic;
  signal op_mem_6_join_10_5_en: std_logic;
  signal op_mem_6_join_10_5_rst: std_logic;
  signal op_mem_11_join_10_5: std_logic;
  signal op_mem_11_join_10_5_en: std_logic;
  signal op_mem_11_join_10_5_rst: std_logic;
  signal op_mem_17_join_10_5: std_logic;
  signal op_mem_17_join_10_5_en: std_logic;
  signal op_mem_17_join_10_5_rst: std_logic;
  signal op_mem_14_join_10_5: std_logic;
  signal op_mem_14_join_10_5_en: std_logic;
  signal op_mem_14_join_10_5_rst: std_logic;
  signal op_mem_5_join_10_5: std_logic;
  signal op_mem_5_join_10_5_en: std_logic;
  signal op_mem_5_join_10_5_rst: std_logic;
  signal op_mem_9_join_10_5: std_logic;
  signal op_mem_9_join_10_5_en: std_logic;
  signal op_mem_9_join_10_5_rst: std_logic;
  signal op_mem_1_join_10_5: std_logic;
  signal op_mem_1_join_10_5_en: std_logic;
  signal op_mem_1_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_op_mem_1_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_1_8_24_rst = '1')) then
        op_mem_1_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_1_8_24_en = '1')) then 
        op_mem_1_8_24 <= op_mem_1_8_24_next;
      end if;
    end if;
  end process proc_op_mem_1_8_24;
  proc_op_mem_2_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_2_8_24_rst = '1')) then
        op_mem_2_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_2_8_24_en = '1')) then 
        op_mem_2_8_24 <= op_mem_2_8_24_next;
      end if;
    end if;
  end process proc_op_mem_2_8_24;
  proc_op_mem_3_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_3_8_24_rst = '1')) then
        op_mem_3_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_3_8_24_en = '1')) then 
        op_mem_3_8_24 <= op_mem_3_8_24_next;
      end if;
    end if;
  end process proc_op_mem_3_8_24;
  proc_op_mem_4_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_4_8_24_rst = '1')) then
        op_mem_4_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_4_8_24_en = '1')) then 
        op_mem_4_8_24 <= op_mem_4_8_24_next;
      end if;
    end if;
  end process proc_op_mem_4_8_24;
  proc_op_mem_5_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_5_8_24_rst = '1')) then
        op_mem_5_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_5_8_24_en = '1')) then 
        op_mem_5_8_24 <= op_mem_5_8_24_next;
      end if;
    end if;
  end process proc_op_mem_5_8_24;
  proc_op_mem_6_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_6_8_24_rst = '1')) then
        op_mem_6_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_6_8_24_en = '1')) then 
        op_mem_6_8_24 <= op_mem_6_8_24_next;
      end if;
    end if;
  end process proc_op_mem_6_8_24;
  proc_op_mem_7_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_7_8_24_rst = '1')) then
        op_mem_7_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_7_8_24_en = '1')) then 
        op_mem_7_8_24 <= op_mem_7_8_24_next;
      end if;
    end if;
  end process proc_op_mem_7_8_24;
  proc_op_mem_8_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_8_8_24_rst = '1')) then
        op_mem_8_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_8_8_24_en = '1')) then 
        op_mem_8_8_24 <= op_mem_8_8_24_next;
      end if;
    end if;
  end process proc_op_mem_8_8_24;
  proc_op_mem_9_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_9_8_24_rst = '1')) then
        op_mem_9_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_9_8_24_en = '1')) then 
        op_mem_9_8_24 <= op_mem_9_8_24_next;
      end if;
    end if;
  end process proc_op_mem_9_8_24;
  proc_op_mem_10_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_10_8_24_rst = '1')) then
        op_mem_10_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_10_8_24_en = '1')) then 
        op_mem_10_8_24 <= op_mem_10_8_24_next;
      end if;
    end if;
  end process proc_op_mem_10_8_24;
  proc_op_mem_11_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_11_8_24_rst = '1')) then
        op_mem_11_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_11_8_24_en = '1')) then 
        op_mem_11_8_24 <= op_mem_11_8_24_next;
      end if;
    end if;
  end process proc_op_mem_11_8_24;
  proc_op_mem_12_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_12_8_24_rst = '1')) then
        op_mem_12_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_12_8_24_en = '1')) then 
        op_mem_12_8_24 <= op_mem_12_8_24_next;
      end if;
    end if;
  end process proc_op_mem_12_8_24;
  proc_op_mem_13_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_13_8_24_rst = '1')) then
        op_mem_13_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_13_8_24_en = '1')) then 
        op_mem_13_8_24 <= op_mem_13_8_24_next;
      end if;
    end if;
  end process proc_op_mem_13_8_24;
  proc_op_mem_14_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_14_8_24_rst = '1')) then
        op_mem_14_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_14_8_24_en = '1')) then 
        op_mem_14_8_24 <= op_mem_14_8_24_next;
      end if;
    end if;
  end process proc_op_mem_14_8_24;
  proc_op_mem_15_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_15_8_24_rst = '1')) then
        op_mem_15_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_15_8_24_en = '1')) then 
        op_mem_15_8_24 <= op_mem_15_8_24_next;
      end if;
    end if;
  end process proc_op_mem_15_8_24;
  proc_op_mem_16_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_16_8_24_rst = '1')) then
        op_mem_16_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_16_8_24_en = '1')) then 
        op_mem_16_8_24 <= op_mem_16_8_24_next;
      end if;
    end if;
  end process proc_op_mem_16_8_24;
  proc_op_mem_17_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_17_8_24_rst = '1')) then
        op_mem_17_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_17_8_24_en = '1')) then 
        op_mem_17_8_24 <= op_mem_17_8_24_next;
      end if;
    end if;
  end process proc_op_mem_17_8_24;
  proc_op_mem_18_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_18_8_24_rst = '1')) then
        op_mem_18_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_18_8_24_en = '1')) then 
        op_mem_18_8_24 <= op_mem_18_8_24_next;
      end if;
    end if;
  end process proc_op_mem_18_8_24;
  proc_op_mem_19_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_19_8_24_rst = '1')) then
        op_mem_19_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_19_8_24_en = '1')) then 
        op_mem_19_8_24 <= op_mem_19_8_24_next;
      end if;
    end if;
  end process proc_op_mem_19_8_24;
  proc_op_mem_20_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_20_8_24_rst = '1')) then
        op_mem_20_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_20_8_24_en = '1')) then 
        op_mem_20_8_24 <= op_mem_20_8_24_next;
      end if;
    end if;
  end process proc_op_mem_20_8_24;
  proc_op_mem_21_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_21_8_24_rst = '1')) then
        op_mem_21_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_21_8_24_en = '1')) then 
        op_mem_21_8_24 <= op_mem_21_8_24_next;
      end if;
    end if;
  end process proc_op_mem_21_8_24;
  proc_op_mem_22_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_8_24_rst = '1')) then
        op_mem_22_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_22_8_24_en = '1')) then 
        op_mem_22_8_24 <= op_mem_22_8_24_next;
      end if;
    end if;
  end process proc_op_mem_22_8_24;
  proc_op_mem_23_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_23_8_24_rst = '1')) then
        op_mem_23_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_23_8_24_en = '1')) then 
        op_mem_23_8_24 <= op_mem_23_8_24_next;
      end if;
    end if;
  end process proc_op_mem_23_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, op_mem_0_8_24, op_mem_10_8_24, op_mem_11_8_24, op_mem_12_8_24, op_mem_13_8_24, op_mem_14_8_24, op_mem_15_8_24, op_mem_16_8_24, op_mem_17_8_24, op_mem_18_8_24, op_mem_19_8_24, op_mem_1_8_24, op_mem_20_8_24, op_mem_21_8_24, op_mem_22_8_24, op_mem_2_8_24, op_mem_3_8_24, op_mem_4_8_24, op_mem_5_8_24, op_mem_6_8_24, op_mem_7_8_24, op_mem_8_8_24, op_mem_9_8_24, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_20_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_20_join_10_5_rst <= '0';
    else 
      op_mem_20_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_20_join_10_5_en <= '1';
    else 
      op_mem_20_join_10_5_en <= '0';
    end if;
    op_mem_20_join_10_5 <= op_mem_19_8_24;
    if rst_1_29 = '1' then
      op_mem_21_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_21_join_10_5_rst <= '0';
    else 
      op_mem_21_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_21_join_10_5_en <= '1';
    else 
      op_mem_21_join_10_5_en <= '0';
    end if;
    op_mem_21_join_10_5 <= op_mem_20_8_24;
    if rst_1_29 = '1' then
      op_mem_3_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_3_join_10_5_rst <= '0';
    else 
      op_mem_3_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_3_join_10_5_en <= '1';
    else 
      op_mem_3_join_10_5_en <= '0';
    end if;
    op_mem_3_join_10_5 <= op_mem_2_8_24;
    if rst_1_29 = '1' then
      op_mem_7_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_7_join_10_5_rst <= '0';
    else 
      op_mem_7_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_7_join_10_5_en <= '1';
    else 
      op_mem_7_join_10_5_en <= '0';
    end if;
    op_mem_7_join_10_5 <= op_mem_6_8_24;
    if rst_1_29 = '1' then
      op_mem_18_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_18_join_10_5_rst <= '0';
    else 
      op_mem_18_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_18_join_10_5_en <= '1';
    else 
      op_mem_18_join_10_5_en <= '0';
    end if;
    op_mem_18_join_10_5 <= op_mem_17_8_24;
    if rst_1_29 = '1' then
      op_mem_16_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_16_join_10_5_rst <= '0';
    else 
      op_mem_16_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_16_join_10_5_en <= '1';
    else 
      op_mem_16_join_10_5_en <= '0';
    end if;
    op_mem_16_join_10_5 <= op_mem_15_8_24;
    if rst_1_29 = '1' then
      op_mem_8_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_8_join_10_5_rst <= '0';
    else 
      op_mem_8_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_8_join_10_5_en <= '1';
    else 
      op_mem_8_join_10_5_en <= '0';
    end if;
    op_mem_8_join_10_5 <= op_mem_7_8_24;
    if rst_1_29 = '1' then
      op_mem_23_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_23_join_10_5_rst <= '0';
    else 
      op_mem_23_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_23_join_10_5_en <= '1';
    else 
      op_mem_23_join_10_5_en <= '0';
    end if;
    op_mem_23_join_10_5 <= op_mem_22_8_24;
    if rst_1_29 = '1' then
      op_mem_15_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_15_join_10_5_rst <= '0';
    else 
      op_mem_15_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_15_join_10_5_en <= '1';
    else 
      op_mem_15_join_10_5_en <= '0';
    end if;
    op_mem_15_join_10_5 <= op_mem_14_8_24;
    if rst_1_29 = '1' then
      op_mem_4_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_4_join_10_5_rst <= '0';
    else 
      op_mem_4_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_4_join_10_5_en <= '1';
    else 
      op_mem_4_join_10_5_en <= '0';
    end if;
    op_mem_4_join_10_5 <= op_mem_3_8_24;
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
    if rst_1_29 = '1' then
      op_mem_2_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_2_join_10_5_rst <= '0';
    else 
      op_mem_2_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_2_join_10_5_en <= '1';
    else 
      op_mem_2_join_10_5_en <= '0';
    end if;
    op_mem_2_join_10_5 <= op_mem_1_8_24;
    if rst_1_29 = '1' then
      op_mem_13_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_13_join_10_5_rst <= '0';
    else 
      op_mem_13_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_13_join_10_5_en <= '1';
    else 
      op_mem_13_join_10_5_en <= '0';
    end if;
    op_mem_13_join_10_5 <= op_mem_12_8_24;
    if rst_1_29 = '1' then
      op_mem_10_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_10_join_10_5_rst <= '0';
    else 
      op_mem_10_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_10_join_10_5_en <= '1';
    else 
      op_mem_10_join_10_5_en <= '0';
    end if;
    op_mem_10_join_10_5 <= op_mem_9_8_24;
    if rst_1_29 = '1' then
      op_mem_12_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_12_join_10_5_rst <= '0';
    else 
      op_mem_12_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_12_join_10_5_en <= '1';
    else 
      op_mem_12_join_10_5_en <= '0';
    end if;
    op_mem_12_join_10_5 <= op_mem_11_8_24;
    if rst_1_29 = '1' then
      op_mem_19_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_19_join_10_5_rst <= '0';
    else 
      op_mem_19_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_19_join_10_5_en <= '1';
    else 
      op_mem_19_join_10_5_en <= '0';
    end if;
    op_mem_19_join_10_5 <= op_mem_18_8_24;
    if rst_1_29 = '1' then
      op_mem_22_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_22_join_10_5_rst <= '0';
    else 
      op_mem_22_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_22_join_10_5_en <= '1';
    else 
      op_mem_22_join_10_5_en <= '0';
    end if;
    op_mem_22_join_10_5 <= op_mem_21_8_24;
    if rst_1_29 = '1' then
      op_mem_6_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_6_join_10_5_rst <= '0';
    else 
      op_mem_6_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_6_join_10_5_en <= '1';
    else 
      op_mem_6_join_10_5_en <= '0';
    end if;
    op_mem_6_join_10_5 <= op_mem_5_8_24;
    if rst_1_29 = '1' then
      op_mem_11_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_11_join_10_5_rst <= '0';
    else 
      op_mem_11_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_11_join_10_5_en <= '1';
    else 
      op_mem_11_join_10_5_en <= '0';
    end if;
    op_mem_11_join_10_5 <= op_mem_10_8_24;
    if rst_1_29 = '1' then
      op_mem_17_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_17_join_10_5_rst <= '0';
    else 
      op_mem_17_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_17_join_10_5_en <= '1';
    else 
      op_mem_17_join_10_5_en <= '0';
    end if;
    op_mem_17_join_10_5 <= op_mem_16_8_24;
    if rst_1_29 = '1' then
      op_mem_14_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_14_join_10_5_rst <= '0';
    else 
      op_mem_14_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_14_join_10_5_en <= '1';
    else 
      op_mem_14_join_10_5_en <= '0';
    end if;
    op_mem_14_join_10_5 <= op_mem_13_8_24;
    if rst_1_29 = '1' then
      op_mem_5_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_5_join_10_5_rst <= '0';
    else 
      op_mem_5_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_5_join_10_5_en <= '1';
    else 
      op_mem_5_join_10_5_en <= '0';
    end if;
    op_mem_5_join_10_5 <= op_mem_4_8_24;
    if rst_1_29 = '1' then
      op_mem_9_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_9_join_10_5_rst <= '0';
    else 
      op_mem_9_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_9_join_10_5_en <= '1';
    else 
      op_mem_9_join_10_5_en <= '0';
    end if;
    op_mem_9_join_10_5 <= op_mem_8_8_24;
    if rst_1_29 = '1' then
      op_mem_1_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_1_join_10_5_rst <= '0';
    else 
      op_mem_1_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_1_join_10_5_en <= '1';
    else 
      op_mem_1_join_10_5_en <= '0';
    end if;
    op_mem_1_join_10_5 <= op_mem_0_8_24;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  op_mem_1_8_24_next <= op_mem_0_8_24;
  op_mem_1_8_24_rst <= op_mem_1_join_10_5_rst;
  op_mem_1_8_24_en <= op_mem_1_join_10_5_en;
  op_mem_2_8_24_next <= op_mem_1_8_24;
  op_mem_2_8_24_rst <= op_mem_2_join_10_5_rst;
  op_mem_2_8_24_en <= op_mem_2_join_10_5_en;
  op_mem_3_8_24_next <= op_mem_2_8_24;
  op_mem_3_8_24_rst <= op_mem_3_join_10_5_rst;
  op_mem_3_8_24_en <= op_mem_3_join_10_5_en;
  op_mem_4_8_24_next <= op_mem_3_8_24;
  op_mem_4_8_24_rst <= op_mem_4_join_10_5_rst;
  op_mem_4_8_24_en <= op_mem_4_join_10_5_en;
  op_mem_5_8_24_next <= op_mem_4_8_24;
  op_mem_5_8_24_rst <= op_mem_5_join_10_5_rst;
  op_mem_5_8_24_en <= op_mem_5_join_10_5_en;
  op_mem_6_8_24_next <= op_mem_5_8_24;
  op_mem_6_8_24_rst <= op_mem_6_join_10_5_rst;
  op_mem_6_8_24_en <= op_mem_6_join_10_5_en;
  op_mem_7_8_24_next <= op_mem_6_8_24;
  op_mem_7_8_24_rst <= op_mem_7_join_10_5_rst;
  op_mem_7_8_24_en <= op_mem_7_join_10_5_en;
  op_mem_8_8_24_next <= op_mem_7_8_24;
  op_mem_8_8_24_rst <= op_mem_8_join_10_5_rst;
  op_mem_8_8_24_en <= op_mem_8_join_10_5_en;
  op_mem_9_8_24_next <= op_mem_8_8_24;
  op_mem_9_8_24_rst <= op_mem_9_join_10_5_rst;
  op_mem_9_8_24_en <= op_mem_9_join_10_5_en;
  op_mem_10_8_24_next <= op_mem_9_8_24;
  op_mem_10_8_24_rst <= op_mem_10_join_10_5_rst;
  op_mem_10_8_24_en <= op_mem_10_join_10_5_en;
  op_mem_11_8_24_next <= op_mem_10_8_24;
  op_mem_11_8_24_rst <= op_mem_11_join_10_5_rst;
  op_mem_11_8_24_en <= op_mem_11_join_10_5_en;
  op_mem_12_8_24_next <= op_mem_11_8_24;
  op_mem_12_8_24_rst <= op_mem_12_join_10_5_rst;
  op_mem_12_8_24_en <= op_mem_12_join_10_5_en;
  op_mem_13_8_24_next <= op_mem_12_8_24;
  op_mem_13_8_24_rst <= op_mem_13_join_10_5_rst;
  op_mem_13_8_24_en <= op_mem_13_join_10_5_en;
  op_mem_14_8_24_next <= op_mem_13_8_24;
  op_mem_14_8_24_rst <= op_mem_14_join_10_5_rst;
  op_mem_14_8_24_en <= op_mem_14_join_10_5_en;
  op_mem_15_8_24_next <= op_mem_14_8_24;
  op_mem_15_8_24_rst <= op_mem_15_join_10_5_rst;
  op_mem_15_8_24_en <= op_mem_15_join_10_5_en;
  op_mem_16_8_24_next <= op_mem_15_8_24;
  op_mem_16_8_24_rst <= op_mem_16_join_10_5_rst;
  op_mem_16_8_24_en <= op_mem_16_join_10_5_en;
  op_mem_17_8_24_next <= op_mem_16_8_24;
  op_mem_17_8_24_rst <= op_mem_17_join_10_5_rst;
  op_mem_17_8_24_en <= op_mem_17_join_10_5_en;
  op_mem_18_8_24_next <= op_mem_17_8_24;
  op_mem_18_8_24_rst <= op_mem_18_join_10_5_rst;
  op_mem_18_8_24_en <= op_mem_18_join_10_5_en;
  op_mem_19_8_24_next <= op_mem_18_8_24;
  op_mem_19_8_24_rst <= op_mem_19_join_10_5_rst;
  op_mem_19_8_24_en <= op_mem_19_join_10_5_en;
  op_mem_20_8_24_next <= op_mem_19_8_24;
  op_mem_20_8_24_rst <= op_mem_20_join_10_5_rst;
  op_mem_20_8_24_en <= op_mem_20_join_10_5_en;
  op_mem_21_8_24_next <= op_mem_20_8_24;
  op_mem_21_8_24_rst <= op_mem_21_join_10_5_rst;
  op_mem_21_8_24_en <= op_mem_21_join_10_5_en;
  op_mem_22_8_24_next <= op_mem_21_8_24;
  op_mem_22_8_24_rst <= op_mem_22_join_10_5_rst;
  op_mem_22_8_24_en <= op_mem_22_join_10_5_en;
  op_mem_23_8_24_next <= op_mem_22_8_24;
  op_mem_23_8_24_rst <= op_mem_23_join_10_5_rst;
  op_mem_23_8_24_en <= op_mem_23_join_10_5_en;
  q <= std_logic_to_vector(op_mem_23_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_1546ec153b is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_1546ec153b;
architecture behavior of sysgen_delay_1546ec153b
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_1_8_24_next: std_logic;
  signal op_mem_1_8_24: std_logic := '0';
  signal op_mem_1_8_24_rst: std_logic;
  signal op_mem_1_8_24_en: std_logic;
  signal op_mem_2_8_24_next: std_logic;
  signal op_mem_2_8_24: std_logic := '0';
  signal op_mem_2_8_24_rst: std_logic;
  signal op_mem_2_8_24_en: std_logic;
  signal op_mem_3_8_24_next: std_logic;
  signal op_mem_3_8_24: std_logic := '0';
  signal op_mem_3_8_24_rst: std_logic;
  signal op_mem_3_8_24_en: std_logic;
  signal op_mem_3_join_10_5: std_logic;
  signal op_mem_3_join_10_5_en: std_logic;
  signal op_mem_3_join_10_5_rst: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
  signal op_mem_2_join_10_5: std_logic;
  signal op_mem_2_join_10_5_en: std_logic;
  signal op_mem_2_join_10_5_rst: std_logic;
  signal op_mem_1_join_10_5: std_logic;
  signal op_mem_1_join_10_5_en: std_logic;
  signal op_mem_1_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_op_mem_1_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_1_8_24_rst = '1')) then
        op_mem_1_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_1_8_24_en = '1')) then 
        op_mem_1_8_24 <= op_mem_1_8_24_next;
      end if;
    end if;
  end process proc_op_mem_1_8_24;
  proc_op_mem_2_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_2_8_24_rst = '1')) then
        op_mem_2_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_2_8_24_en = '1')) then 
        op_mem_2_8_24 <= op_mem_2_8_24_next;
      end if;
    end if;
  end process proc_op_mem_2_8_24;
  proc_op_mem_3_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_3_8_24_rst = '1')) then
        op_mem_3_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_3_8_24_en = '1')) then 
        op_mem_3_8_24 <= op_mem_3_8_24_next;
      end if;
    end if;
  end process proc_op_mem_3_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, op_mem_0_8_24, op_mem_1_8_24, op_mem_2_8_24, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_3_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_3_join_10_5_rst <= '0';
    else 
      op_mem_3_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_3_join_10_5_en <= '1';
    else 
      op_mem_3_join_10_5_en <= '0';
    end if;
    op_mem_3_join_10_5 <= op_mem_2_8_24;
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
    if rst_1_29 = '1' then
      op_mem_2_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_2_join_10_5_rst <= '0';
    else 
      op_mem_2_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_2_join_10_5_en <= '1';
    else 
      op_mem_2_join_10_5_en <= '0';
    end if;
    op_mem_2_join_10_5 <= op_mem_1_8_24;
    if rst_1_29 = '1' then
      op_mem_1_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_1_join_10_5_rst <= '0';
    else 
      op_mem_1_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_1_join_10_5_en <= '1';
    else 
      op_mem_1_join_10_5_en <= '0';
    end if;
    op_mem_1_join_10_5 <= op_mem_0_8_24;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  op_mem_1_8_24_next <= op_mem_0_8_24;
  op_mem_1_8_24_rst <= op_mem_1_join_10_5_rst;
  op_mem_1_8_24_en <= op_mem_1_join_10_5_en;
  op_mem_2_8_24_next <= op_mem_1_8_24;
  op_mem_2_8_24_rst <= op_mem_2_join_10_5_rst;
  op_mem_2_8_24_en <= op_mem_2_join_10_5_en;
  op_mem_3_8_24_next <= op_mem_2_8_24;
  op_mem_3_8_24_rst <= op_mem_3_join_10_5_rst;
  op_mem_3_8_24_en <= op_mem_3_join_10_5_en;
  q <= std_logic_to_vector(op_mem_3_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_caf9be0b87 is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_caf9be0b87;
architecture behavior of sysgen_delay_caf9be0b87
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_1_8_24_next: std_logic;
  signal op_mem_1_8_24: std_logic := '0';
  signal op_mem_1_8_24_rst: std_logic;
  signal op_mem_1_8_24_en: std_logic;
  signal op_mem_2_8_24_next: std_logic;
  signal op_mem_2_8_24: std_logic := '0';
  signal op_mem_2_8_24_rst: std_logic;
  signal op_mem_2_8_24_en: std_logic;
  signal op_mem_3_8_24_next: std_logic;
  signal op_mem_3_8_24: std_logic := '0';
  signal op_mem_3_8_24_rst: std_logic;
  signal op_mem_3_8_24_en: std_logic;
  signal op_mem_4_8_24_next: std_logic;
  signal op_mem_4_8_24: std_logic := '0';
  signal op_mem_4_8_24_rst: std_logic;
  signal op_mem_4_8_24_en: std_logic;
  signal op_mem_5_8_24_next: std_logic;
  signal op_mem_5_8_24: std_logic := '0';
  signal op_mem_5_8_24_rst: std_logic;
  signal op_mem_5_8_24_en: std_logic;
  signal op_mem_6_8_24_next: std_logic;
  signal op_mem_6_8_24: std_logic := '0';
  signal op_mem_6_8_24_rst: std_logic;
  signal op_mem_6_8_24_en: std_logic;
  signal op_mem_7_8_24_next: std_logic;
  signal op_mem_7_8_24: std_logic := '0';
  signal op_mem_7_8_24_rst: std_logic;
  signal op_mem_7_8_24_en: std_logic;
  signal op_mem_8_8_24_next: std_logic;
  signal op_mem_8_8_24: std_logic := '0';
  signal op_mem_8_8_24_rst: std_logic;
  signal op_mem_8_8_24_en: std_logic;
  signal op_mem_9_8_24_next: std_logic;
  signal op_mem_9_8_24: std_logic := '0';
  signal op_mem_9_8_24_rst: std_logic;
  signal op_mem_9_8_24_en: std_logic;
  signal op_mem_10_8_24_next: std_logic;
  signal op_mem_10_8_24: std_logic := '0';
  signal op_mem_10_8_24_rst: std_logic;
  signal op_mem_10_8_24_en: std_logic;
  signal op_mem_11_8_24_next: std_logic;
  signal op_mem_11_8_24: std_logic := '0';
  signal op_mem_11_8_24_rst: std_logic;
  signal op_mem_11_8_24_en: std_logic;
  signal op_mem_12_8_24_next: std_logic;
  signal op_mem_12_8_24: std_logic := '0';
  signal op_mem_12_8_24_rst: std_logic;
  signal op_mem_12_8_24_en: std_logic;
  signal op_mem_13_8_24_next: std_logic;
  signal op_mem_13_8_24: std_logic := '0';
  signal op_mem_13_8_24_rst: std_logic;
  signal op_mem_13_8_24_en: std_logic;
  signal op_mem_14_8_24_next: std_logic;
  signal op_mem_14_8_24: std_logic := '0';
  signal op_mem_14_8_24_rst: std_logic;
  signal op_mem_14_8_24_en: std_logic;
  signal op_mem_15_8_24_next: std_logic;
  signal op_mem_15_8_24: std_logic := '0';
  signal op_mem_15_8_24_rst: std_logic;
  signal op_mem_15_8_24_en: std_logic;
  signal op_mem_16_8_24_next: std_logic;
  signal op_mem_16_8_24: std_logic := '0';
  signal op_mem_16_8_24_rst: std_logic;
  signal op_mem_16_8_24_en: std_logic;
  signal op_mem_17_8_24_next: std_logic;
  signal op_mem_17_8_24: std_logic := '0';
  signal op_mem_17_8_24_rst: std_logic;
  signal op_mem_17_8_24_en: std_logic;
  signal op_mem_18_8_24_next: std_logic;
  signal op_mem_18_8_24: std_logic := '0';
  signal op_mem_18_8_24_rst: std_logic;
  signal op_mem_18_8_24_en: std_logic;
  signal op_mem_19_8_24_next: std_logic;
  signal op_mem_19_8_24: std_logic := '0';
  signal op_mem_19_8_24_rst: std_logic;
  signal op_mem_19_8_24_en: std_logic;
  signal op_mem_20_8_24_next: std_logic;
  signal op_mem_20_8_24: std_logic := '0';
  signal op_mem_20_8_24_rst: std_logic;
  signal op_mem_20_8_24_en: std_logic;
  signal op_mem_21_8_24_next: std_logic;
  signal op_mem_21_8_24: std_logic := '0';
  signal op_mem_21_8_24_rst: std_logic;
  signal op_mem_21_8_24_en: std_logic;
  signal op_mem_22_8_24_next: std_logic;
  signal op_mem_22_8_24: std_logic := '0';
  signal op_mem_22_8_24_rst: std_logic;
  signal op_mem_22_8_24_en: std_logic;
  signal op_mem_6_join_10_5: std_logic;
  signal op_mem_6_join_10_5_en: std_logic;
  signal op_mem_6_join_10_5_rst: std_logic;
  signal op_mem_21_join_10_5: std_logic;
  signal op_mem_21_join_10_5_en: std_logic;
  signal op_mem_21_join_10_5_rst: std_logic;
  signal op_mem_9_join_10_5: std_logic;
  signal op_mem_9_join_10_5_en: std_logic;
  signal op_mem_9_join_10_5_rst: std_logic;
  signal op_mem_2_join_10_5: std_logic;
  signal op_mem_2_join_10_5_en: std_logic;
  signal op_mem_2_join_10_5_rst: std_logic;
  signal op_mem_17_join_10_5: std_logic;
  signal op_mem_17_join_10_5_en: std_logic;
  signal op_mem_17_join_10_5_rst: std_logic;
  signal op_mem_3_join_10_5: std_logic;
  signal op_mem_3_join_10_5_en: std_logic;
  signal op_mem_3_join_10_5_rst: std_logic;
  signal op_mem_16_join_10_5: std_logic;
  signal op_mem_16_join_10_5_en: std_logic;
  signal op_mem_16_join_10_5_rst: std_logic;
  signal op_mem_20_join_10_5: std_logic;
  signal op_mem_20_join_10_5_en: std_logic;
  signal op_mem_20_join_10_5_rst: std_logic;
  signal op_mem_12_join_10_5: std_logic;
  signal op_mem_12_join_10_5_en: std_logic;
  signal op_mem_12_join_10_5_rst: std_logic;
  signal op_mem_10_join_10_5: std_logic;
  signal op_mem_10_join_10_5_en: std_logic;
  signal op_mem_10_join_10_5_rst: std_logic;
  signal op_mem_15_join_10_5: std_logic;
  signal op_mem_15_join_10_5_en: std_logic;
  signal op_mem_15_join_10_5_rst: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
  signal op_mem_13_join_10_5: std_logic;
  signal op_mem_13_join_10_5_en: std_logic;
  signal op_mem_13_join_10_5_rst: std_logic;
  signal op_mem_5_join_10_5: std_logic;
  signal op_mem_5_join_10_5_en: std_logic;
  signal op_mem_5_join_10_5_rst: std_logic;
  signal op_mem_22_join_10_5: std_logic;
  signal op_mem_22_join_10_5_en: std_logic;
  signal op_mem_22_join_10_5_rst: std_logic;
  signal op_mem_14_join_10_5: std_logic;
  signal op_mem_14_join_10_5_en: std_logic;
  signal op_mem_14_join_10_5_rst: std_logic;
  signal op_mem_7_join_10_5: std_logic;
  signal op_mem_7_join_10_5_en: std_logic;
  signal op_mem_7_join_10_5_rst: std_logic;
  signal op_mem_4_join_10_5: std_logic;
  signal op_mem_4_join_10_5_en: std_logic;
  signal op_mem_4_join_10_5_rst: std_logic;
  signal op_mem_19_join_10_5: std_logic;
  signal op_mem_19_join_10_5_en: std_logic;
  signal op_mem_19_join_10_5_rst: std_logic;
  signal op_mem_8_join_10_5: std_logic;
  signal op_mem_8_join_10_5_en: std_logic;
  signal op_mem_8_join_10_5_rst: std_logic;
  signal op_mem_1_join_10_5: std_logic;
  signal op_mem_1_join_10_5_en: std_logic;
  signal op_mem_1_join_10_5_rst: std_logic;
  signal op_mem_11_join_10_5: std_logic;
  signal op_mem_11_join_10_5_en: std_logic;
  signal op_mem_11_join_10_5_rst: std_logic;
  signal op_mem_18_join_10_5: std_logic;
  signal op_mem_18_join_10_5_en: std_logic;
  signal op_mem_18_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_op_mem_1_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_1_8_24_rst = '1')) then
        op_mem_1_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_1_8_24_en = '1')) then 
        op_mem_1_8_24 <= op_mem_1_8_24_next;
      end if;
    end if;
  end process proc_op_mem_1_8_24;
  proc_op_mem_2_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_2_8_24_rst = '1')) then
        op_mem_2_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_2_8_24_en = '1')) then 
        op_mem_2_8_24 <= op_mem_2_8_24_next;
      end if;
    end if;
  end process proc_op_mem_2_8_24;
  proc_op_mem_3_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_3_8_24_rst = '1')) then
        op_mem_3_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_3_8_24_en = '1')) then 
        op_mem_3_8_24 <= op_mem_3_8_24_next;
      end if;
    end if;
  end process proc_op_mem_3_8_24;
  proc_op_mem_4_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_4_8_24_rst = '1')) then
        op_mem_4_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_4_8_24_en = '1')) then 
        op_mem_4_8_24 <= op_mem_4_8_24_next;
      end if;
    end if;
  end process proc_op_mem_4_8_24;
  proc_op_mem_5_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_5_8_24_rst = '1')) then
        op_mem_5_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_5_8_24_en = '1')) then 
        op_mem_5_8_24 <= op_mem_5_8_24_next;
      end if;
    end if;
  end process proc_op_mem_5_8_24;
  proc_op_mem_6_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_6_8_24_rst = '1')) then
        op_mem_6_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_6_8_24_en = '1')) then 
        op_mem_6_8_24 <= op_mem_6_8_24_next;
      end if;
    end if;
  end process proc_op_mem_6_8_24;
  proc_op_mem_7_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_7_8_24_rst = '1')) then
        op_mem_7_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_7_8_24_en = '1')) then 
        op_mem_7_8_24 <= op_mem_7_8_24_next;
      end if;
    end if;
  end process proc_op_mem_7_8_24;
  proc_op_mem_8_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_8_8_24_rst = '1')) then
        op_mem_8_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_8_8_24_en = '1')) then 
        op_mem_8_8_24 <= op_mem_8_8_24_next;
      end if;
    end if;
  end process proc_op_mem_8_8_24;
  proc_op_mem_9_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_9_8_24_rst = '1')) then
        op_mem_9_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_9_8_24_en = '1')) then 
        op_mem_9_8_24 <= op_mem_9_8_24_next;
      end if;
    end if;
  end process proc_op_mem_9_8_24;
  proc_op_mem_10_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_10_8_24_rst = '1')) then
        op_mem_10_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_10_8_24_en = '1')) then 
        op_mem_10_8_24 <= op_mem_10_8_24_next;
      end if;
    end if;
  end process proc_op_mem_10_8_24;
  proc_op_mem_11_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_11_8_24_rst = '1')) then
        op_mem_11_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_11_8_24_en = '1')) then 
        op_mem_11_8_24 <= op_mem_11_8_24_next;
      end if;
    end if;
  end process proc_op_mem_11_8_24;
  proc_op_mem_12_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_12_8_24_rst = '1')) then
        op_mem_12_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_12_8_24_en = '1')) then 
        op_mem_12_8_24 <= op_mem_12_8_24_next;
      end if;
    end if;
  end process proc_op_mem_12_8_24;
  proc_op_mem_13_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_13_8_24_rst = '1')) then
        op_mem_13_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_13_8_24_en = '1')) then 
        op_mem_13_8_24 <= op_mem_13_8_24_next;
      end if;
    end if;
  end process proc_op_mem_13_8_24;
  proc_op_mem_14_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_14_8_24_rst = '1')) then
        op_mem_14_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_14_8_24_en = '1')) then 
        op_mem_14_8_24 <= op_mem_14_8_24_next;
      end if;
    end if;
  end process proc_op_mem_14_8_24;
  proc_op_mem_15_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_15_8_24_rst = '1')) then
        op_mem_15_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_15_8_24_en = '1')) then 
        op_mem_15_8_24 <= op_mem_15_8_24_next;
      end if;
    end if;
  end process proc_op_mem_15_8_24;
  proc_op_mem_16_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_16_8_24_rst = '1')) then
        op_mem_16_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_16_8_24_en = '1')) then 
        op_mem_16_8_24 <= op_mem_16_8_24_next;
      end if;
    end if;
  end process proc_op_mem_16_8_24;
  proc_op_mem_17_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_17_8_24_rst = '1')) then
        op_mem_17_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_17_8_24_en = '1')) then 
        op_mem_17_8_24 <= op_mem_17_8_24_next;
      end if;
    end if;
  end process proc_op_mem_17_8_24;
  proc_op_mem_18_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_18_8_24_rst = '1')) then
        op_mem_18_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_18_8_24_en = '1')) then 
        op_mem_18_8_24 <= op_mem_18_8_24_next;
      end if;
    end if;
  end process proc_op_mem_18_8_24;
  proc_op_mem_19_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_19_8_24_rst = '1')) then
        op_mem_19_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_19_8_24_en = '1')) then 
        op_mem_19_8_24 <= op_mem_19_8_24_next;
      end if;
    end if;
  end process proc_op_mem_19_8_24;
  proc_op_mem_20_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_20_8_24_rst = '1')) then
        op_mem_20_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_20_8_24_en = '1')) then 
        op_mem_20_8_24 <= op_mem_20_8_24_next;
      end if;
    end if;
  end process proc_op_mem_20_8_24;
  proc_op_mem_21_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_21_8_24_rst = '1')) then
        op_mem_21_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_21_8_24_en = '1')) then 
        op_mem_21_8_24 <= op_mem_21_8_24_next;
      end if;
    end if;
  end process proc_op_mem_21_8_24;
  proc_op_mem_22_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_8_24_rst = '1')) then
        op_mem_22_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_22_8_24_en = '1')) then 
        op_mem_22_8_24 <= op_mem_22_8_24_next;
      end if;
    end if;
  end process proc_op_mem_22_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, op_mem_0_8_24, op_mem_10_8_24, op_mem_11_8_24, op_mem_12_8_24, op_mem_13_8_24, op_mem_14_8_24, op_mem_15_8_24, op_mem_16_8_24, op_mem_17_8_24, op_mem_18_8_24, op_mem_19_8_24, op_mem_1_8_24, op_mem_20_8_24, op_mem_21_8_24, op_mem_2_8_24, op_mem_3_8_24, op_mem_4_8_24, op_mem_5_8_24, op_mem_6_8_24, op_mem_7_8_24, op_mem_8_8_24, op_mem_9_8_24, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_6_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_6_join_10_5_rst <= '0';
    else 
      op_mem_6_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_6_join_10_5_en <= '1';
    else 
      op_mem_6_join_10_5_en <= '0';
    end if;
    op_mem_6_join_10_5 <= op_mem_5_8_24;
    if rst_1_29 = '1' then
      op_mem_21_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_21_join_10_5_rst <= '0';
    else 
      op_mem_21_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_21_join_10_5_en <= '1';
    else 
      op_mem_21_join_10_5_en <= '0';
    end if;
    op_mem_21_join_10_5 <= op_mem_20_8_24;
    if rst_1_29 = '1' then
      op_mem_9_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_9_join_10_5_rst <= '0';
    else 
      op_mem_9_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_9_join_10_5_en <= '1';
    else 
      op_mem_9_join_10_5_en <= '0';
    end if;
    op_mem_9_join_10_5 <= op_mem_8_8_24;
    if rst_1_29 = '1' then
      op_mem_2_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_2_join_10_5_rst <= '0';
    else 
      op_mem_2_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_2_join_10_5_en <= '1';
    else 
      op_mem_2_join_10_5_en <= '0';
    end if;
    op_mem_2_join_10_5 <= op_mem_1_8_24;
    if rst_1_29 = '1' then
      op_mem_17_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_17_join_10_5_rst <= '0';
    else 
      op_mem_17_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_17_join_10_5_en <= '1';
    else 
      op_mem_17_join_10_5_en <= '0';
    end if;
    op_mem_17_join_10_5 <= op_mem_16_8_24;
    if rst_1_29 = '1' then
      op_mem_3_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_3_join_10_5_rst <= '0';
    else 
      op_mem_3_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_3_join_10_5_en <= '1';
    else 
      op_mem_3_join_10_5_en <= '0';
    end if;
    op_mem_3_join_10_5 <= op_mem_2_8_24;
    if rst_1_29 = '1' then
      op_mem_16_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_16_join_10_5_rst <= '0';
    else 
      op_mem_16_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_16_join_10_5_en <= '1';
    else 
      op_mem_16_join_10_5_en <= '0';
    end if;
    op_mem_16_join_10_5 <= op_mem_15_8_24;
    if rst_1_29 = '1' then
      op_mem_20_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_20_join_10_5_rst <= '0';
    else 
      op_mem_20_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_20_join_10_5_en <= '1';
    else 
      op_mem_20_join_10_5_en <= '0';
    end if;
    op_mem_20_join_10_5 <= op_mem_19_8_24;
    if rst_1_29 = '1' then
      op_mem_12_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_12_join_10_5_rst <= '0';
    else 
      op_mem_12_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_12_join_10_5_en <= '1';
    else 
      op_mem_12_join_10_5_en <= '0';
    end if;
    op_mem_12_join_10_5 <= op_mem_11_8_24;
    if rst_1_29 = '1' then
      op_mem_10_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_10_join_10_5_rst <= '0';
    else 
      op_mem_10_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_10_join_10_5_en <= '1';
    else 
      op_mem_10_join_10_5_en <= '0';
    end if;
    op_mem_10_join_10_5 <= op_mem_9_8_24;
    if rst_1_29 = '1' then
      op_mem_15_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_15_join_10_5_rst <= '0';
    else 
      op_mem_15_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_15_join_10_5_en <= '1';
    else 
      op_mem_15_join_10_5_en <= '0';
    end if;
    op_mem_15_join_10_5 <= op_mem_14_8_24;
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
    if rst_1_29 = '1' then
      op_mem_13_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_13_join_10_5_rst <= '0';
    else 
      op_mem_13_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_13_join_10_5_en <= '1';
    else 
      op_mem_13_join_10_5_en <= '0';
    end if;
    op_mem_13_join_10_5 <= op_mem_12_8_24;
    if rst_1_29 = '1' then
      op_mem_5_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_5_join_10_5_rst <= '0';
    else 
      op_mem_5_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_5_join_10_5_en <= '1';
    else 
      op_mem_5_join_10_5_en <= '0';
    end if;
    op_mem_5_join_10_5 <= op_mem_4_8_24;
    if rst_1_29 = '1' then
      op_mem_22_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_22_join_10_5_rst <= '0';
    else 
      op_mem_22_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_22_join_10_5_en <= '1';
    else 
      op_mem_22_join_10_5_en <= '0';
    end if;
    op_mem_22_join_10_5 <= op_mem_21_8_24;
    if rst_1_29 = '1' then
      op_mem_14_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_14_join_10_5_rst <= '0';
    else 
      op_mem_14_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_14_join_10_5_en <= '1';
    else 
      op_mem_14_join_10_5_en <= '0';
    end if;
    op_mem_14_join_10_5 <= op_mem_13_8_24;
    if rst_1_29 = '1' then
      op_mem_7_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_7_join_10_5_rst <= '0';
    else 
      op_mem_7_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_7_join_10_5_en <= '1';
    else 
      op_mem_7_join_10_5_en <= '0';
    end if;
    op_mem_7_join_10_5 <= op_mem_6_8_24;
    if rst_1_29 = '1' then
      op_mem_4_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_4_join_10_5_rst <= '0';
    else 
      op_mem_4_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_4_join_10_5_en <= '1';
    else 
      op_mem_4_join_10_5_en <= '0';
    end if;
    op_mem_4_join_10_5 <= op_mem_3_8_24;
    if rst_1_29 = '1' then
      op_mem_19_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_19_join_10_5_rst <= '0';
    else 
      op_mem_19_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_19_join_10_5_en <= '1';
    else 
      op_mem_19_join_10_5_en <= '0';
    end if;
    op_mem_19_join_10_5 <= op_mem_18_8_24;
    if rst_1_29 = '1' then
      op_mem_8_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_8_join_10_5_rst <= '0';
    else 
      op_mem_8_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_8_join_10_5_en <= '1';
    else 
      op_mem_8_join_10_5_en <= '0';
    end if;
    op_mem_8_join_10_5 <= op_mem_7_8_24;
    if rst_1_29 = '1' then
      op_mem_1_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_1_join_10_5_rst <= '0';
    else 
      op_mem_1_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_1_join_10_5_en <= '1';
    else 
      op_mem_1_join_10_5_en <= '0';
    end if;
    op_mem_1_join_10_5 <= op_mem_0_8_24;
    if rst_1_29 = '1' then
      op_mem_11_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_11_join_10_5_rst <= '0';
    else 
      op_mem_11_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_11_join_10_5_en <= '1';
    else 
      op_mem_11_join_10_5_en <= '0';
    end if;
    op_mem_11_join_10_5 <= op_mem_10_8_24;
    if rst_1_29 = '1' then
      op_mem_18_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_18_join_10_5_rst <= '0';
    else 
      op_mem_18_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_18_join_10_5_en <= '1';
    else 
      op_mem_18_join_10_5_en <= '0';
    end if;
    op_mem_18_join_10_5 <= op_mem_17_8_24;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  op_mem_1_8_24_next <= op_mem_0_8_24;
  op_mem_1_8_24_rst <= op_mem_1_join_10_5_rst;
  op_mem_1_8_24_en <= op_mem_1_join_10_5_en;
  op_mem_2_8_24_next <= op_mem_1_8_24;
  op_mem_2_8_24_rst <= op_mem_2_join_10_5_rst;
  op_mem_2_8_24_en <= op_mem_2_join_10_5_en;
  op_mem_3_8_24_next <= op_mem_2_8_24;
  op_mem_3_8_24_rst <= op_mem_3_join_10_5_rst;
  op_mem_3_8_24_en <= op_mem_3_join_10_5_en;
  op_mem_4_8_24_next <= op_mem_3_8_24;
  op_mem_4_8_24_rst <= op_mem_4_join_10_5_rst;
  op_mem_4_8_24_en <= op_mem_4_join_10_5_en;
  op_mem_5_8_24_next <= op_mem_4_8_24;
  op_mem_5_8_24_rst <= op_mem_5_join_10_5_rst;
  op_mem_5_8_24_en <= op_mem_5_join_10_5_en;
  op_mem_6_8_24_next <= op_mem_5_8_24;
  op_mem_6_8_24_rst <= op_mem_6_join_10_5_rst;
  op_mem_6_8_24_en <= op_mem_6_join_10_5_en;
  op_mem_7_8_24_next <= op_mem_6_8_24;
  op_mem_7_8_24_rst <= op_mem_7_join_10_5_rst;
  op_mem_7_8_24_en <= op_mem_7_join_10_5_en;
  op_mem_8_8_24_next <= op_mem_7_8_24;
  op_mem_8_8_24_rst <= op_mem_8_join_10_5_rst;
  op_mem_8_8_24_en <= op_mem_8_join_10_5_en;
  op_mem_9_8_24_next <= op_mem_8_8_24;
  op_mem_9_8_24_rst <= op_mem_9_join_10_5_rst;
  op_mem_9_8_24_en <= op_mem_9_join_10_5_en;
  op_mem_10_8_24_next <= op_mem_9_8_24;
  op_mem_10_8_24_rst <= op_mem_10_join_10_5_rst;
  op_mem_10_8_24_en <= op_mem_10_join_10_5_en;
  op_mem_11_8_24_next <= op_mem_10_8_24;
  op_mem_11_8_24_rst <= op_mem_11_join_10_5_rst;
  op_mem_11_8_24_en <= op_mem_11_join_10_5_en;
  op_mem_12_8_24_next <= op_mem_11_8_24;
  op_mem_12_8_24_rst <= op_mem_12_join_10_5_rst;
  op_mem_12_8_24_en <= op_mem_12_join_10_5_en;
  op_mem_13_8_24_next <= op_mem_12_8_24;
  op_mem_13_8_24_rst <= op_mem_13_join_10_5_rst;
  op_mem_13_8_24_en <= op_mem_13_join_10_5_en;
  op_mem_14_8_24_next <= op_mem_13_8_24;
  op_mem_14_8_24_rst <= op_mem_14_join_10_5_rst;
  op_mem_14_8_24_en <= op_mem_14_join_10_5_en;
  op_mem_15_8_24_next <= op_mem_14_8_24;
  op_mem_15_8_24_rst <= op_mem_15_join_10_5_rst;
  op_mem_15_8_24_en <= op_mem_15_join_10_5_en;
  op_mem_16_8_24_next <= op_mem_15_8_24;
  op_mem_16_8_24_rst <= op_mem_16_join_10_5_rst;
  op_mem_16_8_24_en <= op_mem_16_join_10_5_en;
  op_mem_17_8_24_next <= op_mem_16_8_24;
  op_mem_17_8_24_rst <= op_mem_17_join_10_5_rst;
  op_mem_17_8_24_en <= op_mem_17_join_10_5_en;
  op_mem_18_8_24_next <= op_mem_17_8_24;
  op_mem_18_8_24_rst <= op_mem_18_join_10_5_rst;
  op_mem_18_8_24_en <= op_mem_18_join_10_5_en;
  op_mem_19_8_24_next <= op_mem_18_8_24;
  op_mem_19_8_24_rst <= op_mem_19_join_10_5_rst;
  op_mem_19_8_24_en <= op_mem_19_join_10_5_en;
  op_mem_20_8_24_next <= op_mem_19_8_24;
  op_mem_20_8_24_rst <= op_mem_20_join_10_5_rst;
  op_mem_20_8_24_en <= op_mem_20_join_10_5_en;
  op_mem_21_8_24_next <= op_mem_20_8_24;
  op_mem_21_8_24_rst <= op_mem_21_join_10_5_rst;
  op_mem_21_8_24_en <= op_mem_21_join_10_5_en;
  op_mem_22_8_24_next <= op_mem_21_8_24;
  op_mem_22_8_24_rst <= op_mem_22_join_10_5_rst;
  op_mem_22_8_24_en <= op_mem_22_join_10_5_en;
  q <= std_logic_to_vector(op_mem_22_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_1cd78c9d2c is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_1cd78c9d2c;
architecture behavior of sysgen_delay_1cd78c9d2c
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_1_8_24_next: std_logic;
  signal op_mem_1_8_24: std_logic := '0';
  signal op_mem_1_8_24_rst: std_logic;
  signal op_mem_1_8_24_en: std_logic;
  signal op_mem_2_8_24_next: std_logic;
  signal op_mem_2_8_24: std_logic := '0';
  signal op_mem_2_8_24_rst: std_logic;
  signal op_mem_2_8_24_en: std_logic;
  signal op_mem_3_8_24_next: std_logic;
  signal op_mem_3_8_24: std_logic := '0';
  signal op_mem_3_8_24_rst: std_logic;
  signal op_mem_3_8_24_en: std_logic;
  signal op_mem_4_8_24_next: std_logic;
  signal op_mem_4_8_24: std_logic := '0';
  signal op_mem_4_8_24_rst: std_logic;
  signal op_mem_4_8_24_en: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
  signal op_mem_1_join_10_5: std_logic;
  signal op_mem_1_join_10_5_en: std_logic;
  signal op_mem_1_join_10_5_rst: std_logic;
  signal op_mem_2_join_10_5: std_logic;
  signal op_mem_2_join_10_5_en: std_logic;
  signal op_mem_2_join_10_5_rst: std_logic;
  signal op_mem_4_join_10_5: std_logic;
  signal op_mem_4_join_10_5_en: std_logic;
  signal op_mem_4_join_10_5_rst: std_logic;
  signal op_mem_3_join_10_5: std_logic;
  signal op_mem_3_join_10_5_en: std_logic;
  signal op_mem_3_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_op_mem_1_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_1_8_24_rst = '1')) then
        op_mem_1_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_1_8_24_en = '1')) then 
        op_mem_1_8_24 <= op_mem_1_8_24_next;
      end if;
    end if;
  end process proc_op_mem_1_8_24;
  proc_op_mem_2_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_2_8_24_rst = '1')) then
        op_mem_2_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_2_8_24_en = '1')) then 
        op_mem_2_8_24 <= op_mem_2_8_24_next;
      end if;
    end if;
  end process proc_op_mem_2_8_24;
  proc_op_mem_3_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_3_8_24_rst = '1')) then
        op_mem_3_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_3_8_24_en = '1')) then 
        op_mem_3_8_24 <= op_mem_3_8_24_next;
      end if;
    end if;
  end process proc_op_mem_3_8_24;
  proc_op_mem_4_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_4_8_24_rst = '1')) then
        op_mem_4_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_4_8_24_en = '1')) then 
        op_mem_4_8_24 <= op_mem_4_8_24_next;
      end if;
    end if;
  end process proc_op_mem_4_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, op_mem_0_8_24, op_mem_1_8_24, op_mem_2_8_24, op_mem_3_8_24, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
    if rst_1_29 = '1' then
      op_mem_1_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_1_join_10_5_rst <= '0';
    else 
      op_mem_1_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_1_join_10_5_en <= '1';
    else 
      op_mem_1_join_10_5_en <= '0';
    end if;
    op_mem_1_join_10_5 <= op_mem_0_8_24;
    if rst_1_29 = '1' then
      op_mem_2_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_2_join_10_5_rst <= '0';
    else 
      op_mem_2_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_2_join_10_5_en <= '1';
    else 
      op_mem_2_join_10_5_en <= '0';
    end if;
    op_mem_2_join_10_5 <= op_mem_1_8_24;
    if rst_1_29 = '1' then
      op_mem_4_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_4_join_10_5_rst <= '0';
    else 
      op_mem_4_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_4_join_10_5_en <= '1';
    else 
      op_mem_4_join_10_5_en <= '0';
    end if;
    op_mem_4_join_10_5 <= op_mem_3_8_24;
    if rst_1_29 = '1' then
      op_mem_3_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_3_join_10_5_rst <= '0';
    else 
      op_mem_3_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_3_join_10_5_en <= '1';
    else 
      op_mem_3_join_10_5_en <= '0';
    end if;
    op_mem_3_join_10_5 <= op_mem_2_8_24;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  op_mem_1_8_24_next <= op_mem_0_8_24;
  op_mem_1_8_24_rst <= op_mem_1_join_10_5_rst;
  op_mem_1_8_24_en <= op_mem_1_join_10_5_en;
  op_mem_2_8_24_next <= op_mem_1_8_24;
  op_mem_2_8_24_rst <= op_mem_2_join_10_5_rst;
  op_mem_2_8_24_en <= op_mem_2_join_10_5_en;
  op_mem_3_8_24_next <= op_mem_2_8_24;
  op_mem_3_8_24_rst <= op_mem_3_join_10_5_rst;
  op_mem_3_8_24_en <= op_mem_3_join_10_5_en;
  op_mem_4_8_24_next <= op_mem_3_8_24;
  op_mem_4_8_24_rst <= op_mem_4_join_10_5_rst;
  op_mem_4_8_24_en <= op_mem_4_join_10_5_en;
  q <= std_logic_to_vector(op_mem_4_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_a71f2bf332 is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_a71f2bf332;
architecture behavior of sysgen_delay_a71f2bf332
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_1_8_24_next: std_logic;
  signal op_mem_1_8_24: std_logic := '0';
  signal op_mem_1_8_24_rst: std_logic;
  signal op_mem_1_8_24_en: std_logic;
  signal op_mem_2_8_24_next: std_logic;
  signal op_mem_2_8_24: std_logic := '0';
  signal op_mem_2_8_24_rst: std_logic;
  signal op_mem_2_8_24_en: std_logic;
  signal op_mem_3_8_24_next: std_logic;
  signal op_mem_3_8_24: std_logic := '0';
  signal op_mem_3_8_24_rst: std_logic;
  signal op_mem_3_8_24_en: std_logic;
  signal op_mem_4_8_24_next: std_logic;
  signal op_mem_4_8_24: std_logic := '0';
  signal op_mem_4_8_24_rst: std_logic;
  signal op_mem_4_8_24_en: std_logic;
  signal op_mem_5_8_24_next: std_logic;
  signal op_mem_5_8_24: std_logic := '0';
  signal op_mem_5_8_24_rst: std_logic;
  signal op_mem_5_8_24_en: std_logic;
  signal op_mem_6_8_24_next: std_logic;
  signal op_mem_6_8_24: std_logic := '0';
  signal op_mem_6_8_24_rst: std_logic;
  signal op_mem_6_8_24_en: std_logic;
  signal op_mem_7_8_24_next: std_logic;
  signal op_mem_7_8_24: std_logic := '0';
  signal op_mem_7_8_24_rst: std_logic;
  signal op_mem_7_8_24_en: std_logic;
  signal op_mem_4_join_10_5: std_logic;
  signal op_mem_4_join_10_5_en: std_logic;
  signal op_mem_4_join_10_5_rst: std_logic;
  signal op_mem_7_join_10_5: std_logic;
  signal op_mem_7_join_10_5_en: std_logic;
  signal op_mem_7_join_10_5_rst: std_logic;
  signal op_mem_3_join_10_5: std_logic;
  signal op_mem_3_join_10_5_en: std_logic;
  signal op_mem_3_join_10_5_rst: std_logic;
  signal op_mem_1_join_10_5: std_logic;
  signal op_mem_1_join_10_5_en: std_logic;
  signal op_mem_1_join_10_5_rst: std_logic;
  signal op_mem_6_join_10_5: std_logic;
  signal op_mem_6_join_10_5_en: std_logic;
  signal op_mem_6_join_10_5_rst: std_logic;
  signal op_mem_5_join_10_5: std_logic;
  signal op_mem_5_join_10_5_en: std_logic;
  signal op_mem_5_join_10_5_rst: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
  signal op_mem_2_join_10_5: std_logic;
  signal op_mem_2_join_10_5_en: std_logic;
  signal op_mem_2_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_op_mem_1_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_1_8_24_rst = '1')) then
        op_mem_1_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_1_8_24_en = '1')) then 
        op_mem_1_8_24 <= op_mem_1_8_24_next;
      end if;
    end if;
  end process proc_op_mem_1_8_24;
  proc_op_mem_2_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_2_8_24_rst = '1')) then
        op_mem_2_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_2_8_24_en = '1')) then 
        op_mem_2_8_24 <= op_mem_2_8_24_next;
      end if;
    end if;
  end process proc_op_mem_2_8_24;
  proc_op_mem_3_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_3_8_24_rst = '1')) then
        op_mem_3_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_3_8_24_en = '1')) then 
        op_mem_3_8_24 <= op_mem_3_8_24_next;
      end if;
    end if;
  end process proc_op_mem_3_8_24;
  proc_op_mem_4_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_4_8_24_rst = '1')) then
        op_mem_4_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_4_8_24_en = '1')) then 
        op_mem_4_8_24 <= op_mem_4_8_24_next;
      end if;
    end if;
  end process proc_op_mem_4_8_24;
  proc_op_mem_5_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_5_8_24_rst = '1')) then
        op_mem_5_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_5_8_24_en = '1')) then 
        op_mem_5_8_24 <= op_mem_5_8_24_next;
      end if;
    end if;
  end process proc_op_mem_5_8_24;
  proc_op_mem_6_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_6_8_24_rst = '1')) then
        op_mem_6_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_6_8_24_en = '1')) then 
        op_mem_6_8_24 <= op_mem_6_8_24_next;
      end if;
    end if;
  end process proc_op_mem_6_8_24;
  proc_op_mem_7_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_7_8_24_rst = '1')) then
        op_mem_7_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_7_8_24_en = '1')) then 
        op_mem_7_8_24 <= op_mem_7_8_24_next;
      end if;
    end if;
  end process proc_op_mem_7_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, op_mem_0_8_24, op_mem_1_8_24, op_mem_2_8_24, op_mem_3_8_24, op_mem_4_8_24, op_mem_5_8_24, op_mem_6_8_24, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_4_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_4_join_10_5_rst <= '0';
    else 
      op_mem_4_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_4_join_10_5_en <= '1';
    else 
      op_mem_4_join_10_5_en <= '0';
    end if;
    op_mem_4_join_10_5 <= op_mem_3_8_24;
    if rst_1_29 = '1' then
      op_mem_7_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_7_join_10_5_rst <= '0';
    else 
      op_mem_7_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_7_join_10_5_en <= '1';
    else 
      op_mem_7_join_10_5_en <= '0';
    end if;
    op_mem_7_join_10_5 <= op_mem_6_8_24;
    if rst_1_29 = '1' then
      op_mem_3_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_3_join_10_5_rst <= '0';
    else 
      op_mem_3_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_3_join_10_5_en <= '1';
    else 
      op_mem_3_join_10_5_en <= '0';
    end if;
    op_mem_3_join_10_5 <= op_mem_2_8_24;
    if rst_1_29 = '1' then
      op_mem_1_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_1_join_10_5_rst <= '0';
    else 
      op_mem_1_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_1_join_10_5_en <= '1';
    else 
      op_mem_1_join_10_5_en <= '0';
    end if;
    op_mem_1_join_10_5 <= op_mem_0_8_24;
    if rst_1_29 = '1' then
      op_mem_6_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_6_join_10_5_rst <= '0';
    else 
      op_mem_6_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_6_join_10_5_en <= '1';
    else 
      op_mem_6_join_10_5_en <= '0';
    end if;
    op_mem_6_join_10_5 <= op_mem_5_8_24;
    if rst_1_29 = '1' then
      op_mem_5_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_5_join_10_5_rst <= '0';
    else 
      op_mem_5_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_5_join_10_5_en <= '1';
    else 
      op_mem_5_join_10_5_en <= '0';
    end if;
    op_mem_5_join_10_5 <= op_mem_4_8_24;
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
    if rst_1_29 = '1' then
      op_mem_2_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_2_join_10_5_rst <= '0';
    else 
      op_mem_2_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_2_join_10_5_en <= '1';
    else 
      op_mem_2_join_10_5_en <= '0';
    end if;
    op_mem_2_join_10_5 <= op_mem_1_8_24;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  op_mem_1_8_24_next <= op_mem_0_8_24;
  op_mem_1_8_24_rst <= op_mem_1_join_10_5_rst;
  op_mem_1_8_24_en <= op_mem_1_join_10_5_en;
  op_mem_2_8_24_next <= op_mem_1_8_24;
  op_mem_2_8_24_rst <= op_mem_2_join_10_5_rst;
  op_mem_2_8_24_en <= op_mem_2_join_10_5_en;
  op_mem_3_8_24_next <= op_mem_2_8_24;
  op_mem_3_8_24_rst <= op_mem_3_join_10_5_rst;
  op_mem_3_8_24_en <= op_mem_3_join_10_5_en;
  op_mem_4_8_24_next <= op_mem_3_8_24;
  op_mem_4_8_24_rst <= op_mem_4_join_10_5_rst;
  op_mem_4_8_24_en <= op_mem_4_join_10_5_en;
  op_mem_5_8_24_next <= op_mem_4_8_24;
  op_mem_5_8_24_rst <= op_mem_5_join_10_5_rst;
  op_mem_5_8_24_en <= op_mem_5_join_10_5_en;
  op_mem_6_8_24_next <= op_mem_5_8_24;
  op_mem_6_8_24_rst <= op_mem_6_join_10_5_rst;
  op_mem_6_8_24_en <= op_mem_6_join_10_5_en;
  op_mem_7_8_24_next <= op_mem_6_8_24;
  op_mem_7_8_24_rst <= op_mem_7_join_10_5_rst;
  op_mem_7_8_24_en <= op_mem_7_join_10_5_en;
  q <= std_logic_to_vector(op_mem_7_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_2e9415344a is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_2e9415344a;
architecture behavior of sysgen_delay_2e9415344a
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_1_8_24_next: std_logic;
  signal op_mem_1_8_24: std_logic := '0';
  signal op_mem_1_8_24_rst: std_logic;
  signal op_mem_1_8_24_en: std_logic;
  signal op_mem_2_8_24_next: std_logic;
  signal op_mem_2_8_24: std_logic := '0';
  signal op_mem_2_8_24_rst: std_logic;
  signal op_mem_2_8_24_en: std_logic;
  signal op_mem_3_8_24_next: std_logic;
  signal op_mem_3_8_24: std_logic := '0';
  signal op_mem_3_8_24_rst: std_logic;
  signal op_mem_3_8_24_en: std_logic;
  signal op_mem_4_8_24_next: std_logic;
  signal op_mem_4_8_24: std_logic := '0';
  signal op_mem_4_8_24_rst: std_logic;
  signal op_mem_4_8_24_en: std_logic;
  signal op_mem_5_8_24_next: std_logic;
  signal op_mem_5_8_24: std_logic := '0';
  signal op_mem_5_8_24_rst: std_logic;
  signal op_mem_5_8_24_en: std_logic;
  signal op_mem_6_8_24_next: std_logic;
  signal op_mem_6_8_24: std_logic := '0';
  signal op_mem_6_8_24_rst: std_logic;
  signal op_mem_6_8_24_en: std_logic;
  signal op_mem_7_8_24_next: std_logic;
  signal op_mem_7_8_24: std_logic := '0';
  signal op_mem_7_8_24_rst: std_logic;
  signal op_mem_7_8_24_en: std_logic;
  signal op_mem_8_8_24_next: std_logic;
  signal op_mem_8_8_24: std_logic := '0';
  signal op_mem_8_8_24_rst: std_logic;
  signal op_mem_8_8_24_en: std_logic;
  signal op_mem_5_join_10_5: std_logic;
  signal op_mem_5_join_10_5_en: std_logic;
  signal op_mem_5_join_10_5_rst: std_logic;
  signal op_mem_3_join_10_5: std_logic;
  signal op_mem_3_join_10_5_en: std_logic;
  signal op_mem_3_join_10_5_rst: std_logic;
  signal op_mem_8_join_10_5: std_logic;
  signal op_mem_8_join_10_5_en: std_logic;
  signal op_mem_8_join_10_5_rst: std_logic;
  signal op_mem_6_join_10_5: std_logic;
  signal op_mem_6_join_10_5_en: std_logic;
  signal op_mem_6_join_10_5_rst: std_logic;
  signal op_mem_4_join_10_5: std_logic;
  signal op_mem_4_join_10_5_en: std_logic;
  signal op_mem_4_join_10_5_rst: std_logic;
  signal op_mem_2_join_10_5: std_logic;
  signal op_mem_2_join_10_5_en: std_logic;
  signal op_mem_2_join_10_5_rst: std_logic;
  signal op_mem_1_join_10_5: std_logic;
  signal op_mem_1_join_10_5_en: std_logic;
  signal op_mem_1_join_10_5_rst: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
  signal op_mem_7_join_10_5: std_logic;
  signal op_mem_7_join_10_5_en: std_logic;
  signal op_mem_7_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_op_mem_1_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_1_8_24_rst = '1')) then
        op_mem_1_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_1_8_24_en = '1')) then 
        op_mem_1_8_24 <= op_mem_1_8_24_next;
      end if;
    end if;
  end process proc_op_mem_1_8_24;
  proc_op_mem_2_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_2_8_24_rst = '1')) then
        op_mem_2_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_2_8_24_en = '1')) then 
        op_mem_2_8_24 <= op_mem_2_8_24_next;
      end if;
    end if;
  end process proc_op_mem_2_8_24;
  proc_op_mem_3_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_3_8_24_rst = '1')) then
        op_mem_3_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_3_8_24_en = '1')) then 
        op_mem_3_8_24 <= op_mem_3_8_24_next;
      end if;
    end if;
  end process proc_op_mem_3_8_24;
  proc_op_mem_4_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_4_8_24_rst = '1')) then
        op_mem_4_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_4_8_24_en = '1')) then 
        op_mem_4_8_24 <= op_mem_4_8_24_next;
      end if;
    end if;
  end process proc_op_mem_4_8_24;
  proc_op_mem_5_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_5_8_24_rst = '1')) then
        op_mem_5_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_5_8_24_en = '1')) then 
        op_mem_5_8_24 <= op_mem_5_8_24_next;
      end if;
    end if;
  end process proc_op_mem_5_8_24;
  proc_op_mem_6_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_6_8_24_rst = '1')) then
        op_mem_6_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_6_8_24_en = '1')) then 
        op_mem_6_8_24 <= op_mem_6_8_24_next;
      end if;
    end if;
  end process proc_op_mem_6_8_24;
  proc_op_mem_7_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_7_8_24_rst = '1')) then
        op_mem_7_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_7_8_24_en = '1')) then 
        op_mem_7_8_24 <= op_mem_7_8_24_next;
      end if;
    end if;
  end process proc_op_mem_7_8_24;
  proc_op_mem_8_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_8_8_24_rst = '1')) then
        op_mem_8_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_8_8_24_en = '1')) then 
        op_mem_8_8_24 <= op_mem_8_8_24_next;
      end if;
    end if;
  end process proc_op_mem_8_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, op_mem_0_8_24, op_mem_1_8_24, op_mem_2_8_24, op_mem_3_8_24, op_mem_4_8_24, op_mem_5_8_24, op_mem_6_8_24, op_mem_7_8_24, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_5_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_5_join_10_5_rst <= '0';
    else 
      op_mem_5_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_5_join_10_5_en <= '1';
    else 
      op_mem_5_join_10_5_en <= '0';
    end if;
    op_mem_5_join_10_5 <= op_mem_4_8_24;
    if rst_1_29 = '1' then
      op_mem_3_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_3_join_10_5_rst <= '0';
    else 
      op_mem_3_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_3_join_10_5_en <= '1';
    else 
      op_mem_3_join_10_5_en <= '0';
    end if;
    op_mem_3_join_10_5 <= op_mem_2_8_24;
    if rst_1_29 = '1' then
      op_mem_8_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_8_join_10_5_rst <= '0';
    else 
      op_mem_8_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_8_join_10_5_en <= '1';
    else 
      op_mem_8_join_10_5_en <= '0';
    end if;
    op_mem_8_join_10_5 <= op_mem_7_8_24;
    if rst_1_29 = '1' then
      op_mem_6_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_6_join_10_5_rst <= '0';
    else 
      op_mem_6_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_6_join_10_5_en <= '1';
    else 
      op_mem_6_join_10_5_en <= '0';
    end if;
    op_mem_6_join_10_5 <= op_mem_5_8_24;
    if rst_1_29 = '1' then
      op_mem_4_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_4_join_10_5_rst <= '0';
    else 
      op_mem_4_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_4_join_10_5_en <= '1';
    else 
      op_mem_4_join_10_5_en <= '0';
    end if;
    op_mem_4_join_10_5 <= op_mem_3_8_24;
    if rst_1_29 = '1' then
      op_mem_2_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_2_join_10_5_rst <= '0';
    else 
      op_mem_2_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_2_join_10_5_en <= '1';
    else 
      op_mem_2_join_10_5_en <= '0';
    end if;
    op_mem_2_join_10_5 <= op_mem_1_8_24;
    if rst_1_29 = '1' then
      op_mem_1_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_1_join_10_5_rst <= '0';
    else 
      op_mem_1_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_1_join_10_5_en <= '1';
    else 
      op_mem_1_join_10_5_en <= '0';
    end if;
    op_mem_1_join_10_5 <= op_mem_0_8_24;
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
    if rst_1_29 = '1' then
      op_mem_7_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_7_join_10_5_rst <= '0';
    else 
      op_mem_7_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_7_join_10_5_en <= '1';
    else 
      op_mem_7_join_10_5_en <= '0';
    end if;
    op_mem_7_join_10_5 <= op_mem_6_8_24;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  op_mem_1_8_24_next <= op_mem_0_8_24;
  op_mem_1_8_24_rst <= op_mem_1_join_10_5_rst;
  op_mem_1_8_24_en <= op_mem_1_join_10_5_en;
  op_mem_2_8_24_next <= op_mem_1_8_24;
  op_mem_2_8_24_rst <= op_mem_2_join_10_5_rst;
  op_mem_2_8_24_en <= op_mem_2_join_10_5_en;
  op_mem_3_8_24_next <= op_mem_2_8_24;
  op_mem_3_8_24_rst <= op_mem_3_join_10_5_rst;
  op_mem_3_8_24_en <= op_mem_3_join_10_5_en;
  op_mem_4_8_24_next <= op_mem_3_8_24;
  op_mem_4_8_24_rst <= op_mem_4_join_10_5_rst;
  op_mem_4_8_24_en <= op_mem_4_join_10_5_en;
  op_mem_5_8_24_next <= op_mem_4_8_24;
  op_mem_5_8_24_rst <= op_mem_5_join_10_5_rst;
  op_mem_5_8_24_en <= op_mem_5_join_10_5_en;
  op_mem_6_8_24_next <= op_mem_5_8_24;
  op_mem_6_8_24_rst <= op_mem_6_join_10_5_rst;
  op_mem_6_8_24_en <= op_mem_6_join_10_5_en;
  op_mem_7_8_24_next <= op_mem_6_8_24;
  op_mem_7_8_24_rst <= op_mem_7_join_10_5_rst;
  op_mem_7_8_24_en <= op_mem_7_join_10_5_en;
  op_mem_8_8_24_next <= op_mem_7_8_24;
  op_mem_8_8_24_rst <= op_mem_8_join_10_5_rst;
  op_mem_8_8_24_en <= op_mem_8_join_10_5_en;
  q <= std_logic_to_vector(op_mem_8_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_fa28aa058a is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_fa28aa058a;
architecture behavior of sysgen_delay_fa28aa058a
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_1_8_24_next: std_logic;
  signal op_mem_1_8_24: std_logic := '0';
  signal op_mem_1_8_24_rst: std_logic;
  signal op_mem_1_8_24_en: std_logic;
  signal op_mem_2_8_24_next: std_logic;
  signal op_mem_2_8_24: std_logic := '0';
  signal op_mem_2_8_24_rst: std_logic;
  signal op_mem_2_8_24_en: std_logic;
  signal op_mem_3_8_24_next: std_logic;
  signal op_mem_3_8_24: std_logic := '0';
  signal op_mem_3_8_24_rst: std_logic;
  signal op_mem_3_8_24_en: std_logic;
  signal op_mem_4_8_24_next: std_logic;
  signal op_mem_4_8_24: std_logic := '0';
  signal op_mem_4_8_24_rst: std_logic;
  signal op_mem_4_8_24_en: std_logic;
  signal op_mem_5_8_24_next: std_logic;
  signal op_mem_5_8_24: std_logic := '0';
  signal op_mem_5_8_24_rst: std_logic;
  signal op_mem_5_8_24_en: std_logic;
  signal op_mem_6_8_24_next: std_logic;
  signal op_mem_6_8_24: std_logic := '0';
  signal op_mem_6_8_24_rst: std_logic;
  signal op_mem_6_8_24_en: std_logic;
  signal op_mem_7_8_24_next: std_logic;
  signal op_mem_7_8_24: std_logic := '0';
  signal op_mem_7_8_24_rst: std_logic;
  signal op_mem_7_8_24_en: std_logic;
  signal op_mem_8_8_24_next: std_logic;
  signal op_mem_8_8_24: std_logic := '0';
  signal op_mem_8_8_24_rst: std_logic;
  signal op_mem_8_8_24_en: std_logic;
  signal op_mem_9_8_24_next: std_logic;
  signal op_mem_9_8_24: std_logic := '0';
  signal op_mem_9_8_24_rst: std_logic;
  signal op_mem_9_8_24_en: std_logic;
  signal op_mem_10_8_24_next: std_logic;
  signal op_mem_10_8_24: std_logic := '0';
  signal op_mem_10_8_24_rst: std_logic;
  signal op_mem_10_8_24_en: std_logic;
  signal op_mem_11_8_24_next: std_logic;
  signal op_mem_11_8_24: std_logic := '0';
  signal op_mem_11_8_24_rst: std_logic;
  signal op_mem_11_8_24_en: std_logic;
  signal op_mem_7_join_10_5: std_logic;
  signal op_mem_7_join_10_5_en: std_logic;
  signal op_mem_7_join_10_5_rst: std_logic;
  signal op_mem_1_join_10_5: std_logic;
  signal op_mem_1_join_10_5_en: std_logic;
  signal op_mem_1_join_10_5_rst: std_logic;
  signal op_mem_6_join_10_5: std_logic;
  signal op_mem_6_join_10_5_en: std_logic;
  signal op_mem_6_join_10_5_rst: std_logic;
  signal op_mem_11_join_10_5: std_logic;
  signal op_mem_11_join_10_5_en: std_logic;
  signal op_mem_11_join_10_5_rst: std_logic;
  signal op_mem_9_join_10_5: std_logic;
  signal op_mem_9_join_10_5_en: std_logic;
  signal op_mem_9_join_10_5_rst: std_logic;
  signal op_mem_10_join_10_5: std_logic;
  signal op_mem_10_join_10_5_en: std_logic;
  signal op_mem_10_join_10_5_rst: std_logic;
  signal op_mem_4_join_10_5: std_logic;
  signal op_mem_4_join_10_5_en: std_logic;
  signal op_mem_4_join_10_5_rst: std_logic;
  signal op_mem_8_join_10_5: std_logic;
  signal op_mem_8_join_10_5_en: std_logic;
  signal op_mem_8_join_10_5_rst: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
  signal op_mem_2_join_10_5: std_logic;
  signal op_mem_2_join_10_5_en: std_logic;
  signal op_mem_2_join_10_5_rst: std_logic;
  signal op_mem_5_join_10_5: std_logic;
  signal op_mem_5_join_10_5_en: std_logic;
  signal op_mem_5_join_10_5_rst: std_logic;
  signal op_mem_3_join_10_5: std_logic;
  signal op_mem_3_join_10_5_en: std_logic;
  signal op_mem_3_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_op_mem_1_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_1_8_24_rst = '1')) then
        op_mem_1_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_1_8_24_en = '1')) then 
        op_mem_1_8_24 <= op_mem_1_8_24_next;
      end if;
    end if;
  end process proc_op_mem_1_8_24;
  proc_op_mem_2_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_2_8_24_rst = '1')) then
        op_mem_2_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_2_8_24_en = '1')) then 
        op_mem_2_8_24 <= op_mem_2_8_24_next;
      end if;
    end if;
  end process proc_op_mem_2_8_24;
  proc_op_mem_3_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_3_8_24_rst = '1')) then
        op_mem_3_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_3_8_24_en = '1')) then 
        op_mem_3_8_24 <= op_mem_3_8_24_next;
      end if;
    end if;
  end process proc_op_mem_3_8_24;
  proc_op_mem_4_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_4_8_24_rst = '1')) then
        op_mem_4_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_4_8_24_en = '1')) then 
        op_mem_4_8_24 <= op_mem_4_8_24_next;
      end if;
    end if;
  end process proc_op_mem_4_8_24;
  proc_op_mem_5_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_5_8_24_rst = '1')) then
        op_mem_5_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_5_8_24_en = '1')) then 
        op_mem_5_8_24 <= op_mem_5_8_24_next;
      end if;
    end if;
  end process proc_op_mem_5_8_24;
  proc_op_mem_6_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_6_8_24_rst = '1')) then
        op_mem_6_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_6_8_24_en = '1')) then 
        op_mem_6_8_24 <= op_mem_6_8_24_next;
      end if;
    end if;
  end process proc_op_mem_6_8_24;
  proc_op_mem_7_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_7_8_24_rst = '1')) then
        op_mem_7_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_7_8_24_en = '1')) then 
        op_mem_7_8_24 <= op_mem_7_8_24_next;
      end if;
    end if;
  end process proc_op_mem_7_8_24;
  proc_op_mem_8_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_8_8_24_rst = '1')) then
        op_mem_8_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_8_8_24_en = '1')) then 
        op_mem_8_8_24 <= op_mem_8_8_24_next;
      end if;
    end if;
  end process proc_op_mem_8_8_24;
  proc_op_mem_9_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_9_8_24_rst = '1')) then
        op_mem_9_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_9_8_24_en = '1')) then 
        op_mem_9_8_24 <= op_mem_9_8_24_next;
      end if;
    end if;
  end process proc_op_mem_9_8_24;
  proc_op_mem_10_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_10_8_24_rst = '1')) then
        op_mem_10_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_10_8_24_en = '1')) then 
        op_mem_10_8_24 <= op_mem_10_8_24_next;
      end if;
    end if;
  end process proc_op_mem_10_8_24;
  proc_op_mem_11_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_11_8_24_rst = '1')) then
        op_mem_11_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_11_8_24_en = '1')) then 
        op_mem_11_8_24 <= op_mem_11_8_24_next;
      end if;
    end if;
  end process proc_op_mem_11_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, op_mem_0_8_24, op_mem_10_8_24, op_mem_1_8_24, op_mem_2_8_24, op_mem_3_8_24, op_mem_4_8_24, op_mem_5_8_24, op_mem_6_8_24, op_mem_7_8_24, op_mem_8_8_24, op_mem_9_8_24, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_7_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_7_join_10_5_rst <= '0';
    else 
      op_mem_7_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_7_join_10_5_en <= '1';
    else 
      op_mem_7_join_10_5_en <= '0';
    end if;
    op_mem_7_join_10_5 <= op_mem_6_8_24;
    if rst_1_29 = '1' then
      op_mem_1_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_1_join_10_5_rst <= '0';
    else 
      op_mem_1_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_1_join_10_5_en <= '1';
    else 
      op_mem_1_join_10_5_en <= '0';
    end if;
    op_mem_1_join_10_5 <= op_mem_0_8_24;
    if rst_1_29 = '1' then
      op_mem_6_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_6_join_10_5_rst <= '0';
    else 
      op_mem_6_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_6_join_10_5_en <= '1';
    else 
      op_mem_6_join_10_5_en <= '0';
    end if;
    op_mem_6_join_10_5 <= op_mem_5_8_24;
    if rst_1_29 = '1' then
      op_mem_11_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_11_join_10_5_rst <= '0';
    else 
      op_mem_11_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_11_join_10_5_en <= '1';
    else 
      op_mem_11_join_10_5_en <= '0';
    end if;
    op_mem_11_join_10_5 <= op_mem_10_8_24;
    if rst_1_29 = '1' then
      op_mem_9_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_9_join_10_5_rst <= '0';
    else 
      op_mem_9_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_9_join_10_5_en <= '1';
    else 
      op_mem_9_join_10_5_en <= '0';
    end if;
    op_mem_9_join_10_5 <= op_mem_8_8_24;
    if rst_1_29 = '1' then
      op_mem_10_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_10_join_10_5_rst <= '0';
    else 
      op_mem_10_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_10_join_10_5_en <= '1';
    else 
      op_mem_10_join_10_5_en <= '0';
    end if;
    op_mem_10_join_10_5 <= op_mem_9_8_24;
    if rst_1_29 = '1' then
      op_mem_4_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_4_join_10_5_rst <= '0';
    else 
      op_mem_4_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_4_join_10_5_en <= '1';
    else 
      op_mem_4_join_10_5_en <= '0';
    end if;
    op_mem_4_join_10_5 <= op_mem_3_8_24;
    if rst_1_29 = '1' then
      op_mem_8_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_8_join_10_5_rst <= '0';
    else 
      op_mem_8_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_8_join_10_5_en <= '1';
    else 
      op_mem_8_join_10_5_en <= '0';
    end if;
    op_mem_8_join_10_5 <= op_mem_7_8_24;
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
    if rst_1_29 = '1' then
      op_mem_2_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_2_join_10_5_rst <= '0';
    else 
      op_mem_2_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_2_join_10_5_en <= '1';
    else 
      op_mem_2_join_10_5_en <= '0';
    end if;
    op_mem_2_join_10_5 <= op_mem_1_8_24;
    if rst_1_29 = '1' then
      op_mem_5_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_5_join_10_5_rst <= '0';
    else 
      op_mem_5_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_5_join_10_5_en <= '1';
    else 
      op_mem_5_join_10_5_en <= '0';
    end if;
    op_mem_5_join_10_5 <= op_mem_4_8_24;
    if rst_1_29 = '1' then
      op_mem_3_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_3_join_10_5_rst <= '0';
    else 
      op_mem_3_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_3_join_10_5_en <= '1';
    else 
      op_mem_3_join_10_5_en <= '0';
    end if;
    op_mem_3_join_10_5 <= op_mem_2_8_24;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  op_mem_1_8_24_next <= op_mem_0_8_24;
  op_mem_1_8_24_rst <= op_mem_1_join_10_5_rst;
  op_mem_1_8_24_en <= op_mem_1_join_10_5_en;
  op_mem_2_8_24_next <= op_mem_1_8_24;
  op_mem_2_8_24_rst <= op_mem_2_join_10_5_rst;
  op_mem_2_8_24_en <= op_mem_2_join_10_5_en;
  op_mem_3_8_24_next <= op_mem_2_8_24;
  op_mem_3_8_24_rst <= op_mem_3_join_10_5_rst;
  op_mem_3_8_24_en <= op_mem_3_join_10_5_en;
  op_mem_4_8_24_next <= op_mem_3_8_24;
  op_mem_4_8_24_rst <= op_mem_4_join_10_5_rst;
  op_mem_4_8_24_en <= op_mem_4_join_10_5_en;
  op_mem_5_8_24_next <= op_mem_4_8_24;
  op_mem_5_8_24_rst <= op_mem_5_join_10_5_rst;
  op_mem_5_8_24_en <= op_mem_5_join_10_5_en;
  op_mem_6_8_24_next <= op_mem_5_8_24;
  op_mem_6_8_24_rst <= op_mem_6_join_10_5_rst;
  op_mem_6_8_24_en <= op_mem_6_join_10_5_en;
  op_mem_7_8_24_next <= op_mem_6_8_24;
  op_mem_7_8_24_rst <= op_mem_7_join_10_5_rst;
  op_mem_7_8_24_en <= op_mem_7_join_10_5_en;
  op_mem_8_8_24_next <= op_mem_7_8_24;
  op_mem_8_8_24_rst <= op_mem_8_join_10_5_rst;
  op_mem_8_8_24_en <= op_mem_8_join_10_5_en;
  op_mem_9_8_24_next <= op_mem_8_8_24;
  op_mem_9_8_24_rst <= op_mem_9_join_10_5_rst;
  op_mem_9_8_24_en <= op_mem_9_join_10_5_en;
  op_mem_10_8_24_next <= op_mem_9_8_24;
  op_mem_10_8_24_rst <= op_mem_10_join_10_5_rst;
  op_mem_10_8_24_en <= op_mem_10_join_10_5_en;
  op_mem_11_8_24_next <= op_mem_10_8_24;
  op_mem_11_8_24_rst <= op_mem_11_join_10_5_rst;
  op_mem_11_8_24_en <= op_mem_11_join_10_5_en;
  q <= std_logic_to_vector(op_mem_11_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_4e15eb9db8 is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_4e15eb9db8;
architecture behavior of sysgen_delay_4e15eb9db8
is
  signal d_1_22: std_logic;
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic;
  signal op_mem_0_8_24: std_logic := '0';
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_0_join_10_5: std_logic;
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
begin
  d_1_22 <= d(0);
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= '0';
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  q <= std_logic_to_vector(op_mem_0_8_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_dc7624ca49 is
  port (
    d : in std_logic_vector((16 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_dc7624ca49;
architecture behavior of sysgen_delay_dc7624ca49
is
  signal d_1_22: std_logic_vector((16 - 1) downto 0);
  signal en_1_25: std_logic;
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic_vector((16 - 1) downto 0);
  signal op_mem_0_8_24: std_logic_vector((16 - 1) downto 0) := "0000000000000000";
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_8_24_en: std_logic;
  signal op_mem_0_join_10_5: std_logic_vector((16 - 1) downto 0);
  signal op_mem_0_join_10_5_en: std_logic;
  signal op_mem_0_join_10_5_rst: std_logic;
begin
  d_1_22 <= d;
  en_1_25 <= en(0);
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= "0000000000000000";
      elsif ((ce = '1') and (op_mem_0_8_24_en = '1')) then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_if_10_5: process (d_1_22, en_1_25, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    elsif en_1_25 = '1' then
      op_mem_0_join_10_5_rst <= '0';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    if en_1_25 = '1' then
      op_mem_0_join_10_5_en <= '1';
    else 
      op_mem_0_join_10_5_en <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  op_mem_0_8_24_en <= op_mem_0_join_10_5_en;
  q <= op_mem_0_8_24;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_8802530b21 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_8802530b21;
architecture behavior of sysgen_mux_8802530b21
is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((16 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
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
entity sysgen_shift_918fbf292b is
  port (
    ip : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_918fbf292b;
architecture behavior of sysgen_shift_918fbf292b
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
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 29, 16, 15);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_shift_5de9bb9351 is
  port (
    ip : in std_logic_vector((63 - 1) downto 0);
    op : out std_logic_vector((17 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_shift_5de9bb9351;
architecture behavior of sysgen_shift_5de9bb9351
is
  signal ip_1_23: signed((63 - 1) downto 0);
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
  cast_internal_ip_33_3_convert <= s2s_cast(ip_1_23, 61, 17, 14);
  op_mem_46_20_push_front_pop_back_en <= '0';
  op <= signed_to_std_logic_vector(cast_internal_ip_33_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity axi_qpsk_tx_axi_lite_interface is 
    port(
        transfertime : out std_logic_vector(31 downto 0);
        transfersymbol : out std_logic_vector(31 downto 0);
        transferfft : out std_logic_vector(31 downto 0);
        simulateinterface : out std_logic_vector(31 downto 0);
        resettime : out std_logic_vector(31 downto 0);
        resetsymbol : out std_logic_vector(31 downto 0);
        resetfft : out std_logic_vector(31 downto 0);
        packetsizetime : out std_logic_vector(31 downto 0);
        packetsizesymbol : out std_logic_vector(31 downto 0);
        packetsizerf : out std_logic_vector(31 downto 0);
        packetsizefft : out std_logic_vector(31 downto 0);
        outputgain : out std_logic_vector(31 downto 0);
        lfsr_rst : out std_logic_vector(31 downto 0);
        enable : out std_logic_vector(31 downto 0);
        bypassgain : out std_logic_vector(31 downto 0);
        autorestarttime : out std_logic_vector(31 downto 0);
        autorestartsymbol : out std_logic_vector(31 downto 0);
        autorestartfft : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        axi_qpsk_tx_aclk : in std_logic;
        axi_qpsk_tx_aresetn : in std_logic;
        axi_qpsk_tx_s_axi_awaddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_tx_s_axi_awvalid : in std_logic;
        axi_qpsk_tx_s_axi_awready : out std_logic;
        axi_qpsk_tx_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axi_qpsk_tx_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axi_qpsk_tx_s_axi_wvalid : in std_logic;
        axi_qpsk_tx_s_axi_wready : out std_logic;
        axi_qpsk_tx_s_axi_bresp : out std_logic_vector(1 downto 0);
        axi_qpsk_tx_s_axi_bvalid : out std_logic;
        axi_qpsk_tx_s_axi_bready : in std_logic;
        axi_qpsk_tx_s_axi_araddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_tx_s_axi_arvalid : in std_logic;
        axi_qpsk_tx_s_axi_arready : out std_logic;
        axi_qpsk_tx_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axi_qpsk_tx_s_axi_rresp : out std_logic_vector(1 downto 0);
        axi_qpsk_tx_s_axi_rvalid : out std_logic;
        axi_qpsk_tx_s_axi_rready : in std_logic
    );
end axi_qpsk_tx_axi_lite_interface;
architecture structural of axi_qpsk_tx_axi_lite_interface is 
component axi_qpsk_tx_axi_lite_interface_verilog is
    port(
        transfertime : out std_logic_vector(31 downto 0);
        transfersymbol : out std_logic_vector(31 downto 0);
        transferfft : out std_logic_vector(31 downto 0);
        simulateinterface : out std_logic_vector(31 downto 0);
        resettime : out std_logic_vector(31 downto 0);
        resetsymbol : out std_logic_vector(31 downto 0);
        resetfft : out std_logic_vector(31 downto 0);
        packetsizetime : out std_logic_vector(31 downto 0);
        packetsizesymbol : out std_logic_vector(31 downto 0);
        packetsizerf : out std_logic_vector(31 downto 0);
        packetsizefft : out std_logic_vector(31 downto 0);
        outputgain : out std_logic_vector(31 downto 0);
        lfsr_rst : out std_logic_vector(31 downto 0);
        enable : out std_logic_vector(31 downto 0);
        bypassgain : out std_logic_vector(31 downto 0);
        autorestarttime : out std_logic_vector(31 downto 0);
        autorestartsymbol : out std_logic_vector(31 downto 0);
        autorestartfft : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        axi_qpsk_tx_aclk : in std_logic;
        axi_qpsk_tx_aresetn : in std_logic;
        axi_qpsk_tx_s_axi_awaddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_tx_s_axi_awvalid : in std_logic;
        axi_qpsk_tx_s_axi_awready : out std_logic;
        axi_qpsk_tx_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axi_qpsk_tx_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axi_qpsk_tx_s_axi_wvalid : in std_logic;
        axi_qpsk_tx_s_axi_wready : out std_logic;
        axi_qpsk_tx_s_axi_bresp : out std_logic_vector(1 downto 0);
        axi_qpsk_tx_s_axi_bvalid : out std_logic;
        axi_qpsk_tx_s_axi_bready : in std_logic;
        axi_qpsk_tx_s_axi_araddr : in std_logic_vector(7-1 downto 0);
        axi_qpsk_tx_s_axi_arvalid : in std_logic;
        axi_qpsk_tx_s_axi_arready : out std_logic;
        axi_qpsk_tx_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axi_qpsk_tx_s_axi_rresp : out std_logic_vector(1 downto 0);
        axi_qpsk_tx_s_axi_rvalid : out std_logic;
        axi_qpsk_tx_s_axi_rready : in std_logic
    );
end component;
begin
inst : axi_qpsk_tx_axi_lite_interface_verilog
    port map(
    transfertime => transfertime,
    transfersymbol => transfersymbol,
    transferfft => transferfft,
    simulateinterface => simulateinterface,
    resettime => resettime,
    resetsymbol => resetsymbol,
    resetfft => resetfft,
    packetsizetime => packetsizetime,
    packetsizesymbol => packetsizesymbol,
    packetsizerf => packetsizerf,
    packetsizefft => packetsizefft,
    outputgain => outputgain,
    lfsr_rst => lfsr_rst,
    enable => enable,
    bypassgain => bypassgain,
    autorestarttime => autorestarttime,
    autorestartsymbol => autorestartsymbol,
    autorestartfft => autorestartfft,
    clk => clk,
    axi_qpsk_tx_aclk => axi_qpsk_tx_aclk,
    axi_qpsk_tx_aresetn => axi_qpsk_tx_aresetn,
    axi_qpsk_tx_s_axi_awaddr => axi_qpsk_tx_s_axi_awaddr,
    axi_qpsk_tx_s_axi_awvalid => axi_qpsk_tx_s_axi_awvalid,
    axi_qpsk_tx_s_axi_awready => axi_qpsk_tx_s_axi_awready,
    axi_qpsk_tx_s_axi_wdata => axi_qpsk_tx_s_axi_wdata,
    axi_qpsk_tx_s_axi_wstrb => axi_qpsk_tx_s_axi_wstrb,
    axi_qpsk_tx_s_axi_wvalid => axi_qpsk_tx_s_axi_wvalid,
    axi_qpsk_tx_s_axi_wready => axi_qpsk_tx_s_axi_wready,
    axi_qpsk_tx_s_axi_bresp => axi_qpsk_tx_s_axi_bresp,
    axi_qpsk_tx_s_axi_bvalid => axi_qpsk_tx_s_axi_bvalid,
    axi_qpsk_tx_s_axi_bready => axi_qpsk_tx_s_axi_bready,
    axi_qpsk_tx_s_axi_araddr => axi_qpsk_tx_s_axi_araddr,
    axi_qpsk_tx_s_axi_arvalid => axi_qpsk_tx_s_axi_arvalid,
    axi_qpsk_tx_s_axi_arready => axi_qpsk_tx_s_axi_arready,
    axi_qpsk_tx_s_axi_rdata => axi_qpsk_tx_s_axi_rdata,
    axi_qpsk_tx_s_axi_rresp => axi_qpsk_tx_s_axi_rresp,
    axi_qpsk_tx_s_axi_rvalid => axi_qpsk_tx_s_axi_rvalid,
    axi_qpsk_tx_s_axi_rready => axi_qpsk_tx_s_axi_rready
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

entity axi_qpsk_tx_xladdsub is 
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
 end axi_qpsk_tx_xladdsub;
 
 architecture behavior of axi_qpsk_tx_xladdsub is 
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


 component axi_qpsk_tx_c_addsub_v12_0_i0
    port ( 
    a: in std_logic_vector(65 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(65 - 1 downto 0) 
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


 comp0: if ((core_name0 = "axi_qpsk_tx_c_addsub_v12_0_i0")) generate 
  core_instance0:axi_qpsk_tx_c_addsub_v12_0_i0
   port map ( 
         a => full_a,
         clk => clk,
         ce => internal_ce,
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

entity axi_qpsk_tx_xlcmult is 
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
 end axi_qpsk_tx_xlcmult;
 
 architecture behavior of axi_qpsk_tx_xlcmult is
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


 component axi_qpsk_tx_mult_gen_v12_0_i0
    port ( 
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component axi_qpsk_tx_mult_gen_v12_0_i1
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


 comp0: if ((core_name0 = "axi_qpsk_tx_mult_gen_v12_0_i0")) generate 
  core_instance0:axi_qpsk_tx_mult_gen_v12_0_i0
   port map ( 
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp1: if ((core_name0 = "axi_qpsk_tx_mult_gen_v12_0_i1")) generate 
  core_instance1:axi_qpsk_tx_mult_gen_v12_0_i1
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

entity axi_qpsk_tx_xlcounter_free is 
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
 end axi_qpsk_tx_xlcounter_free;
 
 architecture behavior of axi_qpsk_tx_xlcounter_free is


 component axi_qpsk_tx_c_counter_binary_v12_0_i0
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


 comp0: if ((core_name0 = "axi_qpsk_tx_c_counter_binary_v12_0_i0")) generate 
  core_instance0:axi_qpsk_tx_c_counter_binary_v12_0_i0
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
 --  Filename      : xlcounter.vhd
 --
 --  Created       : 5/31/00
 --  Modified      : 6/7/00
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
 use IEEE.numeric_std.all;

entity axi_qpsk_tx_xlcounter_limit is 
   generic (
     core_name0: string := "";
     op_width: integer := 5;
     op_arith: integer := xlSigned;
     cnt_63_48: integer:= 0;
     cnt_47_32: integer:= 0;
     cnt_31_16: integer:= 0;
     cnt_15_0: integer:= 0;
     count_limited: integer := 0		-- 0 if cnt_to = (2^n)-1 else 1
   );
   port (
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     op: out std_logic_vector(op_width - 1 downto 0);
     up: in std_logic_vector(0 downto 0) := (others => '0');
     en: in std_logic_vector(0 downto 0);
     rst: in std_logic_vector(0 downto 0)
   );
 end axi_qpsk_tx_xlcounter_limit;
 
 architecture behavior of axi_qpsk_tx_xlcounter_limit is
 signal high_cnt_to: std_logic_vector(31 downto 0);
 signal low_cnt_to: std_logic_vector(31 downto 0);
 signal cnt_to: std_logic_vector(63 downto 0);
 signal core_sinit, op_thresh0, core_ce: std_logic;
 signal rst_overrides_en: std_logic;
 signal op_net: std_logic_vector(op_width - 1 downto 0);
 
 -- synthesis translate_off
 signal real_op : real; -- For debugging info ports
 -- synthesis translate_on
 
 function equals(op, cnt_to : std_logic_vector; width, arith : integer)
 return std_logic
 is
 variable signed_op, signed_cnt_to : signed (width - 1 downto 0);
 variable unsigned_op, unsigned_cnt_to : unsigned (width - 1 downto 0);
 variable result : std_logic;
 begin
 -- synthesis translate_off
 if ((is_XorU(op)) or (is_XorU(cnt_to)) ) then
 result := '0';
 return result;
 end if;
 -- synthesis translate_on
 
 if (op = cnt_to) then
 result := '1';
 else
 result := '0';
 end if;
 return result;
 end;


 component axi_qpsk_tx_c_counter_binary_v12_0_i1
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0) 
 		  ); 
 end component;

-- synthesis translate_off
   constant zeroVec : std_logic_vector(op_width - 1 downto 0) := (others => '0');
   constant oneVec : std_logic_vector(op_width - 1 downto 0) := (others => '1');
   constant zeroStr : string(1 to op_width) :=
     std_logic_vector_to_bin_string(zeroVec);
   constant oneStr : string(1 to op_width) :=
     std_logic_vector_to_bin_string(oneVec);
 -- synthesis translate_on
 
 begin
   -- Debugging info for internal full precision variables
   -- synthesis translate_off
 --     real_op <= to_real(op, op_bin_pt, op_arith);
   -- synthesis translate_on
 
   cnt_to(63 downto 48) <= integer_to_std_logic_vector(cnt_63_48, 16, op_arith);
   cnt_to(47 downto 32) <= integer_to_std_logic_vector(cnt_47_32, 16, op_arith);
   cnt_to(31 downto 16) <= integer_to_std_logic_vector(cnt_31_16, 16, op_arith);
   cnt_to(15 downto 0) <= integer_to_std_logic_vector(cnt_15_0, 16, op_arith);
 
   -- Output of counter always valid
   op <= op_net;
   core_ce <= ce and en(0);
   rst_overrides_en <= rst(0) or en(0);
 
   limit : if (count_limited = 1) generate
     eq_cnt_to : process (op_net, cnt_to)
     begin
       -- Had to pass cnt_to(op_width - 1 downto 0) instead of cnt_to so
       -- that XST would infer a macro
       op_thresh0 <= equals(op_net, cnt_to(op_width - 1 downto 0),
                      op_width, op_arith);
     end process;
 
     core_sinit <= (op_thresh0 or clr or rst(0)) and ce and rst_overrides_en;
   end generate;
 
   no_limit : if (count_limited = 0) generate
     core_sinit <= (clr or rst(0)) and ce and rst_overrides_en;
   end generate;


 comp0: if ((core_name0 = "axi_qpsk_tx_c_counter_binary_v12_0_i1")) generate 
  core_instance0:axi_qpsk_tx_c_counter_binary_v12_0_i1
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

entity axi_qpsk_tx_xlfifogen_u is 
   generic (
     core_name0: string := "";
     data_width: integer := -1;
     data_count_width: integer := -1;
     percent_full_width: integer := -1;
     has_ae : integer := 0;
     has_af : integer := 0;
     extra_registers: integer := 0;
     ignore_din_for_gcd: boolean := false;
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
 end axi_qpsk_tx_xlfifogen_u;
 
 architecture behavior of axi_qpsk_tx_xlfifogen_u is
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
 component synth_reg_w_init 
 generic (width : integer;
 init_index : integer; 
 init_value : bit_vector; 
 latency : integer); 
 port (i : in std_logic_vector(width-1 downto 0); 
 ce : in std_logic; 
 clr : in std_logic; 
 clk : in std_logic; 
 o : out std_logic_vector(width-1 downto 0)); 
 end component; 
 


 component axi_qpsk_tx_fifo_generator_i0
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

 component axi_qpsk_tx_fifo_generator_i1
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

 component axi_qpsk_tx_fifo_generator_i2
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
   signal ae_vec: std_logic_vector(0 downto 0); 
   signal af_vec: std_logic_vector(0 downto 0); 
   signal ae_out: std_logic_vector(0 downto 0); 
   signal af_out: std_logic_vector(0 downto 0); 
 
 begin
 

 comp0: if ((core_name0 = "axi_qpsk_tx_fifo_generator_i0")) generate 
  core_instance0:axi_qpsk_tx_fifo_generator_i0
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

 comp1: if ((core_name0 = "axi_qpsk_tx_fifo_generator_i1")) generate 
  core_instance1:axi_qpsk_tx_fifo_generator_i1
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

 comp2: if ((core_name0 = "axi_qpsk_tx_fifo_generator_i2")) generate 
  core_instance2:axi_qpsk_tx_fifo_generator_i2
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
 
  ae_vec(0) <= ae_net;
  af_vec(0) <= af_net;
 multi_sample: if (ignore_din_for_gcd) generate 
    reg1: synth_reg_w_init 
    generic map (width      => 1, 
    init_index => 2, 
    init_value => "1", 
    latency    => 1) 
    port map (i   => ae_vec, 
    ce  => ce, 
    clr => srst_vec(0), 
    clk => clk, 
    o   => ae_out); 
    reg2: synth_reg_w_init 
    generic map (width      => 1, 
    init_index => 2, 
    init_value => "0", 
    latency    => 1) 
    port map (i   => af_vec, 
    ce  => ce, 
    clr => srst_vec(0), 
    clk => clk, 
    o   => af_out); 
  end generate; 
  not_multi: if (ignore_din_for_gcd = false) generate 
 begin 
 af_out <= af_vec; 
  ae_out <= ae_vec; 
  end generate; 
 latency_eq_0: if (extra_registers = 0) generate
   srst <= rst and ce;
 end generate;
 
    process (dout_net, empty_net, core_full, core_dcount, ae_out(0), af_out(0), re, we, en, re_ce, we_ce) is 
    begin 
        dout <= dout_net; 
        empty <= empty_net; 
        full <= core_full; 
        dcount <= core_dcount;
        ae <= ae_out(0);
        af <= af_out(0);
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

entity xlaxi_qpsk_tx_xfft_v9_1_i0_9e77893c2c1664cd2aaf98da31d19f65 is 
  port(
    ce:in std_logic;
    clk:in std_logic;
    in_im:in std_logic_vector(31 downto 0);
    in_re:in std_logic_vector(31 downto 0);
    op_im:out std_logic_vector(31 downto 0);
    op_re:out std_logic_vector(31 downto 0)
  );
end xlaxi_qpsk_tx_xfft_v9_1_i0_9e77893c2c1664cd2aaf98da31d19f65; 

architecture behavior of xlaxi_qpsk_tx_xfft_v9_1_i0_9e77893c2c1664cd2aaf98da31d19f65  is
  component axi_qpsk_tx_xfft_v9_1_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      event_frame_started:out std_logic;
      m_axis_data_tdata:out std_logic_vector(63 downto 0);
      m_axis_data_tlast:out std_logic;
      m_axis_data_tready:in std_logic;
      m_axis_data_tvalid:out std_logic;
      s_axis_config_tdata:in std_logic_vector(15 downto 0);
      s_axis_config_tready:out std_logic;
      s_axis_config_tvalid:in std_logic;
      s_axis_data_tdata:in std_logic_vector(63 downto 0);
      s_axis_data_tlast:in std_logic;
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal event_frame_started: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(63 downto 0) := (others=>'0');
signal m_axis_data_tlast: std_logic := '0';
signal m_axis_data_tvalid: std_logic := '0';
signal s_axis_config_tready: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(63 downto 0) := (others=>'0');
signal s_axis_data_tready: std_logic := '0';
begin
  op_im <= m_axis_data_tdata_net(63 downto 32);
  op_re <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(63 downto 32) <= in_im;
  s_axis_data_tdata_net(31 downto 0) <= in_re;
  axi_qpsk_tx_xfft_v9_1_i0_instance : axi_qpsk_tx_xfft_v9_1_i0
    port map(
      aclk=>clk,
      aclken=>ce,
      event_frame_started=>event_frame_started,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tlast=>m_axis_data_tlast,
      m_axis_data_tready=>'1',
      m_axis_data_tvalid=>m_axis_data_tvalid,
      s_axis_config_tdata=>b"0000010101010111",
      s_axis_config_tready=>s_axis_config_tready,
      s_axis_config_tvalid=>'1',
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tlast=>'0',
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>'1'
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlcic_compiler_bd96f07ecb101ec9bf7973ba13350218 is 
  port(
    ce:in std_logic;
    ce_3200:in std_logic;
    ce_logic_3200:in std_logic;
    clk:in std_logic;
    clk_3200:in std_logic;
    clk_logic_3200:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(62 downto 0);
    m_axis_data_tvalid:out std_logic;
    rst:in std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic
  );
end xlcic_compiler_bd96f07ecb101ec9bf7973ba13350218; 

architecture behavior of xlcic_compiler_bd96f07ecb101ec9bf7973ba13350218  is
  component axi_qpsk_tx_cic_compiler_v4_0_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      aresetn:in std_logic;
      m_axis_data_tdata:out std_logic_vector(63 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal aresetn_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(63 downto 0) := (others=>'0');
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
begin
  aclken_net <= en and ce;
  aresetn_net <= rst or (not ce);
  m_axis_data_tdata_real <= m_axis_data_tdata_net(62 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  axi_qpsk_tx_cic_compiler_v4_0_i0_instance : axi_qpsk_tx_cic_compiler_v4_0_i0
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      aresetn=>aresetn_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid,
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

entity xlfir_compiler_8aa1be8134864fd230e82f2d099cbb8c is 
  port(
    ce:in std_logic;
    ce_12800:in std_logic;
    ce_51200:in std_logic;
    ce_logic_51200:in std_logic;
    clk:in std_logic;
    clk_12800:in std_logic;
    clk_51200:in std_logic;
    clk_logic_51200:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(30 downto 0);
    m_axis_data_tvalid:out std_logic;
    rst:in std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_8aa1be8134864fd230e82f2d099cbb8c; 

architecture behavior of xlfir_compiler_8aa1be8134864fd230e82f2d099cbb8c  is
  component axi_qpsk_tx_fir_compiler_v7_2_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      aresetn:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal aresetn_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(30 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_rst_12800_net: std_logic := '0';
signal internal_en_12800_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  aresetn_net <= rst or (not ce);
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(30 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_rst_12800_net <= (not rst) and ce_12800;
  internal_en_12800_net <= en and ce_12800;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 31,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_12800_net,
        clr => internal_rst_12800_net,
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
        clr => internal_rst_12800_net,
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
        clr => internal_rst_12800_net,
        clk => clk_12800, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_tx_fir_compiler_v7_2_i0_instance : axi_qpsk_tx_fir_compiler_v7_2_i0
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      aresetn=>aresetn_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_51200
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_0594fca8ca3a26bfbd7d44163f1435d5 is 
  port(
    ce:in std_logic;
    ce_12800:in std_logic;
    ce_6400:in std_logic;
    ce_logic_12800:in std_logic;
    clk:in std_logic;
    clk_12800:in std_logic;
    clk_6400:in std_logic;
    clk_logic_12800:in std_logic;
    en:in std_logic;
    m_axis_data_tdata_real:out std_logic_vector(31 downto 0);
    m_axis_data_tvalid:out std_logic;
    rst:in std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_0594fca8ca3a26bfbd7d44163f1435d5; 

architecture behavior of xlfir_compiler_0594fca8ca3a26bfbd7d44163f1435d5  is
  component axi_qpsk_tx_fir_compiler_v7_2_i1
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      aresetn:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal aresetn_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(31 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_rst_6400_net: std_logic := '0';
signal internal_en_6400_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  aresetn_net <= rst or (not ce);
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(31 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_rst_6400_net <= (not rst) and ce_6400;
  internal_en_6400_net <= en and ce_6400;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 32,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_6400_net,
        clr => internal_rst_6400_net,
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
        clr => internal_rst_6400_net,
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
        clr => internal_rst_6400_net,
        clk => clk_6400, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_tx_fir_compiler_v7_2_i1_instance : axi_qpsk_tx_fir_compiler_v7_2_i1
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      aresetn=>aresetn_net,
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

entity xlfir_compiler_cf96ac93db02076c760a12cc085f9781 is 
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
    m_axis_data_tdata_real:out std_logic_vector(32 downto 0);
    m_axis_data_tvalid:out std_logic;
    rst:in std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_cf96ac93db02076c760a12cc085f9781; 

architecture behavior of xlfir_compiler_cf96ac93db02076c760a12cc085f9781  is
  component axi_qpsk_tx_fir_compiler_v7_2_i2
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      aresetn:in std_logic;
      m_axis_data_tdata:out std_logic_vector(39 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic
    );
end component;
signal aclken_net: std_logic := '0';
signal aresetn_net: std_logic := '0';
signal m_axis_data_tdata_net: std_logic_vector(39 downto 0) := (others=>'0');
signal m_axis_data_tdata_real_ps_net: std_logic_vector(32 downto 0) := (others=>'0');
signal m_axis_data_tvalid_ps_net: std_logic := '0';
signal m_axis_data_tvalid_ps_net_captured: std_logic := '0';
signal m_axis_data_tvalid_ps_net_or_captured_net: std_logic := '0';
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal internal_rst_3200_net: std_logic := '0';
signal internal_en_3200_net: std_logic := '0';
begin
  aclken_net <= en and ce;
  aresetn_net <= rst or (not ce);
  m_axis_data_tdata_real_ps_net <= m_axis_data_tdata_net(32 downto 0);
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  internal_rst_3200_net <= (not rst) and ce_3200;
  internal_en_3200_net <= en and ce_3200;
  m_axis_data_tdata_real_ps_net_synchronizer : entity work.synth_reg_w_init
    generic map(
        width => 33,
        init_index => 0,
        init_value => "0",
        latency => 1
    )
    port map (
        i => m_axis_data_tdata_real_ps_net,
        ce => internal_en_3200_net,
        clr => internal_rst_3200_net,
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
        clr => internal_rst_3200_net,
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
        clr => internal_rst_3200_net,
        clk => clk_3200, 
        o(0) => m_axis_data_tvalid_ps_net_captured
    );
  axi_qpsk_tx_fir_compiler_v7_2_i2_instance : axi_qpsk_tx_fir_compiler_v7_2_i2
    port map(
      aclk=>clk,
      aclken=>aclken_net,
      aresetn=>aresetn_net,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid_ps_net,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_6400
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

entity axi_qpsk_tx_xlmult is 
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
 end  axi_qpsk_tx_xlmult;
 
 architecture behavior of axi_qpsk_tx_xlmult is
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


 component axi_qpsk_tx_mult_gen_v12_0_i2
    port ( 
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
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


 comp0: if ((core_name0 = "axi_qpsk_tx_mult_gen_v12_0_i2")) generate 
  core_instance0:axi_qpsk_tx_mult_gen_v12_0_i2
   port map ( 
        a => tmp_a,
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

