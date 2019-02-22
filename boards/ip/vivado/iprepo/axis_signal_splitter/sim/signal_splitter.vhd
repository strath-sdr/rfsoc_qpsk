--  Signal Splitter
--  Copyright (C) 2019 Josh Goldsmith

library ieee;
use ieee.std_logic_1164.all;

entity signal_splitter is
	generic (
		INPUT_WIDTH : integer := 32
		);
	port (
		clk			: in std_logic;
		
		-- AXI Slave input
		ss_in_data 	: in std_logic_vector(INPUT_WIDTH-1 downto 0);
		ss_in_valid : in std_logic;
		ss_in_ready : out std_logic := '0';
		ss_in_last : in std_logic;
		-- AXI Master output (Upper)
		ss_out_data_u	: out std_logic_vector((INPUT_WIDTH/2)-1 downto 0);
		ss_out_valid_u	: out std_logic := '0';
		ss_out_ready_u	: in std_logic;
		ss_out_last_u	: out std_logic;
		-- AXI Master output (Lower)
		ss_out_data_l	: out std_logic_vector((INPUT_WIDTH/2)-1 downto 0);
		ss_out_valid_l	: out std_logic := '0';
		ss_out_ready_l	: in std_logic;
		ss_out_last_l	: out std_logic
		);
end entity;

architecture arch of signal_splitter is
begin
	
	ss_in_ready <= '1' when (ss_out_ready_u = '1' and ss_out_ready_l = '1');
	
	ss_out_data_u <= ss_in_data((INPUT_WIDTH-1) downto (INPUT_WIDTH/2));
	ss_out_valid_u <= '1' when ss_in_valid = '1';
	ss_out_last_u <= '1' when ss_in_last = '1';
	
	ss_out_data_l <= ss_in_data(((INPUT_WIDTH/2)-1) downto 0);
	ss_out_valid_l <= '1' when ss_in_valid = '1';
	ss_out_last_l <= '1' when ss_in_last = '1';
	
end architecture;
	
	
