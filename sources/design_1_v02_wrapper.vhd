--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Fri Jan 11 15:22:50 2019
--Host        : eee-dsp22 running 64-bit Ubuntu 16.04.5 LTS
--Command     : generate_target design_1_v02_wrapper.bd
--Design      : design_1_v02_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_v02_wrapper is
  port (
    adc0_clk_clk_n : in STD_LOGIC;
    adc0_clk_clk_p : in STD_LOGIC;
    dac1_clk_clk_n : in STD_LOGIC;
    dac1_clk_clk_p : in STD_LOGIC;
    reset : in STD_LOGIC;
    sysref_in_diff_n : in STD_LOGIC;
    sysref_in_diff_p : in STD_LOGIC;
    vin0_01_v_n : in STD_LOGIC;
    vin0_01_v_p : in STD_LOGIC;
    vout12_v_n : out STD_LOGIC;
    vout12_v_p : out STD_LOGIC
  );
end design_1_v02_wrapper;

architecture STRUCTURE of design_1_v02_wrapper is
  component design_1_v02 is
  port (
    reset : in STD_LOGIC;
    adc0_clk_clk_n : in STD_LOGIC;
    adc0_clk_clk_p : in STD_LOGIC;
    dac1_clk_clk_n : in STD_LOGIC;
    dac1_clk_clk_p : in STD_LOGIC;
    sysref_in_diff_n : in STD_LOGIC;
    sysref_in_diff_p : in STD_LOGIC;
    vout12_v_n : out STD_LOGIC;
    vout12_v_p : out STD_LOGIC;
    vin0_01_v_n : in STD_LOGIC;
    vin0_01_v_p : in STD_LOGIC
  );
  end component design_1_v02;
begin
design_1_v02_i: component design_1_v02
     port map (
      adc0_clk_clk_n => adc0_clk_clk_n,
      adc0_clk_clk_p => adc0_clk_clk_p,
      dac1_clk_clk_n => dac1_clk_clk_n,
      dac1_clk_clk_p => dac1_clk_clk_p,
      reset => reset,
      sysref_in_diff_n => sysref_in_diff_n,
      sysref_in_diff_p => sysref_in_diff_p,
      vin0_01_v_n => vin0_01_v_n,
      vin0_01_v_p => vin0_01_v_p,
      vout12_v_n => vout12_v_n,
      vout12_v_p => vout12_v_p
    );
end STRUCTURE;
