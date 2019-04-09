-- Generated from Simulink block axi_qpsk_rx_dec/Data Inspector/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec_axi_write_interface is
  port (
    int_reset : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_25600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_dec_axi_write_interface;
architecture structural of axi_qpsk_rx_dec_axi_write_interface is 
  signal clk_net : std_logic;
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal we_ce_net : std_logic;
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 9-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice1_y_net <= int_reset;
  slice3_y_net <= transfer;
  slice2_y_net <= auto_restart;
  packetsizerf_net <= packet_size;
  concat_y_net <= tdata_in;
  logical1_y_net_x0 <= tvalid_in;
  m_axis_tap_tready_net <= tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  we_ce_net <= ce_25600;
  constant_x0 : entity xil_defaultlib.sysgen_constant_2af2d48d22 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => slice3_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register3_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => slice2_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => mcode_re_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert5_dout_net
  );
  counter : entity xil_defaultlib.axi_qpsk_rx_dec_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_dec_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    clr => '0',
    rst => logical_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  fifo : entity xil_defaultlib.axi_qpsk_rx_dec_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_rx_dec_fifo_generator_i0",
    data_count_width => 9,
    data_width => 32,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => true,
    percent_full_width => 1
  )
  port map (
    en => '1',
    din => concat_y_net,
    we => logical1_y_net_x0(0),
    re => logical2_y_net,
    rst => slice1_y_net(0),
    clk => clk_net,
    ce => ce_net,
    we_ce => we_ce_net,
    re_ce => ce_net,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net,
    dcount => fifo_dcount_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_0483cff26d 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_0483cff26d 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a92e18fafb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice1_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_510e07ba13 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_axis_tap_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_a92e18fafb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_510e07ba13 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_7134cf2084 
  port map (
    clr => '0',
    axiwrite => convert_dout_net,
    tlast => convert1_dout_net,
    dcount => convert2_dout_net,
    axiauto => convert3_dout_net,
    clk => clk_net,
    ce => ce_net,
    re => mcode_re_net
  );
  register3 : entity xil_defaultlib.axi_qpsk_rx_dec_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice1_y_net,
    en => m_axis_tap_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_dec_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice1_y_net,
    en => m_axis_tap_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_rx_dec_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice1_y_net,
    en => m_axis_tap_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_7ffb0fab70 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_bd67e2375f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizerf_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_dec/Data Inspector/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec_m_axis_symbol_ctrl is
  port (
    i_data : in std_logic_vector( 16-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    q_data : in std_logic_vector( 16-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_25600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_dec_m_axis_symbol_ctrl;
architecture structural of axi_qpsk_rx_dec_m_axis_symbol_ctrl is 
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal we_ce_net : std_logic;
  signal ce_net : std_logic;
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  convert6_dout_net <= i_data;
  logical1_y_net <= tvalid_in;
  convert7_dout_net <= q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  m_axis_tap_tready_net <= tready_in;
  slice3_y_net <= transfer;
  slice2_y_net <= auto_restart;
  clk_net <= clk_1;
  ce_net <= ce_1;
  we_ce_net <= ce_25600;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_rx_dec_axi_write_interface 
  port map (
    int_reset => slice1_y_net,
    transfer => slice3_y_net,
    auto_restart => slice2_y_net,
    packet_size => packetsizerf_net,
    tdata_in => concat_y_net,
    tvalid_in => logical1_y_net,
    tready => m_axis_tap_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_25600 => we_ce_net,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_55d9481f3f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 32,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 32,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register5_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_7664fa76d3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert7_dout_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_7664fa76d3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert6_dout_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_dec/Data Inspector
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec_data_inspector is
  port (
    symbol_i_data : in std_logic_vector( 16-1 downto 0 );
    symbol_i_valid : in std_logic_vector( 1-1 downto 0 );
    symbol_q_data : in std_logic_vector( 16-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_25600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_dec_data_inspector;
architecture structural of axi_qpsk_rx_dec_data_inspector is 
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal we_ce_net : std_logic;
  signal ce_net : std_logic;
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  convert6_dout_net <= symbol_i_data;
  logical1_y_net <= symbol_i_valid;
  convert7_dout_net <= symbol_q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  slice3_y_net <= transfer;
  slice2_y_net <= auto_restart;
  m_axis_tap_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  we_ce_net <= ce_25600;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_rx_dec_m_axis_symbol_ctrl 
  port map (
    i_data => convert6_dout_net,
    tvalid_in => logical1_y_net,
    q_data => convert7_dout_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    tready_in => m_axis_tap_tready_net,
    transfer => slice3_y_net,
    auto_restart => slice2_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_25600 => we_ce_net,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_dec/Decimation Filtering Stages
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec_decimation_filtering_stages is
  port (
    i_in : in std_logic_vector( 16-1 downto 0 );
    q_in : in std_logic_vector( 16-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    enable : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_40 : in std_logic;
    ce_40 : in std_logic;
    clk_80 : in std_logic;
    ce_80 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    i_out : out std_logic_vector( 16-1 downto 0 );
    q_out : out std_logic_vector( 16-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_dec_decimation_filtering_stages;
architecture structural of axi_qpsk_rx_dec_decimation_filtering_stages is 
  signal fir_compiler_7_2_5_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_8_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_8_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_6_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_7_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_7_m_axis_data_tvalid_net : std_logic;
  signal clk_3200_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x1 : std_logic;
  signal ce_net_x0 : std_logic;
  signal clk_net : std_logic;
  signal clk_net_x2 : std_logic;
  signal ce_40_net : std_logic;
  signal ce_3200_net : std_logic;
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal s_q_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal clk_40_net : std_logic;
  signal clk_80_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal s_i_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x1 : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_80_net : std_logic;
  signal we_ce_net : std_logic;
  signal cic_compiler_4_0_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal cic_compiler_4_0_1_m_axis_data_tvalid_net : std_logic;
  signal logical_y_net : std_logic;
  signal cic_compiler_4_0_1_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal cic_compiler_4_0_1_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_m_axis_data_tvalid_net : std_logic;
  signal cic_compiler_4_0_2_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_2_m_axis_data_tvalid_net : std_logic;
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal delay2_q_net : std_logic;
  signal cic_compiler_4_0_2_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_1_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_3_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal fir_compiler_7_2_2_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_4_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal cic_compiler_4_0_3_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal delay3_q_net : std_logic;
  signal cic_compiler_4_0_3_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_3_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_5_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_8_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_1_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_2_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_7_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_6_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_3_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_5_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_4_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_6_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_1_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_2_s_axis_data_tready_net : std_logic;
  signal shift4_op_net : std_logic_vector( 16-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_3_s_axis_data_tready_net : std_logic;
  signal shift3_op_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_4_s_axis_data_tready_net : std_logic;
begin
  i_out <= convert6_dout_net;
  q_out <= convert7_dout_net;
  tvalid_out <= logical1_y_net;
  s_i_axis_tdata_net <= i_in;
  s_q_axis_tdata_net <= q_in;
  logical_y_net_x0 <= tvalid_in;
  slice_y_net <= enable;
  clk_net_x2 <= clk_1;
  ce_net_x1 <= ce_1;
  clk_40_net <= clk_40;
  ce_40_net <= ce_40;
  clk_80_net <= clk_80;
  ce_80_net <= ce_80;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  clk_net_x1 <= clk_6400;
  ce_net <= ce_6400;
  clk_net_x0 <= clk_12800;
  ce_net_x0 <= ce_12800;
  clk_net <= clk_25600;
  we_ce_net <= ce_25600;
  cic_compiler_4_0 : entity xil_defaultlib.xlcic_compiler_a45b07225a94ffb00f74fbe417cf240f 
  port map (
    s_axis_data_tdata_real => s_i_axis_tdata_net,
    en => logical_y_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_logic_1 => clk_net_x2,
    ce_logic_1 => ce_net_x1,
    s_axis_data_tready => cic_compiler_4_0_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_m_axis_data_tdata_real_net
  );
  cic_compiler_4_0_1 : entity xil_defaultlib.xlcic_compiler_a45b07225a94ffb00f74fbe417cf240f 
  port map (
    s_axis_data_tdata_real => s_q_axis_tdata_net,
    en => logical_y_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_logic_1 => clk_net_x2,
    ce_logic_1 => ce_net_x1,
    s_axis_data_tready => cic_compiler_4_0_1_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_1_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_1_m_axis_data_tdata_real_net
  );
  cic_compiler_4_0_2 : entity xil_defaultlib.xlcic_compiler_a496b84c21ea901f01e5fd1c81a66176 
  port map (
    s_axis_data_tdata_real => convert_dout_net,
    en => delay2_q_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_logic_80 => clk_80_net,
    ce_logic_80 => ce_80_net,
    s_axis_data_tready => cic_compiler_4_0_2_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_2_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_2_m_axis_data_tdata_real_net
  );
  cic_compiler_4_0_3 : entity xil_defaultlib.xlcic_compiler_a496b84c21ea901f01e5fd1c81a66176 
  port map (
    s_axis_data_tdata_real => convert1_dout_net,
    en => delay3_q_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_logic_80 => clk_80_net,
    ce_logic_80 => ce_80_net,
    s_axis_data_tready => cic_compiler_4_0_3_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_3_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_3_m_axis_data_tdata_real_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_3_m_axis_data_tdata_real_net,
    clk => clk_80_net,
    ce => ce_80_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_1_m_axis_data_tdata_real_net,
    clk => clk_80_net,
    ce => ce_80_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_4_m_axis_data_tdata_real_net,
    clk => clk_net_x1,
    ce => ce_net,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_2_m_axis_data_tdata_real_net,
    clk => clk_net_x1,
    ce => ce_net,
    dout => convert3_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_5_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_6_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert5_dout_net
  );
  convert6 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_7_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => we_ce_net,
    dout => convert6_dout_net
  );
  convert7 : entity xil_defaultlib.axi_qpsk_rx_dec_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_8_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => we_ce_net,
    dout => convert7_dout_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_dec_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => fir_compiler_7_2_3_m_axis_data_tvalid_net,
    clk => clk_80_net,
    ce => ce_80_net,
    q(0) => delay2_q_net
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_dec_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => fir_compiler_7_2_1_m_axis_data_tvalid_net,
    clk => clk_80_net,
    ce => ce_80_net,
    q(0) => delay3_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_dec_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => fir_compiler_7_2_2_m_axis_data_tvalid_net,
    clk => clk_net_x1,
    ce => ce_net,
    q => delay6_q_net
  );
  delay7 : entity xil_defaultlib.axi_qpsk_rx_dec_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => fir_compiler_7_2_4_m_axis_data_tvalid_net,
    clk => clk_net_x1,
    ce => ce_net,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.axi_qpsk_rx_dec_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => fir_compiler_7_2_5_m_axis_data_tvalid_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.axi_qpsk_rx_dec_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => fir_compiler_7_2_6_m_axis_data_tvalid_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay9_q_net
  );
  fir_compiler_7_2_1 : entity xil_defaultlib.xlfir_compiler_74dd4feff11d61a655eff23713cbe410 
  port map (
    s_axis_data_tdata_real => shift1_op_net,
    en => cic_compiler_4_0_1_m_axis_data_tvalid_net,
    src_clk => clk_40_net,
    src_ce => ce_40_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_logic_40 => clk_40_net,
    ce_logic_40 => ce_40_net,
    s_axis_data_tready => fir_compiler_7_2_1_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_1_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_1_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_2 : entity xil_defaultlib.xlfir_compiler_1ed208f686883e019973b01dae8fe539 
  port map (
    s_axis_data_tdata_real => shift4_op_net,
    en => cic_compiler_4_0_3_m_axis_data_tvalid_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => fir_compiler_7_2_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_2_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_2_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_3 : entity xil_defaultlib.xlfir_compiler_74dd4feff11d61a655eff23713cbe410 
  port map (
    s_axis_data_tdata_real => shift3_op_net,
    en => cic_compiler_4_0_m_axis_data_tvalid_net,
    src_clk => clk_40_net,
    src_ce => ce_40_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_logic_40 => clk_40_net,
    ce_logic_40 => ce_40_net,
    s_axis_data_tready => fir_compiler_7_2_3_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_3_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_3_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_4 : entity xil_defaultlib.xlfir_compiler_1ed208f686883e019973b01dae8fe539 
  port map (
    s_axis_data_tdata_real => shift2_op_net,
    en => cic_compiler_4_0_2_m_axis_data_tvalid_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => fir_compiler_7_2_4_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_4_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_4_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_5 : entity xil_defaultlib.xlfir_compiler_d1a9f93b61370ea9603034bf620204b9 
  port map (
    s_axis_data_tdata_real => convert2_dout_net,
    en => delay7_q_net(0),
    src_clk => clk_net_x1,
    src_ce => ce_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net_x0,
    clk_logic_6400 => clk_net_x1,
    ce_logic_6400 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_5_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_5_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_5_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_6 : entity xil_defaultlib.xlfir_compiler_d1a9f93b61370ea9603034bf620204b9 
  port map (
    s_axis_data_tdata_real => convert3_dout_net,
    en => delay6_q_net(0),
    src_clk => clk_net_x1,
    src_ce => ce_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net_x0,
    clk_logic_6400 => clk_net_x1,
    ce_logic_6400 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_6_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_6_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_6_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_7 : entity xil_defaultlib.xlfir_compiler_4cb61b970474aa2d3636aa3a0a3f8225 
  port map (
    s_axis_data_tdata_real => convert4_dout_net,
    en => delay8_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net_x0,
    clk_25600 => clk_net,
    ce_25600 => we_ce_net,
    clk_logic_12800 => clk_net_x0,
    ce_logic_12800 => ce_net_x0,
    s_axis_data_tready => fir_compiler_7_2_7_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_7_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_7_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_8 : entity xil_defaultlib.xlfir_compiler_4cb61b970474aa2d3636aa3a0a3f8225 
  port map (
    s_axis_data_tdata_real => convert5_dout_net,
    en => delay9_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x2,
    ce => ce_net_x1,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net_x0,
    clk_25600 => clk_net,
    ce_25600 => we_ce_net,
    clk_logic_12800 => clk_net_x0,
    ce_logic_12800 => ce_net_x0,
    s_axis_data_tready => fir_compiler_7_2_8_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_8_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_8_m_axis_data_tdata_real_net
  );
  logical : entity xil_defaultlib.sysgen_logical_510e07ba13 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical_y_net_x0,
    d1 => slice_y_net,
    y(0) => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_73842583eb 
  port map (
    clr => '0',
    d0(0) => fir_compiler_7_2_8_m_axis_data_tvalid_net,
    d1(0) => fir_compiler_7_2_7_m_axis_data_tvalid_net,
    clk => clk_net,
    ce => we_ce_net,
    y => logical1_y_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_3a256d206d 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_1_m_axis_data_tdata_real_net,
    clk => clk_40_net,
    ce => ce_40_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_3a256d206d 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_2_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_3a256d206d 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_m_axis_data_tdata_real_net,
    clk => clk_40_net,
    ce => ce_40_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_3a256d206d 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_3_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    op => shift4_op_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_dec/M_AXIS_TAP
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec_m_axis_tap is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_dec_m_axis_tap;
architecture structural of axi_qpsk_rx_dec_m_axis_tap is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_axis_tap_tready_net <= m_axis_tap_tready;
end structural;
-- Generated from Simulink block axi_qpsk_rx_dec_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec_struct is
  port (
    enable : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    rxreset : in std_logic_vector( 32-1 downto 0 );
    auto_restart : in std_logic_vector( 32-1 downto 0 );
    s_i_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_i_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_q_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_q_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_40 : in std_logic;
    ce_40 : in std_logic;
    clk_80 : in std_logic;
    ce_80 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    s_i_axis_tready : out std_logic_vector( 1-1 downto 0 );
    s_q_axis_tready : out std_logic_vector( 1-1 downto 0 );
    m_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tlast : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_dec_struct;
architecture structural of axi_qpsk_rx_dec_struct is 
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal s_i_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_q_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_q_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_i_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal rxreset_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal we_ce_net : std_logic;
  signal clk_net_x2 : std_logic;
  signal clk_40_net : std_logic;
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x1 : std_logic;
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net_x1 : std_logic;
  signal ce_80_net : std_logic;
  signal ce_40_net : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal transfer_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal clk_80_net : std_logic;
  signal ce_3200_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_3200_net : std_logic;
begin
  enable_net <= enable;
  packetsizerf_net <= packetsizerf;
  rxreset_net <= rxreset;
  auto_restart_net <= auto_restart;
  s_i_axis_tdata_net <= s_i_axis_tdata;
  s_i_axis_tready <= m_axis_tap_tready_net;
  s_i_axis_tvalid_net <= s_i_axis_tvalid;
  s_q_axis_tdata_net <= s_q_axis_tdata;
  s_q_axis_tready <= m_axis_tap_tready_net;
  s_q_axis_tvalid_net <= s_q_axis_tvalid;
  transfer_net <= transfer;
  m_axis_tdata <= concat_y_net;
  m_axis_tvalid <= logical1_y_net;
  m_axis_tap_tdata <= convert4_dout_net;
  m_axis_tap_tlast <= register3_q_net;
  m_axis_tap_tready_net <= m_axis_tap_tready;
  m_axis_tap_tvalid <= register4_q_net;
  clk_net_x2 <= clk_1;
  ce_net_x1 <= ce_1;
  clk_40_net <= clk_40;
  ce_40_net <= ce_40;
  clk_80_net <= clk_80;
  ce_80_net <= ce_80;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  clk_net_x1 <= clk_6400;
  ce_net_x0 <= ce_6400;
  clk_net_x0 <= clk_12800;
  ce_net <= ce_12800;
  clk_net <= clk_25600;
  we_ce_net <= ce_25600;
  data_inspector : entity xil_defaultlib.axi_qpsk_rx_dec_data_inspector 
  port map (
    symbol_i_data => convert6_dout_net,
    symbol_i_valid => logical1_y_net,
    symbol_q_data => convert7_dout_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    transfer => slice3_y_net,
    auto_restart => slice2_y_net,
    tready_in => m_axis_tap_tready_net,
    clk_1 => clk_net_x2,
    ce_1 => ce_net_x1,
    ce_25600 => we_ce_net,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
  decimation_filtering_stages : entity xil_defaultlib.axi_qpsk_rx_dec_decimation_filtering_stages 
  port map (
    i_in => s_i_axis_tdata_net,
    q_in => s_q_axis_tdata_net,
    tvalid_in => logical_y_net,
    enable => slice_y_net,
    clk_1 => clk_net_x2,
    ce_1 => ce_net_x1,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net_x0,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net,
    clk_25600 => clk_net,
    ce_25600 => we_ce_net,
    i_out => convert6_dout_net,
    q_out => convert7_dout_net,
    tvalid_out => logical1_y_net
  );
  m_axis_tap : entity xil_defaultlib.axi_qpsk_rx_dec_m_axis_tap 
  port map (
    tdata_in => convert4_dout_net,
    tvalid_in => register4_q_net,
    tlast_in => register3_q_net,
    m_axis_tap_tready => m_axis_tap_tready_net
  );
  concat : entity xil_defaultlib.sysgen_concat_55d9481f3f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  logical : entity xil_defaultlib.sysgen_logical_73842583eb 
  port map (
    clr => '0',
    d0 => s_i_axis_tvalid_net,
    d1 => s_q_axis_tvalid_net,
    clk => clk_net_x2,
    ce => ce_net_x1,
    y => logical_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_7664fa76d3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert6_dout_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_7664fa76d3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert7_dout_net,
    output_port => reinterpret1_output_port_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_dec_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => enable_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_dec_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => rxreset_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.axi_qpsk_rx_dec_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => auto_restart_net,
    y => slice2_y_net
  );
  slice3 : entity xil_defaultlib.axi_qpsk_rx_dec_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transfer_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec_default_clock_driver is
  port (
    axi_qpsk_rx_dec_sysclk : in std_logic;
    axi_qpsk_rx_dec_sysce : in std_logic;
    axi_qpsk_rx_dec_sysclr : in std_logic;
    axi_qpsk_rx_dec_clk1 : out std_logic;
    axi_qpsk_rx_dec_ce1 : out std_logic;
    axi_qpsk_rx_dec_clk40 : out std_logic;
    axi_qpsk_rx_dec_ce40 : out std_logic;
    axi_qpsk_rx_dec_clk80 : out std_logic;
    axi_qpsk_rx_dec_ce80 : out std_logic;
    axi_qpsk_rx_dec_clk3200 : out std_logic;
    axi_qpsk_rx_dec_ce3200 : out std_logic;
    axi_qpsk_rx_dec_clk6400 : out std_logic;
    axi_qpsk_rx_dec_ce6400 : out std_logic;
    axi_qpsk_rx_dec_clk12800 : out std_logic;
    axi_qpsk_rx_dec_ce12800 : out std_logic;
    axi_qpsk_rx_dec_clk25600 : out std_logic;
    axi_qpsk_rx_dec_ce25600 : out std_logic
  );
end axi_qpsk_rx_dec_default_clock_driver;
architecture structural of axi_qpsk_rx_dec_default_clock_driver is 
begin
  clockdriver_x5 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => axi_qpsk_rx_dec_sysclk,
    sysce => axi_qpsk_rx_dec_sysce,
    sysclr => axi_qpsk_rx_dec_sysclr,
    clk => axi_qpsk_rx_dec_clk1,
    ce => axi_qpsk_rx_dec_ce1
  );
  clockdriver_x4 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 40,
    log_2_period => 6
  )
  port map (
    sysclk => axi_qpsk_rx_dec_sysclk,
    sysce => axi_qpsk_rx_dec_sysce,
    sysclr => axi_qpsk_rx_dec_sysclr,
    clk => axi_qpsk_rx_dec_clk40,
    ce => axi_qpsk_rx_dec_ce40
  );
  clockdriver_x3 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 80,
    log_2_period => 7
  )
  port map (
    sysclk => axi_qpsk_rx_dec_sysclk,
    sysce => axi_qpsk_rx_dec_sysce,
    sysclr => axi_qpsk_rx_dec_sysclr,
    clk => axi_qpsk_rx_dec_clk80,
    ce => axi_qpsk_rx_dec_ce80
  );
  clockdriver_x2 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 3200,
    log_2_period => 12
  )
  port map (
    sysclk => axi_qpsk_rx_dec_sysclk,
    sysce => axi_qpsk_rx_dec_sysce,
    sysclr => axi_qpsk_rx_dec_sysclr,
    clk => axi_qpsk_rx_dec_clk3200,
    ce => axi_qpsk_rx_dec_ce3200
  );
  clockdriver_x1 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 6400,
    log_2_period => 13
  )
  port map (
    sysclk => axi_qpsk_rx_dec_sysclk,
    sysce => axi_qpsk_rx_dec_sysce,
    sysclr => axi_qpsk_rx_dec_sysclr,
    clk => axi_qpsk_rx_dec_clk6400,
    ce => axi_qpsk_rx_dec_ce6400
  );
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 12800,
    log_2_period => 14
  )
  port map (
    sysclk => axi_qpsk_rx_dec_sysclk,
    sysce => axi_qpsk_rx_dec_sysce,
    sysclr => axi_qpsk_rx_dec_sysclr,
    clk => axi_qpsk_rx_dec_clk12800,
    ce => axi_qpsk_rx_dec_ce12800
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 25600,
    log_2_period => 15
  )
  port map (
    sysclk => axi_qpsk_rx_dec_sysclk,
    sysce => axi_qpsk_rx_dec_sysce,
    sysclr => axi_qpsk_rx_dec_sysclr,
    clk => axi_qpsk_rx_dec_clk25600,
    ce => axi_qpsk_rx_dec_ce25600
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_dec is
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
end axi_qpsk_rx_dec;
architecture structural of axi_qpsk_rx_dec is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "axi_qpsk_rx_dec,sysgen_core_2018_3,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplusRFSOC,part=xczu28dr,speed=-2-e,package=ffvg1517,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=39.0625,system_simulink_period=3.90625e-08,waveform_viewer=0,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=10,cic_compiler_v4_0=4,concat=2,constant=1,convert=14,counter=1,delay=6,fifo=1,fir_compiler_v7_2=8,inv=2,logical=7,mcode=1,register=3,reinterpret=4,relational=2,shift=4,slice=4,}";
  signal auto_restart : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net : std_logic;
  signal clk_3200_net : std_logic;
  signal clk_40_net : std_logic;
  signal ce_3200_net : std_logic;
  signal transfer : std_logic_vector( 32-1 downto 0 );
  signal clk_80_net : std_logic;
  signal enable : std_logic_vector( 32-1 downto 0 );
  signal ce_80_net : std_logic;
  signal ce_1_net : std_logic;
  signal ce_40_net : std_logic;
  signal clk_6400_net : std_logic;
  signal packetsizerf : std_logic_vector( 32-1 downto 0 );
  signal ce_6400_net : std_logic;
  signal clk_12800_net : std_logic;
  signal ce_12800_net : std_logic;
  signal clk_25600_net : std_logic;
  signal ce_25600_net : std_logic;
  signal rxreset : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
begin
  axi_qpsk_rx_dec_axi_lite_interface : entity xil_defaultlib.axi_qpsk_rx_dec_axi_lite_interface 
  port map (
    axi_qpsk_rx_dec_s_axi_awaddr => axi_qpsk_rx_dec_s_axi_awaddr,
    axi_qpsk_rx_dec_s_axi_awvalid => axi_qpsk_rx_dec_s_axi_awvalid,
    axi_qpsk_rx_dec_s_axi_wdata => axi_qpsk_rx_dec_s_axi_wdata,
    axi_qpsk_rx_dec_s_axi_wstrb => axi_qpsk_rx_dec_s_axi_wstrb,
    axi_qpsk_rx_dec_s_axi_wvalid => axi_qpsk_rx_dec_s_axi_wvalid,
    axi_qpsk_rx_dec_s_axi_bready => axi_qpsk_rx_dec_s_axi_bready,
    axi_qpsk_rx_dec_s_axi_araddr => axi_qpsk_rx_dec_s_axi_araddr,
    axi_qpsk_rx_dec_s_axi_arvalid => axi_qpsk_rx_dec_s_axi_arvalid,
    axi_qpsk_rx_dec_s_axi_rready => axi_qpsk_rx_dec_s_axi_rready,
    axi_qpsk_rx_dec_aresetn => axi_qpsk_rx_dec_aresetn,
    axi_qpsk_rx_dec_aclk => clk,
    transfer => transfer,
    auto_restart => auto_restart,
    rxreset => rxreset,
    packetsizerf => packetsizerf,
    enable => enable,
    axi_qpsk_rx_dec_s_axi_awready => axi_qpsk_rx_dec_s_axi_awready,
    axi_qpsk_rx_dec_s_axi_wready => axi_qpsk_rx_dec_s_axi_wready,
    axi_qpsk_rx_dec_s_axi_bresp => axi_qpsk_rx_dec_s_axi_bresp,
    axi_qpsk_rx_dec_s_axi_bvalid => axi_qpsk_rx_dec_s_axi_bvalid,
    axi_qpsk_rx_dec_s_axi_arready => axi_qpsk_rx_dec_s_axi_arready,
    axi_qpsk_rx_dec_s_axi_rdata => axi_qpsk_rx_dec_s_axi_rdata,
    axi_qpsk_rx_dec_s_axi_rresp => axi_qpsk_rx_dec_s_axi_rresp,
    axi_qpsk_rx_dec_s_axi_rvalid => axi_qpsk_rx_dec_s_axi_rvalid,
    clk => clk_net
  );
  axi_qpsk_rx_dec_default_clock_driver : entity xil_defaultlib.axi_qpsk_rx_dec_default_clock_driver 
  port map (
    axi_qpsk_rx_dec_sysclk => clk_net,
    axi_qpsk_rx_dec_sysce => '1',
    axi_qpsk_rx_dec_sysclr => '0',
    axi_qpsk_rx_dec_clk1 => clk_1_net,
    axi_qpsk_rx_dec_ce1 => ce_1_net,
    axi_qpsk_rx_dec_clk40 => clk_40_net,
    axi_qpsk_rx_dec_ce40 => ce_40_net,
    axi_qpsk_rx_dec_clk80 => clk_80_net,
    axi_qpsk_rx_dec_ce80 => ce_80_net,
    axi_qpsk_rx_dec_clk3200 => clk_3200_net,
    axi_qpsk_rx_dec_ce3200 => ce_3200_net,
    axi_qpsk_rx_dec_clk6400 => clk_6400_net,
    axi_qpsk_rx_dec_ce6400 => ce_6400_net,
    axi_qpsk_rx_dec_clk12800 => clk_12800_net,
    axi_qpsk_rx_dec_ce12800 => ce_12800_net,
    axi_qpsk_rx_dec_clk25600 => clk_25600_net,
    axi_qpsk_rx_dec_ce25600 => ce_25600_net
  );
  axi_qpsk_rx_dec_struct : entity xil_defaultlib.axi_qpsk_rx_dec_struct 
  port map (
    enable => enable,
    packetsizerf => packetsizerf,
    rxreset => rxreset,
    auto_restart => auto_restart,
    s_i_axis_tdata => s_i_axis_tdata,
    s_i_axis_tvalid => s_i_axis_tvalid,
    s_q_axis_tdata => s_q_axis_tdata,
    s_q_axis_tvalid => s_q_axis_tvalid,
    transfer => transfer,
    m_axis_tap_tready => m_axis_tap_tready,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_6400_net,
    ce_6400 => ce_6400_net,
    clk_12800 => clk_12800_net,
    ce_12800 => ce_12800_net,
    clk_25600 => clk_25600_net,
    ce_25600 => ce_25600_net,
    s_i_axis_tready => s_i_axis_tready,
    s_q_axis_tready => s_q_axis_tready,
    m_axis_tdata => m_axis_tdata,
    m_axis_tvalid => m_axis_tvalid,
    m_axis_tap_tdata => m_axis_tap_tdata,
    m_axis_tap_tlast => m_axis_tap_tlast,
    m_axis_tap_tvalid => m_axis_tap_tvalid
  );
end structural;
