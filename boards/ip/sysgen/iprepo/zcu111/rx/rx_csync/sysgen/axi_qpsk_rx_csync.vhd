-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Determine Frequency Correction Term
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_determine_frequency_correction_term is
  port (
    mag_sq_fft : in std_logic_vector( 30-1 downto 0 );
    fft_index : in std_logic_vector( 9-1 downto 0 );
    valid : in std_logic_vector( 1-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    freq_correction : out std_logic_vector( 19-1 downto 0 );
    valid_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_csync_determine_frequency_correction_term;
architecture structural of axi_qpsk_rx_csync_determine_frequency_correction_term is 
  signal rom_data_net : std_logic_vector( 19-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 30-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
  signal capture_max_x_val_index_q_net : std_logic_vector( 9-1 downto 0 );
  signal relational2_op_net : std_logic_vector( 1-1 downto 0 );
  signal register_x_coeff_q_net : std_logic_vector( 9-1 downto 0 );
  signal constant5_op_net : std_logic_vector( 9-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational3_op_net : std_logic_vector( 1-1 downto 0 );
  signal register_x_val_q_net : std_logic_vector( 30-1 downto 0 );
begin
  freq_correction <= rom_data_net;
  valid_out <= delay1_q_net;
  delay8_q_net <= mag_sq_fft;
  delay4_q_net <= fft_index;
  delay9_q_net <= valid;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  capture_max_x_val_index : entity xil_defaultlib.axi_qpsk_rx_csync_xlregister 
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
  constant5 : entity xil_defaultlib.sysgen_constant_d684e80479 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant5_op_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay6 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  logical : entity xil_defaultlib.sysgen_logical_62500740bd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay9_q_net,
    d1 => relational3_op_net,
    y => logical_y_net
  );
  rom : entity xil_defaultlib.axi_qpsk_rx_csync_xlsprom 
  generic map (
    c_address_width => 9,
    c_width => 19,
    core_name0 => "axi_qpsk_rx_csync_blk_mem_gen_i0",
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
  register_x_coeff : entity xil_defaultlib.axi_qpsk_rx_csync_xlregister 
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
  register_x_val : entity xil_defaultlib.axi_qpsk_rx_csync_xlregister 
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
  relational2 : entity xil_defaultlib.sysgen_relational_3c445e7dc2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => delay4_q_net,
    b => constant5_op_net,
    op => relational2_op_net
  );
  relational3 : entity xil_defaultlib.sysgen_relational_22d2e4eb39 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => delay8_q_net,
    b => register_x_val_q_net,
    op => relational3_op_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/NCO
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_nco is
  port (
    freq_correction : in std_logic_vector( 19-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    cos : out std_logic_vector( 16-1 downto 0 );
    sin : out std_logic_vector( 16-1 downto 0 )
  );
end axi_qpsk_rx_csync_nco;
architecture structural of axi_qpsk_rx_csync_nco is 
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal rom_data_net : std_logic_vector( 19-1 downto 0 );
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
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
  addsub : entity xil_defaultlib.axi_qpsk_rx_csync_xladdsub 
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
    core_name0 => "axi_qpsk_rx_csync_c_addsub_v12_0_i0",
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
  cmult : entity xil_defaultlib.axi_qpsk_rx_csync_xlcmult 
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
    core_name0 => "axi_qpsk_rx_csync_mult_gen_v12_0_i0",
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
  convert4 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
  delay2 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  sin_rom : entity xil_defaultlib.axi_qpsk_rx_csync_xlsprom 
  generic map (
    c_address_width => 10,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_csync_blk_mem_gen_i1",
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
  cos_rom : entity xil_defaultlib.axi_qpsk_rx_csync_xlsprom 
  generic map (
    c_address_width => 10,
    c_width => 16,
    core_name0 => "axi_qpsk_rx_csync_blk_mem_gen_i2",
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_2 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_2;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_2 is 
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay5_q_net <= x_in;
  delay6_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay5_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay6_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_6b2a0b95b4 
  port map (
    clr => '0',
    ip => delay5_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_6b2a0b95b4 
  port map (
    clr => '0',
    ip => delay6_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_3 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_3;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_3 is 
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
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
  addsub2 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay8_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay9_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_e29b738a25 
  port map (
    clr => '0',
    ip => delay8_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_e29b738a25 
  port map (
    clr => '0',
    ip => delay9_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_4 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_4;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_4 is 
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal delay22_q_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay22_q_net <= x_in;
  delay10_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay22_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay10_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_676f84fbb1 
  port map (
    clr => '0',
    ip => delay22_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_676f84fbb1 
  port map (
    clr => '0',
    ip => delay10_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 5
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_5 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_5;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_5 is 
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay12_q_net <= x_in;
  delay13_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay12_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay13_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_f415df6482 
  port map (
    clr => '0',
    ip => delay12_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_f415df6482 
  port map (
    clr => '0',
    ip => delay13_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 6
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_6 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_6;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_6 is 
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay15_q_net <= x_in;
  delay16_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay15_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay16_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_634502f2bd 
  port map (
    clr => '0',
    ip => delay15_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_634502f2bd 
  port map (
    clr => '0',
    ip => delay16_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring Cell 7
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_7 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_7;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_7 is 
  signal clk_net : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  delay18_q_net <= x_in;
  delay19_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay18_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_75f6902ad2 
  port map (
    clr => '0',
    ip => delay19_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring  Cell 0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_0 is
  port (
    x_in : in std_logic_vector( 16-1 downto 0 );
    y_in : in std_logic_vector( 16-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_0;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_0 is 
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal shift1_op_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net_x0 : std_logic_vector( 15-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  shift_op_net <= x_in;
  shift1_op_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_99c3c5c8fa 
  port map (
    clr => '0',
    a => shift_op_net,
    b => shift1_op_net_x0,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_99c3c5c8fa 
  port map (
    clr => '0',
    a => shift1_op_net,
    b => shift_op_net_x0,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_2e38146113 
  port map (
    clr => '0',
    ip => shift_op_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net_x0
  );
  shift1 : entity xil_defaultlib.sysgen_shift_2e38146113 
  port map (
    clr => '0',
    ip => shift1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net_x0
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1/Vectoring  Cell 1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_vectoring_cell_1 is
  port (
    x_in : in std_logic_vector( 15-1 downto 0 );
    y_in : in std_logic_vector( 15-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    x_out : out std_logic_vector( 15-1 downto 0 );
    y_out : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_vectoring_cell_1;
architecture structural of axi_qpsk_rx_csync_vectoring_cell_1 is 
  signal shift1_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 15-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
  signal ce_net : std_logic;
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal shift_op_net : std_logic_vector( 15-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
begin
  x_out <= addsub2_s_net;
  y_out <= addsub3_s_net;
  delay2_q_net <= x_in;
  delay3_q_net <= y_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  addsub2 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay2_q_net,
    b => shift1_op_net,
    mode => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  addsub3 : entity xil_defaultlib.sysgen_addsub_8e916c5190 
  port map (
    clr => '0',
    a => delay3_q_net,
    b => shift_op_net,
    mode => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub3_s_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_b6e89bd1c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice_y_net,
    d1 => slice1_y_net,
    y => logical_y_net
  );
  shift : entity xil_defaultlib.sysgen_shift_890bfb15e4 
  port map (
    clr => '0',
    ip => delay2_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_890bfb15e4 
  port map (
    clr => '0',
    ip => delay3_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT/CORDIC vector magnitude1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_cordic_vector_magnitude1 is
  port (
    i_in : in std_logic_vector( 16-1 downto 0 );
    q_in : in std_logic_vector( 16-1 downto 0 );
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    mag : out std_logic_vector( 15-1 downto 0 )
  );
end axi_qpsk_rx_csync_cordic_vector_magnitude1;
architecture structural of axi_qpsk_rx_csync_cordic_vector_magnitude1 is 
  signal ce_net : std_logic;
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal delay10_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x5 : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x1 : std_logic_vector( 15-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 15-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub3_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x4 : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x3 : std_logic_vector( 15-1 downto 0 );
  signal delay12_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay13_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x6 : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal delay22_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x3 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x2 : std_logic_vector( 15-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay15_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay16_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay18_q_net : std_logic_vector( 15-1 downto 0 );
  signal delay19_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal addsub2_s_net_x0 : std_logic_vector( 15-1 downto 0 );
  signal addsub3_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 15-1 downto 0 );
begin
  mag <= addsub2_s_net_x1;
  shift_op_net <= i_in;
  shift1_op_net <= q_in;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  vectoring_cell_2 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_2 
  port map (
    x_in => delay5_q_net,
    y_in => delay6_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x6,
    y_out => addsub3_s_net_x6
  );
  vectoring_cell_3 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_3 
  port map (
    x_in => delay8_q_net,
    y_in => delay9_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x5,
    y_out => addsub3_s_net_x5
  );
  vectoring_cell_4 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_4 
  port map (
    x_in => delay22_q_net,
    y_in => delay10_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x4,
    y_out => addsub3_s_net_x4
  );
  vectoring_cell_5 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_5 
  port map (
    x_in => delay12_q_net,
    y_in => delay13_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x3,
    y_out => addsub3_s_net_x3
  );
  vectoring_cell_6 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_6 
  port map (
    x_in => delay15_q_net,
    y_in => delay16_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x2,
    y_out => addsub3_s_net_x2
  );
  vectoring_cell_7 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_7 
  port map (
    x_in => delay18_q_net,
    y_in => delay19_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x1
  );
  vectoring_cell_0 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_0 
  port map (
    x_in => shift_op_net,
    y_in => shift1_op_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net_x0,
    y_out => addsub3_s_net_x0
  );
  vectoring_cell_1 : entity xil_defaultlib.axi_qpsk_rx_csync_vectoring_cell_1 
  port map (
    x_in => delay2_q_net,
    y_in => delay3_q_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    x_out => addsub2_s_net,
    y_out => addsub3_s_net
  );
  delay10 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay10_q_net
  );
  delay12 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay12_q_net
  );
  delay13 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay13_q_net
  );
  delay15 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay15_q_net
  );
  delay16 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 15
  )
  port map (
    en => '1',
    rst => '1',
    d => addsub3_s_net_x3,
    clk => clk_net,
    ce => ce_net,
    q => delay16_q_net
  );
  delay18 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay18_q_net
  );
  delay19 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay2 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay2_q_net
  );
  delay22 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay22_q_net
  );
  delay3 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay3_q_net
  );
  delay5 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay5_q_net
  );
  delay6 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    q => delay6_q_net
  );
  delay8 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay9 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser/Scaled Mag Squared FFT
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_scaled_mag_squared_fft is
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
end axi_qpsk_rx_csync_scaled_mag_squared_fft;
architecture structural of axi_qpsk_rx_csync_scaled_mag_squared_fft is 
  signal mult1_p_net : std_logic_vector( 19-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 9-1 downto 0 );
  signal fft_m_axis_data_tuser_xk_index_net : std_logic_vector( 9-1 downto 0 );
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal fft_m_axis_data_tvalid_net : std_logic;
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal fft_m_axis_data_tdata_xn_im_0_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal fft_m_axis_data_tdata_xn_re_0_net : std_logic_vector( 26-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 9-1 downto 0 );
  signal convert9_dout_net : std_logic_vector( 30-1 downto 0 );
  signal delay8_q_net : std_logic_vector( 30-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay5_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay7_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 9-1 downto 0 );
  signal delay6_q_net : std_logic_vector( 1-1 downto 0 );
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
  cordic_vector_magnitude1 : entity xil_defaultlib.axi_qpsk_rx_csync_cordic_vector_magnitude1 
  port map (
    i_in => shift_op_net,
    q_in => shift1_op_net,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    mag => addsub2_s_net
  );
  convert9 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
  delay1 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay2 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay3 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay4 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay5 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay6 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay7 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay8 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  delay9 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
  mult1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlmult 
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
    core_name0 => "axi_qpsk_rx_csync_mult_gen_v12_0_i1",
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
  shift : entity xil_defaultlib.sysgen_shift_086aa359ef 
  port map (
    clr => '0',
    ip => fft_m_axis_data_tdata_xn_re_0_net,
    en(0) => fft_m_axis_data_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_086aa359ef 
  port map (
    clr => '0',
    ip => fft_m_axis_data_tdata_xn_im_0_net,
    en(0) => fft_m_axis_data_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_csync/Coarse Frequency Synchroniser
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_coarse_frequency_synchroniser is
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
end axi_qpsk_rx_csync_coarse_frequency_synchroniser;
architecture structural of axi_qpsk_rx_csync_coarse_frequency_synchroniser is 
  signal fft_event_status_channel_halt_net : std_logic;
  signal fft_event_data_out_channel_halt_net : std_logic;
  signal delay1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal fft_s_axis_config_tready_net : std_logic;
  signal fft_m_axis_data_tlast_net : std_logic;
  signal fft_event_frame_started_net : std_logic;
  signal fft_event_tlast_unexpected_net : std_logic;
  signal fft_s_axis_data_tready_net : std_logic;
  signal fft_event_tlast_missing_net : std_logic;
  signal fft_event_data_in_channel_halt_net : std_logic;
  signal product2_p_im_net : std_logic_vector( 33-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 18-1 downto 0 );
  signal fft_m_axis_data_tvalid_net : std_logic;
  signal clk_net_x0 : std_logic;
  signal ce_net : std_logic;
  signal constant3_op_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal delay1_q_net_x1 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal delay8_q_net : std_logic_vector( 30-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x1 : std_logic;
  signal delay2_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal rom_data_net : std_logic_vector( 19-1 downto 0 );
  signal delay9_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 18-1 downto 0 );
  signal ce_net_x1 : std_logic;
  signal sin_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal fft_m_axis_data_tdata_xn_re_0_net : std_logic_vector( 26-1 downto 0 );
  signal fft_m_axis_data_tuser_xk_index_net : std_logic_vector( 9-1 downto 0 );
  signal fft_m_axis_data_tdata_xn_im_0_net : std_logic_vector( 26-1 downto 0 );
  signal delay4_q_net : std_logic_vector( 9-1 downto 0 );
  signal cos_rom_data_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal product2_p_re_net : std_logic_vector( 33-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal product_p_re_net : std_logic_vector( 33-1 downto 0 );
  signal product1_p_im_net : std_logic_vector( 39-1 downto 0 );
  signal constant4_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 19-1 downto 0 );
  signal product_p_im_net : std_logic_vector( 33-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 19-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal product1_p_re_net : std_logic_vector( 39-1 downto 0 );
begin
  corrected_i <= convert4_dout_net;
  corrected_q <= convert5_dout_net;
  tvalid_out <= delay2_q_net;
  delay2_q_net_x0 <= i_samples;
  delay1_q_net_x1 <= q_samples;
  logical_y_net <= tvalid_in;
  clk_net_x0 <= clk_1;
  ce_net <= ce_1;
  clk_net_x1 <= clk_6400;
  ce_net_x1 <= ce_6400;
  clk_net <= clk_25600;
  ce_net_x0 <= ce_25600;
  determine_frequency_correction_term : entity xil_defaultlib.axi_qpsk_rx_csync_determine_frequency_correction_term 
  port map (
    mag_sq_fft => delay8_q_net,
    fft_index => delay4_q_net,
    valid => delay9_q_net,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net_x1,
    freq_correction => rom_data_net,
    valid_out => delay1_q_net
  );
  nco : entity xil_defaultlib.axi_qpsk_rx_csync_nco 
  port map (
    freq_correction => rom_data_net,
    en => delay1_q_net,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net_x1,
    cos => cos_rom_data_net,
    sin => sin_rom_data_net
  );
  scaled_mag_squared_fft : entity xil_defaultlib.axi_qpsk_rx_csync_scaled_mag_squared_fft 
  port map (
    im => fft_m_axis_data_tdata_xn_im_0_net,
    re => fft_m_axis_data_tdata_xn_re_0_net,
    fft_index => fft_m_axis_data_tuser_xk_index_net,
    valid => fft_m_axis_data_tvalid_net,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net_x1,
    mag_sq_fft => delay8_q_net,
    fft_index_del => delay4_q_net,
    valid_del => delay9_q_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_33db879c4f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_33db879c4f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  constant4 : entity xil_defaultlib.sysgen_constant_33db879c4f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant4_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
    clk => clk_net,
    ce => ce_net_x0,
    dout => convert3_dout_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
    clk => clk_net_x1,
    ce => ce_net_x1,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
    clk => clk_net_x1,
    ce => ce_net_x1,
    dout => convert5_dout_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
  generic map (
    latency => 6,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => logical_y_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    clk => clk_net,
    ce => ce_net_x0,
    q => delay1_q_net_x0
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    clk => clk_net_x1,
    ce => ce_net_x1,
    q => delay2_q_net
  );
  fft : entity xil_defaultlib.xlfast_fourier_transform_eb94150a14aa2ee2a70f36a887d41ea1 
  port map (
    s_axis_config_tdata_fwd_inv => constant3_op_net,
    s_axis_config_tvalid => constant4_op_net(0),
    s_axis_data_tdata_xn_im_0 => convert3_dout_net,
    s_axis_data_tdata_xn_re_0 => convert2_dout_net,
    s_axis_data_tvalid => delay1_q_net_x0(0),
    s_axis_data_tlast => delay1_q_net_x0(0),
    m_axis_data_tready => constant2_op_net(0),
    clk => clk_net_x1,
    ce => ce_net_x1,
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
  product : entity xil_defaultlib.xlaxi_qpsk_rx_csync_cmpy_v6_0_i0_d4df45f10555148f1bc97124f5a651f0 
  port map (
    a_re => delay2_q_net_x0,
    a_im => delay1_q_net_x1,
    b_re => delay2_q_net_x0,
    b_im => delay1_q_net_x1,
    clk => clk_net_x0,
    ce => ce_net,
    clk_25600 => clk_net,
    ce_25600 => ce_net_x0,
    p_re => product_p_re_net,
    p_im => product_p_im_net
  );
  product1 : entity xil_defaultlib.xlaxi_qpsk_rx_csync_cmpy_v6_0_i1_c73f94df2cde07643235f0dccf6e8a54 
  port map (
    a_re => convert_dout_net,
    a_im => convert1_dout_net,
    b_re => convert_dout_net,
    b_im => convert1_dout_net,
    clk => clk_net_x0,
    ce => ce_net,
    clk_25600 => clk_net,
    ce_25600 => ce_net_x0,
    p_re => product1_p_re_net,
    p_im => product1_p_im_net
  );
  product2 : entity xil_defaultlib.xlaxi_qpsk_rx_csync_cmpy_v6_0_i0_152106942e580a70937a347604186697 
  port map (
    a_re => delay2_q_net_x0,
    a_im => delay1_q_net_x1,
    b_re => cos_rom_data_net,
    b_im => sin_rom_data_net,
    clk => clk_net_x0,
    ce => ce_net,
    clk_6400 => clk_net_x1,
    ce_6400 => ce_net_x1,
    p_re => product2_p_re_net,
    p_im => product2_p_im_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_csync/Data Inspector/M_AXIS_SYMBOL_CTRL/AXI_Write_Interface
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_axi_write_interface is
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
end axi_qpsk_rx_csync_axi_write_interface;
architecture structural of axi_qpsk_rx_csync_axi_write_interface is 
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal fifo_empty_net : std_logic;
  signal logical2_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_dout_net : std_logic_vector( 32-1 downto 0 );
  signal fifo_dcount_net : std_logic_vector( 10-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal fifo_full_net : std_logic;
begin
  tdata_out <= register5_q_net;
  tlast_out <= register3_q_net;
  tvalid_out <= register4_q_net;
  slice1_y_net <= int_reset;
  slice2_y_net <= transfer;
  slice_y_net <= auto_restart;
  packetsizerf_net <= packet_size;
  concat_y_net <= tdata_in;
  delay2_q_net <= tvalid_in;
  m_axis_tap_tready_net <= tready;
  clk_net <= clk_1;
  ce_net <= ce_1;
  ce_net_x0 <= ce_6400;
  constant_x0 : entity xil_defaultlib.sysgen_constant_aeac21b3e1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
  convert1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
  convert2 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
  convert3 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
    ce => ce_net,
    dout => convert3_dout_net
  );
  convert5 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
  counter : entity xil_defaultlib.axi_qpsk_rx_csync_xlcounter_free 
  generic map (
    core_name0 => "axi_qpsk_rx_csync_c_counter_binary_v12_0_i0",
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
  fifo : entity xil_defaultlib.axi_qpsk_rx_csync_xlfifogen_u 
  generic map (
    core_name0 => "axi_qpsk_rx_csync_fifo_generator_i0",
    data_count_width => 10,
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
    ce => ce_net,
    we_ce => ce_net_x0,
    re_ce => ce_net,
    dout => fifo_dout_net,
    empty => fifo_empty_net,
    full => fifo_full_net,
    dcount => fifo_dcount_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_b252909144 
  port map (
    clr => '0',
    ip => relational1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_cf27ca7588 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => slice1_y_net,
    d1 => inverter1_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_62500740bd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => m_axis_tap_tready_net,
    d1 => convert5_dout_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_cf27ca7588 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => logical3_y_net,
    y(0) => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_62500740bd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fifo_full_net,
    d1 => inverter_op_net,
    y => logical3_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_14b2ee0761 
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
  register3 : entity xil_defaultlib.axi_qpsk_rx_csync_xlregister 
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
  register4 : entity xil_defaultlib.axi_qpsk_rx_csync_xlregister 
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
  register5 : entity xil_defaultlib.axi_qpsk_rx_csync_xlregister 
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
  relational : entity xil_defaultlib.sysgen_relational_308a3519ab 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => fifo_dcount_net,
    b => constant_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_0615fc1e75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => packetsizerf_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_csync/Data Inspector/M_AXIS_SYMBOL_CTRL
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_m_axis_symbol_ctrl is
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
end axi_qpsk_rx_csync_m_axis_symbol_ctrl;
architecture structural of axi_qpsk_rx_csync_m_axis_symbol_ctrl is 
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  reinterpret4_output_port_net <= i_data;
  delay2_q_net <= tvalid_in;
  reinterpret5_output_port_net <= q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  m_axis_tap_tready_net <= tready_in;
  slice2_y_net <= transfer;
  slice_y_net <= auto_restart;
  clk_net <= clk_1;
  ce_net <= ce_1;
  ce_net_x0 <= ce_6400;
  axi_write_interface : entity xil_defaultlib.axi_qpsk_rx_csync_axi_write_interface 
  port map (
    int_reset => slice1_y_net,
    transfer => slice2_y_net,
    auto_restart => slice_y_net,
    packet_size => packetsizerf_net,
    tdata_in => concat_y_net,
    tvalid_in => delay2_q_net,
    tready => m_axis_tap_tready_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_6400 => ce_net_x0,
    tdata_out => register5_q_net,
    tlast_out => register3_q_net,
    tvalid_out => register4_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_e1b2cd5ff6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  convert4 : entity xil_defaultlib.axi_qpsk_rx_csync_xlconvert 
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
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_97b9aad587 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_97b9aad587 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_csync/Data Inspector
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_data_inspector is
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
    ce_6400 : in std_logic;
    tdata_out : out std_logic_vector( 32-1 downto 0 );
    tvalid_out : out std_logic_vector( 1-1 downto 0 );
    tlast_out : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_csync_data_inspector;
architecture structural of axi_qpsk_rx_csync_data_inspector is 
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal ce_net_x0 : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  tdata_out <= convert4_dout_net;
  tvalid_out <= register4_q_net;
  tlast_out <= register3_q_net;
  reinterpret4_output_port_net <= symbol_i_data;
  delay2_q_net <= symbol_i_valid;
  reinterpret5_output_port_net <= symbol_q_data;
  slice1_y_net <= reset;
  packetsizerf_net <= packet_size;
  slice2_y_net <= transfer;
  slice_y_net <= auto_restart;
  m_axis_tap_tready_net <= tready_in;
  clk_net <= clk_1;
  ce_net <= ce_1;
  ce_net_x0 <= ce_6400;
  m_axis_symbol_ctrl : entity xil_defaultlib.axi_qpsk_rx_csync_m_axis_symbol_ctrl 
  port map (
    i_data => reinterpret4_output_port_net,
    tvalid_in => delay2_q_net,
    q_data => reinterpret5_output_port_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    tready_in => m_axis_tap_tready_net,
    transfer => slice2_y_net,
    auto_restart => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    ce_6400 => ce_net_x0,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
end structural;
-- Generated from Simulink block axi_qpsk_rx_csync/M_AXIS_TAP
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_m_axis_tap is
  port (
    tdata_in : in std_logic_vector( 32-1 downto 0 );
    tvalid_in : in std_logic_vector( 1-1 downto 0 );
    tlast_in : in std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_csync_m_axis_tap;
architecture structural of axi_qpsk_rx_csync_m_axis_tap is 
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
begin
  convert4_dout_net <= tdata_in;
  register4_q_net <= tvalid_in;
  register3_q_net <= tlast_in;
  m_axis_tap_tready_net <= m_axis_tap_tready;
end structural;
-- Generated from Simulink block axi_qpsk_rx_csync_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_struct is
  port (
    enable : in std_logic_vector( 32-1 downto 0 );
    packetsizerf : in std_logic_vector( 32-1 downto 0 );
    rxreset : in std_logic_vector( 32-1 downto 0 );
    auto_restart : in std_logic_vector( 32-1 downto 0 );
    s_axis_tdata : in std_logic_vector( 32-1 downto 0 );
    s_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    transfer : in std_logic_vector( 32-1 downto 0 );
    m_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_6400 : in std_logic;
    ce_6400 : in std_logic;
    clk_25600 : in std_logic;
    ce_25600 : in std_logic;
    m_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tlast : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tvalid : out std_logic_vector( 1-1 downto 0 )
  );
end axi_qpsk_rx_csync_struct;
architecture structural of axi_qpsk_rx_csync_struct is 
  signal shift_op_net : std_logic_vector( 16-1 downto 0 );
  signal q_samples_y_net : std_logic_vector( 16-1 downto 0 );
  signal shift1_op_net : std_logic_vector( 16-1 downto 0 );
  signal i_samples_y_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net_x1 : std_logic;
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal enable_net : std_logic_vector( 32-1 downto 0 );
  signal delay2_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal packetsizerf_net : std_logic_vector( 32-1 downto 0 );
  signal m_axis_tap_tready_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal clk_net : std_logic;
  signal s_axis_tdata_net : std_logic_vector( 32-1 downto 0 );
  signal m_axis_tready_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net_x1 : std_logic;
  signal s_axis_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal auto_restart_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert4_dout_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 18-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal rxreset_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 1-1 downto 0 );
  signal transfer_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample_q_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  enable_net <= enable;
  packetsizerf_net <= packetsizerf;
  rxreset_net <= rxreset;
  auto_restart_net <= auto_restart;
  s_axis_tdata_net <= s_axis_tdata;
  s_axis_tvalid_net <= s_axis_tvalid;
  transfer_net <= transfer;
  m_axis_tdata <= concat_y_net;
  m_axis_tready_net <= m_axis_tready;
  m_axis_tvalid <= delay2_q_net_x0;
  m_axis_tap_tdata <= convert4_dout_net;
  m_axis_tap_tlast <= register3_q_net;
  m_axis_tap_tready_net <= m_axis_tap_tready;
  m_axis_tap_tvalid <= register4_q_net;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  clk_net <= clk_6400;
  ce_net <= ce_6400;
  clk_net_x1 <= clk_25600;
  ce_net_x1 <= ce_25600;
  coarse_frequency_synchroniser : entity xil_defaultlib.axi_qpsk_rx_csync_coarse_frequency_synchroniser 
  port map (
    i_samples => delay2_q_net,
    q_samples => delay1_q_net,
    tvalid_in => logical_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    clk_6400 => clk_net,
    ce_6400 => ce_net,
    clk_25600 => clk_net_x1,
    ce_25600 => ce_net_x1,
    corrected_i => convert4_dout_net_x0,
    corrected_q => convert5_dout_net,
    tvalid_out => delay2_q_net_x0
  );
  data_inspector : entity xil_defaultlib.axi_qpsk_rx_csync_data_inspector 
  port map (
    symbol_i_data => reinterpret4_output_port_net,
    symbol_i_valid => delay2_q_net_x0,
    symbol_q_data => reinterpret5_output_port_net,
    reset => slice1_y_net,
    packet_size => packetsizerf_net,
    transfer => slice2_y_net,
    auto_restart => slice_y_net,
    tready_in => m_axis_tap_tready_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    ce_6400 => ce_net,
    tdata_out => convert4_dout_net,
    tvalid_out => register4_q_net,
    tlast_out => register3_q_net
  );
  m_axis_tap : entity xil_defaultlib.axi_qpsk_rx_csync_m_axis_tap 
  port map (
    tdata_in => convert4_dout_net,
    tvalid_in => register4_q_net,
    tlast_in => register3_q_net,
    m_axis_tap_tready => m_axis_tap_tready_net
  );
  concat : entity xil_defaultlib.sysgen_concat_e1b2cd5ff6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret2_output_port_net,
    in1 => reinterpret3_output_port_net,
    y => concat_y_net
  );
  delay : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
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
    clk => clk_net_x1,
    ce => ce_net_x1,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => reinterpret1_output_port_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.axi_qpsk_rx_csync_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => reinterpret_output_port_net,
    clk => clk_net_x1,
    ce => ce_net_x1,
    q => delay2_q_net
  );
  down_sample : entity xil_defaultlib.axi_qpsk_rx_csync_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    ds_ratio => 25600,
    latency => 1,
    phase => 25599,
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
    dest_clk => clk_net_x1,
    dest_ce => ce_net_x1,
    q => down_sample_q_net
  );
  logical : entity xil_defaultlib.sysgen_logical_62500740bd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay_q_net,
    d1 => down_sample_q_net,
    y => logical_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_effea76a69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => i_samples_y_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_effea76a69 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => q_samples_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_97b9aad587 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_97b9aad587 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_8e730e0b8c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => shift_op_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_8e730e0b8c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => shift1_op_net,
    output_port => reinterpret5_output_port_net
  );
  shift : entity xil_defaultlib.sysgen_shift_505dabe6ab 
  port map (
    clr => '0',
    ip => convert4_dout_net_x0,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
  shift1 : entity xil_defaultlib.sysgen_shift_505dabe6ab 
  port map (
    clr => '0',
    ip => convert5_dout_net,
    clk => clk_net,
    ce => ce_net,
    op => shift1_op_net
  );
  slice : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice1 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice2 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  slice3 : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
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
  i_samples : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 31,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => s_axis_tdata_net,
    y => i_samples_y_net
  );
  q_samples : entity xil_defaultlib.axi_qpsk_rx_csync_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => s_axis_tdata_net,
    y => q_samples_y_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync_default_clock_driver is
  port (
    axi_qpsk_rx_csync_sysclk : in std_logic;
    axi_qpsk_rx_csync_sysce : in std_logic;
    axi_qpsk_rx_csync_sysclr : in std_logic;
    axi_qpsk_rx_csync_clk1 : out std_logic;
    axi_qpsk_rx_csync_ce1 : out std_logic;
    axi_qpsk_rx_csync_clk6400 : out std_logic;
    axi_qpsk_rx_csync_ce6400 : out std_logic;
    axi_qpsk_rx_csync_clk25600 : out std_logic;
    axi_qpsk_rx_csync_ce25600 : out std_logic
  );
end axi_qpsk_rx_csync_default_clock_driver;
architecture structural of axi_qpsk_rx_csync_default_clock_driver is 
begin
  clockdriver_x1 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => axi_qpsk_rx_csync_sysclk,
    sysce => axi_qpsk_rx_csync_sysce,
    sysclr => axi_qpsk_rx_csync_sysclr,
    clk => axi_qpsk_rx_csync_clk1,
    ce => axi_qpsk_rx_csync_ce1
  );
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 6400,
    log_2_period => 13
  )
  port map (
    sysclk => axi_qpsk_rx_csync_sysclk,
    sysce => axi_qpsk_rx_csync_sysce,
    sysclr => axi_qpsk_rx_csync_sysclr,
    clk => axi_qpsk_rx_csync_clk6400,
    ce => axi_qpsk_rx_csync_ce6400
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 25600,
    log_2_period => 15
  )
  port map (
    sysclk => axi_qpsk_rx_csync_sysclk,
    sysce => axi_qpsk_rx_csync_sysce,
    sysclr => axi_qpsk_rx_csync_sysclr,
    clk => axi_qpsk_rx_csync_clk25600,
    ce => axi_qpsk_rx_csync_ce25600
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity axi_qpsk_rx_csync is
  port (
    s_axis_tdata : in std_logic_vector( 32-1 downto 0 );
    s_axis_tvalid : in std_logic_vector( 1-1 downto 0 );
    m_axis_tready : in std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tready : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    axi_qpsk_rx_csync_aresetn : in std_logic;
    axi_qpsk_rx_csync_s_axi_awaddr : in std_logic_vector( 5-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_awvalid : in std_logic;
    axi_qpsk_rx_csync_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_wvalid : in std_logic;
    axi_qpsk_rx_csync_s_axi_bready : in std_logic;
    axi_qpsk_rx_csync_s_axi_araddr : in std_logic_vector( 5-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_arvalid : in std_logic;
    axi_qpsk_rx_csync_s_axi_rready : in std_logic;
    m_axis_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tdata : out std_logic_vector( 32-1 downto 0 );
    m_axis_tap_tlast : out std_logic_vector( 1-1 downto 0 );
    m_axis_tap_tvalid : out std_logic_vector( 1-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_awready : out std_logic;
    axi_qpsk_rx_csync_s_axi_wready : out std_logic;
    axi_qpsk_rx_csync_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_bvalid : out std_logic;
    axi_qpsk_rx_csync_s_axi_arready : out std_logic;
    axi_qpsk_rx_csync_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    axi_qpsk_rx_csync_s_axi_rvalid : out std_logic
  );
end axi_qpsk_rx_csync;
architecture structural of axi_qpsk_rx_csync is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "axi_qpsk_rx_csync,sysgen_core_2018_3,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplusRFSOC,part=xczu28dr,speed=-2-e,package=ffvg1517,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=39.0625,system_simulink_period=3.90625e-08,waveform_viewer=0,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=10,addsub=25,cmult=1,concat=2,constant=14,convert=14,counter=1,delay=39,dsamp=1,fifo=1,inv=10,logical=14,mcode=1,mult=1,product_macro=3,register=6,reinterpret=8,relational=4,shift=20,slice=22,sprom=3,xfft_v9_1=1,}";
  signal enable : std_logic_vector( 32-1 downto 0 );
  signal ce_1_net : std_logic;
  signal ce_6400_net : std_logic;
  signal clk_25600_net : std_logic;
  signal packetsizerf : std_logic_vector( 32-1 downto 0 );
  signal transfer : std_logic_vector( 32-1 downto 0 );
  signal clk_6400_net : std_logic;
  signal auto_restart : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net : std_logic;
  signal rxreset : std_logic_vector( 32-1 downto 0 );
  signal ce_25600_net : std_logic;
  signal clk_net : std_logic;
begin
  axi_qpsk_rx_csync_axi_lite_interface : entity xil_defaultlib.axi_qpsk_rx_csync_axi_lite_interface 
  port map (
    axi_qpsk_rx_csync_s_axi_awaddr => axi_qpsk_rx_csync_s_axi_awaddr,
    axi_qpsk_rx_csync_s_axi_awvalid => axi_qpsk_rx_csync_s_axi_awvalid,
    axi_qpsk_rx_csync_s_axi_wdata => axi_qpsk_rx_csync_s_axi_wdata,
    axi_qpsk_rx_csync_s_axi_wstrb => axi_qpsk_rx_csync_s_axi_wstrb,
    axi_qpsk_rx_csync_s_axi_wvalid => axi_qpsk_rx_csync_s_axi_wvalid,
    axi_qpsk_rx_csync_s_axi_bready => axi_qpsk_rx_csync_s_axi_bready,
    axi_qpsk_rx_csync_s_axi_araddr => axi_qpsk_rx_csync_s_axi_araddr,
    axi_qpsk_rx_csync_s_axi_arvalid => axi_qpsk_rx_csync_s_axi_arvalid,
    axi_qpsk_rx_csync_s_axi_rready => axi_qpsk_rx_csync_s_axi_rready,
    axi_qpsk_rx_csync_aresetn => axi_qpsk_rx_csync_aresetn,
    axi_qpsk_rx_csync_aclk => clk,
    transfer => transfer,
    auto_restart => auto_restart,
    rxreset => rxreset,
    packetsizerf => packetsizerf,
    enable => enable,
    axi_qpsk_rx_csync_s_axi_awready => axi_qpsk_rx_csync_s_axi_awready,
    axi_qpsk_rx_csync_s_axi_wready => axi_qpsk_rx_csync_s_axi_wready,
    axi_qpsk_rx_csync_s_axi_bresp => axi_qpsk_rx_csync_s_axi_bresp,
    axi_qpsk_rx_csync_s_axi_bvalid => axi_qpsk_rx_csync_s_axi_bvalid,
    axi_qpsk_rx_csync_s_axi_arready => axi_qpsk_rx_csync_s_axi_arready,
    axi_qpsk_rx_csync_s_axi_rdata => axi_qpsk_rx_csync_s_axi_rdata,
    axi_qpsk_rx_csync_s_axi_rresp => axi_qpsk_rx_csync_s_axi_rresp,
    axi_qpsk_rx_csync_s_axi_rvalid => axi_qpsk_rx_csync_s_axi_rvalid,
    clk => clk_net
  );
  axi_qpsk_rx_csync_default_clock_driver : entity xil_defaultlib.axi_qpsk_rx_csync_default_clock_driver 
  port map (
    axi_qpsk_rx_csync_sysclk => clk_net,
    axi_qpsk_rx_csync_sysce => '1',
    axi_qpsk_rx_csync_sysclr => '0',
    axi_qpsk_rx_csync_clk1 => clk_1_net,
    axi_qpsk_rx_csync_ce1 => ce_1_net,
    axi_qpsk_rx_csync_clk6400 => clk_6400_net,
    axi_qpsk_rx_csync_ce6400 => ce_6400_net,
    axi_qpsk_rx_csync_clk25600 => clk_25600_net,
    axi_qpsk_rx_csync_ce25600 => ce_25600_net
  );
  axi_qpsk_rx_csync_struct : entity xil_defaultlib.axi_qpsk_rx_csync_struct 
  port map (
    enable => enable,
    packetsizerf => packetsizerf,
    rxreset => rxreset,
    auto_restart => auto_restart,
    s_axis_tdata => s_axis_tdata,
    s_axis_tvalid => s_axis_tvalid,
    transfer => transfer,
    m_axis_tready => m_axis_tready,
    m_axis_tap_tready => m_axis_tap_tready,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_6400 => clk_6400_net,
    ce_6400 => ce_6400_net,
    clk_25600 => clk_25600_net,
    ce_25600 => ce_25600_net,
    m_axis_tdata => m_axis_tdata,
    m_axis_tvalid => m_axis_tvalid,
    m_axis_tap_tdata => m_axis_tap_tdata,
    m_axis_tap_tlast => m_axis_tap_tlast,
    m_axis_tap_tvalid => m_axis_tap_tvalid
  );
end structural;
