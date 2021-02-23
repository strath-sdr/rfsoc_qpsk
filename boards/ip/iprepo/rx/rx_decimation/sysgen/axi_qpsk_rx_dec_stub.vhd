-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity axi_qpsk_rx_dec_stub is
  port (
    s_i_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_i_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_q_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_q_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    axi_qpsk_rx_dec_aresetn : in std_logic;
    axi_qpsk_rx_dec_s_axi_awaddr : in std_logic_vector( 5-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_awvalid : in std_logic;
    axi_qpsk_rx_dec_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_wvalid : in std_logic;
    axi_qpsk_rx_dec_s_axi_bready : in std_logic;
    axi_qpsk_rx_dec_s_axi_araddr : in std_logic_vector( 5-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_arvalid : in std_logic;
    axi_qpsk_rx_dec_s_axi_rready : in std_logic;
    s_i_axis_tready : out std_logic_vector( 1-1 downto 0 );
    s_q_axis_tready : out std_logic_vector( 1-1 downto 0 );
    m_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tlast : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tvalid : out std_logic_vector( 1-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_awready : out std_logic;
    axi_qpsk_rx_dec_s_axi_wready : out std_logic;
    axi_qpsk_rx_dec_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_bvalid : out std_logic;
    axi_qpsk_rx_dec_s_axi_arready : out std_logic;
    axi_qpsk_rx_dec_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_dec_s_axi_rvalid : out std_logic
  );
end axi_qpsk_rx_dec_stub;
architecture structural of axi_qpsk_rx_dec_stub is 
begin
  sysgen_dut : entity xil_defaultlib.axi_qpsk_rx_dec 
  port map (
    s_i_axis_tdata => s_i_axis_tdata,
    s_i_axis_tvalid => s_i_axis_tvalid,
    s_q_axis_tdata => s_q_axis_tdata,
    s_q_axis_tvalid => s_q_axis_tvalid,
    m_axis_tap_tready => m_axis_tap_tready,
    clk => clk,
    axi_qpsk_rx_dec_aresetn => axi_qpsk_rx_dec_aresetn,
    axi_qpsk_rx_dec_s_axi_awaddr => axi_qpsk_rx_dec_s_axi_awaddr,
    axi_qpsk_rx_dec_s_axi_awvalid => axi_qpsk_rx_dec_s_axi_awvalid,
    axi_qpsk_rx_dec_s_axi_wdata => axi_qpsk_rx_dec_s_axi_wdata,
    axi_qpsk_rx_dec_s_axi_wstrb => axi_qpsk_rx_dec_s_axi_wstrb,
    axi_qpsk_rx_dec_s_axi_wvalid => axi_qpsk_rx_dec_s_axi_wvalid,
    axi_qpsk_rx_dec_s_axi_bready => axi_qpsk_rx_dec_s_axi_bready,
    axi_qpsk_rx_dec_s_axi_araddr => axi_qpsk_rx_dec_s_axi_araddr,
    axi_qpsk_rx_dec_s_axi_arvalid => axi_qpsk_rx_dec_s_axi_arvalid,
    axi_qpsk_rx_dec_s_axi_rready => axi_qpsk_rx_dec_s_axi_rready,
    s_i_axis_tready => s_i_axis_tready,
    s_q_axis_tready => s_q_axis_tready,
    m_axis_tdata => m_axis_tdata,
    m_axis_tvalid => m_axis_tvalid,
    m_axis_tap_tdata => m_axis_tap_tdata,
    m_axis_tap_tlast => m_axis_tap_tlast,
    m_axis_tap_tvalid => m_axis_tap_tvalid,
    axi_qpsk_rx_dec_s_axi_awready => axi_qpsk_rx_dec_s_axi_awready,
    axi_qpsk_rx_dec_s_axi_wready => axi_qpsk_rx_dec_s_axi_wready,
    axi_qpsk_rx_dec_s_axi_bresp => axi_qpsk_rx_dec_s_axi_bresp,
    axi_qpsk_rx_dec_s_axi_bvalid => axi_qpsk_rx_dec_s_axi_bvalid,
    axi_qpsk_rx_dec_s_axi_arready => axi_qpsk_rx_dec_s_axi_arready,
    axi_qpsk_rx_dec_s_axi_rdata => axi_qpsk_rx_dec_s_axi_rdata,
    axi_qpsk_rx_dec_s_axi_rresp => axi_qpsk_rx_dec_s_axi_rresp,
    axi_qpsk_rx_dec_s_axi_rvalid => axi_qpsk_rx_dec_s_axi_rvalid
  );
end structural;
