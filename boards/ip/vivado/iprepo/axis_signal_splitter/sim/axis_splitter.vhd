library ieee;
use ieee.std_logic_1164.all;

entity axis_signal_splitter is
	generic (
		INPUT_WIDTH : integer := 32
		);
	port (
		clk				: in std_logic;
		
		s_axis_tdata	: in std_logic_vector(INPUT_WIDTH-1 downto 0);
		s_axis_tvalid	: in std_logic;
		s_axis_tready	: out std_logic;
		s_axis_tlast	: in std_logic;
		
		m_axis_tdata_u	: out std_logic_vector((INPUT_WIDTH/2)-1 downto 0);
		m_axis_tvalid_u	: out std_logic;
		m_axis_tready_u	: in std_logic;
		m_axis_tlast_u	: out std_logic;
		
		m_axis_tdata_l	: out std_logic_vector((INPUT_WIDTH/2)-1 downto 0);
		m_axis_tvalid_l	: out std_logic;
		m_axis_tready_l	: in std_logic;
		m_axis_tlast_l	: out std_logic
		);
end entity;

architecture arch of axis_signal_splitter is
begin

	signal_splitter_i : entity work.signal_splitter
		generic map (
			INPUT_WIDTH 	=> INPUT_WIDTH
			)
		port map (
			clk				=> clk,
			
			ss_in_data		=> s_axis_tdata,
			ss_in_valid		=> s_axis_tvalid,
			ss_in_ready 	=> s_axis_tready,
			ss_in_last		=> s_axis_tlast,
			
			ss_out_data_u	=> m_axis_tdata_u,
			ss_out_valid_u	=> m_axis_tvalid_u,
			ss_out_ready_u	=> m_axis_tready_u,
			ss_out_last_u	=> m_axis_tlast_u,
			
			ss_out_data_l	=> m_axis_tdata_l,
			ss_out_valid_l	=> m_axis_tvalid_l,
			ss_out_ready_l	=> m_axis_tready_l,
			ss_out_last_l	=> m_axis_tlast_l
			);

end architecture;