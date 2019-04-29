-- Generated from Simulink block CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_ctrl is
  port (
    autorestartsymbol : in std_logic_vector( 32-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    lfsr_rst : in std_logic_vector( 32-1 downto 0 );
    packetsizesymbol : in std_logic_vector( 32-1 downto 0 );
    resetsymbol : in std_logic_vector( 32-1 downto 0 );
    transfersymbol : in std_logic_vector( 32-1 downto 0 );
    enable_out : out std_logic_vector( 1-1 downto 0 );
    lfsr_rst_out : out std_logic_vector( 1-1 downto 0 );
    transfersymbol_out : out std_logic_vector( 1-1 downto 0 );
    autorestartsymbol_out : out std_logic_vector( 1-1 downto 0 );
    resetsymbol_out : out std_logic_vector( 1-1 downto 0 )
  );
end qpsk_tx_symbol_gen_ctrl;
architecture structural of qpsk_tx_symbol_gen_ctrl is 
  signal transfersymbol_net : std_logic_vector( 32-1 downto 0 );
  signal resetsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal lfsr_rst_net : std_logic_vector( 32-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal autorestartsymbol_net : std_logic_vector( 32-1 downto 0 );
begin
  enable_out <= slice_y_net;
  lfsr_rst_out <= slice1_y_net;
  transfersymbol_out <= slice3_y_net;
  autorestartsymbol_out <= slice4_y_net;
  resetsymbol_out <= slice6_y_net;
  autorestartsymbol_net <= autorestartsymbol;
  enable_net <= enable;
  lfsr_rst_net <= lfsr_rst;
  packetsizesymbol_net <= packetsizesymbol;
  resetsymbol_net <= resetsymbol;
  transfersymbol_net <= transfersymbol;
  slice : entity xil_defaultlib.qpsk_tx_symbol_gen_xlslice 
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
  slice1 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlslice 
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
  slice3 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlslice 
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
  slice4 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlslice 
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
  slice6 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlslice 
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
end structural;
-- Generated from Simulink block M_AXIS_SYMBOL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_m_axis_symbol is
  port (
    tdata_in : in std_logic_vector( 8-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end qpsk_tx_symbol_gen_m_axis_symbol;
architecture structural of qpsk_tx_symbol_gen_m_axis_symbol is 
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_symbol_axis_tready_net <= m_symbol_axis_tready;
end structural;
-- Generated from Simulink block QPSK_symbol_mapper
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_qpsk_symbol_mapper is
  port (
    bit_pairs : in std_logic_vector( 2-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
    i_symbols : out std_logic_vector( 2-1 downto 0 );
    q_symbols : out std_logic_vector( 2-1 downto 0 )
  );
end qpsk_tx_symbol_gen_qpsk_symbol_mapper;
architecture structural of qpsk_tx_symbol_gen_qpsk_symbol_mapper is 
  signal register_q_net_x0 : std_logic_vector( 2-1 downto 0 );
  signal register1_q_net_x0 : std_logic_vector( 2-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 2-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 2-1 downto 0 );
  signal ce_net : std_logic;
  signal constant1_op_net : std_logic_vector( 2-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 2-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 2-1 downto 0 );
  signal clk_net : std_logic;
  signal mux_y_net : std_logic_vector( 2-1 downto 0 );
begin
  i_symbols <= register_q_net_x0;
  q_symbols <= register1_q_net_x0;
  register_q_net <= bit_pairs;
  slice1_y_net <= reset;
  clk_net <= clk_51200;
  ce_net <= ce_51200;
  constant_x0 : entity xil_defaultlib.sysgen_constant_c8c4086527 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_b8e3a467cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_c8c4086527 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_b8e3a467cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_9bb83b0c60 
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
  mux1 : entity xil_defaultlib.sysgen_mux_9bb83b0c60 
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
  register_x0 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 2,
    init_value => b"00"
  )
  port map (
    en => "1",
    d => mux_y_net,
    rst => slice1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net_x0
  );
  register1 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 2,
    init_value => b"00"
  )
  port map (
    en => "1",
    d => mux1_y_net,
    rst => slice1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net_x0
  );
end structural;
-- Generated from Simulink block Random_data_generator
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_random_data_generator is
  port (
    enable : in std_logic_vector( 1-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    bit_pairs : out std_logic_vector( 2-1 downto 0 )
  );
end qpsk_tx_symbol_gen_random_data_generator;
architecture structural of qpsk_tx_symbol_gen_random_data_generator is 
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal lfsr1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 2-1 downto 0 );
  signal lfsr_dout_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
begin
  tvalid_out <= register3_q_net;
  bit_pairs <= register_q_net;
  slice_y_net <= enable;
  slice1_y_net <= reset;
  clk_net <= clk_51200;
  ce_net <= ce_51200;
  concat : entity xil_defaultlib.sysgen_concat_2c273a2ba5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => lfsr1_dout_net,
    in1 => lfsr_dout_net,
    y => concat_y_net
  );
  lfsr : entity xil_defaultlib.sysgen_lfsr_d7aeaa8912 
  port map (
    clr => '0',
    rst => slice1_y_net,
    en => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => lfsr_dout_net
  );
  lfsr1 : entity xil_defaultlib.sysgen_lfsr_84c7de9677 
  port map (
    clr => '0',
    rst => slice1_y_net,
    en => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => lfsr1_dout_net
  );
  register_x0 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 2,
    init_value => b"00"
  )
  port map (
    en => "1",
    d => concat_y_net,
    rst => slice1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  register2 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    d => slice_y_net,
    rst => slice1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    d => register2_q_net,
    rst => slice1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_axi_write_interface is
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
end qpsk_tx_symbol_gen_axi_write_interface;
architecture structural of qpsk_tx_symbol_gen_axi_write_interface is 
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 4-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal concat_y_net : std_logic_vector( 4-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_full_net : std_logic;
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal fifo_empty_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 7-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 4-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
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
  ce_net <= ce_1;
  ce_net_x0 <= ce_51200;
  constant_x0 : entity xil_defaultlib.sysgen_constant_1acb71f782 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
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
  convert1 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
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
  convert2 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
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
  convert3 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
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
    ce => ce_net,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
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
  counter : entity xil_defaultlib.qpsk_tx_symbol_gen_xlcounter_free 
  generic map (
    core_name0 => "qpsk_tx_symbol_gen_c_counter_binary_v12_0_i0",
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
  fifo : entity xil_defaultlib.qpsk_tx_symbol_gen_xlfifogen_u 
  generic map (
    core_name0 => "qpsk_tx_symbol_gen_fifo_generator_i0",
    data_count_width => 7,
    data_width => 4,
    extra_registers => 1,
    has_ae => 0,
    has_af => 0,
    has_rst => true,
    percent_full_width => 1
  )
  port map (
    en => '1',
    din => concat_y_net,
    we => register2_q_net(0),
    re => logical2_y_net,
    rst => slice6_y_net(0),
    clk => clk_net,
    ce => ce_net,
    we_ce => ce_net_x0,
    re_ce => ce_net,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net,
    dcount => fifo_dcount_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_af11c886ea 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_af11c886ea 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_1f748ed6a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice6_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_735c50577b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_symbol_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_1f748ed6a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_735c50577b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_a61fffe920 
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
  register3 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice6_y_net,
    en => m_symbol_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice6_y_net,
    en => m_symbol_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 4,
    init_value => b"0000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice6_y_net,
    en => m_symbol_axis_tready_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_fb64b2795b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_8c4040f65a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizesymbol_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_m_axis_symbol_ctrl is
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
end qpsk_tx_symbol_gen_m_axis_symbol_ctrl;
architecture structural of qpsk_tx_symbol_gen_m_axis_symbol_ctrl is 
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 4-1 downto 0 );
  signal concat_y_net : std_logic_vector( 4-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 2-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal reinterpret1_output_port_net : std_logic_vector( 2-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 2-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
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
  ce_net <= ce_1;
  ce_net_x0 <= ce_51200;
  axi_write_interface : entity xil_defaultlib.qpsk_tx_symbol_gen_axi_write_interface 
  port map (
    int_reset => slice6_y_net,
    transfer => slice3_y_net,
    auto_restart => slice4_y_net,
    packet_size => packetsizesymbol_net,
    tdata_in => concat_y_net,
    tvalid_in => register2_q_net,
    tready => m_symbol_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_51200 => ce_net_x0,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_1db22441e5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert4 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
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
    ce => ce_net,
    dout => convert4_dout_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_4e3293e801 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register1_q_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_4e3293e801 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register_q_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block Symbol_2_Output
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_symbol_2_output is
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
end qpsk_tx_symbol_gen_symbol_2_output;
architecture structural of qpsk_tx_symbol_gen_symbol_2_output is 
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
  signal register2_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 2-1 downto 0 );
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
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
  ce_net <= ce_1;
  ce_net_x0 <= ce_51200;
  m_axis_symbol_ctrl : entity xil_defaultlib.qpsk_tx_symbol_gen_m_axis_symbol_ctrl 
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
    ce_1 => ce_net,
    ce_51200 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block qpsk_tx_symbol_gen_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_struct is
  port (
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    autorestartsymbol : in std_logic_vector( 32-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    lfsr_rst : in std_logic_vector( 32-1 downto 0 );
    packetsizesymbol : in std_logic_vector( 32-1 downto 0 );
    resetsymbol : in std_logic_vector( 32-1 downto 0 );
    transfersymbol : in std_logic_vector( 32-1 downto 0 );
    m_symbol_axis_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_51200 : in std_logic;
    ce_51200 : in std_logic;
    m_symbol_axis_tdata_x0 : out std_logic_vector( 8-1 downto 0 );
    m_symbol_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tvalid_x0 : out std_logic_vector( 1-1 downto 0 );
    m_symbol_axis_tdata : out std_logic_vector( 8-1 downto 0 );
    m_symbol_axis_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end qpsk_tx_symbol_gen_struct;
architecture structural of qpsk_tx_symbol_gen_struct is 
  signal autorestartsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal lfsr_rst_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal register_q_net : std_logic_vector( 2-1 downto 0 );
  signal transfersymbol_net : std_logic_vector( 32-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 2-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal convert1_dout_net : std_logic_vector( 4-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 4-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 4-1 downto 0 );
  signal register3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal m_symbol_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net_x0 : std_logic_vector( 2-1 downto 0 );
  signal resetsymbol_net : std_logic_vector( 32-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 4-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizesymbol_net : std_logic_vector( 32-1 downto 0 );
begin
  packetsizerf_net <= packetsizerf;
  autorestartsymbol_net <= autorestartsymbol;
  enable_net <= enable;
  lfsr_rst_net <= lfsr_rst;
  packetsizesymbol_net <= packetsizesymbol;
  resetsymbol_net <= resetsymbol;
  transfersymbol_net <= transfersymbol;
  m_symbol_axis_tdata_x0 <= convert4_dout_net;
  m_symbol_axis_tlast <= register3_q_net;
  m_symbol_axis_tready_net <= m_symbol_axis_tready;
  m_symbol_axis_tvalid_x0 <= register4_q_net;
  m_symbol_axis_tdata <= concat_y_net;
  m_symbol_axis_tvalid <= register2_q_net_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  clk_net_x0 <= clk_51200;
  ce_net_x0 <= ce_51200;
  ctrl : entity xil_defaultlib.qpsk_tx_symbol_gen_ctrl 
  port map (
    autorestartsymbol => autorestartsymbol_net,
    enable => enable_net,
    lfsr_rst => lfsr_rst_net,
    packetsizesymbol => packetsizesymbol_net,
    resetsymbol => resetsymbol_net,
    transfersymbol => transfersymbol_net,
    enable_out => slice_y_net,
    lfsr_rst_out => slice1_y_net,
    transfersymbol_out => slice3_y_net,
    autorestartsymbol_out => slice4_y_net,
    resetsymbol_out => slice6_y_net
  );
  m_axis_symbol : entity xil_defaultlib.qpsk_tx_symbol_gen_m_axis_symbol 
  port map (
    tdata_in => convert4_dout_net,
    tvalid_in => register4_q_net,
    tlast_in => register3_q_net,
    m_symbol_axis_tready => m_symbol_axis_tready_net
  );
  qpsk_symbol_mapper : entity xil_defaultlib.qpsk_tx_symbol_gen_qpsk_symbol_mapper 
  port map (
    bit_pairs => register_q_net_x0,
    reset => slice1_y_net,
    clk_51200 => clk_net_x0,
    ce_51200 => ce_net_x0,
    i_symbols => register_q_net,
    q_symbols => register1_q_net
  );
  random_data_generator : entity xil_defaultlib.qpsk_tx_symbol_gen_random_data_generator 
  port map (
    enable => slice_y_net,
    reset => slice1_y_net,
    clk_51200 => clk_net_x0,
    ce_51200 => ce_net_x0,
    tvalid_out => register3_q_net_x0,
    bit_pairs => register_q_net_x0
  );
  symbol_2_output : entity xil_defaultlib.qpsk_tx_symbol_gen_symbol_2_output 
  port map (
    symbol_i_data => register_q_net,
    symbol_i_valid => register2_q_net_x0,
    symbol_q_data => register1_q_net,
    reset => slice6_y_net,
    packet_size => packetsizesymbol_net,
    transfer => slice3_y_net,
    auto_restart => slice4_y_net,
    tready_in => m_symbol_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_51200 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_4cbc566218 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  register2 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    d => register3_q_net_x0,
    rst => slice1_y_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => register2_q_net_x0
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_4012dc8d9e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert_dout_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_4012dc8d9e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => reinterpret1_output_port_net
  );
  convert : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 0,
    din_width => 2,
    dout_arith => 2,
    dout_bin_pt => 0,
    dout_width => 4,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.qpsk_tx_symbol_gen_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 0,
    din_width => 2,
    dout_arith => 2,
    dout_bin_pt => 0,
    dout_width => 4,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register1_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen_default_clock_driver is
  port (
    qpsk_tx_symbol_gen_sysclk : in std_logic;
    qpsk_tx_symbol_gen_sysce : in std_logic;
    qpsk_tx_symbol_gen_sysclr : in std_logic;
    qpsk_tx_symbol_gen_clk1 : out std_logic;
    qpsk_tx_symbol_gen_ce1 : out std_logic;
    qpsk_tx_symbol_gen_clk51200 : out std_logic;
    qpsk_tx_symbol_gen_ce51200 : out std_logic
  );
end qpsk_tx_symbol_gen_default_clock_driver;
architecture structural of qpsk_tx_symbol_gen_default_clock_driver is 
begin
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => qpsk_tx_symbol_gen_sysclk,
    sysce => qpsk_tx_symbol_gen_sysce,
    sysclr => qpsk_tx_symbol_gen_sysclr,
    clk => qpsk_tx_symbol_gen_clk1,
    ce => qpsk_tx_symbol_gen_ce1
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 51200,
    log_2_period => 16
  )
  port map (
    sysclk => qpsk_tx_symbol_gen_sysclk,
    sysce => qpsk_tx_symbol_gen_sysce,
    sysclr => qpsk_tx_symbol_gen_sysclr,
    clk => qpsk_tx_symbol_gen_clk51200,
    ce => qpsk_tx_symbol_gen_ce51200
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity qpsk_tx_symbol_gen is
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
end qpsk_tx_symbol_gen;
architecture structural of qpsk_tx_symbol_gen is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "qpsk_tx_symbol_gen,sysgen_core_2018_3,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplusRFSOC,part=xczu28dr,speed=-2-e,package=ffvg1517,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=39.0625,system_simulink_period=3.90625e-08,waveform_viewer=0,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.2,concat=3,constant=5,convert=8,counter=2,fifo=1,inv=3,lfsr=2,logical=5,mcode=1,mux=2,register=11,reinterpret=4,relational=3,slice=5,}";
  signal autorestartsymbol : std_logic_vector( 32-1 downto 0 );
  signal lfsr_rst : std_logic_vector( 32-1 downto 0 );
  signal resetsymbol : std_logic_vector( 32-1 downto 0 );
  signal transfersymbol : std_logic_vector( 32-1 downto 0 );
  signal enable : std_logic_vector( 32-1 downto 0 );
  signal packetsizesymbol : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net : std_logic;
  signal clk_51200_net : std_logic;
  signal ce_1_net : std_logic;
  signal ce_51200_net : std_logic;
  signal clk_net : std_logic;
begin
  qpsk_tx_symbol_gen_axi_lite_interface : entity xil_defaultlib.qpsk_tx_symbol_gen_axi_lite_interface 
  port map (
    qpsk_tx_symbol_gen_s_axi_awaddr => qpsk_tx_symbol_gen_s_axi_awaddr,
    qpsk_tx_symbol_gen_s_axi_awvalid => qpsk_tx_symbol_gen_s_axi_awvalid,
    qpsk_tx_symbol_gen_s_axi_wdata => qpsk_tx_symbol_gen_s_axi_wdata,
    qpsk_tx_symbol_gen_s_axi_wstrb => qpsk_tx_symbol_gen_s_axi_wstrb,
    qpsk_tx_symbol_gen_s_axi_wvalid => qpsk_tx_symbol_gen_s_axi_wvalid,
    qpsk_tx_symbol_gen_s_axi_bready => qpsk_tx_symbol_gen_s_axi_bready,
    qpsk_tx_symbol_gen_s_axi_araddr => qpsk_tx_symbol_gen_s_axi_araddr,
    qpsk_tx_symbol_gen_s_axi_arvalid => qpsk_tx_symbol_gen_s_axi_arvalid,
    qpsk_tx_symbol_gen_s_axi_rready => qpsk_tx_symbol_gen_s_axi_rready,
    qpsk_tx_symbol_gen_aresetn => qpsk_tx_symbol_gen_aresetn,
    qpsk_tx_symbol_gen_aclk => clk,
    transfersymbol => transfersymbol,
    resetsymbol => resetsymbol,
    packetsizesymbol => packetsizesymbol,
    lfsr_rst => lfsr_rst,
    enable => enable,
    autorestartsymbol => autorestartsymbol,
    packetsizerf => packetsizerf,
    qpsk_tx_symbol_gen_s_axi_awready => qpsk_tx_symbol_gen_s_axi_awready,
    qpsk_tx_symbol_gen_s_axi_wready => qpsk_tx_symbol_gen_s_axi_wready,
    qpsk_tx_symbol_gen_s_axi_bresp => qpsk_tx_symbol_gen_s_axi_bresp,
    qpsk_tx_symbol_gen_s_axi_bvalid => qpsk_tx_symbol_gen_s_axi_bvalid,
    qpsk_tx_symbol_gen_s_axi_arready => qpsk_tx_symbol_gen_s_axi_arready,
    qpsk_tx_symbol_gen_s_axi_rdata => qpsk_tx_symbol_gen_s_axi_rdata,
    qpsk_tx_symbol_gen_s_axi_rresp => qpsk_tx_symbol_gen_s_axi_rresp,
    qpsk_tx_symbol_gen_s_axi_rvalid => qpsk_tx_symbol_gen_s_axi_rvalid,
    clk => clk_net
  );
  qpsk_tx_symbol_gen_default_clock_driver : entity xil_defaultlib.qpsk_tx_symbol_gen_default_clock_driver 
  port map (
    qpsk_tx_symbol_gen_sysclk => clk_net,
    qpsk_tx_symbol_gen_sysce => '1',
    qpsk_tx_symbol_gen_sysclr => '0',
    qpsk_tx_symbol_gen_clk1 => clk_1_net,
    qpsk_tx_symbol_gen_ce1 => ce_1_net,
    qpsk_tx_symbol_gen_clk51200 => clk_51200_net,
    qpsk_tx_symbol_gen_ce51200 => ce_51200_net
  );
  qpsk_tx_symbol_gen_struct : entity xil_defaultlib.qpsk_tx_symbol_gen_struct 
  port map (
    packetsizerf => packetsizerf,
    autorestartsymbol => autorestartsymbol,
    enable => enable,
    lfsr_rst => lfsr_rst,
    packetsizesymbol => packetsizesymbol,
    resetsymbol => resetsymbol,
    transfersymbol => transfersymbol,
    m_symbol_axis_tready => m_symbol_axis_tready,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_51200 => clk_51200_net,
    ce_51200 => ce_51200_net,
    m_symbol_axis_tdata_x0 => m_symbol_axis_tdata_x0,
    m_symbol_axis_tlast => m_symbol_axis_tlast,
    m_symbol_axis_tvalid_x0 => m_symbol_axis_tvalid_x0,
    m_symbol_axis_tdata => m_symbol_axis_tdata,
    m_symbol_axis_tvalid => m_symbol_axis_tvalid
  );
end structural;
