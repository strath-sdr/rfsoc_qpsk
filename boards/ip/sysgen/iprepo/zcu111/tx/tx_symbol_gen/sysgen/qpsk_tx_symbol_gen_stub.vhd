-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity qpsk_tx_symbol_gen_stub is
  port (
    m_symbol_axis_tready : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    qpsk_tx_symbol_gen_aresetn : in std_logic;
    qpsk_tx_symbol_gen_s_axi_awaddr : in std_logic_vector( 6-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_awvalid : in std_logic;
    qpsk_tx_symbol_gen_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_wvalid : in std_logic;
    qpsk_tx_symbol_gen_s_axi_bready : in std_logic;
    qpsk_tx_symbol_gen_s_axi_araddr : in std_logic_vector( 6-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_arvalid : in std_logic;
    qpsk_tx_symbol_gen_s_axi_rready : in std_logic;
    m_symbol_axis_tdata_x0 : out std_logic_vector( 8-1 downto 0 );
    m_symbol_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tvalid_x0 : out std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tdata : out std_logic_vector( 8-1 downto 0 );
    m_symbol_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_awready : out std_logic;
    qpsk_tx_symbol_gen_s_axi_wready : out std_logic;
    qpsk_tx_symbol_gen_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_bvalid : out std_logic;
    qpsk_tx_symbol_gen_s_axi_arready : out std_logic;
    qpsk_tx_symbol_gen_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    qpsk_tx_symbol_gen_s_axi_rvalid : out std_logic
  );
end qpsk_tx_symbol_gen_stub;
architecture structural of qpsk_tx_symbol_gen_stub is 
begin
  sysgen_dut : entity xil_defaultlib.qpsk_tx_symbol_gen 
  port map (
    m_symbol_axis_tready => m_symbol_axis_tready,
    clk => clk,
    qpsk_tx_symbol_gen_aresetn => qpsk_tx_symbol_gen_aresetn,
    qpsk_tx_symbol_gen_s_axi_awaddr => qpsk_tx_symbol_gen_s_axi_awaddr,
    qpsk_tx_symbol_gen_s_axi_awvalid => qpsk_tx_symbol_gen_s_axi_awvalid,
    qpsk_tx_symbol_gen_s_axi_wdata => qpsk_tx_symbol_gen_s_axi_wdata,
    qpsk_tx_symbol_gen_s_axi_wstrb => qpsk_tx_symbol_gen_s_axi_wstrb,
    qpsk_tx_symbol_gen_s_axi_wvalid => qpsk_tx_symbol_gen_s_axi_wvalid,
    qpsk_tx_symbol_gen_s_axi_bready => qpsk_tx_symbol_gen_s_axi_bready,
    qpsk_tx_symbol_gen_s_axi_araddr => qpsk_tx_symbol_gen_s_axi_araddr,
    qpsk_tx_symbol_gen_s_axi_arvalid => qpsk_tx_symbol_gen_s_axi_arvalid,
    qpsk_tx_symbol_gen_s_axi_rready => qpsk_tx_symbol_gen_s_axi_rready,
    m_symbol_axis_tdata_x0 => m_symbol_axis_tdata_x0,
    m_symbol_axis_tlast => m_symbol_axis_tlast,
    m_symbol_axis_tvalid_x0 => m_symbol_axis_tvalid_x0,
    m_symbol_axis_tdata => m_symbol_axis_tdata,
    m_symbol_axis_tvalid => m_symbol_axis_tvalid,
    qpsk_tx_symbol_gen_s_axi_awready => qpsk_tx_symbol_gen_s_axi_awready,
    qpsk_tx_symbol_gen_s_axi_wready => qpsk_tx_symbol_gen_s_axi_wready,
    qpsk_tx_symbol_gen_s_axi_bresp => qpsk_tx_symbol_gen_s_axi_bresp,
    qpsk_tx_symbol_gen_s_axi_bvalid => qpsk_tx_symbol_gen_s_axi_bvalid,
    qpsk_tx_symbol_gen_s_axi_arready => qpsk_tx_symbol_gen_s_axi_arready,
    qpsk_tx_symbol_gen_s_axi_rdata => qpsk_tx_symbol_gen_s_axi_rdata,
    qpsk_tx_symbol_gen_s_axi_rresp => qpsk_tx_symbol_gen_s_axi_rresp,
    qpsk_tx_symbol_gen_s_axi_rvalid => qpsk_tx_symbol_gen_s_axi_rvalid
  );
end structural;
