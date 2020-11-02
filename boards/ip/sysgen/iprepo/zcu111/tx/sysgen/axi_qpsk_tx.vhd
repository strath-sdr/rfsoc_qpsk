-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_ctrl is
  port (
    autorestartfft : in std_logic_vector( 32-1 downto 0 );
    autorestartsymbol : in std_logic_vector( 32-1 downto 0 );
    autorestarttime : in std_logic_vector( 32-1 downto 0 );
    bypassgain : in std_logic_vector( 32-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    lfsr_rst : in std_logic_vector( 32-1 downto 0 );
    outputgain : in std_logic_vector( 32-1 downto 0 );
    packetsizefft : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    packetsizesymbol : in std_logic_vector( 32-1 downto 0 );
    packetsizetime : in std_logic_vector( 32-1 downto 0 );
    resetfft : in std_logic_vector( 32-1 downto 0 );
    resetsymbol : in std_logic_vector( 32-1 downto 0 );
    resettime : in std_logic_vector( 32-1 downto 0 );
    simulateinterface : in std_logic_vector( 32-1 downto 0 );
    transferfft : in std_logic_vector( 32-1 downto 0 );
    transfersymbol : in std_logic_vector( 32-1 downto 0 );
    transfertime : in std_logic_vector( 32-1 downto 0 );
    enable_out : out std_logic_vector( 1-1 downto 0 );
    lfsr_rst_out : out std_logic_vector( 1-1 downto 0 );
    transfersymbol_out : out std_logic_vector( 1-1 downto 0 );
    transferfft_out : out std_logic_vector( 1-1 downto 0 );
    autorestartsymbol_out : out std_logic_vector( 1-1 downto 0 );
    autorestartfft_out : out std_logic_vector( 1-1 downto 0 );
    resetsymbol_out : out std_logic_vector( 1-1 downto 0 );
    resetfft_out : out std_logic_vector( 1-1 downto 0 );
    outputgain_out : out std_logic_vector( 32-1 downto 0 );
    resettime_out : out std_logic_vector( 1-1 downto 0 );
    autorestarttime_out : out std_logic_vector( 1-1 downto 0 );
    transfertime_out : out std_logic_vector( 1-1 downto 0 );
    simulateinterface_out : out std_logic_vector( 1-1 downto 0 );
    bypassgain_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_ctrl;
architecture structural of axi_qpsk_tx_ctrl is 
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal outputgain_net : std_logic_vector( 32-1 downto 0 );
  signal resetfft_net : std_logic_vector( 32-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 1-1 downto 0 );
  signal resetsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal autorestartsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizetime_net : std_logic_vector( 32-1 downto 0 );
  signal autorestarttime_net : std_logic_vector( 32-1 downto 0 );
  signal bypassgain_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizefft_net : std_logic_vector( 32-1 downto 0 );
  signal simulateinterface_net : std_logic_vector( 32-1 downto 0 );
  signal lfsr_rst_net : std_logic_vector( 32-1 downto 0 );
  signal transferfft_net : std_logic_vector( 32-1 downto 0 );
  signal autorestartfft_net : std_logic_vector( 32-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 1-1 downto 0 );
  signal resettime_net : std_logic_vector( 32-1 downto 0 );
  signal transfersymbol_net : std_logic_vector( 32-1 downto 0 );
  signal transfertime_net : std_logic_vector( 32-1 downto 0 );
begin
  enable_out <= slice_y_net;
  lfsr_rst_out <= slice1_y_net;
  transfersymbol_out <= slice3_y_net;
  transferfft_out <= slice2_y_net;
  autorestartsymbol_out <= slice4_y_net;
  autorestartfft_out <= slice5_y_net;
  resetsymbol_out <= slice6_y_net;
  resetfft_out <= slice7_y_net;
  outputgain_out <= reinterpret_output_port_net;
  resettime_out <= slice8_y_net;
  autorestarttime_out <= slice9_y_net;
  transfertime_out <= slice10_y_net;
  simulateinterface_out <= slice11_y_net;
  bypassgain_out <= slice12_y_net;
  autorestartfft_net <= autorestartfft;
  autorestartsymbol_net <= autorestartsymbol;
  autorestarttime_net <= autorestarttime;
  bypassgain_net <= bypassgain;
  enable_net <= enable;
  lfsr_rst_net <= lfsr_rst;
  outputgain_net <= outputgain;
  packetsizefft_net <= packetsizefft;
  packetsizerf_net <= packetsizerf;
  packetsizesymbol_net <= packetsizesymbol;
  packetsizetime_net <= packetsizetime;
  resetfft_net <= resetfft;
  resetsymbol_net <= resetsymbol;
  resettime_net <= resettime;
  simulateinterface_net <= simulateinterface;
  transferfft_net <= transferfft;
  transfersymbol_net <= transfersymbol;
  transfertime_net <= transfertime;
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_e279805292 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => outputgain_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.axi_qpsk_tx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => lfsr_rst_net,
    y => slice1_y_net
  );
  slice10 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transfertime_net,
    y => slice10_y_net
  );
  slice11 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => simulateinterface_net,
    y => slice11_y_net
  );
  slice12 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => bypassgain_net,
    y => slice12_y_net
  );
  slice2 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transferfft_net,
    y => slice2_y_net
  );
  slice3 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transfersymbol_net,
    y => slice3_y_net
  );
  slice4 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => autorestartsymbol_net,
    y => slice4_y_net
  );
  slice5 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => autorestartfft_net,
    y => slice5_y_net
  );
  slice6 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => resetsymbol_net,
    y => slice6_y_net
  );
  slice7 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => resetfft_net,
    y => slice7_y_net
  );
  slice8 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => resettime_net,
    y => slice8_y_net
  );
  slice9 : entity xil_defaultlib.axi_qpsk_tx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => autorestarttime_net,
    y => slice9_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/M_AXIS
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_m_axis is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_m_axis;
architecture structural of axi_qpsk_tx_m_axis is 
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
begin
  concat_y_net <= tdata_in;
  logical1_y_net <= tvalid_in;
  logical2_y_net <= tlast_in;
  m_rf_axis_tready_net <= m_rf_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/M_AXIS_FFT
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_m_axis_fft is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_fft_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_m_axis_fft;
architecture structural of axi_qpsk_tx_m_axis_fft is 
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal m_fft_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
begin
  register5_q_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_fft_axis_tready_net <= m_fft_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/M_AXIS_SYMBOL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_m_axis_symbol is
  port (
    tdata_in : in std_logic_vector( 8-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_m_axis_symbol;
architecture structural of axi_qpsk_tx_m_axis_symbol is 
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_symbol_axis_tready_net <= m_symbol_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/M_AXIS_TIME
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_m_axis_time is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_time_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_m_axis_time;
architecture structural of axi_qpsk_tx_m_axis_time is 
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal m_time_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
begin
  register5_q_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_time_axis_tready_net <= m_time_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/PostHB_Time_Domain/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_axi_write_interface is
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
    ce_6400 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_axi_write_interface;
architecture structural of axi_qpsk_tx_axi_write_interface is 
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizetime_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal delay_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_time_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal we_ce_net : std_logic;
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal ce_net : std_logic;
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 12-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice8_y_net <= int_reset;
  slice10_y_net <= transfer;
  slice9_y_net <= auto_restart;
  packetsizetime_net <= packet_size;
  concat_y_net <= tdata_in;
  delay_hb1_q_net <= tvalid_in;
  m_time_axis_tready_net <= tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  we_ce_net <= ce_6400;
  constant_x0 : entity xil_defaultlib.sysgen_constant_90890dc395 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    din => slice10_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    din => slice9_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_tx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_tx_c_counter_binary_v12_0_i0",
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
  fifo : entity xil_defaultlib.axi_qpsk_tx_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_tx_fifo_generator_i0",
    data_count_width => 12,
    data_width => 32,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => true,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    din => concat_y_net,
    we => delay_hb1_q_net(0),
    re => logical2_y_net,
    rst => slice8_y_net(0),
    clk => clk_net,
    ce => ce_net,
    we_ce => we_ce_net,
    re_ce => ce_net,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net,
    dcount => fifo_dcount_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice8_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_time_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_e08ab9cdc1 
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
  register3 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice8_y_net,
    en => m_time_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice8_y_net,
    en => m_time_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice8_y_net,
    en => m_time_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_0e1ea12591 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_a95127c338 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizetime_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/PostHB_Time_Domain/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_m_axis_symbol_ctrl is
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
    ce_6400 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_m_axis_symbol_ctrl;
architecture structural of axi_qpsk_tx_m_axis_symbol_ctrl is 
  signal mux1_y_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
  signal we_ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal delay_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizetime_net : std_logic_vector( 32-1 downto 0 );
  signal m_time_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  mux1_y_net <= i_data;
  delay_hb1_q_net <= tvalid_in;
  mux1_y_net_x0 <= q_data;
  slice8_y_net <= reset;
  packetsizetime_net <= packet_size;
  m_time_axis_tready_net <= tready_in;
  slice10_y_net <= transfer;
  slice9_y_net <= auto_restart;
  clk_net <= clk_1;
  ce_net <= ce_1;
  we_ce_net <= ce_6400;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_tx_axi_write_interface 
  port map (
    int_reset => slice8_y_net,
    transfer => slice10_y_net,
    auto_restart => slice9_y_net,
    packet_size => packetsizetime_net,
    tdata_in => concat_y_net,
    tvalid_in => delay_hb1_q_net,
    tready => m_time_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_6400 => we_ce_net,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_28acae67a2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_9de9bdef69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux1_y_net_x0,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_9de9bdef69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux1_y_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/PostHB_Time_Domain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_posthb_time_domain is
  port (
    time_i_data : in std_logic_vector( 16-1 downto 0 );
    time_i_valid : in std_logic_vector( 1-1 downto 0 );
    time_q_data : in std_logic_vector( 16-1 downto 0 );
    time_q_valid : in std_logic_vector( 1-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_6400 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_posthb_time_domain;
architecture structural of axi_qpsk_tx_posthb_time_domain is 
  signal delay_hb1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal packetsizetime_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_time_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal delay_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal mux1_y_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal we_ce_net : std_logic;
begin
  tdata_out <= register5_q_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  mux1_y_net_x0 <= time_i_data;
  delay_hb1_q_net_x0 <= time_i_valid;
  mux1_y_net <= time_q_data;
  delay_hb1_q_net <= time_q_valid;
  slice8_y_net <= reset;
  packetsizetime_net <= packet_size;
  slice10_y_net <= transfer;
  slice9_y_net <= auto_restart;
  m_time_axis_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  we_ce_net <= ce_6400;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_tx_m_axis_symbol_ctrl 
  port map (
    i_data => mux1_y_net_x0,
    tvalid_in => delay_hb1_q_net_x0,
    q_data => mux1_y_net,
    reset => slice8_y_net,
    packet_size => packetsizetime_net,
    tready_in => m_time_axis_tready_net,
    transfer => slice10_y_net,
    auto_restart => slice9_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_6400 => we_ce_net,
    tdata_out => register5_q_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/Post_HB_FFT/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_axi_write_interface_x0 is
  port (
    int_reset : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    sof : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_axi_write_interface_x0;
architecture structural of axi_qpsk_tx_axi_write_interface_x0 is 
  signal packetsizefft_net : std_logic_vector( 32-1 downto 0 );
  signal m_fft_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal register8_q_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal we_ce_net : std_logic;
  signal src_clk_net : std_logic;
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 13-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal up_sample2_q_net : std_logic;
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 13-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal up_sample1_q_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice7_y_net <= int_reset;
  slice2_y_net <= transfer;
  slice5_y_net <= auto_restart;
  packetsizefft_net <= packet_size;
  reinterpret1_output_port_net <= tdata_in;
  register5_q_net_x0 <= tvalid_in;
  register8_q_net <= sof;
  m_fft_axis_tready_net <= tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  src_clk_net <= clk_6400;
  we_ce_net <= ce_6400;
  constant_x0 : entity xil_defaultlib.sysgen_constant_3ffa54be4f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    din => slice5_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert3_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    din => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_tx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_tx_c_counter_binary_v12_0_i0",
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
  fifo : entity xil_defaultlib.axi_qpsk_tx_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_tx_fifo_generator_i1",
    data_count_width => 13,
    data_width => 32,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => true,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    din => reinterpret1_output_port_net,
    we => register5_q_net_x0(0),
    re => logical2_y_net,
    rst => up_sample2_q_net,
    clk => clk_net,
    ce => ce_net,
    we_ce => we_ce_net,
    re_ce => ce_net,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net,
    dcount => fifo_dcount_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => up_sample2_q_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_fft_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_0a85190278 
  port map (
    clr => '0',
    axiwrite => convert_dout_net,
    tlast => convert1_dout_net,
    dcount => convert2_dout_net,
    axiauto => convert3_dout_net,
    sof => convert4_dout_net,
    clk => clk_net,
    ce => ce_net,
    re => mcode_re_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => up_sample1_q_net,
    rst(0) => up_sample2_q_net,
    en => m_fft_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
  register3 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst(0) => up_sample2_q_net,
    en => m_fft_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst(0) => up_sample2_q_net,
    en => m_fft_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst(0) => up_sample2_q_net,
    en => m_fft_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_ef12a990fa 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_a95127c338 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizefft_net,
    op => relational1_op_net
  );
  up_sample1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 0,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => register8_q_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => up_sample1_q_net
  );
  up_sample2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 0,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => slice7_y_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q(0) => up_sample2_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/Post_HB_FFT
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_post_hb_fft is
  port (
    post_hb_i_data : in std_logic_vector( 16-1 downto 0 );
    post_hb_i_valid : in std_logic_vector( 1-1 downto 0 );
    post_hb_q_data : in std_logic_vector( 16-1 downto 0 );
    post_hb_q_valid : in std_logic_vector( 1-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_post_hb_fft;
architecture structural of axi_qpsk_tx_post_hb_fft is 
  signal register3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal complex_abs_s_net : std_logic_vector( 32-1 downto 0 );
  signal delay_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal reinterpret1_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal absolute1_op_net : std_logic_vector( 32-1 downto 0 );
  signal min_y_net : std_logic_vector( 32-1 downto 0 );
  signal we_ce_net : std_logic;
  signal max_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay_hb1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal m_fft_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net_x1 : std_logic_vector( 16-1 downto 0 );
  signal packetsizefft_net : std_logic_vector( 32-1 downto 0 );
  signal absolute_op_net : std_logic_vector( 32-1 downto 0 );
  signal fft1_op_re_net : std_logic_vector( 32-1 downto 0 );
  signal mux1_y_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal cmult_p_net : std_logic_vector( 64-1 downto 0 );
  signal register8_q_net : std_logic_vector( 1-1 downto 0 );
  signal src_clk_net : std_logic;
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal fft1_op_im_net : std_logic_vector( 32-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 32-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 32-1 downto 0 );
  signal relational2_op_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 32-1 downto 0 );
  signal counter_op_net : std_logic_vector( 10-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 32-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 32-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 32-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 10-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 1-1 downto 0 );
  signal register6_q_net : std_logic_vector( 1-1 downto 0 );
  signal register7_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  mux1_y_net_x0 <= post_hb_i_data;
  delay_hb1_q_net <= post_hb_i_valid;
  mux1_y_net_x1 <= post_hb_q_data;
  delay_hb1_q_net_x0 <= post_hb_q_valid;
  slice7_y_net <= reset;
  packetsizefft_net <= packet_size;
  m_fft_axis_tready_net <= tready_in;
  slice2_y_net <= transfer;
  slice5_y_net <= auto_restart;
  clk_net <= clk_1;
  ce_net <= ce_1;
  src_clk_net <= clk_6400;
  we_ce_net <= ce_6400;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_tx_axi_write_interface_x0 
  port map (
    int_reset => slice7_y_net,
    transfer => slice2_y_net,
    auto_restart => slice5_y_net,
    packet_size => packetsizefft_net,
    tdata_in => reinterpret1_output_port_net,
    tvalid_in => register5_q_net_x0,
    sof => register8_q_net,
    tready => m_fft_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  absolute : entity xil_defaultlib.sysgen_abs_8da227a85b 
  port map (
    clr => '0',
    a => fft1_op_re_net,
    clk => src_clk_net,
    ce => we_ce_net,
    op => absolute_op_net
  );
  absolute1 : entity xil_defaultlib.sysgen_abs_8da227a85b 
  port map (
    clr => '0',
    a => fft1_op_im_net,
    clk => src_clk_net,
    ce => we_ce_net,
    op => absolute1_op_net
  );
  cmult : entity xil_defaultlib.axi_qpsk_tx_xlcmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 31,
    a_width => 32,
    b_bin_pt => 31,
    c_a_type => 1,
    c_a_width => 32,
    c_b_type => 1,
    c_b_width => 32,
    c_output_width => 64,
    core_name0 => "axi_qpsk_tx_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 1,
    overflow => 1,
    p_arith => xlUnsigned,
    p_bin_pt => 62,
    p_width => 64,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => min_y_net,
    clk => src_clk_net,
    ce => we_ce_net,
    core_clk => src_clk_net,
    core_ce => we_ce_net,
    p => cmult_p_net
  );
  complex_abs : entity xil_defaultlib.axi_qpsk_tx_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 31,
    a_width => 32,
    b_arith => xlUnsigned,
    b_bin_pt => 62,
    b_width => 64,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 65,
    core_name0 => "axi_qpsk_tx_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 65,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 31,
    s_width => 32
  )
  port map (
    clr => '0',
    en => "1",
    a => max_y_net,
    b => cmult_p_net,
    clk => src_clk_net,
    ce => we_ce_net,
    s => complex_abs_s_net
  );
  counter : entity xil_defaultlib.axi_qpsk_tx_xlcounter_limit 
  generic map (
    cnt_15_0 => 1023,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "axi_qpsk_tx_c_counter_binary_v12_0_i1",
    count_limited => 0,
    op_arith => xlUnsigned,
    op_width => 10
  )
  port map (
    en => "1",
    clr => '0',
    rst => slice7_y_net,
    clk => src_clk_net,
    ce => we_ce_net,
    op => counter_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_8381b2b165 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_f8b183ceaf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 31,
    dout_width => 32,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => mux1_y_net_x0,
    clk => src_clk_net,
    ce => we_ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 31,
    dout_width => 32,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => mux1_y_net_x1,
    clk => src_clk_net,
    ce => we_ce_net,
    dout => convert2_dout_net
  );
  delay : entity xil_defaultlib.axi_qpsk_tx_xldelay 
  generic map (
    latency => 2204,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => delay_hb1_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => delay_q_net
  );
  max : entity xil_defaultlib.sysgen_mux_176ff5c7ea 
  port map (
    clr => '0',
    sel => relational1_op_net,
    d0 => absolute_op_net,
    d1 => absolute1_op_net,
    clk => src_clk_net,
    ce => we_ce_net,
    y => max_y_net
  );
  min : entity xil_defaultlib.sysgen_mux_176ff5c7ea 
  port map (
    clr => '0',
    sel => relational1_op_net,
    d0 => absolute1_op_net,
    d1 => absolute_op_net,
    clk => src_clk_net,
    ce => we_ce_net,
    y => min_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_65cbd99078 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => relational2_op_net,
    d0 => register_q_net,
    d1 => constant3_op_net,
    y => mux1_y_net
  );
  register_x0 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => complex_abs_s_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register_q_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_e279805292 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux1_y_net,
    output_port => reinterpret1_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_46acfc6ff8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_a95127c338 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => absolute_op_net,
    b => absolute1_op_net,
    op => relational1_op_net
  );
  relational2 : entity xil_defaultlib.sysgen_relational_b0e3e92102 
  port map (
    clr => '0',
    a => complex_abs_s_net,
    b => constant2_op_net,
    clk => src_clk_net,
    ce => we_ce_net,
    op => relational2_op_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_bbde368b86 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_tx_xldelay 
  generic map (
    latency => 2204,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => relational_op_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => delay1_q_net
  );
  fft1 : entity xil_defaultlib.xlaxi_qpsk_tx_xfft_v9_1_i0_9e77893c2c1664cd2aaf98da31d19f65 
  port map (
    in_re => convert1_dout_net,
    in_im => convert2_dout_net,
    clk => src_clk_net,
    ce => we_ce_net,
    op_re => fft1_op_re_net,
    op_im => fft1_op_im_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => delay_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register1_q_net
  );
  register2 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => delay1_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register1_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register3_q_net_x0
  );
  register4 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register3_q_net_x0,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register4_q_net_x0
  );
  register5 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register4_q_net_x0,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register5_q_net_x0
  );
  register6 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register2_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register6_q_net
  );
  register7 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register6_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register7_q_net
  );
  register8 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register7_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => register8_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/QPSK_symbol_mapper
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_qpsk_symbol_mapper is
  port (
    bit_pairs : in std_logic_vector( 2-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
    i_symbols : out std_logic_vector( 2-1 downto 0 );
    q_symbols : out std_logic_vector( 2-1 downto 0 )
  );
end axi_qpsk_tx_qpsk_symbol_mapper;
architecture structural of axi_qpsk_tx_qpsk_symbol_mapper is 
  signal register1_q_net_x0 : std_logic_vector( 2-1 downto 0 );
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 2-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 2-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal register_q_net_x0 : std_logic_vector( 2-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 2-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 2-1 downto 0 );
  signal mux_y_net : std_logic_vector( 2-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 2-1 downto 0 );
begin
  i_symbols <= register_q_net_x0;
  q_symbols <= register1_q_net_x0;
  register_q_net <= bit_pairs;
  slice1_y_net <= reset;
  down_sample1_q_net <= tready;
  clk_net <= clk_51200;
  ce_net <= ce_51200;
  constant_x0 : entity xil_defaultlib.sysgen_constant_5cb195ab66 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_a1a2f7fd15 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_5cb195ab66 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_a1a2f7fd15 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_609d5856bc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => register_q_net,
    d0 => constant_op_net,
    d1 => constant_op_net,
    d2 => constant1_op_net,
    d3 => constant1_op_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_609d5856bc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => register_q_net,
    d0 => constant2_op_net,
    d1 => constant3_op_net,
    d2 => constant2_op_net,
    d3 => constant3_op_net,
    y => mux1_y_net
  );
  register_x0 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 2,
    init_value => b"00"
  )
  port map (
    d => mux_y_net,
    rst => slice1_y_net,
    en => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net_x0
  );
  register1 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 2,
    init_value => b"00"
  )
  port map (
    d => mux1_y_net,
    rst => slice1_y_net,
    en => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net_x0
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/RF_Output
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_rf_output is
  port (
    rf_i_data : in std_logic_vector( 16-1 downto 0 );
    rf_i_valid : in std_logic_vector( 1-1 downto 0 );
    rf_i_last : in std_logic_vector( 1-1 downto 0 );
    rf_q_data : in std_logic_vector( 16-1 downto 0 );
    rf_q_valid : in std_logic_vector( 1-1 downto 0 );
    rf_q_last : in std_logic_vector( 1-1 downto 0 );
    out1 : out std_logic_vector( 32-1 downto 0 );
    out2 : out std_logic_vector( 1-1 downto 0 );
    out3 : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_rf_output;
architecture structural of axi_qpsk_tx_rf_output is 
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
begin
  out1 <= concat_y_net;
  out2 <= logical1_y_net;
  out3 <= logical2_y_net;
  delay5_q_net_x0 <= rf_i_data;
  delay3_q_net_x0 <= rf_i_valid;
  delay4_q_net_x0 <= rf_i_last;
  delay5_q_net <= rf_q_data;
  delay3_q_net <= rf_q_valid;
  delay4_q_net <= rf_q_last;
  concat : entity xil_defaultlib.sysgen_concat_28acae67a2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => delay5_q_net,
    in1 => delay5_q_net_x0,
    y => concat_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay3_q_net_x0,
    d1 => delay3_q_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay4_q_net_x0,
    d1 => delay4_q_net,
    y => logical2_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/Random_data_generator
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_random_data_generator is
  port (
    enable : in std_logic_vector( 1-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    bit_pairs : out std_logic_vector( 2-1 downto 0 )
  );
end axi_qpsk_tx_random_data_generator;
architecture structural of axi_qpsk_tx_random_data_generator is 
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 2-1 downto 0 );
  signal lfsr1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal lfsr_dout_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal down_sample1_q_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tvalid_out <= register3_q_net;
  bit_pairs <= register_q_net;
  slice_y_net <= enable;
  slice1_y_net <= reset;
  down_sample1_q_net <= tready;
  packetsizerf_net <= packet_size;
  clk_net <= clk_51200;
  ce_net <= ce_51200;
  concat : entity xil_defaultlib.sysgen_concat_80b6e9eb85 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => lfsr1_dout_net,
    in1 => lfsr_dout_net,
    y => concat_y_net
  );
  lfsr : entity xil_defaultlib.sysgen_lfsr_55445eadaa 
  port map (
    clr => '0',
    rst => slice1_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => lfsr_dout_net
  );
  lfsr1 : entity xil_defaultlib.sysgen_lfsr_f6789c65e0 
  port map (
    clr => '0',
    rst => slice1_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => lfsr1_dout_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => down_sample1_q_net,
    d1 => slice_y_net,
    y => logical1_y_net
  );
  register_x0 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 2,
    init_value => b"00"
  )
  port map (
    d => concat_y_net,
    rst => slice1_y_net,
    en => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  register2 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => logical1_y_net,
    rst => slice1_y_net,
    en => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => register2_q_net,
    rst => slice1_y_net,
    en => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/Symbol_2_Output/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_axi_write_interface_x1 is
  port (
    int_reset : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    tdata_in : in std_logic_vector( 4-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_51200 : in std_logic;
    tdata_out : out std_logic_vector( 4-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_axi_write_interface_x1;
architecture structural of axi_qpsk_tx_axi_write_interface_x1 is 
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 4-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal clk_net : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 4-1 downto 0 );
  signal ce_net : std_logic;
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 4-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dcount_net : std_logic_vector( 12-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_full_net : std_logic;
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice6_y_net <= int_reset;
  slice3_y_net <= transfer;
  slice4_y_net <= auto_restart;
  packetsizesymbol_net <= packet_size;
  concat_y_net <= tdata_in;
  register2_q_net <= tvalid_in;
  m_symbol_axis_tready_net <= tready;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_51200;
  constant_x0 : entity xil_defaultlib.sysgen_constant_90890dc395 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    ce => ce_net_x0,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    din => slice4_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
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
    ce => ce_net_x0,
    dout => convert5_dout_net
  );
  counter : entity xil_defaultlib.axi_qpsk_tx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_tx_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    clr => '0',
    rst => logical_y_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => counter_op_net
  );
  fifo : entity xil_defaultlib.axi_qpsk_tx_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_tx_fifo_generator_i2",
    data_count_width => 12,
    data_width => 4,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => true,
    ignore_din_for_gcd => false,
    percent_full_width => 1
  )
  port map (
    en => '1',
    din => concat_y_net,
    we => register2_q_net(0),
    re => logical2_y_net,
    rst => slice6_y_net(0),
    clk => clk_net,
    ce => ce_net_x0,
    we_ce => ce_net,
    re_ce => ce_net_x0,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net,
    dcount => fifo_dcount_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice6_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_symbol_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_e08ab9cdc1 
  port map (
    clr => '0',
    axiwrite => convert_dout_net,
    tlast => convert1_dout_net,
    dcount => convert2_dout_net,
    axiauto => convert3_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    re => mcode_re_net
  );
  register3 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice6_y_net,
    en => m_symbol_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice6_y_net,
    en => m_symbol_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 4,
    init_value => b"0000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice6_y_net,
    en => m_symbol_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_0e1ea12591 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_a95127c338 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizesymbol_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/Symbol_2_Output/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_m_axis_symbol_ctrl_x0 is
  port (
    i_data : in std_logic_vector( 2-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    q_data : in std_logic_vector( 2-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_51200 : in std_logic;
    tdata_out : out std_logic_vector( 8-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_m_axis_symbol_ctrl_x0;
architecture structural of axi_qpsk_tx_m_axis_symbol_ctrl_x0 is 
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 2-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
  signal ce_net : std_logic;
  signal reinterpret_output_port_net : std_logic_vector( 2-1 downto 0 );
  signal register5_q_net : std_logic_vector( 4-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 4-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 2-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  register_q_net <= i_data;
  register2_q_net <= tvalid_in;
  register1_q_net <= q_data;
  slice6_y_net <= reset;
  packetsizesymbol_net <= packet_size;
  m_symbol_axis_tready_net <= tready_in;
  slice3_y_net <= transfer;
  slice4_y_net <= auto_restart;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_51200;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_tx_axi_write_interface_x1 
  port map (
    int_reset => slice6_y_net,
    transfer => slice3_y_net,
    auto_restart => slice4_y_net,
    packet_size => packetsizesymbol_net,
    tdata_in => concat_y_net,
    tvalid_in => register2_q_net,
    tready => m_symbol_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    ce_51200 => ce_net,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_e5f3597034 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 4,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 8,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register5_q_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert4_dout_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_ca28820f31 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register1_q_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_ca28820f31 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register_q_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/Symbol_2_Output
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_symbol_2_output is
  port (
    symbol_i_data : in std_logic_vector( 2-1 downto 0 );
    symbol_i_valid : in std_logic_vector( 1-1 downto 0 );
    symbol_q_data : in std_logic_vector( 2-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    ce_51200 : in std_logic;
    tdata_out : out std_logic_vector( 8-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_symbol_2_output;
architecture structural of axi_qpsk_tx_symbol_2_output is 
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal register1_q_net : std_logic_vector( 2-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  register_q_net <= symbol_i_data;
  register2_q_net <= symbol_i_valid;
  register1_q_net <= symbol_q_data;
  slice6_y_net <= reset;
  packetsizesymbol_net <= packet_size;
  slice3_y_net <= transfer;
  slice4_y_net <= auto_restart;
  m_symbol_axis_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_51200;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_tx_m_axis_symbol_ctrl_x0 
  port map (
    i_data => register_q_net,
    tvalid_in => register2_q_net,
    q_data => register1_q_net,
    reset => slice6_y_net,
    packet_size => packetsizesymbol_net,
    tready_in => m_symbol_axis_tready_net,
    transfer => slice3_y_net,
    auto_restart => slice4_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    ce_51200 => ce_net,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/TxInterp_I
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_txinterp_i is
  port (
    input_symbols : in std_logic_vector( 2-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    packetsize : in std_logic_vector( 32-1 downto 0 );
    outputgainstage : in std_logic_vector( 32-1 downto 0 );
    bypass_gain : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
    interpolated : out std_logic_vector( 16-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 );
    post_hb_data : out std_logic_vector( 16-1 downto 0 );
    post_hb_valid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_txinterp_i;
architecture structural of axi_qpsk_tx_txinterp_i is 
  signal upsample_cic1_q_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_2_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_2_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_2_s_axis_data_tready_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_3_m_axis_data_tvalid_net : std_logic;
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_3_s_axis_data_tready_net : std_logic;
  signal upsample_cic6_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_cic4_q_net : std_logic_vector( 32-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret_output_port_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net_x1 : std_logic;
  signal ce_net_x1 : std_logic;
  signal cic_compiler_4_0_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_m_axis_data_tvalid_net : std_logic;
  signal shift3_op_net : std_logic_vector( 17-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal upsample_cic2_q_net : std_logic;
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal cic_compiler_4_0_m_axis_data_tdata_real_net : std_logic_vector( 63-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 16-1 downto 0 );
  signal inverter_op_net : std_logic;
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal delay_ciccomp1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_cic2_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_ciccomp1_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_ciccomp2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_cic1_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_3_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal upsample_ciccomp_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_cic_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_m_axis_data_tdata_real_net : std_logic_vector( 31-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal upsample_cic3_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_rrc1_q_net : std_logic_vector( 1-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_m_axis_data_tvalid_net : std_logic;
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal upsample_rrc_q_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_hb2_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_hb_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_rrc2_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_rrc2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 1-1 downto 0 );
  signal src_clk_net : std_logic;
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
  signal ce_3200_net : std_logic;
  signal clk_3200_net : std_logic;
  signal we_ce_net : std_logic;
  signal clk_net : std_logic;
begin
  interpolated <= delay5_q_net;
  tvalid_out <= delay3_q_net;
  tlast_out <= delay4_q_net;
  post_hb_data <= mux1_y_net;
  post_hb_valid <= delay_hb1_q_net;
  register_q_net <= input_symbols;
  slice1_y_net <= reset;
  down_sample1_q_net <= tready;
  register2_q_net <= tvalid_in;
  packetsizerf_net <= packetsize;
  reinterpret_output_port_net <= outputgainstage;
  slice12_y_net <= bypass_gain;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  src_clk_net <= clk_6400;
  we_ce_net <= ce_6400;
  clk_net <= clk_12800;
  ce_net <= ce_12800;
  clk_net_x1 <= clk_51200;
  ce_net_x1 <= ce_51200;
  cic_compiler_4_0 : entity xil_defaultlib.xlcic_compiler_bd96f07ecb101ec9bf7973ba13350218 
  port map (
    s_axis_data_tdata_real => convert5_dout_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => cic_compiler_4_0_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_m_axis_data_tdata_real_net
  );
  cmult : entity xil_defaultlib.axi_qpsk_tx_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 17,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 17,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 33,
    core_name0 => "axi_qpsk_tx_mult_gen_v12_0_i1",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => shift3_op_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    core_clk => clk_net_x0,
    core_ce => ce_net_x0,
    p => cmult_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_2128b184d2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 0,
    din_width => 2,
    dout_arith => 2,
    dout_bin_pt => 0,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register_q_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    dout => convert1_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 31,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_3_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    dout => convert5_dout_net
  );
  counter : entity xil_defaultlib.axi_qpsk_tx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_tx_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    clr => '0',
    rst => logical_y_net,
    en => logical1_y_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => counter_op_net
  );
  delay_cic1 : entity xil_defaultlib.sysgen_delay_ede921e440 
  port map (
    clr => '0',
    d => upsample_cic_q_net,
    rst => upsample_cic3_q_net,
    en(0) => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay_cic1_q_net
  );
  delay_cic2 : entity xil_defaultlib.sysgen_delay_1546ec153b 
  port map (
    clr => '0',
    d => delay_ciccomp1_q_net,
    rst => upsample_ciccomp1_q_net,
    en => upsample_ciccomp2_q_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay_cic2_q_net
  );
  delay_ciccomp1 : entity xil_defaultlib.sysgen_delay_a71f2bf332 
  port map (
    clr => '0',
    d => upsample_ciccomp_q_net,
    rst => upsample_ciccomp1_q_net,
    en => upsample_ciccomp2_q_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay_ciccomp1_q_net
  );
  delay_hb1 : entity xil_defaultlib.sysgen_delay_1546ec153b 
  port map (
    clr => '0',
    d => upsample_hb_q_net,
    rst => upsample_hb1_q_net,
    en => upsample_hb2_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => delay_hb1_q_net
  );
  delay_rrc2 : entity xil_defaultlib.sysgen_delay_2e9415344a 
  port map (
    clr => '0',
    d => upsample_rrc_q_net,
    rst => upsample_rrc1_q_net,
    en => upsample_rrc2_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_rrc2_q_net
  );
  delay3 : entity xil_defaultlib.sysgen_delay_4e15eb9db8 
  port map (
    clr => '0',
    d => delay_cic1_q_net,
    rst => upsample_cic3_q_net,
    en(0) => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.sysgen_delay_4e15eb9db8 
  port map (
    clr => '0',
    d => inverter1_op_net,
    rst => upsample_cic3_q_net,
    en(0) => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.sysgen_delay_dc7624ca49 
  port map (
    clr => '0',
    d => mux2_y_net,
    rst => upsample_cic3_q_net,
    en(0) => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay5_q_net
  );
  fir_compiler_7_2 : entity xil_defaultlib.xlfir_compiler_8aa1be8134864fd230e82f2d099cbb8c 
  port map (
    s_axis_data_tdata_real => mux_y_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_12800 => clk_net,
    ce_12800 => ce_net,
    clk_51200 => clk_net_x1,
    ce_51200 => ce_net_x1,
    clk_logic_51200 => clk_net_x1,
    ce_logic_51200 => ce_net_x1,
    s_axis_data_tready => fir_compiler_7_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_2 : entity xil_defaultlib.xlfir_compiler_0594fca8ca3a26bfbd7d44163f1435d5 
  port map (
    s_axis_data_tdata_real => convert4_dout_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    clk_12800 => clk_net,
    ce_12800 => ce_net,
    clk_logic_12800 => clk_net,
    ce_logic_12800 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_2_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_2_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_3 : entity xil_defaultlib.xlfir_compiler_cf96ac93db02076c760a12cc085f9781 
  port map (
    s_axis_data_tdata_real => shift_op_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    clk_logic_6400 => src_clk_net,
    ce_logic_6400 => we_ce_net,
    s_axis_data_tready => fir_compiler_7_2_3_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_3_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_3_m_axis_data_tdata_real_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => upsample_cic3_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op(0) => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => relational_op_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => upsample_cic3_q_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay_cic1_q_net,
    d1(0) => upsample_cic2_q_net,
    y => logical1_y_net
  );
  mult : entity xil_defaultlib.axi_qpsk_tx_xlmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 32,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 16,
    c_a_type => 1,
    c_a_width => 32,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 32,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "axi_qpsk_tx_mult_gen_v12_0_i2",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => reinterpret_output_port_net,
    b => shift_op_net,
    clk => src_clk_net,
    ce => we_ce_net,
    core_clk => src_clk_net,
    core_ce => we_ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.axi_qpsk_tx_xlmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 32,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 16,
    c_a_type => 1,
    c_a_width => 32,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 32,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "axi_qpsk_tx_mult_gen_v12_0_i2",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => upsample_cic4_q_net,
    b => cmult_p_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    core_clk => clk_net_x0,
    core_ce => ce_net_x0,
    p => mult1_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_8802530b21 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => register2_q_net,
    d0 => constant_op_net,
    d1 => convert1_dout_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_8802530b21 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => slice12_y_net,
    d0 => mult_p_net,
    d1 => shift_op_net,
    y => mux1_y_net
  );
  mux2 : entity xil_defaultlib.sysgen_mux_8802530b21 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => upsample_cic6_q_net,
    d0 => reinterpret_output_port_net_x0,
    d1 => reinterpret1_output_port_net,
    y => mux2_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_9de9bdef69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net_x0
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_9de9bdef69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => cmult_p_net,
    output_port => reinterpret1_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_a95127c338 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => upsample_cic1_q_net,
    op => relational_op_net
  );
  shift : entity xil_defaultlib.sysgen_shift_918fbf292b 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_2_m_axis_data_tdata_real_net,
    clk => src_clk_net,
    ce => we_ce_net,
    op => shift_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_5de9bb9351 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => shift3_op_net
  );
  upsample_cic : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => delay_cic2_q_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic_q_net
  );
  upsample_cic1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 32,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => packetsizerf_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic1_q_net
  );
  upsample_cic2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_ciccomp2_q_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q(0) => upsample_cic2_q_net
  );
  upsample_cic3 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_ciccomp1_q_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic3_q_net
  );
  upsample_cic4 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => reinterpret_output_port_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic4_q_net
  );
  upsample_cic6 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => slice12_y_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic6_q_net
  );
  upsample_ciccomp : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => delay_hb1_q_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_3200_net,
    dest_ce => ce_3200_net,
    q => upsample_ciccomp_q_net
  );
  upsample_ciccomp1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_hb1_q_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_3200_net,
    dest_ce => ce_3200_net,
    q => upsample_ciccomp1_q_net
  );
  upsample_ciccomp2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_hb2_q_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_3200_net,
    dest_ce => ce_3200_net,
    q => upsample_ciccomp2_q_net
  );
  upsample_hb : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => delay_rrc2_q_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => we_ce_net,
    q => upsample_hb_q_net
  );
  upsample_hb1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_rrc1_q_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => we_ce_net,
    q => upsample_hb1_q_net
  );
  upsample_hb2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_rrc2_q_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => we_ce_net,
    q => upsample_hb2_q_net
  );
  upsample_rrc : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => register2_q_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => upsample_rrc_q_net
  );
  upsample_rrc1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => slice1_y_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => upsample_rrc1_q_net
  );
  upsample_rrc2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => down_sample1_q_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => upsample_rrc2_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator/TxInterp_Q
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_txinterp_q is
  port (
    input_symbols : in std_logic_vector( 2-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    packetsize : in std_logic_vector( 32-1 downto 0 );
    outputgainstage : in std_logic_vector( 32-1 downto 0 );
    bypass_gain : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
    interpolated : out std_logic_vector( 16-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 );
    post_hb_data : out std_logic_vector( 16-1 downto 0 );
    post_hb_valid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_txinterp_q;
architecture structural of axi_qpsk_tx_txinterp_q is 
  signal delay_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_3200_net : std_logic;
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal src_clk_net : std_logic;
  signal we_ce_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal down_sample1_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_3200_net : std_logic;
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal clk_net_x1 : std_logic;
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 16-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
  signal register1_q_net : std_logic_vector( 2-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal shift3_op_net : std_logic_vector( 17-1 downto 0 );
  signal ce_net_x1 : std_logic;
  signal upsample_cic6_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret_output_port_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal mux2_y_net : std_logic_vector( 16-1 downto 0 );
  signal upsample_cic1_q_net : std_logic_vector( 32-1 downto 0 );
  signal delay_cic2_q_net : std_logic_vector( 1-1 downto 0 );
  signal cic_compiler_4_0_m_axis_data_tdata_real_net : std_logic_vector( 63-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal upsample_cic_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_2_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal upsample_cic3_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_ciccomp2_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_ciccomp1_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_cic4_q_net : std_logic_vector( 32-1 downto 0 );
  signal upsample_cic2_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_ciccomp_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_hb_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_rrc2_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_rrc1_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_hb2_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_rrc_q_net : std_logic_vector( 1-1 downto 0 );
  signal upsample_rrc2_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_m_axis_data_tdata_real_net : std_logic_vector( 31-1 downto 0 );
  signal cic_compiler_4_0_s_axis_data_tready_net : std_logic;
  signal convert4_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_3_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal cic_compiler_4_0_m_axis_data_tvalid_net : std_logic;
  signal inverter_op_net : std_logic;
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_cic1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_ciccomp1_q_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_3_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_2_m_axis_data_tvalid_net : std_logic;
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_3_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_2_s_axis_data_tready_net : std_logic;
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
begin
  interpolated <= delay5_q_net;
  tvalid_out <= delay3_q_net;
  tlast_out <= delay4_q_net;
  post_hb_data <= mux1_y_net;
  post_hb_valid <= delay_hb1_q_net;
  register1_q_net <= input_symbols;
  slice1_y_net <= reset;
  down_sample1_q_net <= tready;
  register2_q_net <= tvalid_in;
  packetsizerf_net <= packetsize;
  reinterpret_output_port_net <= outputgainstage;
  slice12_y_net <= bypass_gain;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  src_clk_net <= clk_6400;
  we_ce_net <= ce_6400;
  clk_net <= clk_12800;
  ce_net <= ce_12800;
  clk_net_x1 <= clk_51200;
  ce_net_x1 <= ce_51200;
  mux2 : entity xil_defaultlib.sysgen_mux_8802530b21 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => upsample_cic6_q_net,
    d0 => reinterpret_output_port_net_x0,
    d1 => reinterpret1_output_port_net,
    y => mux2_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_9de9bdef69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net_x0
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_9de9bdef69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => cmult_p_net,
    output_port => reinterpret1_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_a95127c338 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => upsample_cic1_q_net,
    op => relational_op_net
  );
  shift : entity xil_defaultlib.sysgen_shift_918fbf292b 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_2_m_axis_data_tdata_real_net,
    clk => src_clk_net,
    ce => we_ce_net,
    op => shift_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_5de9bb9351 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => shift3_op_net
  );
  upsample_cic : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => delay_cic2_q_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic_q_net
  );
  upsample_cic1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 32,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => packetsizerf_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic1_q_net
  );
  upsample_cic2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_ciccomp2_q_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic2_q_net
  );
  upsample_cic3 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_ciccomp1_q_net,
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic3_q_net
  );
  upsample_cic4 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => reinterpret_output_port_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic4_q_net
  );
  upsample_cic6 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => slice12_y_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => upsample_cic6_q_net
  );
  upsample_ciccomp : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => delay_hb1_q_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_3200_net,
    dest_ce => ce_3200_net,
    q => upsample_ciccomp_q_net
  );
  upsample_ciccomp1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_hb1_q_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_3200_net,
    dest_ce => ce_3200_net,
    q => upsample_ciccomp1_q_net
  );
  upsample_ciccomp2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_hb2_q_net,
    src_clk => src_clk_net,
    src_ce => we_ce_net,
    dest_clk => clk_3200_net,
    dest_ce => ce_3200_net,
    q => upsample_ciccomp2_q_net
  );
  upsample_hb : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => delay_rrc2_q_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => we_ce_net,
    q => upsample_hb_q_net
  );
  upsample_hb1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_rrc1_q_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => we_ce_net,
    q => upsample_hb1_q_net
  );
  upsample_hb2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => upsample_rrc2_q_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => we_ce_net,
    q => upsample_hb2_q_net
  );
  upsample_rrc : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => register2_q_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => upsample_rrc_q_net
  );
  upsample_rrc1 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => slice1_y_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => upsample_rrc1_q_net
  );
  upsample_rrc2 : entity xil_defaultlib.axi_qpsk_tx_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    latency => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => down_sample1_q_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => upsample_rrc2_q_net
  );
  cic_compiler_4_0 : entity xil_defaultlib.xlcic_compiler_bd96f07ecb101ec9bf7973ba13350218 
  port map (
    s_axis_data_tdata_real => convert5_dout_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net(0),
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => cic_compiler_4_0_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_m_axis_data_tdata_real_net
  );
  cmult : entity xil_defaultlib.axi_qpsk_tx_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 17,
    b_bin_pt => 15,
    c_a_type => 0,
    c_a_width => 17,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 33,
    core_name0 => "axi_qpsk_tx_mult_gen_v12_0_i1",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => shift3_op_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    core_clk => clk_net_x0,
    core_ce => ce_net_x0,
    p => cmult_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_2128b184d2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 0,
    din_width => 2,
    dout_arith => 2,
    dout_bin_pt => 0,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register1_q_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    dout => convert1_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 31,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_tx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_3_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    dout => convert5_dout_net
  );
  counter : entity xil_defaultlib.axi_qpsk_tx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_tx_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    clr => '0',
    rst => logical_y_net,
    en => logical1_y_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => counter_op_net
  );
  delay_cic1 : entity xil_defaultlib.sysgen_delay_ede921e440 
  port map (
    clr => '0',
    d => upsample_cic_q_net,
    rst => upsample_cic3_q_net,
    en => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay_cic1_q_net
  );
  delay_cic2 : entity xil_defaultlib.sysgen_delay_1546ec153b 
  port map (
    clr => '0',
    d => delay_ciccomp1_q_net,
    rst => upsample_ciccomp1_q_net,
    en => upsample_ciccomp2_q_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay_cic2_q_net
  );
  delay_ciccomp1 : entity xil_defaultlib.sysgen_delay_a71f2bf332 
  port map (
    clr => '0',
    d => upsample_ciccomp_q_net,
    rst => upsample_ciccomp1_q_net,
    en => upsample_ciccomp2_q_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay_ciccomp1_q_net
  );
  delay_hb1 : entity xil_defaultlib.sysgen_delay_1546ec153b 
  port map (
    clr => '0',
    d => upsample_hb_q_net,
    rst => upsample_hb1_q_net,
    en => upsample_hb2_q_net,
    clk => src_clk_net,
    ce => we_ce_net,
    q => delay_hb1_q_net
  );
  delay_rrc2 : entity xil_defaultlib.sysgen_delay_2e9415344a 
  port map (
    clr => '0',
    d => upsample_rrc_q_net,
    rst => upsample_rrc1_q_net,
    en => upsample_rrc2_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_rrc2_q_net
  );
  delay3 : entity xil_defaultlib.sysgen_delay_4e15eb9db8 
  port map (
    clr => '0',
    d => delay_cic1_q_net,
    rst => upsample_cic3_q_net,
    en => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.sysgen_delay_4e15eb9db8 
  port map (
    clr => '0',
    d => inverter1_op_net,
    rst => upsample_cic3_q_net,
    en => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.sysgen_delay_dc7624ca49 
  port map (
    clr => '0',
    d => mux2_y_net,
    rst => upsample_cic3_q_net,
    en => upsample_cic2_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay5_q_net
  );
  fir_compiler_7_2 : entity xil_defaultlib.xlfir_compiler_8aa1be8134864fd230e82f2d099cbb8c 
  port map (
    s_axis_data_tdata_real => mux_y_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_12800 => clk_net,
    ce_12800 => ce_net,
    clk_51200 => clk_net_x1,
    ce_51200 => ce_net_x1,
    clk_logic_51200 => clk_net_x1,
    ce_logic_51200 => ce_net_x1,
    s_axis_data_tready => fir_compiler_7_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_2 : entity xil_defaultlib.xlfir_compiler_0594fca8ca3a26bfbd7d44163f1435d5 
  port map (
    s_axis_data_tdata_real => convert4_dout_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    clk_12800 => clk_net,
    ce_12800 => ce_net,
    clk_logic_12800 => clk_net,
    ce_logic_12800 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_2_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_2_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_3 : entity xil_defaultlib.xlfir_compiler_cf96ac93db02076c760a12cc085f9781 
  port map (
    s_axis_data_tdata_real => shift_op_net,
    rst => inverter_op_net,
    en => upsample_cic2_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x0,
    ce => ce_net_x0,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    clk_logic_6400 => src_clk_net,
    ce_logic_6400 => we_ce_net,
    s_axis_data_tready => fir_compiler_7_2_3_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_3_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_3_m_axis_data_tdata_real_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => upsample_cic3_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op(0) => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_c1e7f57146 
  port map (
    clr => '0',
    ip => relational_op_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => upsample_cic3_q_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5d21ffa8a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay_cic1_q_net,
    d1 => upsample_cic2_q_net,
    y => logical1_y_net
  );
  mult : entity xil_defaultlib.axi_qpsk_tx_xlmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 32,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 16,
    c_a_type => 1,
    c_a_width => 32,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 32,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "axi_qpsk_tx_mult_gen_v12_0_i2",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => reinterpret_output_port_net,
    b => shift_op_net,
    clk => src_clk_net,
    ce => we_ce_net,
    core_clk => src_clk_net,
    core_ce => we_ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.axi_qpsk_tx_xlmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 32,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 15,
    b_width => 16,
    c_a_type => 1,
    c_a_width => 32,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 32,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "axi_qpsk_tx_mult_gen_v12_0_i2",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 15,
    p_width => 16,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => upsample_cic4_q_net,
    b => cmult_p_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    core_clk => clk_net_x0,
    core_ce => ce_net_x0,
    p => mult1_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_8802530b21 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => register2_q_net,
    d0 => constant_op_net,
    d1 => convert1_dout_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_8802530b21 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => slice12_y_net,
    d0 => mult_p_net,
    d1 => shift_op_net,
    y => mux1_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx/AXI_QPSK_Generator
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_axi_qpsk_generator is
  port (
    autorestartfft : in std_logic_vector( 32-1 downto 0 );
    autorestartsymbol : in std_logic_vector( 32-1 downto 0 );
    autorestarttime : in std_logic_vector( 32-1 downto 0 );
    bypassgain : in std_logic_vector( 32-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    lfsr_rst : in std_logic_vector( 32-1 downto 0 );
    outputgain : in std_logic_vector( 32-1 downto 0 );
    packetsizefft : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    packetsizesymbol : in std_logic_vector( 32-1 downto 0 );
    packetsizetime : in std_logic_vector( 32-1 downto 0 );
    resetfft : in std_logic_vector( 32-1 downto 0 );
    resetsymbol : in std_logic_vector( 32-1 downto 0 );
    resettime : in std_logic_vector( 32-1 downto 0 );
    simulateinterface : in std_logic_vector( 32-1 downto 0 );
    transferfft : in std_logic_vector( 32-1 downto 0 );
    transfersymbol : in std_logic_vector( 32-1 downto 0 );
    transfertime : in std_logic_vector( 32-1 downto 0 );
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_fft_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_time_axis_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
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
    m_time_axis_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_axi_qpsk_generator;
architecture structural of axi_qpsk_tx_axi_qpsk_generator is 
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal lfsr_rst_net : std_logic_vector( 32-1 downto 0 );
  signal outputgain_net : std_logic_vector( 32-1 downto 0 );
  signal autorestartfft_net : std_logic_vector( 32-1 downto 0 );
  signal autorestartsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal autorestarttime_net : std_logic_vector( 32-1 downto 0 );
  signal bypassgain_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net_x1 : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_3200_net : std_logic;
  signal resetfft_net : std_logic_vector( 32-1 downto 0 );
  signal transfertime_net : std_logic_vector( 32-1 downto 0 );
  signal resetsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizefft_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net_x1 : std_logic;
  signal ce_3200_net : std_logic;
  signal src_clk_net : std_logic;
  signal resettime_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x2 : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal packetsizetime_net : std_logic_vector( 32-1 downto 0 );
  signal simulateinterface_net : std_logic_vector( 32-1 downto 0 );
  signal transfersymbol_net : std_logic_vector( 32-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal transferfft_net : std_logic_vector( 32-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal m_fft_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal m_time_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_hb1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal delay_hb1_q_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal register_q_net_x0 : std_logic_vector( 2-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 16-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal we_ce_net : std_logic;
  signal delay3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net_x0 : std_logic_vector( 2-1 downto 0 );
  signal delay4_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net_x0 : std_logic;
begin
  autorestartfft_net <= autorestartfft;
  autorestartsymbol_net <= autorestartsymbol;
  autorestarttime_net <= autorestarttime;
  bypassgain_net <= bypassgain;
  enable_net <= enable;
  lfsr_rst_net <= lfsr_rst;
  outputgain_net <= outputgain;
  packetsizefft_net <= packetsizefft;
  packetsizerf_net <= packetsizerf;
  packetsizesymbol_net <= packetsizesymbol;
  packetsizetime_net <= packetsizetime;
  resetfft_net <= resetfft;
  resetsymbol_net <= resetsymbol;
  resettime_net <= resettime;
  simulateinterface_net <= simulateinterface;
  transferfft_net <= transferfft;
  transfersymbol_net <= transfersymbol;
  transfertime_net <= transfertime;
  m_rf_axis_tdata <= concat_y_net;
  m_rf_axis_tlast <= logical2_y_net;
  m_rf_axis_tready_net <= m_rf_axis_tready;
  m_rf_axis_tvalid <= logical1_y_net;
  m_fft_axis_tdata <= register5_q_net;
  m_fft_axis_tlast <= register3_q_net_x1;
  m_fft_axis_tready_net <= m_fft_axis_tready;
  m_fft_axis_tvalid <= register4_q_net_x0;
  m_symbol_axis_tdata <= convert4_dout_net;
  m_symbol_axis_tlast <= register3_q_net;
  m_symbol_axis_tready_net <= m_symbol_axis_tready;
  m_symbol_axis_tvalid <= register4_q_net;
  m_time_axis_tdata <= register5_q_net_x0;
  m_time_axis_tlast <= register3_q_net_x2;
  m_time_axis_tready_net <= m_time_axis_tready;
  m_time_axis_tvalid <= register4_q_net_x1;
  clk_net_x1 <= clk_1;
  ce_net_x1 <= ce_1;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  src_clk_net <= clk_6400;
  we_ce_net <= ce_6400;
  clk_net <= clk_12800;
  ce_net <= ce_12800;
  clk_net_x0 <= clk_51200;
  ce_net_x0 <= ce_51200;
  ctrl : entity xil_defaultlib.axi_qpsk_tx_ctrl 
  port map (
    autorestartfft => autorestartfft_net,
    autorestartsymbol => autorestartsymbol_net,
    autorestarttime => autorestarttime_net,
    bypassgain => bypassgain_net,
    enable => enable_net,
    lfsr_rst => lfsr_rst_net,
    outputgain => outputgain_net,
    packetsizefft => packetsizefft_net,
    packetsizerf => packetsizerf_net,
    packetsizesymbol => packetsizesymbol_net,
    packetsizetime => packetsizetime_net,
    resetfft => resetfft_net,
    resetsymbol => resetsymbol_net,
    resettime => resettime_net,
    simulateinterface => simulateinterface_net,
    transferfft => transferfft_net,
    transfersymbol => transfersymbol_net,
    transfertime => transfertime_net,
    enable_out => slice_y_net,
    lfsr_rst_out => slice1_y_net,
    transfersymbol_out => slice3_y_net,
    transferfft_out => slice2_y_net,
    autorestartsymbol_out => slice4_y_net,
    autorestartfft_out => slice5_y_net,
    resetsymbol_out => slice6_y_net,
    resetfft_out => slice7_y_net,
    outputgain_out => reinterpret_output_port_net,
    resettime_out => slice8_y_net,
    autorestarttime_out => slice9_y_net,
    transfertime_out => slice10_y_net,
    simulateinterface_out => slice11_y_net,
    bypassgain_out => slice12_y_net
  );
  m_axis : entity xil_defaultlib.axi_qpsk_tx_m_axis 
  port map (
    tdata_in => concat_y_net,
    tvalid_in => logical1_y_net,
    tlast_in => logical2_y_net,
    m_rf_axis_tready => m_rf_axis_tready_net
  );
  m_axis_fft : entity xil_defaultlib.axi_qpsk_tx_m_axis_fft 
  port map (
    tdata_in => register5_q_net,
    tvalid_in => register4_q_net_x0,
    tlast_in => register3_q_net_x1,
    m_fft_axis_tready => m_fft_axis_tready_net
  );
  m_axis_symbol : entity xil_defaultlib.axi_qpsk_tx_m_axis_symbol 
  port map (
    tdata_in => convert4_dout_net,
    tvalid_in => register4_q_net,
    tlast_in => register3_q_net,
    m_symbol_axis_tready => m_symbol_axis_tready_net
  );
  m_axis_time : entity xil_defaultlib.axi_qpsk_tx_m_axis_time 
  port map (
    tdata_in => register5_q_net_x0,
    tvalid_in => register4_q_net_x1,
    tlast_in => register3_q_net_x2,
    m_time_axis_tready => m_time_axis_tready_net
  );
  posthb_time_domain : entity xil_defaultlib.axi_qpsk_tx_posthb_time_domain 
  port map (
    time_i_data => mux1_y_net,
    time_i_valid => delay_hb1_q_net,
    time_q_data => mux1_y_net_x0,
    time_q_valid => delay_hb1_q_net_x0,
    reset => slice8_y_net,
    packet_size => packetsizetime_net,
    transfer => slice10_y_net,
    auto_restart => slice9_y_net,
    tready_in => m_time_axis_tready_net,
    clk_1 => clk_net_x1,
    ce_1 => ce_net_x1,
    ce_6400 => we_ce_net,
    tdata_out => register5_q_net_x0,
    tvalid_out => register4_q_net_x1,
    tlast_out => register3_q_net_x2
  );
  post_hb_fft : entity xil_defaultlib.axi_qpsk_tx_post_hb_fft 
  port map (
    post_hb_i_data => mux1_y_net,
    post_hb_i_valid => delay_hb1_q_net,
    post_hb_q_data => mux1_y_net_x0,
    post_hb_q_valid => delay_hb1_q_net_x0,
    reset => slice7_y_net,
    packet_size => packetsizefft_net,
    tready_in => m_fft_axis_tready_net,
    transfer => slice2_y_net,
    auto_restart => slice5_y_net,
    clk_1 => clk_net_x1,
    ce_1 => ce_net_x1,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    tdata_out => register5_q_net,
    tvalid_out => register4_q_net_x0,
    tlast_out => register3_q_net_x1
  );
  qpsk_symbol_mapper : entity xil_defaultlib.axi_qpsk_tx_qpsk_symbol_mapper 
  port map (
    bit_pairs => register_q_net,
    reset => slice1_y_net,
    tready => down_sample1_q_net,
    clk_51200 => clk_net_x0,
    ce_51200 => ce_net_x0,
    i_symbols => register_q_net_x0,
    q_symbols => register1_q_net_x0
  );
  rf_output : entity xil_defaultlib.axi_qpsk_tx_rf_output 
  port map (
    rf_i_data => delay5_q_net,
    rf_i_valid => delay3_q_net,
    rf_i_last => delay4_q_net,
    rf_q_data => delay5_q_net_x0,
    rf_q_valid => delay3_q_net_x0,
    rf_q_last => delay4_q_net_x0,
    out1 => concat_y_net,
    out2 => logical1_y_net,
    out3 => logical2_y_net
  );
  random_data_generator : entity xil_defaultlib.axi_qpsk_tx_random_data_generator 
  port map (
    enable => slice_y_net,
    reset => slice1_y_net,
    tready => down_sample1_q_net,
    packet_size => packetsizerf_net,
    clk_51200 => clk_net_x0,
    ce_51200 => ce_net_x0,
    tvalid_out => register3_q_net_x0,
    bit_pairs => register_q_net
  );
  symbol_2_output : entity xil_defaultlib.axi_qpsk_tx_symbol_2_output 
  port map (
    symbol_i_data => register_q_net_x0,
    symbol_i_valid => register2_q_net,
    symbol_q_data => register1_q_net_x0,
    reset => slice6_y_net,
    packet_size => packetsizesymbol_net,
    transfer => slice3_y_net,
    auto_restart => slice4_y_net,
    tready_in => m_symbol_axis_tready_net,
    clk_1 => clk_net_x1,
    ce_1 => ce_net_x1,
    ce_51200 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
  txinterp_i : entity xil_defaultlib.axi_qpsk_tx_txinterp_i 
  port map (
    input_symbols => register_q_net_x0,
    reset => slice1_y_net,
    tready => down_sample1_q_net,
    tvalid_in => register2_q_net,
    packetsize => packetsizerf_net,
    outputgainstage => reinterpret_output_port_net,
    bypass_gain => slice12_y_net,
    clk_1 => clk_net_x1,
    ce_1 => ce_net_x1,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    clk_12800 => clk_net,
    ce_12800 => ce_net,
    clk_51200 => clk_net_x0,
    ce_51200 => ce_net_x0,
    interpolated => delay5_q_net,
    tvalid_out => delay3_q_net,
    tlast_out => delay4_q_net,
    post_hb_data => mux1_y_net,
    post_hb_valid => delay_hb1_q_net
  );
  txinterp_q : entity xil_defaultlib.axi_qpsk_tx_txinterp_q 
  port map (
    input_symbols => register1_q_net_x0,
    reset => slice1_y_net,
    tready => down_sample1_q_net,
    tvalid_in => register2_q_net,
    packetsize => packetsizerf_net,
    outputgainstage => reinterpret_output_port_net,
    bypass_gain => slice12_y_net,
    clk_1 => clk_net_x1,
    ce_1 => ce_net_x1,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    clk_12800 => clk_net,
    ce_12800 => ce_net,
    clk_51200 => clk_net_x0,
    ce_51200 => ce_net_x0,
    interpolated => delay5_q_net_x0,
    tvalid_out => delay3_q_net_x0,
    tlast_out => delay4_q_net_x0,
    post_hb_data => mux1_y_net_x0,
    post_hb_valid => delay_hb1_q_net_x0
  );
  down_sample1 : entity xil_defaultlib.axi_qpsk_tx_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    ds_ratio => 51200,
    latency => 0,
    phase => 0,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => logical_y_net,
    src_clk => clk_net_x1,
    src_ce => ce_net_x1,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => down_sample1_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_663a092771 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_rf_axis_tready_net,
    d1 => slice11_y_net,
    y => logical_y_net
  );
  register2 : entity xil_defaultlib.axi_qpsk_tx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => register3_q_net_x0,
    rst => slice1_y_net,
    en => down_sample1_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => register2_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Tx_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_struct is
  port (
    autorestartfft : in std_logic_vector( 32-1 downto 0 );
    autorestartsymbol : in std_logic_vector( 32-1 downto 0 );
    autorestarttime : in std_logic_vector( 32-1 downto 0 );
    bypassgain : in std_logic_vector( 32-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    lfsr_rst : in std_logic_vector( 32-1 downto 0 );
    outputgain : in std_logic_vector( 32-1 downto 0 );
    packetsizefft : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    packetsizesymbol : in std_logic_vector( 32-1 downto 0 );
    packetsizetime : in std_logic_vector( 32-1 downto 0 );
    resetfft : in std_logic_vector( 32-1 downto 0 );
    resetsymbol : in std_logic_vector( 32-1 downto 0 );
    resettime : in std_logic_vector( 32-1 downto 0 );
    simulateinterface : in std_logic_vector( 32-1 downto 0 );
    transferfft : in std_logic_vector( 32-1 downto 0 );
    transfersymbol : in std_logic_vector( 32-1 downto 0 );
    transfertime : in std_logic_vector( 32-1 downto 0 );
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_fft_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_time_axis_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
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
    m_time_axis_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_tx_struct;
architecture structural of axi_qpsk_tx_struct is 
  signal m_fft_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal transferfft_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal packetsizetime_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal autorestarttime_net : std_logic_vector( 32-1 downto 0 );
  signal simulateinterface_net : std_logic_vector( 32-1 downto 0 );
  signal transfersymbol_net : std_logic_vector( 32-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal resetsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizefft_net : std_logic_vector( 32-1 downto 0 );
  signal autorestartfft_net : std_logic_vector( 32-1 downto 0 );
  signal autorestartsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal lfsr_rst_net : std_logic_vector( 32-1 downto 0 );
  signal resetfft_net : std_logic_vector( 32-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal bypassgain_net : std_logic_vector( 32-1 downto 0 );
  signal resettime_net : std_logic_vector( 32-1 downto 0 );
  signal transfertime_net : std_logic_vector( 32-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal outputgain_net : std_logic_vector( 32-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal clk_3200_net : std_logic;
  signal m_time_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x1 : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal we_ce_net : std_logic;
  signal src_clk_net : std_logic;
  signal clk_net_x1 : std_logic;
  signal ce_3200_net : std_logic;
  signal ce_net_x0 : std_logic;
begin
  autorestartfft_net <= autorestartfft;
  autorestartsymbol_net <= autorestartsymbol;
  autorestarttime_net <= autorestarttime;
  bypassgain_net <= bypassgain;
  enable_net <= enable;
  lfsr_rst_net <= lfsr_rst;
  outputgain_net <= outputgain;
  packetsizefft_net <= packetsizefft;
  packetsizerf_net <= packetsizerf;
  packetsizesymbol_net <= packetsizesymbol;
  packetsizetime_net <= packetsizetime;
  resetfft_net <= resetfft;
  resetsymbol_net <= resetsymbol;
  resettime_net <= resettime;
  simulateinterface_net <= simulateinterface;
  transferfft_net <= transferfft;
  transfersymbol_net <= transfersymbol;
  transfertime_net <= transfertime;
  m_rf_axis_tdata <= concat_y_net;
  m_rf_axis_tlast <= logical2_y_net;
  m_rf_axis_tready_net <= m_rf_axis_tready;
  m_rf_axis_tvalid <= logical1_y_net;
  m_fft_axis_tdata <= register5_q_net;
  m_fft_axis_tlast <= register3_q_net_x0;
  m_fft_axis_tready_net <= m_fft_axis_tready;
  m_fft_axis_tvalid <= register4_q_net_x0;
  m_symbol_axis_tdata <= convert4_dout_net;
  m_symbol_axis_tlast <= register3_q_net;
  m_symbol_axis_tready_net <= m_symbol_axis_tready;
  m_symbol_axis_tvalid <= register4_q_net;
  m_time_axis_tdata <= register5_q_net_x0;
  m_time_axis_tlast <= register3_q_net_x1;
  m_time_axis_tready_net <= m_time_axis_tready;
  m_time_axis_tvalid <= register4_q_net_x1;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  src_clk_net <= clk_6400;
  we_ce_net <= ce_6400;
  clk_net_x1 <= clk_12800;
  ce_net_x0 <= ce_12800;
  clk_net <= clk_51200;
  ce_net_x1 <= ce_51200;
  axi_qpsk_generator : entity xil_defaultlib.axi_qpsk_tx_axi_qpsk_generator 
  port map (
    autorestartfft => autorestartfft_net,
    autorestartsymbol => autorestartsymbol_net,
    autorestarttime => autorestarttime_net,
    bypassgain => bypassgain_net,
    enable => enable_net,
    lfsr_rst => lfsr_rst_net,
    outputgain => outputgain_net,
    packetsizefft => packetsizefft_net,
    packetsizerf => packetsizerf_net,
    packetsizesymbol => packetsizesymbol_net,
    packetsizetime => packetsizetime_net,
    resetfft => resetfft_net,
    resetsymbol => resetsymbol_net,
    resettime => resettime_net,
    simulateinterface => simulateinterface_net,
    transferfft => transferfft_net,
    transfersymbol => transfersymbol_net,
    transfertime => transfertime_net,
    m_rf_axis_tready => m_rf_axis_tready_net,
    m_fft_axis_tready => m_fft_axis_tready_net,
    m_symbol_axis_tready => m_symbol_axis_tready_net,
    m_time_axis_tready => m_time_axis_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => src_clk_net,
    ce_6400 => we_ce_net,
    clk_12800 => clk_net_x1,
    ce_12800 => ce_net_x0,
    clk_51200 => clk_net,
    ce_51200 => ce_net_x1,
    m_rf_axis_tdata => concat_y_net,
    m_rf_axis_tlast => logical2_y_net,
    m_rf_axis_tvalid => logical1_y_net,
    m_fft_axis_tdata => register5_q_net,
    m_fft_axis_tlast => register3_q_net_x0,
    m_fft_axis_tvalid => register4_q_net_x0,
    m_symbol_axis_tdata => convert4_dout_net,
    m_symbol_axis_tlast => register3_q_net,
    m_symbol_axis_tvalid => register4_q_net,
    m_time_axis_tdata => register5_q_net_x0,
    m_time_axis_tlast => register3_q_net_x1,
    m_time_axis_tvalid => register4_q_net_x1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx_default_clock_driver is
  port (
    axi_qpsk_tx_sysclk : in std_logic;
    axi_qpsk_tx_sysce : in std_logic;
    axi_qpsk_tx_sysclr : in std_logic;
    axi_qpsk_tx_clk1 : out std_logic;
    axi_qpsk_tx_ce1 : out std_logic;
    axi_qpsk_tx_clk3200 : out std_logic;
    axi_qpsk_tx_ce3200 : out std_logic;
    axi_qpsk_tx_clk6400 : out std_logic;
    axi_qpsk_tx_ce6400 : out std_logic;
    axi_qpsk_tx_clk12800 : out std_logic;
    axi_qpsk_tx_ce12800 : out std_logic;
    axi_qpsk_tx_clk51200 : out std_logic;
    axi_qpsk_tx_ce51200 : out std_logic
  );
end axi_qpsk_tx_default_clock_driver;
architecture structural of axi_qpsk_tx_default_clock_driver is 
begin
  clockdriver_x3 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => axi_qpsk_tx_sysclk,
    sysce => axi_qpsk_tx_sysce,
    sysclr => axi_qpsk_tx_sysclr,
    clk => axi_qpsk_tx_clk1,
    ce => axi_qpsk_tx_ce1
  );
  clockdriver_x2 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 3200,
    log_2_period => 12
  )
  port map (
    sysclk => axi_qpsk_tx_sysclk,
    sysce => axi_qpsk_tx_sysce,
    sysclr => axi_qpsk_tx_sysclr,
    clk => axi_qpsk_tx_clk3200,
    ce => axi_qpsk_tx_ce3200
  );
  clockdriver_x1 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 6400,
    log_2_period => 13
  )
  port map (
    sysclk => axi_qpsk_tx_sysclk,
    sysce => axi_qpsk_tx_sysce,
    sysclr => axi_qpsk_tx_sysclr,
    clk => axi_qpsk_tx_clk6400,
    ce => axi_qpsk_tx_ce6400
  );
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 12800,
    log_2_period => 14
  )
  port map (
    sysclk => axi_qpsk_tx_sysclk,
    sysce => axi_qpsk_tx_sysce,
    sysclr => axi_qpsk_tx_sysclr,
    clk => axi_qpsk_tx_clk12800,
    ce => axi_qpsk_tx_ce12800
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 51200,
    log_2_period => 16
  )
  port map (
    sysclk => axi_qpsk_tx_sysclk,
    sysce => axi_qpsk_tx_sysce,
    sysclr => axi_qpsk_tx_sysclr,
    clk => axi_qpsk_tx_clk51200,
    ce => axi_qpsk_tx_ce51200
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_tx is
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
end axi_qpsk_tx;
architecture structural of axi_qpsk_tx is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "axi_qpsk_tx,sysgen_core_2020_1,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplusRFSOC,part=xczu28dr,speed=-2-e,package=ffvg1517,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=39.0625,system_simulink_period=3.90625e-08,waveform_viewer=1,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=1,abs=2,addsub=1,cic_compiler_v4_0=2,cmult=3,concat=4,constant=12,convert=25,counter=7,delay=28,dsamp=1,fifo=3,fir_compiler_v7_2=6,inv=11,lfsr=2,logical=21,mcode=3,mult=4,mux=11,register=27,reinterpret=10,relational=12,shift=4,slice=13,usamp=40,xfft_forward=1,}";
  signal autorestartfft : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf : std_logic_vector( 32-1 downto 0 );
  signal simulateinterface : std_logic_vector( 32-1 downto 0 );
  signal transferfft : std_logic_vector( 32-1 downto 0 );
  signal transfersymbol : std_logic_vector( 32-1 downto 0 );
  signal resetsymbol : std_logic_vector( 32-1 downto 0 );
  signal resettime : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net : std_logic;
  signal packetsizetime : std_logic_vector( 32-1 downto 0 );
  signal ce_3200_net : std_logic;
  signal packetsizefft : std_logic_vector( 32-1 downto 0 );
  signal clk_6400_net : std_logic;
  signal enable : std_logic_vector( 32-1 downto 0 );
  signal resetfft : std_logic_vector( 32-1 downto 0 );
  signal autorestartsymbol : std_logic_vector( 32-1 downto 0 );
  signal outputgain : std_logic_vector( 32-1 downto 0 );
  signal transfertime : std_logic_vector( 32-1 downto 0 );
  signal ce_1_net : std_logic;
  signal clk_3200_net : std_logic;
  signal lfsr_rst : std_logic_vector( 32-1 downto 0 );
  signal bypassgain : std_logic_vector( 32-1 downto 0 );
  signal autorestarttime : std_logic_vector( 32-1 downto 0 );
  signal packetsizesymbol : std_logic_vector( 32-1 downto 0 );
  signal ce_51200_net : std_logic;
  signal clk_12800_net : std_logic;
  signal clk_51200_net : std_logic;
  signal ce_6400_net : std_logic;
  signal ce_12800_net : std_logic;
  signal clk_net : std_logic;
begin
  axi_qpsk_tx_axi_lite_interface : entity xil_defaultlib.axi_qpsk_tx_axi_lite_interface 
  port map (
    axi_qpsk_tx_s_axi_awaddr => axi_qpsk_tx_s_axi_awaddr,
    axi_qpsk_tx_s_axi_awvalid => axi_qpsk_tx_s_axi_awvalid,
    axi_qpsk_tx_s_axi_wdata => axi_qpsk_tx_s_axi_wdata,
    axi_qpsk_tx_s_axi_wstrb => axi_qpsk_tx_s_axi_wstrb,
    axi_qpsk_tx_s_axi_wvalid => axi_qpsk_tx_s_axi_wvalid,
    axi_qpsk_tx_s_axi_bready => axi_qpsk_tx_s_axi_bready,
    axi_qpsk_tx_s_axi_araddr => axi_qpsk_tx_s_axi_araddr,
    axi_qpsk_tx_s_axi_arvalid => axi_qpsk_tx_s_axi_arvalid,
    axi_qpsk_tx_s_axi_rready => axi_qpsk_tx_s_axi_rready,
    axi_qpsk_tx_aresetn => axi_qpsk_tx_aresetn,
    axi_qpsk_tx_aclk => clk,
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
    axi_qpsk_tx_s_axi_awready => axi_qpsk_tx_s_axi_awready,
    axi_qpsk_tx_s_axi_wready => axi_qpsk_tx_s_axi_wready,
    axi_qpsk_tx_s_axi_bresp => axi_qpsk_tx_s_axi_bresp,
    axi_qpsk_tx_s_axi_bvalid => axi_qpsk_tx_s_axi_bvalid,
    axi_qpsk_tx_s_axi_arready => axi_qpsk_tx_s_axi_arready,
    axi_qpsk_tx_s_axi_rdata => axi_qpsk_tx_s_axi_rdata,
    axi_qpsk_tx_s_axi_rresp => axi_qpsk_tx_s_axi_rresp,
    axi_qpsk_tx_s_axi_rvalid => axi_qpsk_tx_s_axi_rvalid,
    clk => clk_net
  );
  axi_qpsk_tx_default_clock_driver : entity xil_defaultlib.axi_qpsk_tx_default_clock_driver 
  port map (
    axi_qpsk_tx_sysclk => clk_net,
    axi_qpsk_tx_sysce => '1',
    axi_qpsk_tx_sysclr => '0',
    axi_qpsk_tx_clk1 => clk_1_net,
    axi_qpsk_tx_ce1 => ce_1_net,
    axi_qpsk_tx_clk3200 => clk_3200_net,
    axi_qpsk_tx_ce3200 => ce_3200_net,
    axi_qpsk_tx_clk6400 => clk_6400_net,
    axi_qpsk_tx_ce6400 => ce_6400_net,
    axi_qpsk_tx_clk12800 => clk_12800_net,
    axi_qpsk_tx_ce12800 => ce_12800_net,
    axi_qpsk_tx_clk51200 => clk_51200_net,
    axi_qpsk_tx_ce51200 => ce_51200_net
  );
  axi_qpsk_tx_struct : entity xil_defaultlib.axi_qpsk_tx_struct 
  port map (
    autorestartfft => autorestartfft,
    autorestartsymbol => autorestartsymbol,
    autorestarttime => autorestarttime,
    bypassgain => bypassgain,
    enable => enable,
    lfsr_rst => lfsr_rst,
    outputgain => outputgain,
    packetsizefft => packetsizefft,
    packetsizerf => packetsizerf,
    packetsizesymbol => packetsizesymbol,
    packetsizetime => packetsizetime,
    resetfft => resetfft,
    resetsymbol => resetsymbol,
    resettime => resettime,
    simulateinterface => simulateinterface,
    transferfft => transferfft,
    transfersymbol => transfersymbol,
    transfertime => transfertime,
    m_rf_axis_tready => m_rf_axis_tready,
    m_fft_axis_tready => m_fft_axis_tready,
    m_symbol_axis_tready => m_symbol_axis_tready,
    m_time_axis_tready => m_time_axis_tready,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_6400_net,
    ce_6400 => ce_6400_net,
    clk_12800 => clk_12800_net,
    ce_12800 => ce_12800_net,
    clk_51200 => clk_51200_net,
    ce_51200 => ce_51200_net,
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
    m_time_axis_tvalid => m_time_axis_tvalid
  );
end structural;
