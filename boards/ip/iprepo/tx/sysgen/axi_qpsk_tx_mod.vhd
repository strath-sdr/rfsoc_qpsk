-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity axi_qpsk_tx_stub is
  port (
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_fft_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_time_axis_tready : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    axi_qpsk_tx_aresetn : in std_logic;
    axi_qpsk_tx_s_axi_awaddr : in std_logic_vector( 7-1 downto 0 );
    axi_qpsk_tx_s_axi_awvalid : in std_logic;
    axi_qpsk_tx_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    axi_qpsk_tx_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    axi_qpsk_tx_s_axi_wvalid : in std_logic;
    axi_qpsk_tx_s_axi_bready : in std_logic;
    axi_qpsk_tx_s_axi_araddr : in std_logic_vector( 7-1 downto 0 );
    axi_qpsk_tx_s_axi_arvalid : in std_logic;
    axi_qpsk_tx_s_axi_rready : in std_logic;
    m_rf_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_rf_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_rf_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_fft_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_fft_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_fft_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tdata : out std_logic_vector( 8-1 downto 0 );
    m_symbol_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_time_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_time_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_time_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    axi_qpsk_tx_s_axi_awready : out std_logic;
    axi_qpsk_tx_s_axi_wready : out std_logic;
    axi_qpsk_tx_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_tx_s_axi_bvalid : out std_logic;
    axi_qpsk_tx_s_axi_arready : out std_logic;
    axi_qpsk_tx_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    axi_qpsk_tx_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_tx_s_axi_rvalid : out std_logic
  );
end axi_qpsk_tx_stub;
architecture structural of axi_qpsk_tx_stub is 
begin
  sysgen_dut : entity xil_defaultlib.axi_qpsk_tx_0 
  port map (
    m_rf_axis_tready => m_rf_axis_tready,
    m_fft_axis_tready => m_fft_axis_tready,
    m_symbol_axis_tready => m_symbol_axis_tready,
    m_time_axis_tready => m_time_axis_tready,
    clk => clk,
    axi_qpsk_tx_aresetn => axi_qpsk_tx_aresetn,
    axi_qpsk_tx_s_axi_awaddr => axi_qpsk_tx_s_axi_awaddr,
    axi_qpsk_tx_s_axi_awvalid => axi_qpsk_tx_s_axi_awvalid,
    axi_qpsk_tx_s_axi_wdata => axi_qpsk_tx_s_axi_wdata,
    axi_qpsk_tx_s_axi_wstrb => axi_qpsk_tx_s_axi_wstrb,
    axi_qpsk_tx_s_axi_wvalid => axi_qpsk_tx_s_axi_wvalid,
    axi_qpsk_tx_s_axi_bready => axi_qpsk_tx_s_axi_bready,
    axi_qpsk_tx_s_axi_araddr => axi_qpsk_tx_s_axi_araddr,
    axi_qpsk_tx_s_axi_arvalid => axi_qpsk_tx_s_axi_arvalid,
    axi_qpsk_tx_s_axi_rready => axi_qpsk_tx_s_axi_rready,
    m_rf_axis_tdata => m_rf_axis_tdata,
    m_rf_axis_tlast => m_rf_axis_tlast,
    m_rf_axis_tvalid => m_rf_axis_tvalid,
    m_fft_axis_tdata => m_fft_axis_tdata,
    m_fft_axis_tlast => m_fft_axis_tlast,
    m_fft_axis_tvalid => m_fft_axis_tvalid,
    m_symbol_axis_tdata => m_symbol_axis_tdata,
    m_symbol_axis_tlast => m_symbol_axis_tlast,
    m_symbol_axis_tvalid => m_symbol_axis_tvalid,
    m_time_axis_tdata => m_time_axis_tdata,
    m_time_axis_tlast => m_time_axis_tlast,
    m_time_axis_tvalid => m_time_axis_tvalid,
    axi_qpsk_tx_s_axi_awready => axi_qpsk_tx_s_axi_awready,
    axi_qpsk_tx_s_axi_wready => axi_qpsk_tx_s_axi_wready,
    axi_qpsk_tx_s_axi_bresp => axi_qpsk_tx_s_axi_bresp,
    axi_qpsk_tx_s_axi_bvalid => axi_qpsk_tx_s_axi_bvalid,
    axi_qpsk_tx_s_axi_arready => axi_qpsk_tx_s_axi_arready,
    axi_qpsk_tx_s_axi_rdata => axi_qpsk_tx_s_axi_rdata,
    axi_qpsk_tx_s_axi_rresp => axi_qpsk_tx_s_axi_rresp,
    axi_qpsk_tx_s_axi_rvalid => axi_qpsk_tx_s_axi_rvalid
  );
end structural;
