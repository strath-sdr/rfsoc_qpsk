library ieee;
use ieee.std_logic_1164.all;

entity axis_signal_join is
	generic (
		INPUT_WIDTH_U : integer := 16;
		INPUT_WIDTH_L : integer := 16
		);
	port (
		clk				: in std_logic;
		
		s_axis_tdata_u	: in std_logic_vector(INPUT_WIDTH_U-1 downto 0);
		s_axis_tvalid_u	: in std_logic;
		s_axis_tready_u	: out std_logic;
		s_axis_tlast_u	: in std_logic;
		
        s_axis_tdata_l	: in std_logic_vector(INPUT_WIDTH_L-1 downto 0);
        s_axis_tvalid_l : in std_logic;
        s_axis_tready_l : out std_logic;
        s_axis_tlast_l  : in std_logic;
		
		m_axis_tdata	: out std_logic_vector((INPUT_WIDTH_U + INPUT_WIDTH_L)-1 downto 0);
		m_axis_tvalid	: out std_logic;
		m_axis_tready	: in std_logic;
		m_axis_tlast	: out std_logic
		);
end entity;

architecture arch of axis_signal_join is
begin

	signal_splitter : entity work.signal_join
		generic map (
			INPUT_WIDTH_U 	=> INPUT_WIDTH_U,
			INPUT_WIDTH_L 	=> INPUT_WIDTH_L
			)
		port map (
			clk                 => clk,
			
			sj_in_data_u		=> s_axis_tdata_u,
			sj_in_valid_u		=> s_axis_tvalid_u,
            sj_in_ready_u 	    => s_axis_tready_u,
			sj_in_last_u		=> s_axis_tlast_u,
			
            sj_in_data_l		=> s_axis_tdata_l,
            sj_in_valid_l       => s_axis_tvalid_l,
            sj_in_ready_l       => s_axis_tready_l,
            sj_in_last_l        => s_axis_tlast_l,

            sj_out_data         => m_axis_tdata,
			sj_out_valid	    => m_axis_tvalid,
			sj_out_ready	    => m_axis_tready,
            sj_out_last         => m_axis_tlast
			);

end architecture;