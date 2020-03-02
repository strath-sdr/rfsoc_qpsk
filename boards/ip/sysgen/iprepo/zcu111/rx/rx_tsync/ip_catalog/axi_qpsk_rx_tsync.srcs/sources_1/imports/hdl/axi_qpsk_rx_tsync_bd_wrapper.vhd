--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
--Date        : Mon Mar  2 14:32:50 2020
--Host        : eee-dsp22 running 64-bit Ubuntu 18.04.3 LTS
--Command     : generate_target axi_qpsk_rx_tsync_bd_wrapper.bd
--Design      : axi_qpsk_rx_tsync_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_qpsk_rx_tsync_bd_wrapper is
  port (
    CLK_IN1_D_clk_n : in STD_LOGIC;
    CLK_IN1_D_clk_p : in STD_LOGIC;
    m_axis_tap_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tap_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tap_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tap_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset_rtl : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end axi_qpsk_rx_tsync_bd_wrapper;

architecture STRUCTURE of axi_qpsk_rx_tsync_bd_wrapper is
  component axi_qpsk_rx_tsync_bd is
  port (
    CLK_IN1_D_clk_n : in STD_LOGIC;
    CLK_IN1_D_clk_p : in STD_LOGIC;
    reset_rtl : in STD_LOGIC;
    m_axis_tap_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tap_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tap_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tap_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component axi_qpsk_rx_tsync_bd;
begin
axi_qpsk_rx_tsync_bd_i: component axi_qpsk_rx_tsync_bd
     port map (
      CLK_IN1_D_clk_n => CLK_IN1_D_clk_n,
      CLK_IN1_D_clk_p => CLK_IN1_D_clk_p,
      m_axis_tap_tdata(31 downto 0) => m_axis_tap_tdata(31 downto 0),
      m_axis_tap_tlast(0) => m_axis_tap_tlast(0),
      m_axis_tap_tready(0) => m_axis_tap_tready(0),
      m_axis_tap_tvalid(0) => m_axis_tap_tvalid(0),
      reset_rtl => reset_rtl,
      s_axis_tdata(31 downto 0) => s_axis_tdata(31 downto 0),
      s_axis_tvalid(0) => s_axis_tvalid(0)
    );
end STRUCTURE;
