-- Generated from Simulink block De-Rotate Constellation
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_de_rotate_constellation is
  port (
    en_in : in std_logic_vector( 1-1 downto 0 );
    x_in : in std_logic_vector( 16-1 downto 0 );
    y_in : in std_logic_vector( 16-1 downto 0 );
    cos_error : in std_logic_vector( 16-1 downto 0 );
    neg_sin_error : in std_logic_vector( 16-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 19-1 downto 0 );
    y_out : out std_logic_vector( 19-1 downto 0 )
  );
end axi_qpsk_rx_tsync_de_rotate_constellation;
architecture structural of axi_qpsk_rx_tsync_de_rotate_constellation is 
  signal register2_q_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal mult1_p_net : std_logic_vector( 18-1 downto 0 );
  signal mult3_p_net : std_logic_vector( 18-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 18-1 downto 0 );
  signal mult4_p_net : std_logic_vector( 18-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub_s_net : std_logic_vector( 19-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 16-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 19-1 downto 0 );
begin
  x_out <= addsub1_s_net;
  y_out <= addsub_s_net;
  logical_y_net <= en_in;
  delay2_q_net <= x_in;
  delay3_q_net <= y_in;
  register2_q_net <= cos_error;
  register3_q_net <= neg_sin_error;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 18,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 18,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 19,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 19,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 19
  )
  port map (
    clr => '0',
    en => "1",
    a => mult1_p_net,
    b => mult3_p_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  addsub1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 18,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 18,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 19,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i1",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 19,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 19
  )
  port map (
    clr => '0',
    en => "1",
    a => mult2_p_net,
    b => mult4_p_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  mult1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 18,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay2_q_net,
    b => register3_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 18,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay2_q_net,
    b => register2_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult2_p_net
  );
  mult3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 18,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay3_q_net,
    b => register2_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult3_p_net
  );
  mult4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 18,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay3_q_net,
    b => register3_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult4_p_net
  );
end structural;
-- Generated from Simulink block Vectoring Cell 2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_2 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 );
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_2;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_2 is 
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal delay5_q_net : std_logic_vector( 20-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay3_q_net <= x_in;
  delay4_q_net <= y_in;
  delay5_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_0985f9734e 
  port map (
    clr => '0',
    a => delay5_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay3_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay4_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_021e034365 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_41dde04530 
  port map (
    clr => '0',
    ip => delay3_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_41dde04530 
  port map (
    clr => '0',
    ip => delay4_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay3_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay4_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Vectoring Cell 3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_3 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 );
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_3;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_3 is 
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 20-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 20-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay6_q_net <= x_in;
  delay7_q_net <= y_in;
  delay8_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_0985f9734e 
  port map (
    clr => '0',
    a => delay8_q_net,
    b => constant1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay6_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay7_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_23373b56d4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_ae1da486de 
  port map (
    clr => '0',
    ip => delay6_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_ae1da486de 
  port map (
    clr => '0',
    ip => delay7_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay6_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay7_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Vectoring Cell 4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_4 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 );
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_4;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_4 is 
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 20-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay9_q_net <= x_in;
  delay10_q_net <= y_in;
  delay11_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_0985f9734e 
  port map (
    clr => '0',
    a => delay11_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay9_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay10_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_f3ad42bf7f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_45d58034ad 
  port map (
    clr => '0',
    ip => delay9_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_45d58034ad 
  port map (
    clr => '0',
    ip => delay10_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay9_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay10_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Vectoring Cell 5
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_5 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 );
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_5;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_5 is 
  signal clk_net : std_logic;
  signal delay14_q_net : std_logic_vector( 20-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay12_q_net <= x_in;
  delay13_q_net <= y_in;
  delay14_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_0985f9734e 
  port map (
    clr => '0',
    a => delay14_q_net,
    b => constant1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay12_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay13_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_fa3290153c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_68b15d5c90 
  port map (
    clr => '0',
    ip => delay12_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_68b15d5c90 
  port map (
    clr => '0',
    ip => delay13_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay12_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay13_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Vectoring Cell 6
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_6 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 );
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_6;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_6 is 
  signal clk_net : std_logic;
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal delay17_q_net : std_logic_vector( 20-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay15_q_net <= x_in;
  delay16_q_net <= y_in;
  delay17_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_0985f9734e 
  port map (
    clr => '0',
    a => delay17_q_net,
    b => constant1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay15_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay16_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_4bead40404 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_e5679d78b3 
  port map (
    clr => '0',
    ip => delay15_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_e5679d78b3 
  port map (
    clr => '0',
    ip => delay16_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay15_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay16_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Vectoring Cell 7
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_7 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_7;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_7 is 
  signal ce_net : std_logic;
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay20_q_net : std_logic_vector( 20-1 downto 0 );
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  z_out <= addsub1_s_net;
  delay18_q_net <= x_in;
  delay19_q_net <= y_in;
  delay20_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_0985f9734e 
  port map (
    clr => '0',
    a => delay20_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_d34446bed9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay18_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay19_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Vectoring  Cell 0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_0 is
  port (
    x_in : in std_logic_vector( 19-1 downto 0 );
    y_in : in std_logic_vector( 19-1 downto 0 );
    z_in : in std_logic_vector( 16-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 );
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_0;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_0 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal constant_op_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
  signal register4_q_net : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  register4_q_net <= x_in;
  register5_q_net <= y_in;
  constant_op_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_502a276a3b 
  port map (
    clr => '0',
    a => constant_op_net,
    b => constant_op_net_x0,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_bac345244d 
  port map (
    clr => '0',
    a => register4_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_bac345244d 
  port map (
    clr => '0',
    a => register5_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_8cb4c42f92 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net_x0
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_9e631d32c7 
  port map (
    clr => '0',
    ip => register4_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_9e631d32c7 
  port map (
    clr => '0',
    ip => register5_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 18,
    x_width => 19,
    y_width => 1
  )
  port map (
    x => register4_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 18,
    x_width => 19,
    y_width => 1
  )
  port map (
    x => register5_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Vectoring  Cell 1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_vectoring_cell_1 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 );
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_tsync_vectoring_cell_1;
architecture structural of axi_qpsk_rx_tsync_vectoring_cell_1 is 
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal delay2_q_net : std_logic_vector( 20-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal delay_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal ce_net : std_logic;
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay_q_net <= x_in;
  delay1_q_net <= y_in;
  delay2_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_0985f9734e 
  port map (
    clr => '0',
    a => delay2_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_d474495ee2 
  port map (
    clr => '0',
    a => delay1_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_e478a4cb34 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_f2543bac47 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_d6924d5698 
  port map (
    clr => '0',
    ip => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_d6924d5698 
  port map (
    clr => '0',
    ip => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay1_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block Generate Angle Error
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_generate_angle_error is
  port (
    x_out : in std_logic_vector( 19-1 downto 0 );
    y_out : in std_logic_vector( 19-1 downto 0 );
    x_out_q : in std_logic_vector( 1-1 downto 0 );
    y_out_q : in std_logic_vector( 1-1 downto 0 );
    en_in : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    angle_error : out std_logic_vector( 21-1 downto 0 );
    en_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_generate_angle_error;
architecture structural of axi_qpsk_rx_tsync_generate_angle_error is 
  signal delay20_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x3 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay14_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub3_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x6 : std_logic_vector( 20-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub3_s_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal register4_q_net : std_logic_vector( 19-1 downto 0 );
  signal addsub3_s_net_x1 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x3 : std_logic_vector( 20-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay21_q_net : std_logic_vector( 2-1 downto 0 );
  signal addsub1_s_net_x4 : std_logic_vector( 20-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 21-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay22_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x5 : std_logic_vector( 20-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay17_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x1 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net : std_logic_vector( 2-1 downto 0 );
  signal delay23_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal delay_q_net : std_logic_vector( 15-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  angle_error <= addsub_s_net;
  en_out <= delay23_q_net;
  register4_q_net <= x_out;
  register5_q_net <= y_out;
  slice_y_net <= x_out_q;
  slice1_y_net <= y_out_q;
  delay_q_net_x0 <= en_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  vectoring_cell_2 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_2 
  port map (
    x_in => delay3_q_net,
    y_in => delay4_q_net,
    z_in => delay5_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub2_s_net_x6,
    y_out => addsub3_s_net_x6,
    z_out => addsub1_s_net_x5
  );
  vectoring_cell_3 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_3 
  port map (
    x_in => delay6_q_net,
    y_in => delay7_q_net,
    z_in => delay8_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub2_s_net_x4,
    y_out => addsub3_s_net_x2,
    z_out => addsub1_s_net_x6
  );
  vectoring_cell_4 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_4 
  port map (
    x_in => delay9_q_net,
    y_in => delay10_q_net,
    z_in => delay11_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub2_s_net,
    y_out => addsub3_s_net_x1,
    z_out => addsub1_s_net_x3
  );
  vectoring_cell_5 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_5 
  port map (
    x_in => delay12_q_net,
    y_in => delay13_q_net,
    z_in => delay14_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub2_s_net_x2,
    y_out => addsub3_s_net_x0,
    z_out => addsub1_s_net_x1
  );
  vectoring_cell_6 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_6 
  port map (
    x_in => delay15_q_net,
    y_in => delay16_q_net,
    z_in => delay17_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub2_s_net_x1,
    y_out => addsub3_s_net,
    z_out => addsub1_s_net_x0
  );
  vectoring_cell_7 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_7 
  port map (
    x_in => delay18_q_net,
    y_in => delay19_q_net,
    z_in => delay20_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    z_out => addsub1_s_net
  );
  vectoring_cell_0 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_0 
  port map (
    x_in => register4_q_net,
    y_in => register5_q_net,
    z_in => constant_op_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub2_s_net_x3,
    y_out => addsub3_s_net_x4,
    z_out => addsub1_s_net_x4
  );
  vectoring_cell_1 : entity xil_defaultlib.axi_qpsk_rx_tsync_vectoring_cell_1 
  port map (
    x_in => delay_q_net,
    y_in => delay1_q_net,
    z_in => delay2_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub2_s_net_x5,
    y_out => addsub3_s_net_x5,
    z_out => addsub1_s_net_x2
  );
  addsub : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 18,
    a_width => 20,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 21,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i2",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 21,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 18,
    s_width => 21
  )
  port map (
    clr => '0',
    en => "1",
    a => addsub1_s_net,
    b => delay22_q_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  concat : entity xil_defaultlib.sysgen_concat_1c4dae9eb2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => slice_y_net,
    in1 => slice1_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_19d84134a9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net_x3,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net_x4,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay10 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net_x2,
    clk => clk_net,
    ce => ce_net,
    q => delay10_q_net
  );
  delay11 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 20
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net_x6,
    clk => clk_net,
    ce => ce_net,
    q => delay11_q_net
  );
  delay12 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net,
    clk => clk_net,
    ce => ce_net,
    q => delay12_q_net
  );
  delay13 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net_x1,
    clk => clk_net,
    ce => ce_net,
    q => delay13_q_net
  );
  delay14 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 20
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net_x3,
    clk => clk_net,
    ce => ce_net,
    q => delay14_q_net
  );
  delay15 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net_x2,
    clk => clk_net,
    ce => ce_net,
    q => delay15_q_net
  );
  delay16 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay16_q_net
  );
  delay17 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 20
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net_x1,
    clk => clk_net,
    ce => ce_net,
    q => delay17_q_net
  );
  delay18 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net_x1,
    clk => clk_net,
    ce => ce_net,
    q => delay18_q_net
  );
  delay19 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net,
    clk => clk_net,
    ce => ce_net,
    q => delay19_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 20
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net_x4,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay20 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 20
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay20_q_net
  );
  delay21 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 2
  )
  port map (
    en => '1',
    rst => '1',
    d => concat_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay21_q_net
  );
  delay22 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 5,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => rom_data_net,
    clk => clk_net,
    ce => ce_net,
    q => delay22_q_net
  );
  delay23 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 8,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay23_q_net
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net_x5,
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net_x5,
    clk => clk_net,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 20
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net_x2,
    clk => clk_net,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net_x6,
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  delay7 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net_x6,
    clk => clk_net,
    ce => ce_net,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 20
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub1_s_net_x5,
    clk => clk_net,
    ce => ce_net,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net_x4,
    clk => clk_net,
    ce => ce_net,
    q => delay9_q_net
  );
  rom : entity xil_defaultlib.axi_qpsk_rx_tsync_xlsprom 
  generic map (
    c_address_width => 2,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_tsync_blk_mem_gen_i0",
    latency => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => delay21_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom_data_net
  );
end structural;
-- Generated from Simulink block Loop Filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_loop_filter_x0 is
  port (
    signal_x0 : in std_logic_vector( 21-1 downto 0 );
    en_in : in std_logic_vector( 1-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    error_filt : out std_logic_vector( 39-1 downto 0 );
    en_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_loop_filter_x0;
architecture structural of axi_qpsk_rx_tsync_loop_filter_x0 is 
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 39-1 downto 0 );
  signal register1_q_net_x0 : std_logic_vector( 38-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 38-1 downto 0 );
  signal mux_y_net : std_logic_vector( 38-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal register1_q_net : std_logic_vector( 21-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 36-1 downto 0 );
begin
  error_filt <= addsub3_s_net;
  en_out <= delay_q_net;
  register1_q_net <= signal_x0;
  delay1_q_net <= en_in;
  relational_op_net <= reset;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 32,
    a_width => 36,
    b_arith => xlSigned,
    b_bin_pt => 28,
    b_width => 38,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 43,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i3",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 43,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 28,
    s_width => 39
  )
  port map (
    clr => '0',
    en => "1",
    a => cmult_p_net,
    b => addsub4_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  addsub4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 32,
    a_width => 39,
    b_arith => xlSigned,
    b_bin_pt => 28,
    b_width => 38,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 43,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i3",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 43,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 28,
    s_width => 38
  )
  port map (
    clr => '0',
    en => "1",
    a => cmult1_p_net,
    b => register1_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  cmult : entity xil_defaultlib.axi_qpsk_rx_tsync_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 18,
    a_width => 21,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 21,
    c_b_type => 1,
    c_b_width => 15,
    c_output_width => 36,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i1",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 32,
    p_width => 36,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 18,
    a_width => 21,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 21,
    c_b_type => 1,
    c_b_width => 18,
    c_output_width => 39,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i2",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 32,
    p_width => 39,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult1_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_19d84134a9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_4eb3e59825 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => delay1_q_net,
    d0 => constant_op_net,
    d1 => addsub4_s_net,
    y => mux_y_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 38,
    init_value => b"00000000000000000000000000000000000000"
  )
  port map (
    d => mux_y_net,
    rst => relational_op_net,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net_x0
  );
end structural;
-- Generated from Simulink block NCO
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_nco is
  port (
    step_size : in std_logic_vector( 39-1 downto 0 );
    en_in : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    cos : out std_logic_vector( 16-1 downto 0 );
    neg_sin : out std_logic_vector( 16-1 downto 0 );
    en_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_nco;
architecture structural of axi_qpsk_rx_tsync_nco is 
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 22-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 22-1 downto 0 );
  signal register1_q_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 8-1 downto 0 );
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 22-1 downto 0 );
  signal neg_sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
begin
  cos <= cos_rom_data_net;
  neg_sin <= neg_sin_rom_data_net;
  en_out <= delay_q_net_x0;
  addsub3_s_net <= step_size;
  delay_q_net <= en_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 22,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 22,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 23,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i4",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 23,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 22
  )
  port map (
    clr => '0',
    en => "1",
    a => cmult1_p_net,
    b => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  cmult1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 28,
    a_width => 39,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 39,
    c_b_type => 1,
    c_b_width => 20,
    c_output_width => 59,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i3",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 22,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => addsub3_s_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult1_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_19d84134a9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 22,
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
    din => addsub4_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  cos_rom : entity xil_defaultlib.axi_qpsk_rx_tsync_xlsprom 
  generic map (
    c_address_width => 8,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_tsync_blk_mem_gen_i1",
    latency => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => convert1_dout_net,
    clk => clk_net,
    ce => ce_net,
    data => cos_rom_data_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net_x0
  );
  mux : entity xil_defaultlib.sysgen_mux_7842e69b1c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => delay_q_net,
    d0 => constant_op_net,
    d1 => addsub4_s_net,
    y => mux_y_net
  );
  neg_sin_rom : entity xil_defaultlib.axi_qpsk_rx_tsync_xlsprom 
  generic map (
    c_address_width => 8,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_tsync_blk_mem_gen_i2",
    latency => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => convert1_dout_net,
    clk => clk_net,
    ce => ce_net,
    data => neg_sin_rom_data_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 22,
    init_value => b"0000000000000000000000"
  )
  port map (
    rst => "0",
    d => mux_y_net,
    en => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
end structural;
-- Generated from Simulink block Carrier Synch
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_carrier_synch is
  port (
    sample_strobe : in std_logic_vector( 1-1 downto 0 );
    x_in : in std_logic_vector( 16-1 downto 0 );
    y_in : in std_logic_vector( 16-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    symbol_strobe : out std_logic_vector( 1-1 downto 0 );
    i_out : out std_logic_vector( 19-1 downto 0 );
    q_out : out std_logic_vector( 19-1 downto 0 )
  );
end axi_qpsk_rx_tsync_carrier_synch;
architecture structural of axi_qpsk_rx_tsync_carrier_synch is 
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 19-1 downto 0 );
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal neg_sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 16-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal delay_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 21-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 21-1 downto 0 );
  signal delay23_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal addsub_s_net_x0 : std_logic_vector( 19-1 downto 0 );
  signal register2_q_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net : std_logic_vector( 16-1 downto 0 );
begin
  symbol_strobe <= delay_q_net;
  i_out <= register4_q_net;
  q_out <= register5_q_net;
  logical_y_net <= sample_strobe;
  delay2_q_net <= x_in;
  delay3_q_net <= y_in;
  relational_op_net <= reset;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  de_rotate_constellation : entity xil_defaultlib.axi_qpsk_rx_tsync_de_rotate_constellation 
  port map (
    en_in => logical_y_net,
    x_in => delay2_q_net,
    y_in => delay3_q_net,
    cos_error => register2_q_net,
    neg_sin_error => register3_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub1_s_net,
    y_out => addsub_s_net_x0
  );
  generate_angle_error : entity xil_defaultlib.axi_qpsk_rx_tsync_generate_angle_error 
  port map (
    x_out => register4_q_net,
    y_out => register5_q_net,
    x_out_q => slice_y_net,
    y_out_q => slice1_y_net,
    en_in => delay_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    angle_error => addsub_s_net,
    en_out => delay23_q_net
  );
  loop_filter : entity xil_defaultlib.axi_qpsk_rx_tsync_loop_filter_x0 
  port map (
    signal_x0 => register1_q_net,
    en_in => delay1_q_net,
    reset => relational_op_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    error_filt => addsub3_s_net,
    en_out => delay_q_net_x1
  );
  nco : entity xil_defaultlib.axi_qpsk_rx_tsync_nco 
  port map (
    step_size => addsub3_s_net,
    en_in => delay_q_net_x1,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    cos => cos_rom_data_net,
    neg_sin => neg_sin_rom_data_net,
    en_out => delay_q_net_x0
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay23_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 21,
    init_value => b"000000000000000000000"
  )
  port map (
    rst => "0",
    d => addsub_s_net,
    en => delay23_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
  register2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0100000000000000"
  )
  port map (
    rst => "0",
    d => cos_rom_data_net,
    en => delay_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    rst => "0",
    d => neg_sin_rom_data_net,
    en => delay_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 19,
    init_value => b"0000100000000000000"
  )
  port map (
    rst => "0",
    d => addsub1_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 19,
    init_value => b"0000100000000000000"
  )
  port map (
    rst => "0",
    d => addsub_s_net_x0,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 18,
    x_width => 19,
    y_width => 1
  )
  port map (
    x => register4_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 18,
    x_width => 19,
    y_width => 1
  )
  port map (
    x => register5_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_axi_write_interface is
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
    ce_1600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_axi_write_interface;
architecture structural of axi_qpsk_rx_tsync_axi_write_interface is 
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal logical2_y_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 8-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice1_y_net <= int_reset;
  slice2_y_net <= transfer;
  slice_y_net <= auto_restart;
  packetsizerf_net <= packet_size;
  concat_y_net <= tdata_in;
  delay_q_net <= tvalid_in;
  m_axis_tap_tready_net <= tready;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_1600;
  constant_x0 : entity xil_defaultlib.sysgen_constant_c58a18529d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
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
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
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
    din => slice_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_rx_tsync_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_tsync_c_counter_binary_v12_0_i1",
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
  fifo : entity xil_defaultlib.axi_qpsk_rx_tsync_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_rx_tsync_fifo_generator_i0",
    data_count_width => 8,
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
    we => delay_q_net(0),
    re => logical2_y_net,
    rst => slice1_y_net(0),
    clk => clk_net,
    ce => ce_net_x0,
    we_ce => ce_net,
    re_ce => ce_net_x0,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net,
    dcount => fifo_dcount_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_ffa53b05ba 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_ad36c2ea6e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice1_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_eca05ff97b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_axis_tap_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_ad36c2ea6e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_eca05ff97b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_63d5ede9bf 
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
  register3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice1_y_net,
    en => m_axis_tap_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice1_y_net,
    en => m_axis_tap_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice1_y_net,
    en => m_axis_tap_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_f0e5fbf8fc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_c782154ba9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizerf_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_m_axis_symbol_ctrl is
  port (
    i_data : in std_logic_vector( 19-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    q_data : in std_logic_vector( 19-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_m_axis_symbol_ctrl;
architecture structural of axi_qpsk_rx_tsync_m_axis_symbol_ctrl is 
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal register5_q_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  register4_q_net_x0 <= i_data;
  delay_q_net <= tvalid_in;
  register5_q_net <= q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  m_axis_tap_tready_net <= tready_in;
  slice2_y_net <= transfer;
  slice_y_net <= auto_restart;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_1600;
  ce_net_x0 <= ce_1600;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_rx_tsync_axi_write_interface 
  port map (
    int_reset => slice1_y_net,
    transfer => slice2_y_net,
    auto_restart => slice_y_net,
    packet_size => packetsizerf_net,
    tdata_in => concat_y_net,
    tvalid_in => delay_q_net,
    tready => m_axis_tap_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    ce_1600 => ce_net_x0,
    tdata_out => register5_q_net_x0,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_cae2bdbbdb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 19,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
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
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 19,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register4_q_net_x0,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlconvert 
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
    din => register5_q_net_x0,
    clk => clk_net_x0,
    ce => ce_net,
    dout => convert4_dout_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_981fb3effc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert_dout_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_981fb3effc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block Data Inspector
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_data_inspector is
  port (
    symbol_i_data : in std_logic_vector( 19-1 downto 0 );
    symbol_i_valid : in std_logic_vector( 1-1 downto 0 );
    symbol_q_data : in std_logic_vector( 19-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_data_inspector;
architecture structural of axi_qpsk_rx_tsync_data_inspector is 
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 19-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  register4_q_net_x0 <= symbol_i_data;
  delay_q_net <= symbol_i_valid;
  register5_q_net <= symbol_q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  slice2_y_net <= transfer;
  slice_y_net <= auto_restart;
  m_axis_tap_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  clk_net_x0 <= clk_1600;
  ce_net_x0 <= ce_1600;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_rx_tsync_m_axis_symbol_ctrl 
  port map (
    i_data => register4_q_net_x0,
    tvalid_in => delay_q_net,
    q_data => register5_q_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    tready_in => m_axis_tap_tready_net,
    transfer => slice2_y_net,
    auto_restart => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    clk_1600 => clk_net_x0,
    ce_1600 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block M_AXIS_TAP
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_m_axis_tap is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_m_axis_tap;
architecture structural of axi_qpsk_rx_tsync_m_axis_tap is 
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_axis_tap_tready_net <= m_axis_tap_tready;
end structural;
-- Generated from Simulink block Loop Filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_loop_filter is
  port (
    signal_x0 : in std_logic_vector( 20-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    error_filt : out std_logic_vector( 39-1 downto 0 )
  );
end axi_qpsk_rx_tsync_loop_filter;
architecture structural of axi_qpsk_rx_tsync_loop_filter is 
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal register_q_net : std_logic_vector( 20-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 1-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 35-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 38-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 38-1 downto 0 );
  signal register1_q_net : std_logic_vector( 38-1 downto 0 );
  signal mux_y_net : std_logic_vector( 38-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
begin
  error_filt <= addsub3_s_net;
  register_q_net <= signal_x0;
  delay10_q_net <= en;
  relational_op_net <= reset;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 28,
    a_width => 35,
    b_arith => xlSigned,
    b_bin_pt => 28,
    b_width => 38,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 39,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i6",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 39,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 28,
    s_width => 39
  )
  port map (
    clr => '0',
    en => "1",
    a => cmult_p_net,
    b => addsub4_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  addsub4 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 28,
    a_width => 38,
    b_arith => xlSigned,
    b_bin_pt => 28,
    b_width => 38,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 39,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i6",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 39,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 28,
    s_width => 38
  )
  port map (
    clr => '0',
    en => "1",
    a => cmult1_p_net,
    b => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  cmult : entity xil_defaultlib.axi_qpsk_rx_tsync_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 20,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 20,
    c_b_type => 1,
    c_b_width => 15,
    c_output_width => 35,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i4",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 28,
    p_width => 35,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => register_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 20,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 20,
    c_b_type => 1,
    c_b_width => 18,
    c_output_width => 38,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i5",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 28,
    p_width => 38,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => register_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult1_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_19d84134a9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_4eb3e59825 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => delay10_q_net,
    d0 => constant_op_net,
    d1 => addsub4_s_net,
    y => mux_y_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 38,
    init_value => b"00000000000000000000000000000000000000"
  )
  port map (
    d => mux_y_net,
    rst => relational_op_net,
    en => delay10_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
end structural;
-- Generated from Simulink block NCC
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_ncc is
  port (
    error_filt : in std_logic_vector( 39-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    strobe : out std_logic_vector( 1-1 downto 0 );
    adj_step : out std_logic_vector( 26-1 downto 0 )
  );
end axi_qpsk_rx_tsync_ncc;
architecture structural of axi_qpsk_rx_tsync_ncc is 
  signal constant1_op_net : std_logic_vector( 26-1 downto 0 );
  signal addsub6_s_net : std_logic_vector( 26-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 29-1 downto 0 );
  signal register_q_net : std_logic_vector( 30-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 30-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub5_s_net : std_logic_vector( 30-1 downto 0 );
  signal mux_y_net : std_logic_vector( 29-1 downto 0 );
begin
  strobe <= relational_op_net;
  adj_step <= addsub6_s_net;
  addsub3_s_net <= error_filt;
  logical1_y_net <= en;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 24,
    a_width => 30,
    b_arith => xlUnsigned,
    b_bin_pt => 24,
    b_width => 30,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 31,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i7",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 31,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 24,
    s_width => 29
  )
  port map (
    clr => '0',
    en => "1",
    a => register_q_net,
    b => constant2_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub5 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 24,
    a_width => 29,
    b_arith => xlUnsigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 30,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i8",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 30,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 24,
    s_width => 30
  )
  port map (
    clr => '0',
    en => "1",
    a => mux_y_net,
    b => addsub6_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub5_s_net
  );
  addsub6 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 28,
    a_width => 39,
    b_arith => xlUnsigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 40,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i9",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 40,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addsub3_s_net,
    b => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub6_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_d8bed3f508 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_209a9c014e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_3177d60273 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => relational1_op_net,
    d0 => register_q_net,
    d1 => addsub1_s_net,
    y => mux_y_net
  );
  register_x0 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 30,
    init_value => b"000010000000000000000000000000"
  )
  port map (
    rst => "0",
    d => addsub5_s_net,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_acbee475ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => register_q_net,
    b => addsub5_s_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_acbee475ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => register_q_net,
    b => constant2_op_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block Timing Synch
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_timing_synch is
  port (
    i_in : in std_logic_vector( 16-1 downto 0 );
    q_in : in std_logic_vector( 16-1 downto 0 );
    valid_in : in std_logic_vector( 1-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    sample_valid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_timing_synch;
architecture structural of axi_qpsk_rx_tsync_timing_synch is 
  signal delay12_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal register_q_net : std_logic_vector( 20-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 20-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 19-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 18-1 downto 0 );
  signal delay_q_net : std_logic_vector( 18-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 19-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 18-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 18-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub6_s_net : std_logic_vector( 26-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
begin
  sample_valid <= delay12_q_net;
  reinterpret_output_port_net <= i_in;
  reinterpret1_output_port_net <= q_in;
  logical1_y_net <= valid_in;
  relational_op_net_x0 <= reset;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  loop_filter : entity xil_defaultlib.axi_qpsk_rx_tsync_loop_filter 
  port map (
    signal_x0 => register_q_net,
    en => delay10_q_net,
    reset => relational_op_net_x0,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    error_filt => addsub3_s_net
  );
  ncc : entity xil_defaultlib.axi_qpsk_rx_tsync_ncc 
  port map (
    error_filt => addsub3_s_net,
    en => logical1_y_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    strobe => relational_op_net,
    adj_step => addsub6_s_net
  );
  addsub : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 18,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 18,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 19,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i1",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 19,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 19
  )
  port map (
    clr => '0',
    en => "1",
    a => mult2_p_net,
    b => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  addsub1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 18,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 18,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 19,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i1",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 19,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 19
  )
  port map (
    clr => '0',
    en => "1",
    a => mult1_p_net,
    b => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 19,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 19,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 20,
    core_name0 => "axi_qpsk_rx_tsync_c_addsub_v12_0_i5",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 20,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 20
  )
  port map (
    clr => '0',
    en => "1",
    a => addsub_s_net,
    b => addsub1_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 32,
    reg_retiming => 0,
    reset => 0,
    width => 18
  )
  port map (
    en => '1',
    rst => '1',
    d => mult2_p_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 32,
    reg_retiming => 0,
    reset => 0,
    width => 18
  )
  port map (
    en => '1',
    rst => '1',
    d => mult1_p_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay10 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay10_q_net
  );
  delay11 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 16,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay11_q_net
  );
  delay12 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay11_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay12_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_eca05ff97b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational_op_net,
    d1 => logical1_y_net,
    y => logical_y_net
  );
  mult1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 18,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => reinterpret1_output_port_net,
    b => reinterpret1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "axi_qpsk_rx_tsync_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 18,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => reinterpret_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult2_p_net
  );
  register_x0 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlregister 
  generic map (
    d_width => 20,
    init_value => b"00000000000000000000"
  )
  port map (
    rst => "0",
    d => addsub2_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_tsync_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_struct is
  port (
    enable : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    rxreset : in std_logic_vector( 32-1 downto 0 );
    auto_restart : in std_logic_vector( 32-1 downto 0 );
    s_axis_tdata : in std_logic_vector( 32-1 downto 0 );
    s_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    syncreset : in std_logic_vector( 32-1 downto 0 );
    transfer : in std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    m_axis_tap_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tlast : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_tsync_struct;
architecture structural of axi_qpsk_rx_tsync_struct is 
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal rxreset_net : std_logic_vector( 32-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 16-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 32-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal auto_restart_net : std_logic_vector( 32-1 downto 0 );
  signal s_axis_tdata_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal clk_net : std_logic;
  signal syncreset_net : std_logic_vector( 32-1 downto 0 );
  signal i_samples_y_net : std_logic_vector( 16-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal q_samples_y_net : std_logic_vector( 16-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal transfer_net : std_logic_vector( 32-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
begin
  enable_net <= enable;
  packetsizerf_net <= packetsizerf;
  rxreset_net <= rxreset;
  auto_restart_net <= auto_restart;
  s_axis_tdata_net <= s_axis_tdata;
  s_axis_tvalid_net <= s_axis_tvalid;
  syncreset_net <= syncreset;
  transfer_net <= transfer;
  m_axis_tap_tdata <= convert4_dout_net;
  m_axis_tap_tlast <= register3_q_net;
  m_axis_tap_tready_net <= m_axis_tap_tready;
  m_axis_tap_tvalid <= register4_q_net;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  carrier_synch : entity xil_defaultlib.axi_qpsk_rx_tsync_carrier_synch 
  port map (
    sample_strobe => logical_y_net,
    x_in => delay2_q_net,
    y_in => delay3_q_net,
    reset => relational_op_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    symbol_strobe => delay_q_net_x0,
    i_out => register4_q_net_x0,
    q_out => register5_q_net
  );
  data_inspector : entity xil_defaultlib.axi_qpsk_rx_tsync_data_inspector 
  port map (
    symbol_i_data => register4_q_net_x0,
    symbol_i_valid => delay_q_net_x0,
    symbol_q_data => register5_q_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    transfer => slice2_y_net,
    auto_restart => slice_y_net,
    tready_in => m_axis_tap_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
  m_axis_tap : entity xil_defaultlib.axi_qpsk_rx_tsync_m_axis_tap 
  port map (
    tdata_in => convert4_dout_net,
    tvalid_in => register4_q_net,
    tlast_in => register3_q_net,
    m_axis_tap_tready => m_axis_tap_tready_net
  );
  timing_synch : entity xil_defaultlib.axi_qpsk_rx_tsync_timing_synch 
  port map (
    i_in => reinterpret_output_port_net,
    q_in => reinterpret1_output_port_net,
    valid_in => logical1_y_net,
    reset => relational_op_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    sample_valid => delay12_q_net
  );
  counter : entity xil_defaultlib.axi_qpsk_rx_tsync_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_tsync_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    en => "1",
    clr => '0',
    rst => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 16,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 16,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => reinterpret1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  delay5 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 32
  )
  port map (
    en => '1',
    rst => '1',
    d => s_axis_tdata_net,
    clk => clk_net,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => s_axis_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  down_sample : entity xil_defaultlib.axi_qpsk_rx_tsync_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    ds_ratio => 1600,
    latency => 1,
    phase => 1599,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => slice3_y_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample_q_net
  );
  down_sample1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 32,
    ds_ratio => 1600,
    latency => 1,
    phase => 1599,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => syncreset_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample1_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_eca05ff97b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay12_q_net,
    d1 => logical1_y_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_eca05ff97b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay6_q_net,
    d1 => down_sample_q_net,
    y => logical1_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_e106c09362 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => i_samples_y_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_e106c09362 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => q_samples_y_net,
    output_port => reinterpret1_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_4b283eb8ab 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => down_sample1_q_net,
    op => relational_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => auto_restart_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
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
  slice2 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transfer_net,
    y => slice2_y_net
  );
  slice3 : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => enable_net,
    y => slice3_y_net
  );
  i_samples : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 31,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => delay5_q_net,
    y => i_samples_y_net
  );
  q_samples : entity xil_defaultlib.axi_qpsk_rx_tsync_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => delay5_q_net,
    y => q_samples_y_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync_default_clock_driver is
  port (
    axi_qpsk_rx_tsync_sysclk : in std_logic;
    axi_qpsk_rx_tsync_sysce : in std_logic;
    axi_qpsk_rx_tsync_sysclr : in std_logic;
    axi_qpsk_rx_tsync_clk1 : out std_logic;
    axi_qpsk_rx_tsync_ce1 : out std_logic;
    axi_qpsk_rx_tsync_clk1600 : out std_logic;
    axi_qpsk_rx_tsync_ce1600 : out std_logic
  );
end axi_qpsk_rx_tsync_default_clock_driver;
architecture structural of axi_qpsk_rx_tsync_default_clock_driver is 
begin
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => axi_qpsk_rx_tsync_sysclk,
    sysce => axi_qpsk_rx_tsync_sysce,
    sysclr => axi_qpsk_rx_tsync_sysclr,
    clk => axi_qpsk_rx_tsync_clk1,
    ce => axi_qpsk_rx_tsync_ce1
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1600,
    log_2_period => 11
  )
  port map (
    sysclk => axi_qpsk_rx_tsync_sysclk,
    sysce => axi_qpsk_rx_tsync_sysce,
    sysclr => axi_qpsk_rx_tsync_sysclr,
    clk => axi_qpsk_rx_tsync_clk1600,
    ce => axi_qpsk_rx_tsync_ce1600
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_tsync is
  port (
    s_axis_tdata : in std_logic_vector( 32-1 downto 0 );
    s_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    axi_qpsk_rx_tsync_aresetn : in std_logic;
    axi_qpsk_rx_tsync_s_axi_awaddr : in std_logic_vector( 5-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_awvalid : in std_logic;
    axi_qpsk_rx_tsync_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_wvalid : in std_logic;
    axi_qpsk_rx_tsync_s_axi_bready : in std_logic;
    axi_qpsk_rx_tsync_s_axi_araddr : in std_logic_vector( 5-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_arvalid : in std_logic;
    axi_qpsk_rx_tsync_s_axi_rready : in std_logic;
    m_axis_tap_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tlast : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tvalid : out std_logic_vector( 1-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_awready : out std_logic;
    axi_qpsk_rx_tsync_s_axi_wready : out std_logic;
    axi_qpsk_rx_tsync_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_bvalid : out std_logic;
    axi_qpsk_rx_tsync_s_axi_arready : out std_logic;
    axi_qpsk_rx_tsync_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_tsync_s_axi_rvalid : out std_logic
  );
end axi_qpsk_rx_tsync;
architecture structural of axi_qpsk_rx_tsync is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "axi_qpsk_rx_tsync,sysgen_core_2018_3,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplusRFSOC,part=xczu28dr,speed=-2-e,package=ffvg1517,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=39.0625,system_simulink_period=3.90625e-08,waveform_viewer=0,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=10,addsub=38,cmult=5,concat=2,constant=15,convert=9,counter=2,delay=41,dsamp=2,fifo=1,inv=10,logical=15,mcode=1,mult=6,mux=4,register=15,reinterpret=4,relational=5,shift=16,slice=24,sprom=3,}";
  signal rxreset : std_logic_vector( 32-1 downto 0 );
  signal ce_1_net : std_logic;
  signal syncreset : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net : std_logic;
  signal transfer : std_logic_vector( 32-1 downto 0 );
  signal clk_1600_net : std_logic;
  signal ce_1600_net : std_logic;
  signal clk_net : std_logic;
  signal enable : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf : std_logic_vector( 32-1 downto 0 );
  signal auto_restart : std_logic_vector( 32-1 downto 0 );
begin
  axi_qpsk_rx_tsync_axi_lite_interface : entity xil_defaultlib.axi_qpsk_rx_tsync_axi_lite_interface 
  port map (
    axi_qpsk_rx_tsync_s_axi_awaddr => axi_qpsk_rx_tsync_s_axi_awaddr,
    axi_qpsk_rx_tsync_s_axi_awvalid => axi_qpsk_rx_tsync_s_axi_awvalid,
    axi_qpsk_rx_tsync_s_axi_wdata => axi_qpsk_rx_tsync_s_axi_wdata,
    axi_qpsk_rx_tsync_s_axi_wstrb => axi_qpsk_rx_tsync_s_axi_wstrb,
    axi_qpsk_rx_tsync_s_axi_wvalid => axi_qpsk_rx_tsync_s_axi_wvalid,
    axi_qpsk_rx_tsync_s_axi_bready => axi_qpsk_rx_tsync_s_axi_bready,
    axi_qpsk_rx_tsync_s_axi_araddr => axi_qpsk_rx_tsync_s_axi_araddr,
    axi_qpsk_rx_tsync_s_axi_arvalid => axi_qpsk_rx_tsync_s_axi_arvalid,
    axi_qpsk_rx_tsync_s_axi_rready => axi_qpsk_rx_tsync_s_axi_rready,
    axi_qpsk_rx_tsync_aresetn => axi_qpsk_rx_tsync_aresetn,
    axi_qpsk_rx_tsync_aclk => clk,
    transfer => transfer,
    syncreset => syncreset,
    auto_restart => auto_restart,
    rxreset => rxreset,
    packetsizerf => packetsizerf,
    enable => enable,
    axi_qpsk_rx_tsync_s_axi_awready => axi_qpsk_rx_tsync_s_axi_awready,
    axi_qpsk_rx_tsync_s_axi_wready => axi_qpsk_rx_tsync_s_axi_wready,
    axi_qpsk_rx_tsync_s_axi_bresp => axi_qpsk_rx_tsync_s_axi_bresp,
    axi_qpsk_rx_tsync_s_axi_bvalid => axi_qpsk_rx_tsync_s_axi_bvalid,
    axi_qpsk_rx_tsync_s_axi_arready => axi_qpsk_rx_tsync_s_axi_arready,
    axi_qpsk_rx_tsync_s_axi_rdata => axi_qpsk_rx_tsync_s_axi_rdata,
    axi_qpsk_rx_tsync_s_axi_rresp => axi_qpsk_rx_tsync_s_axi_rresp,
    axi_qpsk_rx_tsync_s_axi_rvalid => axi_qpsk_rx_tsync_s_axi_rvalid,
    clk => clk_net
  );
  axi_qpsk_rx_tsync_default_clock_driver : entity xil_defaultlib.axi_qpsk_rx_tsync_default_clock_driver 
  port map (
    axi_qpsk_rx_tsync_sysclk => clk_net,
    axi_qpsk_rx_tsync_sysce => '1',
    axi_qpsk_rx_tsync_sysclr => '0',
    axi_qpsk_rx_tsync_clk1 => clk_1_net,
    axi_qpsk_rx_tsync_ce1 => ce_1_net,
    axi_qpsk_rx_tsync_clk1600 => clk_1600_net,
    axi_qpsk_rx_tsync_ce1600 => ce_1600_net
  );
  axi_qpsk_rx_tsync_struct : entity xil_defaultlib.axi_qpsk_rx_tsync_struct 
  port map (
    enable => enable,
    packetsizerf => packetsizerf,
    rxreset => rxreset,
    auto_restart => auto_restart,
    s_axis_tdata => s_axis_tdata,
    s_axis_tvalid => s_axis_tvalid,
    syncreset => syncreset,
    transfer => transfer,
    m_axis_tap_tready => m_axis_tap_tready,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_1600 => clk_1600_net,
    ce_1600 => ce_1600_net,
    m_axis_tap_tdata => m_axis_tap_tdata,
    m_axis_tap_tlast => m_axis_tap_tlast,
    m_axis_tap_tvalid => m_axis_tap_tvalid
  );
end structural;
