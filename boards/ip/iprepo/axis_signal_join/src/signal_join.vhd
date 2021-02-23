
--  Signal Join
--  Copyright (C) 2019 Josh Goldsmith

library ieee;
use ieee.std_logic_1164.all;

entity signal_join is
	generic (
		INPUT_WIDTH_U : integer := 16;
		INPUT_WIDTH_L : integer := 16
		);
	port (
		clk				: in std_logic;
		
		-- AXI Slave input (Upper)
		sj_in_data_u 	: in std_logic_vector(INPUT_WIDTH_U-1 downto 0);
		sj_in_valid_u 	: in std_logic;
		sj_in_ready_u 	: out std_logic := '0';
		sj_in_last_u 	: in std_logic;
		-- AXI Slave input (Lower)
		sj_in_data_l 	: in std_logic_vector(INPUT_WIDTH_L-1 downto 0);
		sj_in_valid_l 	: in std_logic;
		sj_in_ready_l 	: out std_logic := '0';
		sj_in_last_l 	: in std_logic;
		-- AXI Master output
		sj_out_data		: out std_logic_vector((INPUT_WIDTH_U + INPUT_WIDTH_L)-1 downto 0);
		sj_out_valid	: out std_logic := '0';
		sj_out_ready	: in std_logic;
		sj_out_last		: out std_logic
		);
end entity;

architecture arch of signal_join is

constant OUTPUT_WIDTH : integer := INPUT_WIDTH_U + INPUT_WIDTH_L; 

begin
	
	sj_in_ready_u <= '1' when sj_out_ready = '1';
	sj_in_ready_l <= '1' when sj_out_ready = '1';

	sj_out_data(OUTPUT_WIDTH-1 downto INPUT_WIDTH_L)  <= sj_in_data_u;
	sj_out_data(INPUT_WIDTH_L-1 downto 0)  <= sj_in_data_l;
	sj_out_valid <= '1' when (sj_in_valid_u = '1' and sj_in_valid_l = '1');
	sj_out_last <= '1' when (sj_in_last_u = '1' and sj_in_last_l = '1');
	
end architecture;
	
	
