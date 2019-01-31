-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/De-Rotate Constellation
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_de_rotate_constellation is
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
end axi_qpsk_rx_de_rotate_constellation;
architecture structural of axi_qpsk_rx_de_rotate_constellation is 
  signal addsub1_s_net : std_logic_vector( 19-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 19-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 16-1 downto 0 );
  signal register2_q_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal mult1_p_net : std_logic_vector( 18-1 downto 0 );
  signal mult3_p_net : std_logic_vector( 18-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 18-1 downto 0 );
  signal mult4_p_net : std_logic_vector( 18-1 downto 0 );
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
  addsub : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i0",
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
  addsub1 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i1",
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
  mult1 : entity xil_defaultlib.axi_qpsk_rx_xlmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i0",
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
  mult2 : entity xil_defaultlib.axi_qpsk_rx_xlmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i0",
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
  mult3 : entity xil_defaultlib.axi_qpsk_rx_xlmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i0",
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
  mult4 : entity xil_defaultlib.axi_qpsk_rx_xlmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i0",
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring Cell 2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_2 is
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
end axi_qpsk_rx_vectoring_cell_2;
architecture structural of axi_qpsk_rx_vectoring_cell_2 is 
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 20-1 downto 0 );
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay3_q_net <= x_in;
  delay4_q_net <= y_in;
  delay5_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_9be80d1a82 
  port map (
    clr => '0',
    a => delay5_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay3_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay4_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_8a3c490755 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_41b19789a3 
  port map (
    clr => '0',
    ip => delay3_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_41b19789a3 
  port map (
    clr => '0',
    ip => delay4_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring Cell 3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_3_x0 is
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
end axi_qpsk_rx_vectoring_cell_3_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_3_x0 is 
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant1_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay6_q_net <= x_in;
  delay7_q_net <= y_in;
  delay8_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_9be80d1a82 
  port map (
    clr => '0',
    a => delay8_q_net,
    b => constant1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay6_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay7_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_5c7fcca31d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_3b7c852278 
  port map (
    clr => '0',
    ip => delay6_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_3b7c852278 
  port map (
    clr => '0',
    ip => delay7_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring Cell 4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_4 is
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
end axi_qpsk_rx_vectoring_cell_4;
architecture structural of axi_qpsk_rx_vectoring_cell_4 is 
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
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
  addsub1 : entity xil_defaultlib.sysgen_addsub_9be80d1a82 
  port map (
    clr => '0',
    a => delay11_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay9_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay10_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_819de9fa19 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_e43195c749 
  port map (
    clr => '0',
    ip => delay9_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_e43195c749 
  port map (
    clr => '0',
    ip => delay10_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring Cell 5
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_5_x0 is
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
end axi_qpsk_rx_vectoring_cell_5_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_5_x0 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay14_q_net : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant1_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay12_q_net <= x_in;
  delay13_q_net <= y_in;
  delay14_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_9be80d1a82 
  port map (
    clr => '0',
    a => delay14_q_net,
    b => constant1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay12_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay13_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_b72a705628 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_1239abb7a8 
  port map (
    clr => '0',
    ip => delay12_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_1239abb7a8 
  port map (
    clr => '0',
    ip => delay13_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring Cell 6
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_6_x0 is
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
end axi_qpsk_rx_vectoring_cell_6_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_6_x0 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay17_q_net : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant1_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay15_q_net <= x_in;
  delay16_q_net <= y_in;
  delay17_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_9be80d1a82 
  port map (
    clr => '0',
    a => delay17_q_net,
    b => constant1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay15_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay16_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_0880909ffe 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_3c96ef04d0 
  port map (
    clr => '0',
    ip => delay15_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_3c96ef04d0 
  port map (
    clr => '0',
    ip => delay16_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring Cell 7
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_7_x0 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    z_in : in std_logic_vector( 20-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    z_out : out std_logic_vector( 20-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_7_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_7_x0 is 
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay20_q_net : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  z_out <= addsub1_s_net;
  delay18_q_net <= x_in;
  delay19_q_net <= y_in;
  delay20_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_9be80d1a82 
  port map (
    clr => '0',
    a => delay20_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_9dc06ea2a0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring  Cell 0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_0_x0 is
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
end axi_qpsk_rx_vectoring_cell_0_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_0_x0 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal register4_q_net : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  register4_q_net <= x_in;
  register5_q_net <= y_in;
  constant_op_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_1d223d9e75 
  port map (
    clr => '0',
    a => constant_op_net,
    b => constant_op_net_x0,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_d5fefdfebc 
  port map (
    clr => '0',
    a => register4_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_d5fefdfebc 
  port map (
    clr => '0',
    a => register5_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_335dcdd784 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net_x0
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_ebeed46c83 
  port map (
    clr => '0',
    ip => register4_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_ebeed46c83 
  port map (
    clr => '0',
    ip => register5_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error/Vectoring  Cell 1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_1_x0 is
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
end axi_qpsk_rx_vectoring_cell_1_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_1_x0 is 
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  z_out <= addsub1_s_net;
  delay_q_net <= x_in;
  delay1_q_net <= y_in;
  delay2_q_net <= z_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.sysgen_addsub_9be80d1a82 
  port map (
    clr => '0',
    a => delay2_q_net,
    b => constant_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay1_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_b154b9238b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_8463c36d4f 
  port map (
    clr => '0',
    ip => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_8463c36d4f 
  port map (
    clr => '0',
    ip => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Generate Angle Error
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_generate_angle_error is
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
end axi_qpsk_rx_generate_angle_error;
architecture structural of axi_qpsk_rx_generate_angle_error is 
  signal addsub_s_net : std_logic_vector( 21-1 downto 0 );
  signal delay23_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub2_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x5 : std_logic_vector( 20-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x6 : std_logic_vector( 20-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x1 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x3 : std_logic_vector( 20-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay14_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x1 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay17_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 20-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay20_q_net : std_logic_vector( 20-1 downto 0 );
  signal addsub2_s_net_x3 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x4 : std_logic_vector( 20-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal addsub2_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal addsub1_s_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal delay_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 20-1 downto 0 );
  signal delay22_q_net : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net : std_logic_vector( 2-1 downto 0 );
  signal delay21_q_net : std_logic_vector( 2-1 downto 0 );
  signal rom_data_net : std_logic_vector( 16-1 downto 0 );
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
  vectoring_cell_2 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_2 
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
  vectoring_cell_3 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_3_x0 
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
  vectoring_cell_4 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_4 
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
  vectoring_cell_5 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_5_x0 
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
  vectoring_cell_6 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_6_x0 
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
  vectoring_cell_7 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_7_x0 
  port map (
    x_in => delay18_q_net,
    y_in => delay19_q_net,
    z_in => delay20_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    z_out => addsub1_s_net
  );
  vectoring_cell_0 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_0_x0 
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
  vectoring_cell_1 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_1_x0 
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
  addsub : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i2",
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
  concat : entity xil_defaultlib.sysgen_concat_66bc51e78d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => slice_y_net,
    in1 => slice1_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_766b7584dc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay10 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay11 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay12 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay13 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay14 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay15 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay16 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay17 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay18 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay19 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay20 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay21 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay22 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay23 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay3 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay4 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay5 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay6 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay7 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay8 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay9 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  rom : entity xil_defaultlib.axi_qpsk_rx_xlsprom 
  generic map (
    c_address_width => 2,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_blk_mem_gen_i0",
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/Loop Filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_loop_filter_x0 is
  port (
    signal_x0 : in std_logic_vector( 21-1 downto 0 );
    en_in : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    error_filt : out std_logic_vector( 39-1 downto 0 );
    en_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_loop_filter_x0;
architecture structural of axi_qpsk_rx_loop_filter_x0 is 
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net_x0 : std_logic_vector( 21-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal cmult_p_net : std_logic_vector( 36-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 38-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 39-1 downto 0 );
  signal register1_q_net : std_logic_vector( 38-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 38-1 downto 0 );
begin
  error_filt <= addsub3_s_net;
  en_out <= delay_q_net;
  register1_q_net_x0 <= signal_x0;
  delay1_q_net <= en_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub3 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i3",
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
  addsub4 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i3",
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
    b => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub4_s_net
  );
  cmult : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i1",
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
    a => register1_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i2",
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
    a => register1_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult1_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_766b7584dc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  mux : entity xil_defaultlib.sysgen_mux_014707fac5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => delay1_q_net,
    d0 => constant_op_net,
    d1 => addsub4_s_net,
    y => mux_y_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 38,
    init_value => b"00000000000000000000000000000000000000"
  )
  port map (
    rst => "0",
    d => mux_y_net,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch/NCO
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_nco is
  port (
    step_size : in std_logic_vector( 39-1 downto 0 );
    en_in : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    cos : out std_logic_vector( 16-1 downto 0 );
    neg_sin : out std_logic_vector( 16-1 downto 0 );
    en_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_nco;
architecture structural of axi_qpsk_rx_nco is 
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal neg_sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub4_s_net : std_logic_vector( 22-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 22-1 downto 0 );
  signal register1_q_net : std_logic_vector( 22-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 8-1 downto 0 );
  signal mux_y_net : std_logic_vector( 22-1 downto 0 );
begin
  cos <= cos_rom_data_net;
  neg_sin <= neg_sin_rom_data_net;
  en_out <= delay_q_net_x0;
  addsub3_s_net <= step_size;
  delay_q_net <= en_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub4 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i4",
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
  cmult1 : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i3",
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
  constant_x0 : entity xil_defaultlib.sysgen_constant_766b7584dc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  cos_rom : entity xil_defaultlib.axi_qpsk_rx_xlsprom 
  generic map (
    c_address_width => 8,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_blk_mem_gen_i1",
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
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  mux : entity xil_defaultlib.sysgen_mux_689a393bb6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => delay_q_net,
    d0 => constant_op_net,
    d1 => addsub4_s_net,
    y => mux_y_net
  );
  neg_sin_rom : entity xil_defaultlib.axi_qpsk_rx_xlsprom 
  generic map (
    c_address_width => 8,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_blk_mem_gen_i2",
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
  register1 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Carrier Synch
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_carrier_synch is
  port (
    sample_strobe : in std_logic_vector( 1-1 downto 0 );
    x_in : in std_logic_vector( 16-1 downto 0 );
    y_in : in std_logic_vector( 16-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    symbol_strobe : out std_logic_vector( 1-1 downto 0 );
    i_out : out std_logic_vector( 19-1 downto 0 );
    q_out : out std_logic_vector( 19-1 downto 0 )
  );
end axi_qpsk_rx_carrier_synch;
architecture structural of axi_qpsk_rx_carrier_synch is 
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 19-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 19-1 downto 0 );
  signal register2_q_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net : std_logic_vector( 16-1 downto 0 );
  signal addsub_s_net_x0 : std_logic_vector( 21-1 downto 0 );
  signal delay23_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal register1_q_net : std_logic_vector( 21-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal neg_sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net_x1 : std_logic_vector( 1-1 downto 0 );
begin
  symbol_strobe <= delay_q_net;
  i_out <= register4_q_net;
  q_out <= register5_q_net;
  logical_y_net <= sample_strobe;
  delay2_q_net <= x_in;
  delay3_q_net <= y_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  de_rotate_constellation : entity xil_defaultlib.axi_qpsk_rx_de_rotate_constellation 
  port map (
    en_in => logical_y_net,
    x_in => delay2_q_net,
    y_in => delay3_q_net,
    cos_error => register2_q_net,
    neg_sin_error => register3_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    x_out => addsub1_s_net,
    y_out => addsub_s_net
  );
  generate_angle_error : entity xil_defaultlib.axi_qpsk_rx_generate_angle_error 
  port map (
    x_out => register4_q_net,
    y_out => register5_q_net,
    x_out_q => slice_y_net,
    y_out_q => slice1_y_net,
    en_in => delay_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    angle_error => addsub_s_net_x0,
    en_out => delay23_q_net
  );
  loop_filter : entity xil_defaultlib.axi_qpsk_rx_loop_filter_x0 
  port map (
    signal_x0 => register1_q_net,
    en_in => delay1_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    error_filt => addsub3_s_net,
    en_out => delay_q_net_x0
  );
  nco : entity xil_defaultlib.axi_qpsk_rx_nco 
  port map (
    step_size => addsub3_s_net,
    en_in => delay_q_net_x0,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    cos => cos_rom_data_net,
    neg_sin => neg_sin_rom_data_net,
    en_out => delay_q_net_x1
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  register1 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 21,
    init_value => b"000000000000000000000"
  )
  port map (
    rst => "0",
    d => addsub_s_net_x0,
    en => delay23_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
  register2 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0100000000000000"
  )
  port map (
    rst => "0",
    d => cos_rom_data_net,
    en => delay_q_net_x1,
    clk => clk_net,
    ce => ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    rst => "0",
    d => neg_sin_rom_data_net,
    en => delay_q_net_x1,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
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
  register5 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 19,
    init_value => b"0000100000000000000"
  )
  port map (
    rst => "0",
    d => addsub_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Determine Frequency Correction Term
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_determine_frequency_correction_term is
  port (
    mag_sq_fft : in std_logic_vector( 30-1 downto 0 );
    fft_index : in std_logic_vector( 9-1 downto 0 );
    valid : in std_logic_vector( 1-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    freq_correction : out std_logic_vector( 19-1 downto 0 );
    valid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_determine_frequency_correction_term;
architecture structural of axi_qpsk_rx_determine_frequency_correction_term is 
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 30-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal capture_max_x_val_index_q_net : std_logic_vector( 9-1 downto 0 );
  signal register_x_coeff_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal constant5_op_net : std_logic_vector( 9-1 downto 0 );
  signal relational2_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational3_op_net : std_logic_vector( 1-1 downto 0 );
  signal rom_data_net : std_logic_vector( 19-1 downto 0 );
  signal register_x_val_q_net : std_logic_vector( 30-1 downto 0 );
begin
  freq_correction <= rom_data_net;
  valid_out <= delay1_q_net;
  delay8_q_net <= mag_sq_fft;
  delay4_q_net <= fft_index;
  delay9_q_net <= valid;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  capture_max_x_val_index : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 9,
    init_value => b"000000000"
  )
  port map (
    rst => "0",
    d => register_x_coeff_q_net,
    en => delay6_q_net,
    clk => clk_net,
    ce => ce_net,
    q => capture_max_x_val_index_q_net
  );
  constant5 : entity xil_defaultlib.sysgen_constant_86ab61f740 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant5_op_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 512,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay9_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => relational2_op_net,
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay9_q_net,
    d1 => relational3_op_net,
    y => logical_y_net
  );
  rom : entity xil_defaultlib.axi_qpsk_rx_xlsprom 
  generic map (
    c_address_width => 9,
    c_width => 19,
    core_name0 => "axi_qpsk_rx_blk_mem_gen_i3",
    latency => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => capture_max_x_val_index_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom_data_net
  );
  register_x_coeff : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 9,
    init_value => b"000000000"
  )
  port map (
    rst => "0",
    d => delay4_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_x_coeff_q_net
  );
  register_x_val : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 30,
    init_value => b"000000000000000000000000000000"
  )
  port map (
    d => delay8_q_net,
    rst => relational2_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_x_val_q_net
  );
  relational2 : entity xil_defaultlib.sysgen_relational_33b72c42a8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => delay4_q_net,
    b => constant5_op_net,
    op => relational2_op_net
  );
  relational3 : entity xil_defaultlib.sysgen_relational_39926d6db9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => delay8_q_net,
    b => register_x_val_q_net,
    op => relational3_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/NCO
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_nco_x0 is
  port (
    freq_correction : in std_logic_vector( 19-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    cos : out std_logic_vector( 16-1 downto 0 );
    sin : out std_logic_vector( 16-1 downto 0 )
  );
end axi_qpsk_rx_nco_x0;
architecture structural of axi_qpsk_rx_nco_x0 is 
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal rom_data_net : std_logic_vector( 19-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub_s_net : std_logic_vector( 18-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 18-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 20-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 10-1 downto 0 );
begin
  cos <= cos_rom_data_net;
  sin <= sin_rom_data_net;
  rom_data_net <= freq_correction;
  delay1_q_net <= en;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 8,
    a_width => 18,
    b_arith => xlSigned,
    b_bin_pt => 10,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 22,
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i5",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 22,
    latency => 0,
    overflow => 1,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 8,
    s_width => 18
  )
  port map (
    clr => '0',
    en => "1",
    a => delay2_q_net,
    b => cmult_p_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  cmult : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 6,
    a_width => 19,
    b_bin_pt => 10,
    c_a_type => 0,
    c_a_width => 19,
    c_b_type => 1,
    c_b_width => 11,
    c_output_width => 30,
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i4",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 10,
    p_width => 20,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => rom_data_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 8,
    din_width => 18,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 10,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => addsub_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 18
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub_s_net,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  sin_rom : entity xil_defaultlib.axi_qpsk_rx_xlsprom 
  generic map (
    c_address_width => 10,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_blk_mem_gen_i4",
    latency => 1
  )
  port map (
    rst => "0",
    addr => convert4_dout_net,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    data => sin_rom_data_net
  );
  cos_rom : entity xil_defaultlib.axi_qpsk_rx_xlsprom 
  generic map (
    c_address_width => 10,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_blk_mem_gen_i5",
    latency => 1
  )
  port map (
    rst => "0",
    addr => convert4_dout_net,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    data => cos_rom_data_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_2_x0 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_2_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_2_x0 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay5_q_net <= x_in;
  delay6_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay5_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay6_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_41b19789a3 
  port map (
    clr => '0',
    ip => delay5_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_41b19789a3 
  port map (
    clr => '0',
    ip => delay6_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay5_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay6_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_3 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_3;
architecture structural of axi_qpsk_rx_vectoring_cell_3 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay8_q_net <= x_in;
  delay9_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay8_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay9_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_3b7c852278 
  port map (
    clr => '0',
    ip => delay8_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_3b7c852278 
  port map (
    clr => '0',
    ip => delay9_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay8_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay9_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_4_x0 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_4_x0;
architecture structural of axi_qpsk_rx_vectoring_cell_4_x0 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay22_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay22_q_net <= x_in;
  delay10_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay22_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay10_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_e43195c749 
  port map (
    clr => '0',
    ip => delay22_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_e43195c749 
  port map (
    clr => '0',
    ip => delay10_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay22_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 5
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_5 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_5;
architecture structural of axi_qpsk_rx_vectoring_cell_5 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay12_q_net <= x_in;
  delay13_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay12_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay13_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_1239abb7a8 
  port map (
    clr => '0',
    ip => delay12_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_1239abb7a8 
  port map (
    clr => '0',
    ip => delay13_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 6
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_6 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_6;
architecture structural of axi_qpsk_rx_vectoring_cell_6 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay15_q_net <= x_in;
  delay16_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay15_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay16_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_3c96ef04d0 
  port map (
    clr => '0',
    ip => delay15_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_3c96ef04d0 
  port map (
    clr => '0',
    ip => delay16_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 7
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_7 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_7;
architecture structural of axi_qpsk_rx_vectoring_cell_7 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  delay18_q_net <= x_in;
  delay19_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay18_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_955cb48bd0 
  port map (
    clr => '0',
    ip => delay19_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring  Cell 0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_0 is
  port (
    x_in : in std_logic_vector( 16-1 downto 0 );
    y_in : in std_logic_vector( 16-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_0;
architecture structural of axi_qpsk_rx_vectoring_cell_0 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  shift_op_net <= x_in;
  shift1_op_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_78a1e4d5fa 
  port map (
    clr => '0',
    a => shift_op_net,
    b => shift1_op_net_x0,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_78a1e4d5fa 
  port map (
    clr => '0',
    a => shift1_op_net,
    b => shift_op_net_x0,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_b3626a6de7 
  port map (
    clr => '0',
    ip => shift_op_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net_x0
  );
  shift1 : entity xil_defaultlib.sysgen_shift_b3626a6de7 
  port map (
    clr => '0',
    ip => shift1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net_x0
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 15,
    new_msb => 15,
    x_width => 16,
    y_width => 1
  )
  port map (
    x => shift_op_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 15,
    new_msb => 15,
    x_width => 16,
    y_width => 1
  )
  port map (
    x => shift1_op_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring  Cell 1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_vectoring_cell_1 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_vectoring_cell_1;
architecture structural of axi_qpsk_rx_vectoring_cell_1 is 
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay2_q_net <= x_in;
  delay3_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay2_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_049491c9fe 
  port map (
    clr => '0',
    a => delay3_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_853283f4e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_8463c36d4f 
  port map (
    clr => '0',
    ip => delay2_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_8463c36d4f 
  port map (
    clr => '0',
    ip => delay3_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay2_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 15,
    y_width => 1
  )
  port map (
    x => delay3_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_cordic_vector_magnitude1 is
  port (
    i_in : in std_logic_vector( 16-1 downto 0 );
    q_in : in std_logic_vector( 16-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    mag : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_cordic_vector_magnitude1;
architecture structural of axi_qpsk_rx_cordic_vector_magnitude1 is 
  signal addsub2_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub2_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x3 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal delay22_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x1 : std_logic_vector( 15-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x1 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
begin
  mag <= addsub2_s_net_x2;
  shift_op_net <= i_in;
  shift1_op_net <= q_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  vectoring_cell_2 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_2_x0 
  port map (
    x_in => delay5_q_net,
    y_in => delay6_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x6,
    y_out => addsub3_s_net_x6
  );
  vectoring_cell_3 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_3 
  port map (
    x_in => delay8_q_net,
    y_in => delay9_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x3,
    y_out => addsub3_s_net
  );
  vectoring_cell_4 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_4_x0 
  port map (
    x_in => delay22_q_net,
    y_in => delay10_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net,
    y_out => addsub3_s_net_x0
  );
  vectoring_cell_5 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_5 
  port map (
    x_in => delay12_q_net,
    y_in => delay13_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x0,
    y_out => addsub3_s_net_x1
  );
  vectoring_cell_6 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_6 
  port map (
    x_in => delay15_q_net,
    y_in => delay16_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x1,
    y_out => addsub3_s_net_x2
  );
  vectoring_cell_7 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_7 
  port map (
    x_in => delay18_q_net,
    y_in => delay19_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x2
  );
  vectoring_cell_0 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_0 
  port map (
    x_in => shift_op_net,
    y_in => shift1_op_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x4,
    y_out => addsub3_s_net_x4
  );
  vectoring_cell_1 : entity xil_defaultlib.axi_qpsk_rx_vectoring_cell_1 
  port map (
    x_in => delay2_q_net,
    y_in => delay3_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x5,
    y_out => addsub3_s_net_x5
  );
  delay10 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay10_q_net
  );
  delay12 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay13 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay13_q_net
  );
  delay15 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub2_s_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay15_q_net
  );
  delay16 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay16_q_net
  );
  delay18 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay19 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay19_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay2_q_net
  );
  delay22 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay22_q_net
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay3_q_net
  );
  delay5 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay6_q_net
  );
  delay8 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    q => delay9_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser/Scaled Mag Squared FFT
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_scaled_mag_squared_fft is
  port (
    im : in std_logic_vector( 26-1 downto 0 );
    re : in std_logic_vector( 26-1 downto 0 );
    fft_index : in std_logic_vector( 9-1 downto 0 );
    valid : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    mag_sq_fft : out std_logic_vector( 30-1 downto 0 );
    fft_index_del : out std_logic_vector( 9-1 downto 0 );
    valid_del : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_scaled_mag_squared_fft;
architecture structural of axi_qpsk_rx_scaled_mag_squared_fft is 
  signal delay8_q_net : std_logic_vector( 30-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal fft_m_axis_data_tdata_xn_im_0_net : std_logic_vector( 26-1 downto 0 );
  signal fft_m_axis_data_tdata_xn_re_0_net : std_logic_vector( 26-1 downto 0 );
  signal fft_m_axis_data_tuser_xk_index_net : std_logic_vector( 9-1 downto 0 );
  signal fft_m_axis_data_tvalid_net : std_logic;
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal convert9_dout_net : std_logic_vector( 30-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 19-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 1-1 downto 0 );
begin
  mag_sq_fft <= delay8_q_net;
  fft_index_del <= delay4_q_net;
  valid_del <= delay9_q_net;
  fft_m_axis_data_tdata_xn_im_0_net <= im;
  fft_m_axis_data_tdata_xn_re_0_net <= re;
  fft_m_axis_data_tuser_xk_index_net <= fft_index;
  fft_m_axis_data_tvalid_net <= valid;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  cordic_vector_magnitude1 : entity xil_defaultlib.axi_qpsk_rx_cordic_vector_magnitude1 
  port map (
    i_in => shift_op_net,
    q_in => shift1_op_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    mag => addsub2_s_net
  );
  convert9 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 19,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 30,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => mult1_p_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert9_dout_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 9
  )
  port map (
    en => '1',
    rst => '1',
    d => fft_m_axis_data_tuser_xk_index_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 7,
    reg_retiming => 0,
    reset => 0,
    width => 9
  )
  port map (
    en => '1',
    rst => '1',
    d => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 9
  )
  port map (
    en => '1',
    rst => '1',
    d => delay2_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 9
  )
  port map (
    en => '1',
    rst => '1',
    d => delay3_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d(0) => fft_m_axis_data_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 7,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay5_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay6_q_net
  );
  delay7 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay6_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 30
  )
  port map (
    en => '1',
    rst => '1',
    d => convert9_dout_net,
    clk => clk_net,
    ce => ce_net,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay7_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay9_q_net
  );
  mult1 : entity xil_defaultlib.axi_qpsk_rx_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 12,
    a_width => 15,
    b_arith => xlSigned,
    b_bin_pt => 12,
    b_width => 15,
    c_a_type => 0,
    c_a_width => 15,
    c_b_type => 0,
    c_b_width => 15,
    c_baat => 15,
    c_output_width => 30,
    c_type => 0,
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i5",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 19,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => addsub2_s_net,
    b => addsub2_s_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  shift : entity xil_defaultlib.sysgen_shift_412e8aeba1 
  port map (
    clr => '0',
    ip => fft_m_axis_data_tdata_xn_re_0_net,
    en(0) => fft_m_axis_data_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_412e8aeba1 
  port map (
    clr => '0',
    ip => fft_m_axis_data_tdata_xn_im_0_net,
    en(0) => fft_m_axis_data_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Coarse Frequency Synchroniser
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_coarse_frequency_synchroniser is
  port (
    i_samples : in std_logic_vector( 16-1 downto 0 );
    q_samples : in std_logic_vector( 16-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    corrected_i : out std_logic_vector( 18-1 downto 0 );
    corrected_q : out std_logic_vector( 18-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_coarse_frequency_synchroniser;
architecture structural of axi_qpsk_rx_coarse_frequency_synchroniser is 
  signal convert4_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 18-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x1 : std_logic;
  signal ce_net_x1 : std_logic;
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
  signal rom_data_net : std_logic_vector( 19-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 30-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal fft_m_axis_data_tdata_xn_im_0_net : std_logic_vector( 26-1 downto 0 );
  signal fft_m_axis_data_tdata_xn_re_0_net : std_logic_vector( 26-1 downto 0 );
  signal fft_m_axis_data_tuser_xk_index_net : std_logic_vector( 9-1 downto 0 );
  signal fft_m_axis_data_tvalid_net : std_logic;
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant4_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 19-1 downto 0 );
  signal product_p_re_net : std_logic_vector( 33-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 19-1 downto 0 );
  signal product_p_im_net : std_logic_vector( 33-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal product1_p_re_net : std_logic_vector( 39-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal product1_p_im_net : std_logic_vector( 39-1 downto 0 );
  signal product2_p_re_net : std_logic_vector( 33-1 downto 0 );
  signal product2_p_im_net : std_logic_vector( 33-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal fft_s_axis_config_tready_net : std_logic;
  signal fft_s_axis_data_tready_net : std_logic;
  signal fft_m_axis_data_tlast_net : std_logic;
  signal fft_event_frame_started_net : std_logic;
  signal fft_event_tlast_unexpected_net : std_logic;
  signal fft_event_tlast_missing_net : std_logic;
  signal fft_event_data_in_channel_halt_net : std_logic;
  signal fft_event_status_channel_halt_net : std_logic;
  signal fft_event_data_out_channel_halt_net : std_logic;
begin
  corrected_i <= convert4_dout_net;
  corrected_q <= convert5_dout_net;
  tvalid_out <= delay2_q_net;
  convert6_dout_net <= i_samples;
  convert7_dout_net <= q_samples;
  logical1_y_net <= tvalid_in;
  clk_net_x1 <= clk_1;
  ce_net_x1 <= ce_1;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  clk_net_x0 <= clk_25600;
  ce_net_x0 <= ce_25600;
  determine_frequency_correction_term : entity xil_defaultlib.axi_qpsk_rx_determine_frequency_correction_term 
  port map (
    mag_sq_fft => delay8_q_net,
    fft_index => delay4_q_net,
    valid => delay9_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    freq_correction => rom_data_net,
    valid_out => delay1_q_net
  );
  nco : entity xil_defaultlib.axi_qpsk_rx_nco_x0 
  port map (
    freq_correction => rom_data_net,
    en => delay1_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    cos => cos_rom_data_net,
    sin => sin_rom_data_net
  );
  scaled_mag_squared_fft : entity xil_defaultlib.axi_qpsk_rx_scaled_mag_squared_fft 
  port map (
    im => fft_m_axis_data_tdata_xn_im_0_net,
    re => fft_m_axis_data_tdata_xn_re_0_net,
    fft_index => fft_m_axis_data_tuser_xk_index_net,
    valid => fft_m_axis_data_tvalid_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    mag_sq_fft => delay8_q_net,
    fft_index_del => delay4_q_net,
    valid_del => delay9_q_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_432822c268 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_432822c268 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  constant4 : entity xil_defaultlib.sysgen_constant_432822c268 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant4_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 28,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 19,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product_p_re_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 28,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 19,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product_p_im_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 28,
    din_width => 39,
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
    din => product1_p_re_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 28,
    din_width => 39,
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
    din => product1_p_im_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert3_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 28,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 18,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product2_p_re_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 28,
    din_width => 33,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 18,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product2_p_im_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert5_dout_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 6,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical1_y_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 6,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => delay_q_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay1_q_net_x0
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 6,
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
    q => delay2_q_net
  );
  fft : entity xil_defaultlib.xlfast_fourier_transform_63ed7b037d3533d17c19a6ba47478754 
  port map (
    s_axis_config_tdata_fwd_inv => constant3_op_net,
    s_axis_config_tvalid => constant4_op_net(0),
    s_axis_data_tdata_xn_im_0 => convert3_dout_net,
    s_axis_data_tdata_xn_re_0 => convert2_dout_net,
    s_axis_data_tvalid => delay1_q_net_x0(0),
    s_axis_data_tlast => delay1_q_net_x0(0),
    m_axis_data_tready => constant2_op_net(0),
    clk => clk_net,
    ce => ce_net,
    s_axis_config_tready => fft_s_axis_config_tready_net,
    s_axis_data_tready => fft_s_axis_data_tready_net,
    m_axis_data_tdata_xn_im_0 => fft_m_axis_data_tdata_xn_im_0_net,
    m_axis_data_tdata_xn_re_0 => fft_m_axis_data_tdata_xn_re_0_net,
    m_axis_data_tuser_xk_index => fft_m_axis_data_tuser_xk_index_net,
    m_axis_data_tvalid => fft_m_axis_data_tvalid_net,
    m_axis_data_tlast => fft_m_axis_data_tlast_net,
    event_frame_started => fft_event_frame_started_net,
    event_tlast_unexpected => fft_event_tlast_unexpected_net,
    event_tlast_missing => fft_event_tlast_missing_net,
    event_data_in_channel_halt => fft_event_data_in_channel_halt_net,
    event_status_channel_halt => fft_event_status_channel_halt_net,
    event_data_out_channel_halt => fft_event_data_out_channel_halt_net
  );
  product : entity xil_defaultlib.xlaxi_qpsk_rx_cmpy_v6_0_i0_9e7e05098c985ce10daa9179eb0c35f1 
  port map (
    a_re => convert6_dout_net,
    a_im => convert7_dout_net,
    b_re => convert6_dout_net,
    b_im => convert7_dout_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_25600 => clk_net_x0,
    ce_25600 => ce_net_x0,
    p_re => product_p_re_net,
    p_im => product_p_im_net
  );
  product1 : entity xil_defaultlib.xlaxi_qpsk_rx_cmpy_v6_0_i1_e12f1df6f5f130a6b47388b563218dc6 
  port map (
    a_re => convert_dout_net,
    a_im => convert1_dout_net,
    b_re => convert_dout_net,
    b_im => convert1_dout_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_25600 => clk_net_x0,
    ce_25600 => ce_net_x0,
    p_re => product1_p_re_net,
    p_im => product1_p_im_net
  );
  product2 : entity xil_defaultlib.xlaxi_qpsk_rx_cmpy_v6_0_i0_ba1bc0fdc1f2157be504e38e5fb295b9 
  port map (
    a_re => convert6_dout_net,
    a_im => convert7_dout_net,
    b_re => cos_rom_data_net,
    b_im => sin_rom_data_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    p_re => product2_p_re_net,
    p_im => product2_p_im_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_axi_write_interface_x0 is
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
end axi_qpsk_rx_axi_write_interface_x0;
architecture structural of axi_qpsk_rx_axi_write_interface_x0 is 
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 7-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice1_y_net <= int_reset;
  slice3_y_net <= transfer;
  slice2_y_net <= auto_restart;
  packetsizerf_net <= packet_size;
  concat_y_net <= tdata_in;
  delay_q_net <= tvalid_in;
  m_rf_axis_tready_net <= tready;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_1600;
  constant_x0 : entity xil_defaultlib.sysgen_constant_4a1c0a5c6e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_rx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_c_counter_binary_v12_0_i0",
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
  fifo : entity xil_defaultlib.axi_qpsk_rx_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_rx_fifo_generator_i0",
    data_count_width => 7,
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
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice1_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_rf_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_cc2ba69160 
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
  register3 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice1_y_net,
    en => m_rf_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice1_y_net,
    en => m_rf_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice1_y_net,
    en => m_rf_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_14537c6392 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_8fd2049cdd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizerf_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis_symbol_ctrl_x1 is
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
end axi_qpsk_rx_m_axis_symbol_ctrl_x1;
architecture structural of axi_qpsk_rx_m_axis_symbol_ctrl_x1 is 
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal register5_q_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 19-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  register4_q_net_x0 <= i_data;
  delay_q_net <= tvalid_in;
  register5_q_net <= q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  m_rf_axis_tready_net <= tready_in;
  slice3_y_net <= transfer;
  slice2_y_net <= auto_restart;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_1600;
  ce_net_x0 <= ce_1600;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_rx_axi_write_interface_x0 
  port map (
    int_reset => slice1_y_net,
    transfer => slice3_y_net,
    auto_restart => slice2_y_net,
    packet_size => packetsizerf_net,
    tdata_in => concat_y_net,
    tvalid_in => delay_q_net,
    tready => m_rf_axis_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    ce_1600 => ce_net_x0,
    tdata_out => register5_q_net_x0,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_2f4e7d13ad 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 19,
    dout_arith => 2,
    dout_bin_pt => 11,
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
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 19,
    dout_arith => 2,
    dout_bin_pt => 11,
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
  convert4 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert_dout_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_data_inspector is
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
end axi_qpsk_rx_data_inspector;
architecture structural of axi_qpsk_rx_data_inspector is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 19-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  register4_q_net_x0 <= symbol_i_data;
  delay_q_net <= symbol_i_valid;
  register5_q_net <= symbol_q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  slice3_y_net <= transfer;
  slice2_y_net <= auto_restart;
  m_rf_axis_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  clk_net_x0 <= clk_1600;
  ce_net_x0 <= ce_1600;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_rx_m_axis_symbol_ctrl_x1 
  port map (
    i_data => register4_q_net_x0,
    tvalid_in => delay_q_net,
    q_data => register5_q_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    tready_in => m_rf_axis_tready_net,
    transfer => slice3_y_net,
    auto_restart => slice2_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    clk_1600 => clk_net_x0,
    ce_1600 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector Decimation/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_axi_write_interface is
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
end axi_qpsk_rx_axi_write_interface;
architecture structural of axi_qpsk_rx_axi_write_interface is 
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_dec_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_dec_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 12-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice1_y_net <= int_reset;
  slice5_y_net <= transfer;
  slice4_y_net <= auto_restart;
  packetsize_dec_net <= packet_size;
  concat_y_net <= tdata_in;
  logical1_y_net <= tvalid_in;
  m_dec_axis_tready_net <= tready;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_25600;
  constant_x0 : entity xil_defaultlib.sysgen_constant_4a1c0a5c6e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert5 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_rx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    clr => '0',
    rst => logical_y_net,
    en => logical1_y_net_x0,
    clk => clk_net,
    ce => ce_net_x0,
    op => counter_op_net
  );
  fifo : entity xil_defaultlib.axi_qpsk_rx_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_rx_fifo_generator_i1",
    data_count_width => 12,
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
    we => logical1_y_net(0),
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
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice1_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_dec_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net_x0
  );
  logical2 : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net_x0,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_cc2ba69160 
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
  register3 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice1_y_net,
    en => m_dec_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice1_y_net,
    en => m_dec_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice1_y_net,
    en => m_dec_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_fc947ff06d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_8fd2049cdd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsize_dec_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector Decimation/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis_symbol_ctrl_x0 is
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
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_m_axis_symbol_ctrl_x0;
architecture structural of axi_qpsk_rx_m_axis_symbol_ctrl_x0 is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_dec_net : std_logic_vector( 32-1 downto 0 );
  signal m_dec_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  convert6_dout_net <= i_data;
  logical1_y_net <= tvalid_in;
  convert7_dout_net <= q_data;
  slice1_y_net <= reset;
  packetsize_dec_net <= packet_size;
  m_dec_axis_tready_net <= tready_in;
  slice5_y_net <= transfer;
  slice4_y_net <= auto_restart;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_25600;
  ce_net_x0 <= ce_25600;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_rx_axi_write_interface 
  port map (
    int_reset => slice1_y_net,
    transfer => slice5_y_net,
    auto_restart => slice4_y_net,
    packet_size => packetsize_dec_net,
    tdata_in => concat_y_net,
    tvalid_in => logical1_y_net,
    tready => m_dec_axis_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    ce_25600 => ce_net_x0,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_2f4e7d13ad 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 16,
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
    din => convert7_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 16,
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
    din => convert6_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert2_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    clk => clk_net_x0,
    ce => ce_net,
    dout => convert4_dout_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert2_dout_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector Decimation
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_data_inspector_decimation is
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
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_data_inspector_decimation;
architecture structural of axi_qpsk_rx_data_inspector_decimation is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_dec_net : std_logic_vector( 32-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_dec_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  convert6_dout_net <= symbol_i_data;
  logical1_y_net <= symbol_i_valid;
  convert7_dout_net <= symbol_q_data;
  slice1_y_net <= reset;
  packetsize_dec_net <= packet_size;
  slice5_y_net <= transfer;
  slice4_y_net <= auto_restart;
  m_dec_axis_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  clk_net_x0 <= clk_25600;
  ce_net_x0 <= ce_25600;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_rx_m_axis_symbol_ctrl_x0 
  port map (
    i_data => convert6_dout_net,
    tvalid_in => logical1_y_net,
    q_data => convert7_dout_net,
    reset => slice1_y_net,
    packet_size => packetsize_dec_net,
    tready_in => m_dec_axis_tready_net,
    transfer => slice5_y_net,
    auto_restart => slice4_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    clk_25600 => clk_net_x0,
    ce_25600 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector Freq Sync/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_axi_write_interface_x1 is
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
end axi_qpsk_rx_axi_write_interface_x1;
architecture structural of axi_qpsk_rx_axi_write_interface_x1 is 
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_sync_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_sync_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 12-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice1_y_net <= int_reset;
  slice9_y_net <= transfer;
  slice8_y_net <= auto_restart;
  packetsize_sync_net <= packet_size;
  concat_y_net <= tdata_in;
  delay2_q_net <= tvalid_in;
  m_sync_axis_tready_net <= tready;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_6400;
  constant_x0 : entity xil_defaultlib.sysgen_constant_4a1c0a5c6e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    din => slice8_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_rx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_c_counter_binary_v12_0_i0",
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
  fifo : entity xil_defaultlib.axi_qpsk_rx_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_rx_fifo_generator_i1",
    data_count_width => 12,
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
    we => delay2_q_net(0),
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
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice1_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_sync_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_cc2ba69160 
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
  register3 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice1_y_net,
    en => m_sync_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice1_y_net,
    en => m_sync_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice1_y_net,
    en => m_sync_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_fc947ff06d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_8fd2049cdd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsize_sync_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector Freq Sync/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis_symbol_ctrl is
  port (
    i_data : in std_logic_vector( 18-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    q_data : in std_logic_vector( 18-1 downto 0 );
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
end axi_qpsk_rx_m_axis_symbol_ctrl;
architecture structural of axi_qpsk_rx_m_axis_symbol_ctrl is 
  signal convert4_dout_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 18-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 18-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_sync_net : std_logic_vector( 32-1 downto 0 );
  signal m_sync_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
begin
  tdata_out <= convert4_dout_net_x0;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  convert4_dout_net <= i_data;
  delay2_q_net <= tvalid_in;
  convert5_dout_net <= q_data;
  slice1_y_net <= reset;
  packetsize_sync_net <= packet_size;
  m_sync_axis_tready_net <= tready_in;
  slice9_y_net <= transfer;
  slice8_y_net <= auto_restart;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net <= clk_6400;
  ce_net_x0 <= ce_6400;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_rx_axi_write_interface_x1 
  port map (
    int_reset => slice1_y_net,
    transfer => slice9_y_net,
    auto_restart => slice8_y_net,
    packet_size => packetsize_sync_net,
    tdata_in => concat_y_net,
    tvalid_in => delay2_q_net,
    tready => m_sync_axis_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net,
    ce_6400 => ce_net_x0,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_2f4e7d13ad 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 18,
    dout_arith => 2,
    dout_bin_pt => 13,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => convert5_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 18,
    dout_arith => 2,
    dout_bin_pt => 13,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => convert4_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert2_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    clk => clk_net_x0,
    ce => ce_net,
    dout => convert4_dout_net_x0
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert2_dout_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector Freq Sync
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_data_inspector_freq_sync is
  port (
    symbol_i_data : in std_logic_vector( 18-1 downto 0 );
    symbol_i_valid : in std_logic_vector( 1-1 downto 0 );
    symbol_q_data : in std_logic_vector( 18-1 downto 0 );
    reset : in std_logic_vector( 1-1 downto 0 );
    packet_size : in std_logic_vector( 32-1 downto 0 );
    transfer : in std_logic_vector( 1-1 downto 0 );
    auto_restart : in std_logic_vector( 1-1 downto 0 );
    tready_in : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_data_inspector_freq_sync;
architecture structural of axi_qpsk_rx_data_inspector_freq_sync is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 18-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_sync_net : std_logic_vector( 32-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_sync_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  convert4_dout_net_x0 <= symbol_i_data;
  delay2_q_net <= symbol_i_valid;
  convert5_dout_net <= symbol_q_data;
  slice1_y_net <= reset;
  packetsize_sync_net <= packet_size;
  slice9_y_net <= transfer;
  slice8_y_net <= auto_restart;
  m_sync_axis_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  clk_net_x0 <= clk_6400;
  ce_net_x0 <= ce_6400;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_rx_m_axis_symbol_ctrl 
  port map (
    i_data => convert4_dout_net_x0,
    tvalid_in => delay2_q_net,
    q_data => convert5_dout_net,
    reset => slice1_y_net,
    packet_size => packetsize_sync_net,
    tready_in => m_sync_axis_tready_net,
    transfer => slice9_y_net,
    auto_restart => slice8_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    clk_6400 => clk_net_x0,
    ce_6400 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector RRC/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_axi_write_interface_x2 is
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
end axi_qpsk_rx_axi_write_interface_x2;
architecture structural of axi_qpsk_rx_axi_write_interface_x2 is 
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_rrc_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_empty_net : std_logic;
  signal fifo_full_net : std_logic;
  signal fifo_dcount_net : std_logic_vector( 12-1 downto 0 );
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice1_y_net <= int_reset;
  slice7_y_net <= transfer;
  slice6_y_net <= auto_restart;
  packetsize_rrc_net <= packet_size;
  concat_y_net <= tdata_in;
  logical_y_net <= tvalid_in;
  m_rrc_axis_tready_net <= tready;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_1600;
  constant_x0 : entity xil_defaultlib.sysgen_constant_4a1c0a5c6e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    din => slice7_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    din => slice6_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_rx_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    clr => '0',
    rst => logical_y_net_x0,
    en => logical1_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => counter_op_net
  );
  fifo : entity xil_defaultlib.axi_qpsk_rx_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_rx_fifo_generator_i1",
    data_count_width => 12,
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
    we => logical_y_net(0),
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
  inverter : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_2be377593a 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net_x0,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice1_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net_x0
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_rrc_axis_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_b04b39890e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_cc2ba69160 
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
  register3 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => inverter1_op_net,
    rst => slice1_y_net,
    en => m_rrc_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => convert5_dout_net,
    rst => slice1_y_net,
    en => m_rrc_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    d => fifo_dout_net,
    rst => slice1_y_net,
    en => m_rrc_axis_tready_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => register5_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_fc947ff06d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_8fd2049cdd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsize_rrc_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector RRC/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis_symbol_ctrl_x2 is
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
    ce_1600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_m_axis_symbol_ctrl_x2;
architecture structural of axi_qpsk_rx_m_axis_symbol_ctrl_x2 is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal m_rrc_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  shift6_op_net <= i_data;
  logical_y_net <= tvalid_in;
  shift7_op_net <= q_data;
  slice1_y_net <= reset;
  packetsize_rrc_net <= packet_size;
  m_rrc_axis_tready_net <= tready_in;
  slice7_y_net <= transfer;
  slice6_y_net <= auto_restart;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  ce_net <= ce_1600;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_rx_axi_write_interface_x2 
  port map (
    int_reset => slice1_y_net,
    transfer => slice7_y_net,
    auto_restart => slice6_y_net,
    packet_size => packetsize_rrc_net,
    tdata_in => concat_y_net,
    tvalid_in => logical_y_net,
    tready => m_rrc_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    ce_1600 => ce_net,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_2f4e7d13ad 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    ce => ce_net_x0,
    dout => convert4_dout_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => shift7_op_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_2b0fa1c5bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => shift6_op_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Data Inspector RRC
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_data_inspector_rrc is
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
    ce_1600 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_data_inspector_rrc;
architecture structural of axi_qpsk_rx_data_inspector_rrc is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsize_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_rrc_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal ce_net_x0 : std_logic;
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  shift6_op_net <= symbol_i_data;
  logical_y_net <= symbol_i_valid;
  shift7_op_net <= symbol_q_data;
  slice1_y_net <= reset;
  packetsize_rrc_net <= packet_size;
  slice7_y_net <= transfer;
  slice6_y_net <= auto_restart;
  m_rrc_axis_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  ce_net_x0 <= ce_1600;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_rx_m_axis_symbol_ctrl_x2 
  port map (
    i_data => shift6_op_net,
    tvalid_in => logical_y_net,
    q_data => shift7_op_net,
    reset => slice1_y_net,
    packet_size => packetsize_rrc_net,
    tready_in => m_rrc_axis_tready_net,
    transfer => slice7_y_net,
    auto_restart => slice6_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_1600 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Decimation Filtering Stages
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_decimation_filtering_stages is
  port (
    i_in : in std_logic_vector( 16-1 downto 0 );
    q_in : in std_logic_vector( 16-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tready : in std_logic_vector( 1-1 downto 0 );
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
end axi_qpsk_rx_decimation_filtering_stages;
architecture structural of axi_qpsk_rx_decimation_filtering_stages is 
  signal fir_compiler_7_2_7_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_7_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_8_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_8_m_axis_data_tvalid_net : std_logic;
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_i_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_q_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal clk_40_net : std_logic;
  signal ce_40_net : std_logic;
  signal clk_80_net : std_logic;
  signal ce_80_net : std_logic;
  signal clk_3200_net : std_logic;
  signal ce_3200_net : std_logic;
  signal clk_net_x2 : std_logic;
  signal ce_net_x2 : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x1 : std_logic;
  signal ce_net_x1 : std_logic;
  signal cic_compiler_4_0_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_m_axis_data_tvalid_net : std_logic;
  signal cic_compiler_4_0_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic;
  signal cic_compiler_4_0_1_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_1_m_axis_data_tvalid_net : std_logic;
  signal cic_compiler_4_0_1_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal cic_compiler_4_0_2_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_2_m_axis_data_tvalid_net : std_logic;
  signal cic_compiler_4_0_2_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal delay2_q_net : std_logic;
  signal cic_compiler_4_0_3_s_axis_data_tready_net : std_logic;
  signal cic_compiler_4_0_3_m_axis_data_tvalid_net : std_logic;
  signal cic_compiler_4_0_3_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic;
  signal shift3_op_net : std_logic_vector( 17-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 16-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 17-1 downto 0 );
  signal cmult2_p_net : std_logic_vector( 16-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 17-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 17-1 downto 0 );
  signal cmult3_p_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_3_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal fir_compiler_7_2_1_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_4_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_2_m_axis_data_tdata_real_net : std_logic_vector( 33-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_5_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_6_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_7_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal fir_compiler_7_2_8_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_3_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_1_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_2_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_4_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_5_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_6_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_1_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_2_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_3_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_4_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_5_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_6_s_axis_data_tready_net : std_logic;
begin
  i_out <= convert6_dout_net;
  q_out <= convert7_dout_net;
  tvalid_out <= logical1_y_net;
  s_i_axis_tdata_net <= i_in;
  s_q_axis_tdata_net <= q_in;
  logical1_y_net_x0 <= tvalid_in;
  m_rf_axis_tready_net <= tready;
  slice_y_net <= enable;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  clk_40_net <= clk_40;
  ce_40_net <= ce_40;
  clk_80_net <= clk_80;
  ce_80_net <= ce_80;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  clk_net_x2 <= clk_6400;
  ce_net_x2 <= ce_6400;
  clk_net_x0 <= clk_12800;
  ce_net <= ce_12800;
  clk_net_x1 <= clk_25600;
  ce_net_x1 <= ce_25600;
  cic_compiler_4_0 : entity xil_defaultlib.xlcic_compiler_37f18edfc02d40b346aaebf9efc006db 
  port map (
    s_axis_data_tdata_real => s_i_axis_tdata_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_logic_1 => clk_net,
    ce_logic_1 => ce_net_x0,
    s_axis_data_tready => cic_compiler_4_0_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_m_axis_data_tdata_real_net
  );
  cic_compiler_4_0_1 : entity xil_defaultlib.xlcic_compiler_37f18edfc02d40b346aaebf9efc006db 
  port map (
    s_axis_data_tdata_real => s_q_axis_tdata_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_logic_1 => clk_net,
    ce_logic_1 => ce_net_x0,
    s_axis_data_tready => cic_compiler_4_0_1_s_axis_data_tready_net,
    m_axis_data_tvalid => cic_compiler_4_0_1_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => cic_compiler_4_0_1_m_axis_data_tdata_real_net
  );
  cic_compiler_4_0_2 : entity xil_defaultlib.xlcic_compiler_af10703a295672242f03d669604ee1f7 
  port map (
    s_axis_data_tdata_real => convert_dout_net,
    en => delay2_q_net,
    clk => clk_net,
    ce => ce_net_x0,
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
  cic_compiler_4_0_3 : entity xil_defaultlib.xlcic_compiler_af10703a295672242f03d669604ee1f7 
  port map (
    s_axis_data_tdata_real => convert1_dout_net,
    en => delay3_q_net,
    clk => clk_net,
    ce => ce_net_x0,
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
  cmult : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 17,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 17,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 33,
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i6",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
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
    clk => clk_40_net,
    ce => ce_40_net,
    core_clk => clk_40_net,
    core_ce => ce_40_net,
    p => cmult_p_net
  );
  cmult1 : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 17,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 17,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 33,
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i6",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => shift1_op_net,
    clk => clk_40_net,
    ce => ce_40_net,
    core_clk => clk_40_net,
    core_ce => ce_40_net,
    p => cmult1_p_net
  );
  cmult2 : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 17,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 17,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 33,
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i6",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => shift4_op_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    core_clk => clk_3200_net,
    core_ce => ce_3200_net,
    p => cmult2_p_net
  );
  cmult3 : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 17,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 17,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 33,
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i6",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => shift2_op_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    core_clk => clk_3200_net,
    core_ce => ce_3200_net,
    p => cmult3_p_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert1 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    clk => clk_net_x2,
    ce => ce_net_x2,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    clk => clk_net_x2,
    ce => ce_net_x2,
    dout => convert3_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    ce => ce_net,
    dout => convert5_dout_net
  );
  convert6 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    clk => clk_net_x1,
    ce => ce_net_x1,
    dout => convert6_dout_net
  );
  convert7 : entity xil_defaultlib.axi_qpsk_rx_xlconvert 
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
    clk => clk_net_x1,
    ce => ce_net_x1,
    dout => convert7_dout_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d(0) => cic_compiler_4_0_1_m_axis_data_tvalid_net,
    clk => clk_40_net,
    ce => ce_40_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d(0) => cic_compiler_4_0_m_axis_data_tvalid_net,
    clk => clk_40_net,
    ce => ce_40_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay3 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay4 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d(0) => cic_compiler_4_0_2_m_axis_data_tvalid_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay4_q_net
  );
  delay5 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d(0) => cic_compiler_4_0_3_m_axis_data_tvalid_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    clk => clk_net_x2,
    ce => ce_net_x2,
    q => delay6_q_net
  );
  delay7 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    clk => clk_net_x2,
    ce => ce_net_x2,
    q => delay7_q_net
  );
  delay8 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    ce => ce_net,
    q => delay8_q_net
  );
  delay9 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    ce => ce_net,
    q => delay9_q_net
  );
  fir_compiler_7_2_1 : entity xil_defaultlib.xlfir_compiler_01d1aeffd197140cfb09270a59cd8fdf 
  port map (
    s_axis_data_tdata_real => cmult1_p_net,
    en => delay_q_net(0),
    src_clk => clk_40_net,
    src_ce => ce_40_net,
    clk => clk_net,
    ce => ce_net_x0,
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
  fir_compiler_7_2_2 : entity xil_defaultlib.xlfir_compiler_5c7307251e097c00a189135eeeb98bca 
  port map (
    s_axis_data_tdata_real => cmult3_p_net,
    en => delay5_q_net(0),
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    clk => clk_net,
    ce => ce_net_x0,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => fir_compiler_7_2_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_2_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_2_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_3 : entity xil_defaultlib.xlfir_compiler_01d1aeffd197140cfb09270a59cd8fdf 
  port map (
    s_axis_data_tdata_real => cmult_p_net,
    en => delay1_q_net(0),
    src_clk => clk_40_net,
    src_ce => ce_40_net,
    clk => clk_net,
    ce => ce_net_x0,
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
  fir_compiler_7_2_4 : entity xil_defaultlib.xlfir_compiler_5c7307251e097c00a189135eeeb98bca 
  port map (
    s_axis_data_tdata_real => cmult2_p_net,
    en => delay4_q_net(0),
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    clk => clk_net,
    ce => ce_net_x0,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => fir_compiler_7_2_4_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_4_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_4_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_5 : entity xil_defaultlib.xlfir_compiler_3916ee27bcf977f17f8b73d96f6228bd 
  port map (
    s_axis_data_tdata_real => convert2_dout_net,
    en => delay7_q_net(0),
    src_clk => clk_net_x2,
    src_ce => ce_net_x2,
    clk => clk_net,
    ce => ce_net_x0,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net,
    clk_logic_6400 => clk_net_x2,
    ce_logic_6400 => ce_net_x2,
    s_axis_data_tready => fir_compiler_7_2_5_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_5_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_5_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_6 : entity xil_defaultlib.xlfir_compiler_3916ee27bcf977f17f8b73d96f6228bd 
  port map (
    s_axis_data_tdata_real => convert3_dout_net,
    en => delay6_q_net(0),
    src_clk => clk_net_x2,
    src_ce => ce_net_x2,
    clk => clk_net,
    ce => ce_net_x0,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net,
    clk_logic_6400 => clk_net_x2,
    ce_logic_6400 => ce_net_x2,
    s_axis_data_tready => fir_compiler_7_2_6_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_6_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_6_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_7 : entity xil_defaultlib.xlfir_compiler_67a914d3e02be7d68a6298218071ca32 
  port map (
    s_axis_data_tdata_real => convert4_dout_net,
    en => delay8_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net,
    ce => ce_net_x0,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net,
    clk_25600 => clk_net_x1,
    ce_25600 => ce_net_x1,
    clk_logic_12800 => clk_net_x0,
    ce_logic_12800 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_7_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_7_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_7_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_8 : entity xil_defaultlib.xlfir_compiler_67a914d3e02be7d68a6298218071ca32 
  port map (
    s_axis_data_tdata_real => convert5_dout_net,
    en => delay9_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net,
    clk => clk_net,
    ce => ce_net_x0,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net,
    clk_25600 => clk_net_x1,
    ce_25600 => ce_net_x1,
    clk_logic_12800 => clk_net_x0,
    ce_logic_12800 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_8_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_8_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_8_m_axis_data_tdata_real_net
  );
  logical : entity xil_defaultlib.sysgen_logical_cee7ed0ed3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net_x0,
    d1 => m_rf_axis_tready_net,
    d2 => slice_y_net,
    y(0) => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_5939c83eda 
  port map (
    clr => '0',
    d0(0) => fir_compiler_7_2_8_m_axis_data_tvalid_net,
    d1(0) => fir_compiler_7_2_7_m_axis_data_tvalid_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    y => logical1_y_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_3b0583e07f 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_1_m_axis_data_tdata_real_net,
    clk => clk_40_net,
    ce => ce_40_net,
    op => shift1_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_3b0583e07f 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_3_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    op => shift2_op_net
  );
  shift3 : entity xil_defaultlib.sysgen_shift_3b0583e07f 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_m_axis_data_tdata_real_net,
    clk => clk_40_net,
    ce => ce_40_net,
    op => shift3_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_3b0583e07f 
  port map (
    clr => '0',
    ip => cic_compiler_4_0_2_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    op => shift4_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/M_AXIS
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_m_axis;
architecture structural of axi_qpsk_rx_m_axis is 
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_rf_axis_tready_net <= m_rf_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/M_AXIS_DECIMATION
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis_decimation is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_m_axis_decimation;
architecture structural of axi_qpsk_rx_m_axis_decimation is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_dec_axis_tready_net : std_logic_vector( 1-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_dec_axis_tready_net <= m_dec_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/M_AXIS_FREQ_SYNC
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis_freq_sync is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_m_axis_freq_sync;
architecture structural of axi_qpsk_rx_m_axis_freq_sync is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_sync_axis_tready_net : std_logic_vector( 1-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_sync_axis_tready_net <= m_sync_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/M_AXIS_RRC
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_m_axis_rrc is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_m_axis_rrc;
architecture structural of axi_qpsk_rx_m_axis_rrc is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_rrc_axis_tready_net : std_logic_vector( 1-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_rrc_axis_tready_net <= m_rrc_axis_tready;
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/RRC Filtering and Pre-Synch Interpolation 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_rrc_filtering_and_pre_synch_interpolation is
  port (
    i_in : in std_logic_vector( 18-1 downto 0 );
    q_in : in std_logic_vector( 18-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    i_out : out std_logic_vector( 16-1 downto 0 );
    q_out : out std_logic_vector( 16-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_rrc_filtering_and_pre_synch_interpolation;
architecture structural of axi_qpsk_rx_rrc_filtering_and_pre_synch_interpolation is 
  signal shift6_op_net : std_logic_vector( 16-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 18-1 downto 0 );
  signal delay2_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x1 : std_logic;
  signal ce_net_x1 : std_logic;
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal clk_3200_net : std_logic;
  signal ce_3200_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_4_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_2_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_5_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_6_m_axis_data_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_2_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_2_m_axis_data_tdata_real_net : std_logic_vector( 37-1 downto 0 );
  signal fir_compiler_7_2_4_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_4_m_axis_data_tdata_real_net : std_logic_vector( 37-1 downto 0 );
  signal fir_compiler_7_2_5_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_5_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_6_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_6_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal shift2_op_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_7_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_7_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_7_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal shift4_op_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_8_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_8_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_8_m_axis_data_tdata_real_net : std_logic_vector( 32-1 downto 0 );
  signal shift5_op_net : std_logic_vector( 16-1 downto 0 );
begin
  i_out <= shift6_op_net;
  q_out <= shift7_op_net;
  tvalid_out <= logical_y_net;
  convert4_dout_net <= i_in;
  convert5_dout_net <= q_in;
  delay2_q_net_x0 <= tvalid_in;
  clk_net_x1 <= clk_1;
  ce_net_x1 <= ce_1;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  clk_net_x0 <= clk_6400;
  ce_net_x0 <= ce_6400;
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay3_q_net
  );
  delay4 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    clk => clk_3200_net,
    ce => ce_3200_net,
    q => delay4_q_net
  );
  fir_compiler_7_2_2 : entity xil_defaultlib.xlfir_compiler_0014b67889914168a9f41e931b693b4c 
  port map (
    s_axis_data_tdata_real => convert4_dout_net,
    en => delay2_q_net_x0(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_6400 => clk_net_x0,
    ce_6400 => ce_net_x0,
    clk_logic_6400 => clk_net_x0,
    ce_logic_6400 => ce_net_x0,
    s_axis_data_tready => fir_compiler_7_2_2_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_2_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_2_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_4 : entity xil_defaultlib.xlfir_compiler_0014b67889914168a9f41e931b693b4c 
  port map (
    s_axis_data_tdata_real => convert5_dout_net,
    en => delay2_q_net_x0(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_6400 => clk_net_x0,
    ce_6400 => ce_net_x0,
    clk_logic_6400 => clk_net_x0,
    ce_logic_6400 => ce_net_x0,
    s_axis_data_tready => fir_compiler_7_2_4_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_4_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_4_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_5 : entity xil_defaultlib.xlfir_compiler_041b08792fd78d36a48b07a12d3328a2 
  port map (
    s_axis_data_tdata_real => shift_op_net,
    en => delay2_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x0,
    ce_6400 => ce_net_x0,
    clk_logic_6400 => clk_net_x0,
    ce_logic_6400 => ce_net_x0,
    s_axis_data_tready => fir_compiler_7_2_5_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_5_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_5_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_6 : entity xil_defaultlib.xlfir_compiler_041b08792fd78d36a48b07a12d3328a2 
  port map (
    s_axis_data_tdata_real => shift2_op_net,
    en => delay1_q_net(0),
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x0,
    ce_6400 => ce_net_x0,
    clk_logic_6400 => clk_net_x0,
    ce_logic_6400 => ce_net_x0,
    s_axis_data_tready => fir_compiler_7_2_6_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_6_m_axis_data_tvalid_net(0),
    m_axis_data_tdata_real => fir_compiler_7_2_6_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_7 : entity xil_defaultlib.xlfir_compiler_c0378ac8a16c56d90cd5cf68473618a1 
  port map (
    s_axis_data_tdata_real => shift4_op_net,
    en => delay3_q_net(0),
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => fir_compiler_7_2_7_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_7_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_7_m_axis_data_tdata_real_net
  );
  fir_compiler_7_2_8 : entity xil_defaultlib.xlfir_compiler_c0378ac8a16c56d90cd5cf68473618a1 
  port map (
    s_axis_data_tdata_real => shift5_op_net,
    en => delay4_q_net(0),
    src_clk => clk_3200_net,
    src_ce => ce_3200_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_logic_3200 => clk_3200_net,
    ce_logic_3200 => ce_3200_net,
    s_axis_data_tready => fir_compiler_7_2_8_s_axis_data_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_8_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_8_m_axis_data_tdata_real_net
  );
  logical : entity xil_defaultlib.sysgen_logical_5939c83eda 
  port map (
    clr => '0',
    d0(0) => fir_compiler_7_2_7_m_axis_data_tvalid_net,
    d1(0) => fir_compiler_7_2_8_m_axis_data_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_2a2162dd1a 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_2_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => shift_op_net
  );
  shift2 : entity xil_defaultlib.sysgen_shift_2a2162dd1a 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_4_m_axis_data_tdata_real_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    op => shift2_op_net
  );
  shift4 : entity xil_defaultlib.sysgen_shift_9048a82ea4 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_5_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    op => shift4_op_net
  );
  shift5 : entity xil_defaultlib.sysgen_shift_9048a82ea4 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_6_m_axis_data_tdata_real_net,
    clk => clk_3200_net,
    ce => ce_3200_net,
    op => shift5_op_net
  );
  shift6 : entity xil_defaultlib.sysgen_shift_9048a82ea4 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_7_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => ce_net,
    op => shift6_op_net
  );
  shift7 : entity xil_defaultlib.sysgen_shift_9048a82ea4 
  port map (
    clr => '0',
    ip => fir_compiler_7_2_8_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => ce_net,
    op => shift7_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/S_AXIS
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_s_axis is
  port (
    tready_i_in : in std_logic_vector( 1-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    packetsize_dec : in std_logic_vector( 32-1 downto 0 );
    packetsize_rrc : in std_logic_vector( 32-1 downto 0 );
    packetsize_sync : in std_logic_vector( 32-1 downto 0 );
    rxreset : in std_logic_vector( 32-1 downto 0 );
    auto_restart : in std_logic_vector( 32-1 downto 0 );
    auto_restart_dec : in std_logic_vector( 32-1 downto 0 );
    auto_restart_rrc : in std_logic_vector( 32-1 downto 0 );
    auto_restart_sync : in std_logic_vector( 32-1 downto 0 );
    s_i_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_i_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_q_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_q_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 32-1 downto 0 );
    transfer_dec : in std_logic_vector( 32-1 downto 0 );
    transfer_rrc : in std_logic_vector( 32-1 downto 0 );
    transfer_sync : in std_logic_vector( 32-1 downto 0 );
    reset_out : out std_logic_vector( 1-1 downto 0 );
    enable_out : out std_logic_vector( 1-1 downto 0 );
    auto_restart_out : out std_logic_vector( 1-1 downto 0 );
    transfer_out : out std_logic_vector( 1-1 downto 0 );
    autorestart_dec_out : out std_logic_vector( 1-1 downto 0 );
    transfer_dec_out : out std_logic_vector( 1-1 downto 0 );
    autorestart_rrc_out : out std_logic_vector( 1-1 downto 0 );
    transfer_rrc_out : out std_logic_vector( 1-1 downto 0 );
    autorestart_sync_out : out std_logic_vector( 1-1 downto 0 );
    transfer_sync_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_s_axis;
architecture structural of axi_qpsk_rx_s_axis is 
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_dec_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_sync_net : std_logic_vector( 32-1 downto 0 );
  signal rxreset_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_dec_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_sync_net : std_logic_vector( 32-1 downto 0 );
  signal s_i_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_i_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_q_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_q_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal transfer_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_dec_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_sync_net : std_logic_vector( 32-1 downto 0 );
begin
  reset_out <= slice1_y_net;
  enable_out <= slice_y_net;
  auto_restart_out <= slice2_y_net;
  transfer_out <= slice3_y_net;
  autorestart_dec_out <= slice4_y_net;
  transfer_dec_out <= slice5_y_net;
  autorestart_rrc_out <= slice6_y_net;
  transfer_rrc_out <= slice7_y_net;
  autorestart_sync_out <= slice8_y_net;
  transfer_sync_out <= slice9_y_net;
  m_rf_axis_tready_net <= tready_i_in;
  enable_net <= enable;
  packetsizerf_net <= packetsizerf;
  packetsize_dec_net <= packetsize_dec;
  packetsize_rrc_net <= packetsize_rrc;
  packetsize_sync_net <= packetsize_sync;
  rxreset_net <= rxreset;
  auto_restart_net <= auto_restart;
  auto_restart_dec_net <= auto_restart_dec;
  auto_restart_rrc_net <= auto_restart_rrc;
  auto_restart_sync_net <= auto_restart_sync;
  s_i_axis_tdata_net <= s_i_axis_tdata;
  s_i_axis_tvalid_net <= s_i_axis_tvalid;
  s_q_axis_tdata_net <= s_q_axis_tdata;
  s_q_axis_tvalid_net <= s_q_axis_tvalid;
  transfer_net <= transfer;
  transfer_dec_net <= transfer_dec;
  transfer_rrc_net <= transfer_rrc;
  transfer_sync_net <= transfer_sync;
  slice : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice2 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice3 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
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
  slice4 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => auto_restart_dec_net,
    y => slice4_y_net
  );
  slice5 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transfer_dec_net,
    y => slice5_y_net
  );
  slice6 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => auto_restart_rrc_net,
    y => slice6_y_net
  );
  slice7 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transfer_rrc_net,
    y => slice7_y_net
  );
  slice8 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => auto_restart_sync_net,
    y => slice8_y_net
  );
  slice9 : entity xil_defaultlib.axi_qpsk_rx_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => transfer_sync_net,
    y => slice9_y_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Timing Synch1/Loop Filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_loop_filter is
  port (
    signal_x0 : in std_logic_vector( 20-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    error_filt : out std_logic_vector( 39-1 downto 0 )
  );
end axi_qpsk_rx_loop_filter;
architecture structural of axi_qpsk_rx_loop_filter is 
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal register_q_net : std_logic_vector( 20-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal cmult_p_net : std_logic_vector( 35-1 downto 0 );
  signal addsub4_s_net : std_logic_vector( 38-1 downto 0 );
  signal cmult1_p_net : std_logic_vector( 38-1 downto 0 );
  signal register1_q_net : std_logic_vector( 38-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 38-1 downto 0 );
begin
  error_filt <= addsub3_s_net;
  register_q_net <= signal_x0;
  delay10_q_net <= en;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub3 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i7",
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
  addsub4 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i7",
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
  cmult : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i7",
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
  cmult1 : entity xil_defaultlib.axi_qpsk_rx_xlcmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i8",
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
  constant_x0 : entity xil_defaultlib.sysgen_constant_766b7584dc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_014707fac5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => delay10_q_net,
    d0 => constant_op_net,
    d1 => addsub4_s_net,
    y => mux_y_net
  );
  register1 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 38,
    init_value => b"00000000000000000000000000000000000000"
  )
  port map (
    rst => "0",
    d => mux_y_net,
    en => delay10_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Timing Synch1/NCC
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_ncc is
  port (
    error_filt : in std_logic_vector( 39-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    strobe : out std_logic_vector( 1-1 downto 0 );
    adj_step : out std_logic_vector( 26-1 downto 0 )
  );
end axi_qpsk_rx_ncc;
architecture structural of axi_qpsk_rx_ncc is 
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub6_s_net : std_logic_vector( 26-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub1_s_net : std_logic_vector( 29-1 downto 0 );
  signal register_q_net : std_logic_vector( 30-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 30-1 downto 0 );
  signal mux_y_net : std_logic_vector( 29-1 downto 0 );
  signal addsub5_s_net : std_logic_vector( 30-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 26-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
begin
  strobe <= relational_op_net;
  adj_step <= addsub6_s_net;
  addsub3_s_net <= error_filt;
  logical_y_net <= en;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  addsub1 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i8",
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
  addsub5 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i9",
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
  addsub6 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i10",
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
  constant1 : entity xil_defaultlib.sysgen_constant_3fbbbda527 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_a8a74738be 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_7e5186e255 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => relational1_op_net,
    d0 => register_q_net,
    d1 => addsub1_s_net,
    y => mux_y_net
  );
  register_x0 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
  generic map (
    d_width => 30,
    init_value => b"000010000000000000000000000000"
  )
  port map (
    rst => "0",
    d => addsub5_s_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_b397dac787 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => register_q_net,
    b => addsub5_s_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_b397dac787 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => register_q_net,
    b => constant2_op_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem/Timing Synch1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_timing_synch1 is
  port (
    i_in : in std_logic_vector( 16-1 downto 0 );
    q_in : in std_logic_vector( 16-1 downto 0 );
    valid_in : in std_logic_vector( 1-1 downto 0 );
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    sample_valid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_timing_synch1;
architecture structural of axi_qpsk_rx_timing_synch1 is 
  signal delay12_q_net : std_logic_vector( 1-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 16-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addsub3_s_net : std_logic_vector( 39-1 downto 0 );
  signal register_q_net : std_logic_vector( 20-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub6_s_net : std_logic_vector( 26-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 19-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 18-1 downto 0 );
  signal delay_q_net : std_logic_vector( 18-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 19-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 18-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 18-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 20-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay11_q_net : std_logic_vector( 1-1 downto 0 );
begin
  sample_valid <= delay12_q_net;
  shift6_op_net <= i_in;
  shift7_op_net <= q_in;
  logical_y_net_x0 <= valid_in;
  clk_net <= clk_1600;
  ce_net <= ce_1600;
  loop_filter : entity xil_defaultlib.axi_qpsk_rx_loop_filter 
  port map (
    signal_x0 => register_q_net,
    en => delay10_q_net,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    error_filt => addsub3_s_net
  );
  ncc : entity xil_defaultlib.axi_qpsk_rx_ncc 
  port map (
    error_filt => addsub3_s_net,
    en => logical_y_net_x0,
    clk_1600 => clk_net,
    ce_1600 => ce_net,
    strobe => relational_op_net,
    adj_step => addsub6_s_net
  );
  addsub : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i1",
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
  addsub1 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i1",
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
  addsub2 : entity xil_defaultlib.axi_qpsk_rx_xladdsub 
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
    core_name0 => "axi_qpsk_rx_c_addsub_v12_0_i6",
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
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay10 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay11 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  delay12 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
  logical : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational_op_net,
    d1 => logical_y_net_x0,
    y => logical_y_net
  );
  mult1 : entity xil_defaultlib.axi_qpsk_rx_xlmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i0",
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
    a => shift7_op_net,
    b => shift7_op_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.axi_qpsk_rx_xlmult 
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
    core_name0 => "axi_qpsk_rx_mult_gen_v12_0_i0",
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
    a => shift6_op_net,
    b => shift6_op_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult2_p_net
  );
  register_x0 : entity xil_defaultlib.axi_qpsk_rx_xlregister 
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
-- Generated from Simulink block AXI_QPSK_Rx/Subsystem
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_subsystem is
  port (
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tready : in std_logic_vector( 1-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    packetsize_dec : in std_logic_vector( 32-1 downto 0 );
    packetsize_rrc : in std_logic_vector( 32-1 downto 0 );
    packetsize_sync : in std_logic_vector( 32-1 downto 0 );
    rxreset : in std_logic_vector( 32-1 downto 0 );
    auto_restart : in std_logic_vector( 32-1 downto 0 );
    auto_restart_dec : in std_logic_vector( 32-1 downto 0 );
    auto_restart_rrc : in std_logic_vector( 32-1 downto 0 );
    auto_restart_sync : in std_logic_vector( 32-1 downto 0 );
    s_i_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_i_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_q_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_q_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 32-1 downto 0 );
    transfer_dec : in std_logic_vector( 32-1 downto 0 );
    transfer_rrc : in std_logic_vector( 32-1 downto 0 );
    transfer_sync : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_40 : in std_logic;
    ce_40 : in std_logic;
    clk_80 : in std_logic;
    ce_80 : in std_logic;
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    m_rf_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_rf_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_rf_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_dec_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_sync_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_rrc_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_subsystem;
architecture structural of axi_qpsk_rx_subsystem is 
  signal convert4_dout_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net_x1 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal m_dec_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net_x2 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal m_sync_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net_x3 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x2 : std_logic_vector( 1-1 downto 0 );
  signal m_rrc_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x2 : std_logic_vector( 1-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_dec_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_sync_net : std_logic_vector( 32-1 downto 0 );
  signal rxreset_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_dec_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_sync_net : std_logic_vector( 32-1 downto 0 );
  signal s_i_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_i_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x2 : std_logic;
  signal s_q_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_q_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal transfer_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_dec_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_sync_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal clk_40_net : std_logic;
  signal ce_40_net : std_logic;
  signal clk_80_net : std_logic;
  signal ce_80_net : std_logic;
  signal clk_net_x3 : std_logic;
  signal ce_net_x3 : std_logic;
  signal clk_3200_net : std_logic;
  signal ce_3200_net : std_logic;
  signal ce_net_x2 : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x1 : std_logic;
  signal ce_net_x1 : std_logic;
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x3 : std_logic_vector( 19-1 downto 0 );
  signal register5_q_net : std_logic_vector( 19-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 16-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 18-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert7_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift6_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal shift7_op_net : std_logic_vector( 16-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
begin
  m_rf_axis_tdata <= convert4_dout_net_x0;
  m_rf_axis_tlast <= register3_q_net;
  m_rf_axis_tready_net <= m_rf_axis_tready;
  m_rf_axis_tvalid <= register4_q_net;
  m_dec_axis_tdata <= convert4_dout_net_x1;
  m_dec_axis_tlast <= register3_q_net_x0;
  m_dec_axis_tready_net <= m_dec_axis_tready;
  m_dec_axis_tvalid <= register4_q_net_x0;
  m_sync_axis_tdata <= convert4_dout_net_x2;
  m_sync_axis_tlast <= register3_q_net_x1;
  m_sync_axis_tready_net <= m_sync_axis_tready;
  m_sync_axis_tvalid <= register4_q_net_x1;
  m_rrc_axis_tdata <= convert4_dout_net_x3;
  m_rrc_axis_tlast <= register3_q_net_x2;
  m_rrc_axis_tready_net <= m_rrc_axis_tready;
  m_rrc_axis_tvalid <= register4_q_net_x2;
  enable_net <= enable;
  packetsizerf_net <= packetsizerf;
  packetsize_dec_net <= packetsize_dec;
  packetsize_rrc_net <= packetsize_rrc;
  packetsize_sync_net <= packetsize_sync;
  rxreset_net <= rxreset;
  auto_restart_net <= auto_restart;
  auto_restart_dec_net <= auto_restart_dec;
  auto_restart_rrc_net <= auto_restart_rrc;
  auto_restart_sync_net <= auto_restart_sync;
  s_i_axis_tdata_net <= s_i_axis_tdata;
  s_i_axis_tvalid_net <= s_i_axis_tvalid;
  s_q_axis_tdata_net <= s_q_axis_tdata;
  s_q_axis_tvalid_net <= s_q_axis_tvalid;
  transfer_net <= transfer;
  transfer_dec_net <= transfer_dec;
  transfer_rrc_net <= transfer_rrc;
  transfer_sync_net <= transfer_sync;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  clk_40_net <= clk_40;
  ce_40_net <= ce_40;
  clk_80_net <= clk_80;
  ce_80_net <= ce_80;
  clk_net_x3 <= clk_1600;
  ce_net_x3 <= ce_1600;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  clk_net_x2 <= clk_6400;
  ce_net_x2 <= ce_6400;
  clk_net_x0 <= clk_12800;
  ce_net <= ce_12800;
  clk_net_x1 <= clk_25600;
  ce_net_x1 <= ce_25600;
  carrier_synch : entity xil_defaultlib.axi_qpsk_rx_carrier_synch 
  port map (
    sample_strobe => logical_y_net,
    x_in => delay2_q_net_x0,
    y_in => delay3_q_net,
    clk_1600 => clk_net_x3,
    ce_1600 => ce_net_x3,
    symbol_strobe => delay_q_net,
    i_out => register4_q_net_x3,
    q_out => register5_q_net
  );
  coarse_frequency_synchroniser : entity xil_defaultlib.axi_qpsk_rx_coarse_frequency_synchroniser 
  port map (
    i_samples => convert6_dout_net,
    q_samples => convert7_dout_net,
    tvalid_in => logical1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    clk_25600 => clk_net_x1,
    ce_25600 => ce_net_x1,
    corrected_i => convert4_dout_net,
    corrected_q => convert5_dout_net,
    tvalid_out => delay2_q_net
  );
  data_inspector : entity xil_defaultlib.axi_qpsk_rx_data_inspector 
  port map (
    symbol_i_data => register4_q_net_x3,
    symbol_i_valid => delay_q_net,
    symbol_q_data => register5_q_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    transfer => slice3_y_net,
    auto_restart => slice2_y_net,
    tready_in => m_rf_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    clk_1600 => clk_net_x3,
    ce_1600 => ce_net_x3,
    tdata_out => convert4_dout_net_x0,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
  data_inspector_decimation : entity xil_defaultlib.axi_qpsk_rx_data_inspector_decimation 
  port map (
    symbol_i_data => convert6_dout_net,
    symbol_i_valid => logical1_y_net,
    symbol_q_data => convert7_dout_net,
    reset => slice1_y_net,
    packet_size => packetsize_dec_net,
    transfer => slice5_y_net,
    auto_restart => slice4_y_net,
    tready_in => m_dec_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    clk_25600 => clk_net_x1,
    ce_25600 => ce_net_x1,
    tdata_out => convert4_dout_net_x1,
    tvalid_out => register4_q_net_x0,
    tlast_out => register3_q_net_x0
  );
  data_inspector_freq_sync : entity xil_defaultlib.axi_qpsk_rx_data_inspector_freq_sync 
  port map (
    symbol_i_data => convert4_dout_net,
    symbol_i_valid => delay2_q_net,
    symbol_q_data => convert5_dout_net,
    reset => slice1_y_net,
    packet_size => packetsize_sync_net,
    transfer => slice9_y_net,
    auto_restart => slice8_y_net,
    tready_in => m_sync_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    tdata_out => convert4_dout_net_x2,
    tvalid_out => register4_q_net_x1,
    tlast_out => register3_q_net_x1
  );
  data_inspector_rrc : entity xil_defaultlib.axi_qpsk_rx_data_inspector_rrc 
  port map (
    symbol_i_data => shift6_op_net,
    symbol_i_valid => logical_y_net_x0,
    symbol_q_data => shift7_op_net,
    reset => slice1_y_net,
    packet_size => packetsize_rrc_net,
    transfer => slice7_y_net,
    auto_restart => slice6_y_net,
    tready_in => m_rrc_axis_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    ce_1600 => ce_net_x3,
    tdata_out => convert4_dout_net_x3,
    tvalid_out => register4_q_net_x2,
    tlast_out => register3_q_net_x2
  );
  decimation_filtering_stages : entity xil_defaultlib.axi_qpsk_rx_decimation_filtering_stages 
  port map (
    i_in => s_i_axis_tdata_net,
    q_in => s_q_axis_tdata_net,
    tvalid_in => logical1_y_net_x0,
    tready => m_rf_axis_tready_net,
    enable => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    clk_12800 => clk_net_x0,
    ce_12800 => ce_net,
    clk_25600 => clk_net_x1,
    ce_25600 => ce_net_x1,
    i_out => convert6_dout_net,
    q_out => convert7_dout_net,
    tvalid_out => logical1_y_net
  );
  m_axis : entity xil_defaultlib.axi_qpsk_rx_m_axis 
  port map (
    tdata_in => convert4_dout_net_x0,
    tvalid_in => register4_q_net,
    tlast_in => register3_q_net,
    m_rf_axis_tready => m_rf_axis_tready_net
  );
  m_axis_decimation : entity xil_defaultlib.axi_qpsk_rx_m_axis_decimation 
  port map (
    tdata_in => convert4_dout_net_x1,
    tvalid_in => register4_q_net_x0,
    tlast_in => register3_q_net_x0,
    m_dec_axis_tready => m_dec_axis_tready_net
  );
  m_axis_freq_sync : entity xil_defaultlib.axi_qpsk_rx_m_axis_freq_sync 
  port map (
    tdata_in => convert4_dout_net_x2,
    tvalid_in => register4_q_net_x1,
    tlast_in => register3_q_net_x1,
    m_sync_axis_tready => m_sync_axis_tready_net
  );
  m_axis_rrc : entity xil_defaultlib.axi_qpsk_rx_m_axis_rrc 
  port map (
    tdata_in => convert4_dout_net_x3,
    tvalid_in => register4_q_net_x2,
    tlast_in => register3_q_net_x2,
    m_rrc_axis_tready => m_rrc_axis_tready_net
  );
  rrc_filtering_and_pre_synch_interpolation : entity xil_defaultlib.axi_qpsk_rx_rrc_filtering_and_pre_synch_interpolation 
  port map (
    i_in => convert4_dout_net,
    q_in => convert5_dout_net,
    tvalid_in => delay2_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    clk_1600 => clk_net_x3,
    ce_1600 => ce_net_x3,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net_x2,
    ce_6400 => ce_net_x2,
    i_out => shift6_op_net,
    q_out => shift7_op_net,
    tvalid_out => logical_y_net_x0
  );
  s_axis : entity xil_defaultlib.axi_qpsk_rx_s_axis 
  port map (
    tready_i_in => m_rf_axis_tready_net,
    enable => enable_net,
    packetsizerf => packetsizerf_net,
    packetsize_dec => packetsize_dec_net,
    packetsize_rrc => packetsize_rrc_net,
    packetsize_sync => packetsize_sync_net,
    rxreset => rxreset_net,
    auto_restart => auto_restart_net,
    auto_restart_dec => auto_restart_dec_net,
    auto_restart_rrc => auto_restart_rrc_net,
    auto_restart_sync => auto_restart_sync_net,
    s_i_axis_tdata => s_i_axis_tdata_net,
    s_i_axis_tvalid => s_i_axis_tvalid_net,
    s_q_axis_tdata => s_q_axis_tdata_net,
    s_q_axis_tvalid => s_q_axis_tvalid_net,
    transfer => transfer_net,
    transfer_dec => transfer_dec_net,
    transfer_rrc => transfer_rrc_net,
    transfer_sync => transfer_sync_net,
    reset_out => slice1_y_net,
    enable_out => slice_y_net,
    auto_restart_out => slice2_y_net,
    transfer_out => slice3_y_net,
    autorestart_dec_out => slice4_y_net,
    transfer_dec_out => slice5_y_net,
    autorestart_rrc_out => slice6_y_net,
    transfer_rrc_out => slice7_y_net,
    autorestart_sync_out => slice8_y_net,
    transfer_sync_out => slice9_y_net
  );
  timing_synch1 : entity xil_defaultlib.axi_qpsk_rx_timing_synch1 
  port map (
    i_in => shift6_op_net,
    q_in => shift7_op_net,
    valid_in => logical_y_net_x0,
    clk_1600 => clk_net_x3,
    ce_1600 => ce_net_x3,
    sample_valid => delay12_q_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 16,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => shift6_op_net,
    clk => clk_net_x3,
    ce => ce_net_x3,
    q => delay_q_net_x0
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 16,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => shift7_op_net,
    clk => clk_net_x3,
    ce => ce_net_x3,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => delay_q_net_x0,
    clk => clk_net_x3,
    ce => ce_net_x3,
    q => delay2_q_net_x0
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_xldelay 
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
    clk => clk_net_x3,
    ce => ce_net_x3,
    q => delay3_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay12_q_net,
    d1 => logical_y_net_x0,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_a5eb79e2b1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => s_i_axis_tvalid_net,
    d1 => s_q_axis_tvalid_net,
    y => logical1_y_net_x0
  );
end structural;
-- Generated from Simulink block AXI_QPSK_Rx_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_struct is
  port (
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tready : in std_logic_vector( 1-1 downto 0 );
    enable : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    packetsize_dec : in std_logic_vector( 32-1 downto 0 );
    packetsize_rrc : in std_logic_vector( 32-1 downto 0 );
    packetsize_sync : in std_logic_vector( 32-1 downto 0 );
    rxreset : in std_logic_vector( 32-1 downto 0 );
    auto_restart : in std_logic_vector( 32-1 downto 0 );
    auto_restart_dec : in std_logic_vector( 32-1 downto 0 );
    auto_restart_rrc : in std_logic_vector( 32-1 downto 0 );
    auto_restart_sync : in std_logic_vector( 32-1 downto 0 );
    s_i_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_i_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_q_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_q_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 32-1 downto 0 );
    transfer_dec : in std_logic_vector( 32-1 downto 0 );
    transfer_rrc : in std_logic_vector( 32-1 downto 0 );
    transfer_sync : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_40 : in std_logic;
    ce_40 : in std_logic;
    clk_80 : in std_logic;
    ce_80 : in std_logic;
    clk_1600 : in std_logic;
    ce_1600 : in std_logic;
    clk_3200 : in std_logic;
    ce_3200 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_12800 : in std_logic;
    ce_12800 : in std_logic;
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    m_rf_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_rf_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_rf_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_dec_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_sync_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_rrc_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    s_i_axis_tready : out std_logic_vector( 1-1 downto 0 );
    s_q_axis_tready : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_struct;
architecture structural of axi_qpsk_rx_struct is 
  signal convert4_dout_net_x2 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x2 : std_logic_vector( 1-1 downto 0 );
  signal m_rf_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x2 : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net_x1 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal m_dec_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net_x0 : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal m_sync_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_rrc_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_dec_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal packetsize_sync_net : std_logic_vector( 32-1 downto 0 );
  signal rxreset_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_dec_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_sync_net : std_logic_vector( 32-1 downto 0 );
  signal s_i_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_i_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal s_q_axis_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_q_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal transfer_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_dec_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_rrc_net : std_logic_vector( 32-1 downto 0 );
  signal transfer_sync_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net_x1 : std_logic;
  signal ce_net_x2 : std_logic;
  signal clk_40_net : std_logic;
  signal ce_40_net : std_logic;
  signal clk_80_net : std_logic;
  signal ce_80_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
  signal clk_3200_net : std_logic;
  signal ce_3200_net : std_logic;
  signal ce_net : std_logic;
  signal clk_net_x2 : std_logic;
  signal ce_net_x3 : std_logic;
  signal clk_net_x3 : std_logic;
  signal ce_net_x1 : std_logic;
begin
  m_rf_axis_tdata <= convert4_dout_net_x2;
  m_rf_axis_tlast <= register3_q_net_x2;
  m_rf_axis_tready_net <= m_rf_axis_tready;
  m_rf_axis_tvalid <= register4_q_net_x2;
  m_dec_axis_tdata <= convert4_dout_net_x1;
  m_dec_axis_tlast <= register3_q_net_x1;
  m_dec_axis_tready_net <= m_dec_axis_tready;
  m_dec_axis_tvalid <= register4_q_net_x1;
  m_sync_axis_tdata <= convert4_dout_net_x0;
  m_sync_axis_tlast <= register3_q_net_x0;
  m_sync_axis_tready_net <= m_sync_axis_tready;
  m_sync_axis_tvalid <= register4_q_net;
  m_rrc_axis_tdata <= convert4_dout_net;
  m_rrc_axis_tlast <= register3_q_net;
  m_rrc_axis_tready_net <= m_rrc_axis_tready;
  m_rrc_axis_tvalid <= register4_q_net_x0;
  enable_net <= enable;
  packetsizerf_net <= packetsizerf;
  packetsize_dec_net <= packetsize_dec;
  packetsize_rrc_net <= packetsize_rrc;
  packetsize_sync_net <= packetsize_sync;
  rxreset_net <= rxreset;
  auto_restart_net <= auto_restart;
  auto_restart_dec_net <= auto_restart_dec;
  auto_restart_rrc_net <= auto_restart_rrc;
  auto_restart_sync_net <= auto_restart_sync;
  s_i_axis_tdata_net <= s_i_axis_tdata;
  s_i_axis_tready <= m_rf_axis_tready_net;
  s_i_axis_tvalid_net <= s_i_axis_tvalid;
  s_q_axis_tdata_net <= s_q_axis_tdata;
  s_q_axis_tready <= m_rf_axis_tready_net;
  s_q_axis_tvalid_net <= s_q_axis_tvalid;
  transfer_net <= transfer;
  transfer_dec_net <= transfer_dec;
  transfer_rrc_net <= transfer_rrc;
  transfer_sync_net <= transfer_sync;
  clk_net_x1 <= clk_1;
  ce_net_x2 <= ce_1;
  clk_40_net <= clk_40;
  ce_40_net <= ce_40;
  clk_80_net <= clk_80;
  ce_80_net <= ce_80;
  clk_net_x0 <= clk_1600;
  ce_net_x0 <= ce_1600;
  clk_3200_net <= clk_3200;
  ce_3200_net <= ce_3200;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  clk_net_x2 <= clk_12800;
  ce_net_x3 <= ce_12800;
  clk_net_x3 <= clk_25600;
  ce_net_x1 <= ce_25600;
  subsystem : entity xil_defaultlib.axi_qpsk_rx_subsystem 
  port map (
    m_rf_axis_tready => m_rf_axis_tready_net,
    m_dec_axis_tready => m_dec_axis_tready_net,
    m_sync_axis_tready => m_sync_axis_tready_net,
    m_rrc_axis_tready => m_rrc_axis_tready_net,
    enable => enable_net,
    packetsizerf => packetsizerf_net,
    packetsize_dec => packetsize_dec_net,
    packetsize_rrc => packetsize_rrc_net,
    packetsize_sync => packetsize_sync_net,
    rxreset => rxreset_net,
    auto_restart => auto_restart_net,
    auto_restart_dec => auto_restart_dec_net,
    auto_restart_rrc => auto_restart_rrc_net,
    auto_restart_sync => auto_restart_sync_net,
    s_i_axis_tdata => s_i_axis_tdata_net,
    s_i_axis_tvalid => s_i_axis_tvalid_net,
    s_q_axis_tdata => s_q_axis_tdata_net,
    s_q_axis_tvalid => s_q_axis_tvalid_net,
    transfer => transfer_net,
    transfer_dec => transfer_dec_net,
    transfer_rrc => transfer_rrc_net,
    transfer_sync => transfer_sync_net,
    clk_1 => clk_net_x1,
    ce_1 => ce_net_x2,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_1600 => clk_net_x0,
    ce_1600 => ce_net_x0,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    clk_12800 => clk_net_x2,
    ce_12800 => ce_net_x3,
    clk_25600 => clk_net_x3,
    ce_25600 => ce_net_x1,
    m_rf_axis_tdata => convert4_dout_net_x2,
    m_rf_axis_tlast => register3_q_net_x2,
    m_rf_axis_tvalid => register4_q_net_x2,
    m_dec_axis_tdata => convert4_dout_net_x1,
    m_dec_axis_tlast => register3_q_net_x1,
    m_dec_axis_tvalid => register4_q_net_x1,
    m_sync_axis_tdata => convert4_dout_net_x0,
    m_sync_axis_tlast => register3_q_net_x0,
    m_sync_axis_tvalid => register4_q_net,
    m_rrc_axis_tdata => convert4_dout_net,
    m_rrc_axis_tlast => register3_q_net,
    m_rrc_axis_tvalid => register4_q_net_x0
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_default_clock_driver is
  port (
    axi_qpsk_rx_sysclk : in std_logic;
    axi_qpsk_rx_sysce : in std_logic;
    axi_qpsk_rx_sysclr : in std_logic;
    axi_qpsk_rx_clk1 : out std_logic;
    axi_qpsk_rx_ce1 : out std_logic;
    axi_qpsk_rx_clk40 : out std_logic;
    axi_qpsk_rx_ce40 : out std_logic;
    axi_qpsk_rx_clk80 : out std_logic;
    axi_qpsk_rx_ce80 : out std_logic;
    axi_qpsk_rx_clk1600 : out std_logic;
    axi_qpsk_rx_ce1600 : out std_logic;
    axi_qpsk_rx_clk3200 : out std_logic;
    axi_qpsk_rx_ce3200 : out std_logic;
    axi_qpsk_rx_clk6400 : out std_logic;
    axi_qpsk_rx_ce6400 : out std_logic;
    axi_qpsk_rx_clk12800 : out std_logic;
    axi_qpsk_rx_ce12800 : out std_logic;
    axi_qpsk_rx_clk25600 : out std_logic;
    axi_qpsk_rx_ce25600 : out std_logic
  );
end axi_qpsk_rx_default_clock_driver;
architecture structural of axi_qpsk_rx_default_clock_driver is 
begin
  clockdriver_x6 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk1,
    ce => axi_qpsk_rx_ce1
  );
  clockdriver_x4 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 40,
    log_2_period => 6
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk40,
    ce => axi_qpsk_rx_ce40
  );
  clockdriver_x2 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 80,
    log_2_period => 7
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk80,
    ce => axi_qpsk_rx_ce80
  );
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1600,
    log_2_period => 11
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk1600,
    ce => axi_qpsk_rx_ce1600
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 3200,
    log_2_period => 12
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk3200,
    ce => axi_qpsk_rx_ce3200
  );
  clockdriver_x1 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 6400,
    log_2_period => 13
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk6400,
    ce => axi_qpsk_rx_ce6400
  );
  clockdriver_x3 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 12800,
    log_2_period => 14
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk12800,
    ce => axi_qpsk_rx_ce12800
  );
  clockdriver_x5 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 25600,
    log_2_period => 15
  )
  port map (
    sysclk => axi_qpsk_rx_sysclk,
    sysce => axi_qpsk_rx_sysce,
    sysclr => axi_qpsk_rx_sysclr,
    clk => axi_qpsk_rx_clk25600,
    ce => axi_qpsk_rx_ce25600
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx is
  port (
    m_rf_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tready : in std_logic_vector( 1-1 downto 0 );
    s_i_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_i_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_q_axis_tdata : in std_logic_vector( 16-1 downto 0 );
    s_q_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    axi_qpsk_rx_aresetn : in std_logic;
    axi_qpsk_rx_s_axi_awaddr : in std_logic_vector( 7-1 downto 0 );
    axi_qpsk_rx_s_axi_awvalid : in std_logic;
    axi_qpsk_rx_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    axi_qpsk_rx_s_axi_wvalid : in std_logic;
    axi_qpsk_rx_s_axi_bready : in std_logic;
    axi_qpsk_rx_s_axi_araddr : in std_logic_vector( 7-1 downto 0 );
    axi_qpsk_rx_s_axi_arvalid : in std_logic;
    axi_qpsk_rx_s_axi_rready : in std_logic;
    m_rf_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_rf_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_rf_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_dec_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_dec_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_sync_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_sync_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_rrc_axis_tlast : out std_logic_vector( 1-1 downto 0 );
    m_rrc_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    s_i_axis_tready : out std_logic_vector( 1-1 downto 0 );
    s_q_axis_tready : out std_logic_vector( 1-1 downto 0 );
    axi_qpsk_rx_s_axi_awready : out std_logic;
    axi_qpsk_rx_s_axi_wready : out std_logic;
    axi_qpsk_rx_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_s_axi_bvalid : out std_logic;
    axi_qpsk_rx_s_axi_arready : out std_logic;
    axi_qpsk_rx_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_s_axi_rvalid : out std_logic
  );
end axi_qpsk_rx;
architecture structural of axi_qpsk_rx is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "axi_qpsk_rx,sysgen_core_2018_2,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplusRFSOC,part=xczu28dr,speed=-2-e,package=ffvg1517,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=10,system_simulink_period=3.90625e-08,waveform_viewer=0,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=2.5,addsub=63,cic_compiler_v4_0=4,cmult=10,concat=5,constant=31,convert=47,counter=4,delay=89,fifo=4,fir_compiler_v7_2=14,inv=24,logical=39,mcode=4,mult=7,mux=4,product_macro=3,register=27,reinterpret=8,relational=12,shift=44,slice=44,sprom=6,xfft_v9_1=1,}";
  signal enable : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf : std_logic_vector( 32-1 downto 0 );
  signal packetsize_dec : std_logic_vector( 32-1 downto 0 );
  signal packetsize_rrc : std_logic_vector( 32-1 downto 0 );
  signal packetsize_sync : std_logic_vector( 32-1 downto 0 );
  signal rxreset : std_logic_vector( 32-1 downto 0 );
  signal auto_restart : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_dec : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_rrc : std_logic_vector( 32-1 downto 0 );
  signal auto_restart_sync : std_logic_vector( 32-1 downto 0 );
  signal transfer : std_logic_vector( 32-1 downto 0 );
  signal transfer_dec : std_logic_vector( 32-1 downto 0 );
  signal transfer_rrc : std_logic_vector( 32-1 downto 0 );
  signal transfer_sync : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
  signal clk_40_net : std_logic;
  signal ce_40_net : std_logic;
  signal clk_80_net : std_logic;
  signal ce_80_net : std_logic;
  signal clk_1600_net : std_logic;
  signal ce_1600_net : std_logic;
  signal clk_3200_net : std_logic;
  signal ce_3200_net : std_logic;
  signal clk_6400_net : std_logic;
  signal ce_6400_net : std_logic;
  signal clk_12800_net : std_logic;
  signal ce_12800_net : std_logic;
  signal clk_25600_net : std_logic;
  signal ce_25600_net : std_logic;
  signal clk_net : std_logic;
begin
  axi_qpsk_rx_axi_lite_interface : entity xil_defaultlib.axi_qpsk_rx_axi_lite_interface 
  port map (
    axi_qpsk_rx_s_axi_awaddr => axi_qpsk_rx_s_axi_awaddr,
    axi_qpsk_rx_s_axi_awvalid => axi_qpsk_rx_s_axi_awvalid,
    axi_qpsk_rx_s_axi_wdata => axi_qpsk_rx_s_axi_wdata,
    axi_qpsk_rx_s_axi_wstrb => axi_qpsk_rx_s_axi_wstrb,
    axi_qpsk_rx_s_axi_wvalid => axi_qpsk_rx_s_axi_wvalid,
    axi_qpsk_rx_s_axi_bready => axi_qpsk_rx_s_axi_bready,
    axi_qpsk_rx_s_axi_araddr => axi_qpsk_rx_s_axi_araddr,
    axi_qpsk_rx_s_axi_arvalid => axi_qpsk_rx_s_axi_arvalid,
    axi_qpsk_rx_s_axi_rready => axi_qpsk_rx_s_axi_rready,
    axi_qpsk_rx_aresetn => axi_qpsk_rx_aresetn,
    axi_qpsk_rx_aclk => clk,
    transfer_sync => transfer_sync,
    transfer_rrc => transfer_rrc,
    transfer_dec => transfer_dec,
    transfer => transfer,
    auto_restart_sync => auto_restart_sync,
    auto_restart_rrc => auto_restart_rrc,
    auto_restart_dec => auto_restart_dec,
    auto_restart => auto_restart,
    rxreset => rxreset,
    packetsize_sync => packetsize_sync,
    packetsize_rrc => packetsize_rrc,
    packetsize_dec => packetsize_dec,
    packetsizerf => packetsizerf,
    enable => enable,
    axi_qpsk_rx_s_axi_awready => axi_qpsk_rx_s_axi_awready,
    axi_qpsk_rx_s_axi_wready => axi_qpsk_rx_s_axi_wready,
    axi_qpsk_rx_s_axi_bresp => axi_qpsk_rx_s_axi_bresp,
    axi_qpsk_rx_s_axi_bvalid => axi_qpsk_rx_s_axi_bvalid,
    axi_qpsk_rx_s_axi_arready => axi_qpsk_rx_s_axi_arready,
    axi_qpsk_rx_s_axi_rdata => axi_qpsk_rx_s_axi_rdata,
    axi_qpsk_rx_s_axi_rresp => axi_qpsk_rx_s_axi_rresp,
    axi_qpsk_rx_s_axi_rvalid => axi_qpsk_rx_s_axi_rvalid,
    clk => clk_net
  );
  axi_qpsk_rx_default_clock_driver : entity xil_defaultlib.axi_qpsk_rx_default_clock_driver 
  port map (
    axi_qpsk_rx_sysclk => clk_net,
    axi_qpsk_rx_sysce => '1',
    axi_qpsk_rx_sysclr => '0',
    axi_qpsk_rx_clk1 => clk_1_net,
    axi_qpsk_rx_ce1 => ce_1_net,
    axi_qpsk_rx_clk40 => clk_40_net,
    axi_qpsk_rx_ce40 => ce_40_net,
    axi_qpsk_rx_clk80 => clk_80_net,
    axi_qpsk_rx_ce80 => ce_80_net,
    axi_qpsk_rx_clk1600 => clk_1600_net,
    axi_qpsk_rx_ce1600 => ce_1600_net,
    axi_qpsk_rx_clk3200 => clk_3200_net,
    axi_qpsk_rx_ce3200 => ce_3200_net,
    axi_qpsk_rx_clk6400 => clk_6400_net,
    axi_qpsk_rx_ce6400 => ce_6400_net,
    axi_qpsk_rx_clk12800 => clk_12800_net,
    axi_qpsk_rx_ce12800 => ce_12800_net,
    axi_qpsk_rx_clk25600 => clk_25600_net,
    axi_qpsk_rx_ce25600 => ce_25600_net
  );
  axi_qpsk_rx_struct : entity xil_defaultlib.axi_qpsk_rx_struct 
  port map (
    m_rf_axis_tready => m_rf_axis_tready,
    m_dec_axis_tready => m_dec_axis_tready,
    m_sync_axis_tready => m_sync_axis_tready,
    m_rrc_axis_tready => m_rrc_axis_tready,
    enable => enable,
    packetsizerf => packetsizerf,
    packetsize_dec => packetsize_dec,
    packetsize_rrc => packetsize_rrc,
    packetsize_sync => packetsize_sync,
    rxreset => rxreset,
    auto_restart => auto_restart,
    auto_restart_dec => auto_restart_dec,
    auto_restart_rrc => auto_restart_rrc,
    auto_restart_sync => auto_restart_sync,
    s_i_axis_tdata => s_i_axis_tdata,
    s_i_axis_tvalid => s_i_axis_tvalid,
    s_q_axis_tdata => s_q_axis_tdata,
    s_q_axis_tvalid => s_q_axis_tvalid,
    transfer => transfer,
    transfer_dec => transfer_dec,
    transfer_rrc => transfer_rrc,
    transfer_sync => transfer_sync,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_40 => clk_40_net,
    ce_40 => ce_40_net,
    clk_80 => clk_80_net,
    ce_80 => ce_80_net,
    clk_1600 => clk_1600_net,
    ce_1600 => ce_1600_net,
    clk_3200 => clk_3200_net,
    ce_3200 => ce_3200_net,
    clk_6400 => clk_6400_net,
    ce_6400 => ce_6400_net,
    clk_12800 => clk_12800_net,
    ce_12800 => ce_12800_net,
    clk_25600 => clk_25600_net,
    ce_25600 => ce_25600_net,
    m_rf_axis_tdata => m_rf_axis_tdata,
    m_rf_axis_tlast => m_rf_axis_tlast,
    m_rf_axis_tvalid => m_rf_axis_tvalid,
    m_dec_axis_tdata => m_dec_axis_tdata,
    m_dec_axis_tlast => m_dec_axis_tlast,
    m_dec_axis_tvalid => m_dec_axis_tvalid,
    m_sync_axis_tdata => m_sync_axis_tdata,
    m_sync_axis_tlast => m_sync_axis_tlast,
    m_sync_axis_tvalid => m_sync_axis_tvalid,
    m_rrc_axis_tdata => m_rrc_axis_tdata,
    m_rrc_axis_tlast => m_rrc_axis_tlast,
    m_rrc_axis_tvalid => m_rrc_axis_tvalid,
    s_i_axis_tready => s_i_axis_tready,
    s_q_axis_tready => s_q_axis_tready
  );
end structural;
