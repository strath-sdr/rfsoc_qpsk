--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Wed Oct 14 12:16:35 2020
--Host        : DESKTOP-2K5Q0I9 running 64-bit major release  (build 9200)
--Command     : generate_target axi_qpsk_tx_bd.bd
--Design      : axi_qpsk_tx_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity microblaze_1_local_memory_imp_1O1WDD1 is
  port (
    DLMB_abus : in STD_LOGIC_VECTOR ( 0 to 31 );
    DLMB_addrstrobe : in STD_LOGIC;
    DLMB_be : in STD_LOGIC_VECTOR ( 0 to 3 );
    DLMB_ce : out STD_LOGIC;
    DLMB_readdbus : out STD_LOGIC_VECTOR ( 0 to 31 );
    DLMB_readstrobe : in STD_LOGIC;
    DLMB_ready : out STD_LOGIC;
    DLMB_ue : out STD_LOGIC;
    DLMB_wait : out STD_LOGIC;
    DLMB_writedbus : in STD_LOGIC_VECTOR ( 0 to 31 );
    DLMB_writestrobe : in STD_LOGIC;
    ILMB_abus : in STD_LOGIC_VECTOR ( 0 to 31 );
    ILMB_addrstrobe : in STD_LOGIC;
    ILMB_ce : out STD_LOGIC;
    ILMB_readdbus : out STD_LOGIC_VECTOR ( 0 to 31 );
    ILMB_readstrobe : in STD_LOGIC;
    ILMB_ready : out STD_LOGIC;
    ILMB_ue : out STD_LOGIC;
    ILMB_wait : out STD_LOGIC;
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC
  );
end microblaze_1_local_memory_imp_1O1WDD1;

architecture STRUCTURE of microblaze_1_local_memory_imp_1O1WDD1 is
  component axi_qpsk_tx_bd_dlmb_v10_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 0 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  end component axi_qpsk_tx_bd_dlmb_v10_0;
  component axi_qpsk_tx_bd_ilmb_v10_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 0 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  end component axi_qpsk_tx_bd_ilmb_v10_0;
  component axi_qpsk_tx_bd_dlmb_bram_if_cntlr_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component axi_qpsk_tx_bd_dlmb_bram_if_cntlr_0;
  component axi_qpsk_tx_bd_ilmb_bram_if_cntlr_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component axi_qpsk_tx_bd_ilmb_bram_if_cntlr_0;
  component axi_qpsk_tx_bd_lmb_bram_0 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rsta_busy : out STD_LOGIC;
    rstb_busy : out STD_LOGIC
  );
  end component axi_qpsk_tx_bd_lmb_bram_0;
  signal SYS_Rst_1 : STD_LOGIC;
  signal microblaze_1_Clk : STD_LOGIC;
  signal microblaze_1_dlmb_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_ADDRSTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal microblaze_1_dlmb_CE : STD_LOGIC;
  signal microblaze_1_dlmb_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_READSTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_READY : STD_LOGIC;
  signal microblaze_1_dlmb_UE : STD_LOGIC;
  signal microblaze_1_dlmb_WAIT : STD_LOGIC;
  signal microblaze_1_dlmb_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_WRITESTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_bus_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_bus_ADDRSTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_bus_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal microblaze_1_dlmb_bus_CE : STD_LOGIC;
  signal microblaze_1_dlmb_bus_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_bus_READSTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_bus_READY : STD_LOGIC;
  signal microblaze_1_dlmb_bus_UE : STD_LOGIC;
  signal microblaze_1_dlmb_bus_WAIT : STD_LOGIC;
  signal microblaze_1_dlmb_bus_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_bus_WRITESTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_cntlr_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_cntlr_CLK : STD_LOGIC;
  signal microblaze_1_dlmb_cntlr_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_cntlr_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_dlmb_cntlr_EN : STD_LOGIC;
  signal microblaze_1_dlmb_cntlr_RST : STD_LOGIC;
  signal microblaze_1_dlmb_cntlr_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal microblaze_1_ilmb_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_ADDRSTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_CE : STD_LOGIC;
  signal microblaze_1_ilmb_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_READSTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_READY : STD_LOGIC;
  signal microblaze_1_ilmb_UE : STD_LOGIC;
  signal microblaze_1_ilmb_WAIT : STD_LOGIC;
  signal microblaze_1_ilmb_bus_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_bus_ADDRSTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_bus_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal microblaze_1_ilmb_bus_CE : STD_LOGIC;
  signal microblaze_1_ilmb_bus_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_bus_READSTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_bus_READY : STD_LOGIC;
  signal microblaze_1_ilmb_bus_UE : STD_LOGIC;
  signal microblaze_1_ilmb_bus_WAIT : STD_LOGIC;
  signal microblaze_1_ilmb_bus_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_bus_WRITESTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_cntlr_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_cntlr_CLK : STD_LOGIC;
  signal microblaze_1_ilmb_cntlr_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_cntlr_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_ilmb_cntlr_EN : STD_LOGIC;
  signal microblaze_1_ilmb_cntlr_RST : STD_LOGIC;
  signal microblaze_1_ilmb_cntlr_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal NLW_dlmb_v10_LMB_Rst_UNCONNECTED : STD_LOGIC;
  signal NLW_ilmb_v10_LMB_Rst_UNCONNECTED : STD_LOGIC;
  signal NLW_lmb_bram_rsta_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_lmb_bram_rstb_busy_UNCONNECTED : STD_LOGIC;
  attribute BMM_INFO_ADDRESS_SPACE : string;
  attribute BMM_INFO_ADDRESS_SPACE of dlmb_bram_if_cntlr : label is "byte  0x00000000 32 > axi_qpsk_tx_bd microblaze_1_local_memory/lmb_bram";
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of dlmb_bram_if_cntlr : label is "yes";
begin
  DLMB_ce <= microblaze_1_dlmb_CE;
  DLMB_readdbus(0 to 31) <= microblaze_1_dlmb_READDBUS(0 to 31);
  DLMB_ready <= microblaze_1_dlmb_READY;
  DLMB_ue <= microblaze_1_dlmb_UE;
  DLMB_wait <= microblaze_1_dlmb_WAIT;
  ILMB_ce <= microblaze_1_ilmb_CE;
  ILMB_readdbus(0 to 31) <= microblaze_1_ilmb_READDBUS(0 to 31);
  ILMB_ready <= microblaze_1_ilmb_READY;
  ILMB_ue <= microblaze_1_ilmb_UE;
  ILMB_wait <= microblaze_1_ilmb_WAIT;
  SYS_Rst_1 <= SYS_Rst;
  microblaze_1_Clk <= LMB_Clk;
  microblaze_1_dlmb_ABUS(0 to 31) <= DLMB_abus(0 to 31);
  microblaze_1_dlmb_ADDRSTROBE <= DLMB_addrstrobe;
  microblaze_1_dlmb_BE(0 to 3) <= DLMB_be(0 to 3);
  microblaze_1_dlmb_READSTROBE <= DLMB_readstrobe;
  microblaze_1_dlmb_WRITEDBUS(0 to 31) <= DLMB_writedbus(0 to 31);
  microblaze_1_dlmb_WRITESTROBE <= DLMB_writestrobe;
  microblaze_1_ilmb_ABUS(0 to 31) <= ILMB_abus(0 to 31);
  microblaze_1_ilmb_ADDRSTROBE <= ILMB_addrstrobe;
  microblaze_1_ilmb_READSTROBE <= ILMB_readstrobe;
dlmb_bram_if_cntlr: component axi_qpsk_tx_bd_dlmb_bram_if_cntlr_0
     port map (
      BRAM_Addr_A(0 to 31) => microblaze_1_dlmb_cntlr_ADDR(0 to 31),
      BRAM_Clk_A => microblaze_1_dlmb_cntlr_CLK,
      BRAM_Din_A(0) => microblaze_1_dlmb_cntlr_DOUT(31),
      BRAM_Din_A(1) => microblaze_1_dlmb_cntlr_DOUT(30),
      BRAM_Din_A(2) => microblaze_1_dlmb_cntlr_DOUT(29),
      BRAM_Din_A(3) => microblaze_1_dlmb_cntlr_DOUT(28),
      BRAM_Din_A(4) => microblaze_1_dlmb_cntlr_DOUT(27),
      BRAM_Din_A(5) => microblaze_1_dlmb_cntlr_DOUT(26),
      BRAM_Din_A(6) => microblaze_1_dlmb_cntlr_DOUT(25),
      BRAM_Din_A(7) => microblaze_1_dlmb_cntlr_DOUT(24),
      BRAM_Din_A(8) => microblaze_1_dlmb_cntlr_DOUT(23),
      BRAM_Din_A(9) => microblaze_1_dlmb_cntlr_DOUT(22),
      BRAM_Din_A(10) => microblaze_1_dlmb_cntlr_DOUT(21),
      BRAM_Din_A(11) => microblaze_1_dlmb_cntlr_DOUT(20),
      BRAM_Din_A(12) => microblaze_1_dlmb_cntlr_DOUT(19),
      BRAM_Din_A(13) => microblaze_1_dlmb_cntlr_DOUT(18),
      BRAM_Din_A(14) => microblaze_1_dlmb_cntlr_DOUT(17),
      BRAM_Din_A(15) => microblaze_1_dlmb_cntlr_DOUT(16),
      BRAM_Din_A(16) => microblaze_1_dlmb_cntlr_DOUT(15),
      BRAM_Din_A(17) => microblaze_1_dlmb_cntlr_DOUT(14),
      BRAM_Din_A(18) => microblaze_1_dlmb_cntlr_DOUT(13),
      BRAM_Din_A(19) => microblaze_1_dlmb_cntlr_DOUT(12),
      BRAM_Din_A(20) => microblaze_1_dlmb_cntlr_DOUT(11),
      BRAM_Din_A(21) => microblaze_1_dlmb_cntlr_DOUT(10),
      BRAM_Din_A(22) => microblaze_1_dlmb_cntlr_DOUT(9),
      BRAM_Din_A(23) => microblaze_1_dlmb_cntlr_DOUT(8),
      BRAM_Din_A(24) => microblaze_1_dlmb_cntlr_DOUT(7),
      BRAM_Din_A(25) => microblaze_1_dlmb_cntlr_DOUT(6),
      BRAM_Din_A(26) => microblaze_1_dlmb_cntlr_DOUT(5),
      BRAM_Din_A(27) => microblaze_1_dlmb_cntlr_DOUT(4),
      BRAM_Din_A(28) => microblaze_1_dlmb_cntlr_DOUT(3),
      BRAM_Din_A(29) => microblaze_1_dlmb_cntlr_DOUT(2),
      BRAM_Din_A(30) => microblaze_1_dlmb_cntlr_DOUT(1),
      BRAM_Din_A(31) => microblaze_1_dlmb_cntlr_DOUT(0),
      BRAM_Dout_A(0 to 31) => microblaze_1_dlmb_cntlr_DIN(0 to 31),
      BRAM_EN_A => microblaze_1_dlmb_cntlr_EN,
      BRAM_Rst_A => microblaze_1_dlmb_cntlr_RST,
      BRAM_WEN_A(0 to 3) => microblaze_1_dlmb_cntlr_WE(0 to 3),
      LMB_ABus(0 to 31) => microblaze_1_dlmb_bus_ABUS(0 to 31),
      LMB_AddrStrobe => microblaze_1_dlmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => microblaze_1_dlmb_bus_BE(0 to 3),
      LMB_Clk => microblaze_1_Clk,
      LMB_ReadStrobe => microblaze_1_dlmb_bus_READSTROBE,
      LMB_Rst => SYS_Rst_1,
      LMB_WriteDBus(0 to 31) => microblaze_1_dlmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => microblaze_1_dlmb_bus_WRITESTROBE,
      Sl_CE => microblaze_1_dlmb_bus_CE,
      Sl_DBus(0 to 31) => microblaze_1_dlmb_bus_READDBUS(0 to 31),
      Sl_Ready => microblaze_1_dlmb_bus_READY,
      Sl_UE => microblaze_1_dlmb_bus_UE,
      Sl_Wait => microblaze_1_dlmb_bus_WAIT
    );
dlmb_v10: component axi_qpsk_tx_bd_dlmb_v10_0
     port map (
      LMB_ABus(0 to 31) => microblaze_1_dlmb_bus_ABUS(0 to 31),
      LMB_AddrStrobe => microblaze_1_dlmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => microblaze_1_dlmb_bus_BE(0 to 3),
      LMB_CE => microblaze_1_dlmb_CE,
      LMB_Clk => microblaze_1_Clk,
      LMB_ReadDBus(0 to 31) => microblaze_1_dlmb_READDBUS(0 to 31),
      LMB_ReadStrobe => microblaze_1_dlmb_bus_READSTROBE,
      LMB_Ready => microblaze_1_dlmb_READY,
      LMB_Rst => NLW_dlmb_v10_LMB_Rst_UNCONNECTED,
      LMB_UE => microblaze_1_dlmb_UE,
      LMB_Wait => microblaze_1_dlmb_WAIT,
      LMB_WriteDBus(0 to 31) => microblaze_1_dlmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => microblaze_1_dlmb_bus_WRITESTROBE,
      M_ABus(0 to 31) => microblaze_1_dlmb_ABUS(0 to 31),
      M_AddrStrobe => microblaze_1_dlmb_ADDRSTROBE,
      M_BE(0 to 3) => microblaze_1_dlmb_BE(0 to 3),
      M_DBus(0 to 31) => microblaze_1_dlmb_WRITEDBUS(0 to 31),
      M_ReadStrobe => microblaze_1_dlmb_READSTROBE,
      M_WriteStrobe => microblaze_1_dlmb_WRITESTROBE,
      SYS_Rst => SYS_Rst_1,
      Sl_CE(0) => microblaze_1_dlmb_bus_CE,
      Sl_DBus(0 to 31) => microblaze_1_dlmb_bus_READDBUS(0 to 31),
      Sl_Ready(0) => microblaze_1_dlmb_bus_READY,
      Sl_UE(0) => microblaze_1_dlmb_bus_UE,
      Sl_Wait(0) => microblaze_1_dlmb_bus_WAIT
    );
ilmb_bram_if_cntlr: component axi_qpsk_tx_bd_ilmb_bram_if_cntlr_0
     port map (
      BRAM_Addr_A(0 to 31) => microblaze_1_ilmb_cntlr_ADDR(0 to 31),
      BRAM_Clk_A => microblaze_1_ilmb_cntlr_CLK,
      BRAM_Din_A(0) => microblaze_1_ilmb_cntlr_DOUT(31),
      BRAM_Din_A(1) => microblaze_1_ilmb_cntlr_DOUT(30),
      BRAM_Din_A(2) => microblaze_1_ilmb_cntlr_DOUT(29),
      BRAM_Din_A(3) => microblaze_1_ilmb_cntlr_DOUT(28),
      BRAM_Din_A(4) => microblaze_1_ilmb_cntlr_DOUT(27),
      BRAM_Din_A(5) => microblaze_1_ilmb_cntlr_DOUT(26),
      BRAM_Din_A(6) => microblaze_1_ilmb_cntlr_DOUT(25),
      BRAM_Din_A(7) => microblaze_1_ilmb_cntlr_DOUT(24),
      BRAM_Din_A(8) => microblaze_1_ilmb_cntlr_DOUT(23),
      BRAM_Din_A(9) => microblaze_1_ilmb_cntlr_DOUT(22),
      BRAM_Din_A(10) => microblaze_1_ilmb_cntlr_DOUT(21),
      BRAM_Din_A(11) => microblaze_1_ilmb_cntlr_DOUT(20),
      BRAM_Din_A(12) => microblaze_1_ilmb_cntlr_DOUT(19),
      BRAM_Din_A(13) => microblaze_1_ilmb_cntlr_DOUT(18),
      BRAM_Din_A(14) => microblaze_1_ilmb_cntlr_DOUT(17),
      BRAM_Din_A(15) => microblaze_1_ilmb_cntlr_DOUT(16),
      BRAM_Din_A(16) => microblaze_1_ilmb_cntlr_DOUT(15),
      BRAM_Din_A(17) => microblaze_1_ilmb_cntlr_DOUT(14),
      BRAM_Din_A(18) => microblaze_1_ilmb_cntlr_DOUT(13),
      BRAM_Din_A(19) => microblaze_1_ilmb_cntlr_DOUT(12),
      BRAM_Din_A(20) => microblaze_1_ilmb_cntlr_DOUT(11),
      BRAM_Din_A(21) => microblaze_1_ilmb_cntlr_DOUT(10),
      BRAM_Din_A(22) => microblaze_1_ilmb_cntlr_DOUT(9),
      BRAM_Din_A(23) => microblaze_1_ilmb_cntlr_DOUT(8),
      BRAM_Din_A(24) => microblaze_1_ilmb_cntlr_DOUT(7),
      BRAM_Din_A(25) => microblaze_1_ilmb_cntlr_DOUT(6),
      BRAM_Din_A(26) => microblaze_1_ilmb_cntlr_DOUT(5),
      BRAM_Din_A(27) => microblaze_1_ilmb_cntlr_DOUT(4),
      BRAM_Din_A(28) => microblaze_1_ilmb_cntlr_DOUT(3),
      BRAM_Din_A(29) => microblaze_1_ilmb_cntlr_DOUT(2),
      BRAM_Din_A(30) => microblaze_1_ilmb_cntlr_DOUT(1),
      BRAM_Din_A(31) => microblaze_1_ilmb_cntlr_DOUT(0),
      BRAM_Dout_A(0 to 31) => microblaze_1_ilmb_cntlr_DIN(0 to 31),
      BRAM_EN_A => microblaze_1_ilmb_cntlr_EN,
      BRAM_Rst_A => microblaze_1_ilmb_cntlr_RST,
      BRAM_WEN_A(0 to 3) => microblaze_1_ilmb_cntlr_WE(0 to 3),
      LMB_ABus(0 to 31) => microblaze_1_ilmb_bus_ABUS(0 to 31),
      LMB_AddrStrobe => microblaze_1_ilmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => microblaze_1_ilmb_bus_BE(0 to 3),
      LMB_Clk => microblaze_1_Clk,
      LMB_ReadStrobe => microblaze_1_ilmb_bus_READSTROBE,
      LMB_Rst => SYS_Rst_1,
      LMB_WriteDBus(0 to 31) => microblaze_1_ilmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => microblaze_1_ilmb_bus_WRITESTROBE,
      Sl_CE => microblaze_1_ilmb_bus_CE,
      Sl_DBus(0 to 31) => microblaze_1_ilmb_bus_READDBUS(0 to 31),
      Sl_Ready => microblaze_1_ilmb_bus_READY,
      Sl_UE => microblaze_1_ilmb_bus_UE,
      Sl_Wait => microblaze_1_ilmb_bus_WAIT
    );
ilmb_v10: component axi_qpsk_tx_bd_ilmb_v10_0
     port map (
      LMB_ABus(0 to 31) => microblaze_1_ilmb_bus_ABUS(0 to 31),
      LMB_AddrStrobe => microblaze_1_ilmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => microblaze_1_ilmb_bus_BE(0 to 3),
      LMB_CE => microblaze_1_ilmb_CE,
      LMB_Clk => microblaze_1_Clk,
      LMB_ReadDBus(0 to 31) => microblaze_1_ilmb_READDBUS(0 to 31),
      LMB_ReadStrobe => microblaze_1_ilmb_bus_READSTROBE,
      LMB_Ready => microblaze_1_ilmb_READY,
      LMB_Rst => NLW_ilmb_v10_LMB_Rst_UNCONNECTED,
      LMB_UE => microblaze_1_ilmb_UE,
      LMB_Wait => microblaze_1_ilmb_WAIT,
      LMB_WriteDBus(0 to 31) => microblaze_1_ilmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => microblaze_1_ilmb_bus_WRITESTROBE,
      M_ABus(0 to 31) => microblaze_1_ilmb_ABUS(0 to 31),
      M_AddrStrobe => microblaze_1_ilmb_ADDRSTROBE,
      M_BE(0 to 3) => B"0000",
      M_DBus(0 to 31) => B"00000000000000000000000000000000",
      M_ReadStrobe => microblaze_1_ilmb_READSTROBE,
      M_WriteStrobe => '0',
      SYS_Rst => SYS_Rst_1,
      Sl_CE(0) => microblaze_1_ilmb_bus_CE,
      Sl_DBus(0 to 31) => microblaze_1_ilmb_bus_READDBUS(0 to 31),
      Sl_Ready(0) => microblaze_1_ilmb_bus_READY,
      Sl_UE(0) => microblaze_1_ilmb_bus_UE,
      Sl_Wait(0) => microblaze_1_ilmb_bus_WAIT
    );
lmb_bram: component axi_qpsk_tx_bd_lmb_bram_0
     port map (
      addra(31) => microblaze_1_dlmb_cntlr_ADDR(0),
      addra(30) => microblaze_1_dlmb_cntlr_ADDR(1),
      addra(29) => microblaze_1_dlmb_cntlr_ADDR(2),
      addra(28) => microblaze_1_dlmb_cntlr_ADDR(3),
      addra(27) => microblaze_1_dlmb_cntlr_ADDR(4),
      addra(26) => microblaze_1_dlmb_cntlr_ADDR(5),
      addra(25) => microblaze_1_dlmb_cntlr_ADDR(6),
      addra(24) => microblaze_1_dlmb_cntlr_ADDR(7),
      addra(23) => microblaze_1_dlmb_cntlr_ADDR(8),
      addra(22) => microblaze_1_dlmb_cntlr_ADDR(9),
      addra(21) => microblaze_1_dlmb_cntlr_ADDR(10),
      addra(20) => microblaze_1_dlmb_cntlr_ADDR(11),
      addra(19) => microblaze_1_dlmb_cntlr_ADDR(12),
      addra(18) => microblaze_1_dlmb_cntlr_ADDR(13),
      addra(17) => microblaze_1_dlmb_cntlr_ADDR(14),
      addra(16) => microblaze_1_dlmb_cntlr_ADDR(15),
      addra(15) => microblaze_1_dlmb_cntlr_ADDR(16),
      addra(14) => microblaze_1_dlmb_cntlr_ADDR(17),
      addra(13) => microblaze_1_dlmb_cntlr_ADDR(18),
      addra(12) => microblaze_1_dlmb_cntlr_ADDR(19),
      addra(11) => microblaze_1_dlmb_cntlr_ADDR(20),
      addra(10) => microblaze_1_dlmb_cntlr_ADDR(21),
      addra(9) => microblaze_1_dlmb_cntlr_ADDR(22),
      addra(8) => microblaze_1_dlmb_cntlr_ADDR(23),
      addra(7) => microblaze_1_dlmb_cntlr_ADDR(24),
      addra(6) => microblaze_1_dlmb_cntlr_ADDR(25),
      addra(5) => microblaze_1_dlmb_cntlr_ADDR(26),
      addra(4) => microblaze_1_dlmb_cntlr_ADDR(27),
      addra(3) => microblaze_1_dlmb_cntlr_ADDR(28),
      addra(2) => microblaze_1_dlmb_cntlr_ADDR(29),
      addra(1) => microblaze_1_dlmb_cntlr_ADDR(30),
      addra(0) => microblaze_1_dlmb_cntlr_ADDR(31),
      addrb(31) => microblaze_1_ilmb_cntlr_ADDR(0),
      addrb(30) => microblaze_1_ilmb_cntlr_ADDR(1),
      addrb(29) => microblaze_1_ilmb_cntlr_ADDR(2),
      addrb(28) => microblaze_1_ilmb_cntlr_ADDR(3),
      addrb(27) => microblaze_1_ilmb_cntlr_ADDR(4),
      addrb(26) => microblaze_1_ilmb_cntlr_ADDR(5),
      addrb(25) => microblaze_1_ilmb_cntlr_ADDR(6),
      addrb(24) => microblaze_1_ilmb_cntlr_ADDR(7),
      addrb(23) => microblaze_1_ilmb_cntlr_ADDR(8),
      addrb(22) => microblaze_1_ilmb_cntlr_ADDR(9),
      addrb(21) => microblaze_1_ilmb_cntlr_ADDR(10),
      addrb(20) => microblaze_1_ilmb_cntlr_ADDR(11),
      addrb(19) => microblaze_1_ilmb_cntlr_ADDR(12),
      addrb(18) => microblaze_1_ilmb_cntlr_ADDR(13),
      addrb(17) => microblaze_1_ilmb_cntlr_ADDR(14),
      addrb(16) => microblaze_1_ilmb_cntlr_ADDR(15),
      addrb(15) => microblaze_1_ilmb_cntlr_ADDR(16),
      addrb(14) => microblaze_1_ilmb_cntlr_ADDR(17),
      addrb(13) => microblaze_1_ilmb_cntlr_ADDR(18),
      addrb(12) => microblaze_1_ilmb_cntlr_ADDR(19),
      addrb(11) => microblaze_1_ilmb_cntlr_ADDR(20),
      addrb(10) => microblaze_1_ilmb_cntlr_ADDR(21),
      addrb(9) => microblaze_1_ilmb_cntlr_ADDR(22),
      addrb(8) => microblaze_1_ilmb_cntlr_ADDR(23),
      addrb(7) => microblaze_1_ilmb_cntlr_ADDR(24),
      addrb(6) => microblaze_1_ilmb_cntlr_ADDR(25),
      addrb(5) => microblaze_1_ilmb_cntlr_ADDR(26),
      addrb(4) => microblaze_1_ilmb_cntlr_ADDR(27),
      addrb(3) => microblaze_1_ilmb_cntlr_ADDR(28),
      addrb(2) => microblaze_1_ilmb_cntlr_ADDR(29),
      addrb(1) => microblaze_1_ilmb_cntlr_ADDR(30),
      addrb(0) => microblaze_1_ilmb_cntlr_ADDR(31),
      clka => microblaze_1_dlmb_cntlr_CLK,
      clkb => microblaze_1_ilmb_cntlr_CLK,
      dina(31) => microblaze_1_dlmb_cntlr_DIN(0),
      dina(30) => microblaze_1_dlmb_cntlr_DIN(1),
      dina(29) => microblaze_1_dlmb_cntlr_DIN(2),
      dina(28) => microblaze_1_dlmb_cntlr_DIN(3),
      dina(27) => microblaze_1_dlmb_cntlr_DIN(4),
      dina(26) => microblaze_1_dlmb_cntlr_DIN(5),
      dina(25) => microblaze_1_dlmb_cntlr_DIN(6),
      dina(24) => microblaze_1_dlmb_cntlr_DIN(7),
      dina(23) => microblaze_1_dlmb_cntlr_DIN(8),
      dina(22) => microblaze_1_dlmb_cntlr_DIN(9),
      dina(21) => microblaze_1_dlmb_cntlr_DIN(10),
      dina(20) => microblaze_1_dlmb_cntlr_DIN(11),
      dina(19) => microblaze_1_dlmb_cntlr_DIN(12),
      dina(18) => microblaze_1_dlmb_cntlr_DIN(13),
      dina(17) => microblaze_1_dlmb_cntlr_DIN(14),
      dina(16) => microblaze_1_dlmb_cntlr_DIN(15),
      dina(15) => microblaze_1_dlmb_cntlr_DIN(16),
      dina(14) => microblaze_1_dlmb_cntlr_DIN(17),
      dina(13) => microblaze_1_dlmb_cntlr_DIN(18),
      dina(12) => microblaze_1_dlmb_cntlr_DIN(19),
      dina(11) => microblaze_1_dlmb_cntlr_DIN(20),
      dina(10) => microblaze_1_dlmb_cntlr_DIN(21),
      dina(9) => microblaze_1_dlmb_cntlr_DIN(22),
      dina(8) => microblaze_1_dlmb_cntlr_DIN(23),
      dina(7) => microblaze_1_dlmb_cntlr_DIN(24),
      dina(6) => microblaze_1_dlmb_cntlr_DIN(25),
      dina(5) => microblaze_1_dlmb_cntlr_DIN(26),
      dina(4) => microblaze_1_dlmb_cntlr_DIN(27),
      dina(3) => microblaze_1_dlmb_cntlr_DIN(28),
      dina(2) => microblaze_1_dlmb_cntlr_DIN(29),
      dina(1) => microblaze_1_dlmb_cntlr_DIN(30),
      dina(0) => microblaze_1_dlmb_cntlr_DIN(31),
      dinb(31) => microblaze_1_ilmb_cntlr_DIN(0),
      dinb(30) => microblaze_1_ilmb_cntlr_DIN(1),
      dinb(29) => microblaze_1_ilmb_cntlr_DIN(2),
      dinb(28) => microblaze_1_ilmb_cntlr_DIN(3),
      dinb(27) => microblaze_1_ilmb_cntlr_DIN(4),
      dinb(26) => microblaze_1_ilmb_cntlr_DIN(5),
      dinb(25) => microblaze_1_ilmb_cntlr_DIN(6),
      dinb(24) => microblaze_1_ilmb_cntlr_DIN(7),
      dinb(23) => microblaze_1_ilmb_cntlr_DIN(8),
      dinb(22) => microblaze_1_ilmb_cntlr_DIN(9),
      dinb(21) => microblaze_1_ilmb_cntlr_DIN(10),
      dinb(20) => microblaze_1_ilmb_cntlr_DIN(11),
      dinb(19) => microblaze_1_ilmb_cntlr_DIN(12),
      dinb(18) => microblaze_1_ilmb_cntlr_DIN(13),
      dinb(17) => microblaze_1_ilmb_cntlr_DIN(14),
      dinb(16) => microblaze_1_ilmb_cntlr_DIN(15),
      dinb(15) => microblaze_1_ilmb_cntlr_DIN(16),
      dinb(14) => microblaze_1_ilmb_cntlr_DIN(17),
      dinb(13) => microblaze_1_ilmb_cntlr_DIN(18),
      dinb(12) => microblaze_1_ilmb_cntlr_DIN(19),
      dinb(11) => microblaze_1_ilmb_cntlr_DIN(20),
      dinb(10) => microblaze_1_ilmb_cntlr_DIN(21),
      dinb(9) => microblaze_1_ilmb_cntlr_DIN(22),
      dinb(8) => microblaze_1_ilmb_cntlr_DIN(23),
      dinb(7) => microblaze_1_ilmb_cntlr_DIN(24),
      dinb(6) => microblaze_1_ilmb_cntlr_DIN(25),
      dinb(5) => microblaze_1_ilmb_cntlr_DIN(26),
      dinb(4) => microblaze_1_ilmb_cntlr_DIN(27),
      dinb(3) => microblaze_1_ilmb_cntlr_DIN(28),
      dinb(2) => microblaze_1_ilmb_cntlr_DIN(29),
      dinb(1) => microblaze_1_ilmb_cntlr_DIN(30),
      dinb(0) => microblaze_1_ilmb_cntlr_DIN(31),
      douta(31 downto 0) => microblaze_1_dlmb_cntlr_DOUT(31 downto 0),
      doutb(31 downto 0) => microblaze_1_ilmb_cntlr_DOUT(31 downto 0),
      ena => microblaze_1_dlmb_cntlr_EN,
      enb => microblaze_1_ilmb_cntlr_EN,
      rsta => microblaze_1_dlmb_cntlr_RST,
      rsta_busy => NLW_lmb_bram_rsta_busy_UNCONNECTED,
      rstb => microblaze_1_ilmb_cntlr_RST,
      rstb_busy => NLW_lmb_bram_rstb_busy_UNCONNECTED,
      wea(3) => microblaze_1_dlmb_cntlr_WE(0),
      wea(2) => microblaze_1_dlmb_cntlr_WE(1),
      wea(1) => microblaze_1_dlmb_cntlr_WE(2),
      wea(0) => microblaze_1_dlmb_cntlr_WE(3),
      web(3) => microblaze_1_ilmb_cntlr_WE(0),
      web(2) => microblaze_1_ilmb_cntlr_WE(1),
      web(1) => microblaze_1_ilmb_cntlr_WE(2),
      web(0) => microblaze_1_ilmb_cntlr_WE(3)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s00_couplers_imp_PF4HSK is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_PF4HSK;

architecture STRUCTURE of s00_couplers_imp_PF4HSK is
  signal s00_couplers_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_ARREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_AWREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_BVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_RREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_RVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_WREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= s00_couplers_to_s00_couplers_ARADDR(31 downto 0);
  M_AXI_arvalid <= s00_couplers_to_s00_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= s00_couplers_to_s00_couplers_AWADDR(31 downto 0);
  M_AXI_awvalid <= s00_couplers_to_s00_couplers_AWVALID;
  M_AXI_bready <= s00_couplers_to_s00_couplers_BREADY;
  M_AXI_rready <= s00_couplers_to_s00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= s00_couplers_to_s00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= s00_couplers_to_s00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= s00_couplers_to_s00_couplers_WVALID;
  S_AXI_arready <= s00_couplers_to_s00_couplers_ARREADY;
  S_AXI_awready <= s00_couplers_to_s00_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= s00_couplers_to_s00_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= s00_couplers_to_s00_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= s00_couplers_to_s00_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= s00_couplers_to_s00_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= s00_couplers_to_s00_couplers_RVALID;
  S_AXI_wready <= s00_couplers_to_s00_couplers_WREADY;
  s00_couplers_to_s00_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  s00_couplers_to_s00_couplers_ARREADY <= M_AXI_arready;
  s00_couplers_to_s00_couplers_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_s00_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  s00_couplers_to_s00_couplers_AWREADY <= M_AXI_awready;
  s00_couplers_to_s00_couplers_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_s00_couplers_BREADY <= S_AXI_bready;
  s00_couplers_to_s00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  s00_couplers_to_s00_couplers_BVALID <= M_AXI_bvalid;
  s00_couplers_to_s00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  s00_couplers_to_s00_couplers_RREADY <= S_AXI_rready;
  s00_couplers_to_s00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  s00_couplers_to_s00_couplers_RVALID <= M_AXI_rvalid;
  s00_couplers_to_s00_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  s00_couplers_to_s00_couplers_WREADY <= M_AXI_wready;
  s00_couplers_to_s00_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  s00_couplers_to_s00_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_qpsk_tx_bd_microblaze_1_axi_periph_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rready : out STD_LOGIC;
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC
  );
end axi_qpsk_tx_bd_microblaze_1_axi_periph_0;

architecture STRUCTURE of axi_qpsk_tx_bd_microblaze_1_axi_periph_0 is
  signal S00_ACLK_1 : STD_LOGIC;
  signal S00_ARESETN_1 : STD_LOGIC;
  signal microblaze_1_axi_periph_ACLK_net : STD_LOGIC;
  signal microblaze_1_axi_periph_ARESETN_net : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_to_s00_couplers_ARREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_ARVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_to_s00_couplers_AWREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_AWVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_BREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_1_axi_periph_to_s00_couplers_BVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_to_s00_couplers_RREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_1_axi_periph_to_s00_couplers_RVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_to_s00_couplers_WREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_1_axi_periph_to_s00_couplers_WVALID : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_microblaze_1_axi_periph_ARREADY : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_ARVALID : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_microblaze_1_axi_periph_AWREADY : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_AWVALID : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_BREADY : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_microblaze_1_axi_periph_BVALID : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_microblaze_1_axi_periph_RREADY : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_microblaze_1_axi_periph_RVALID : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_microblaze_1_axi_periph_WREADY : STD_LOGIC;
  signal s00_couplers_to_microblaze_1_axi_periph_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_microblaze_1_axi_periph_WVALID : STD_LOGIC;
begin
  M00_AXI_araddr(31 downto 0) <= s00_couplers_to_microblaze_1_axi_periph_ARADDR(31 downto 0);
  M00_AXI_arvalid <= s00_couplers_to_microblaze_1_axi_periph_ARVALID;
  M00_AXI_awaddr(31 downto 0) <= s00_couplers_to_microblaze_1_axi_periph_AWADDR(31 downto 0);
  M00_AXI_awvalid <= s00_couplers_to_microblaze_1_axi_periph_AWVALID;
  M00_AXI_bready <= s00_couplers_to_microblaze_1_axi_periph_BREADY;
  M00_AXI_rready <= s00_couplers_to_microblaze_1_axi_periph_RREADY;
  M00_AXI_wdata(31 downto 0) <= s00_couplers_to_microblaze_1_axi_periph_WDATA(31 downto 0);
  M00_AXI_wstrb(3 downto 0) <= s00_couplers_to_microblaze_1_axi_periph_WSTRB(3 downto 0);
  M00_AXI_wvalid <= s00_couplers_to_microblaze_1_axi_periph_WVALID;
  S00_ACLK_1 <= S00_ACLK;
  S00_ARESETN_1 <= S00_ARESETN;
  S00_AXI_arready <= microblaze_1_axi_periph_to_s00_couplers_ARREADY;
  S00_AXI_awready <= microblaze_1_axi_periph_to_s00_couplers_AWREADY;
  S00_AXI_bresp(1 downto 0) <= microblaze_1_axi_periph_to_s00_couplers_BRESP(1 downto 0);
  S00_AXI_bvalid <= microblaze_1_axi_periph_to_s00_couplers_BVALID;
  S00_AXI_rdata(31 downto 0) <= microblaze_1_axi_periph_to_s00_couplers_RDATA(31 downto 0);
  S00_AXI_rresp(1 downto 0) <= microblaze_1_axi_periph_to_s00_couplers_RRESP(1 downto 0);
  S00_AXI_rvalid <= microblaze_1_axi_periph_to_s00_couplers_RVALID;
  S00_AXI_wready <= microblaze_1_axi_periph_to_s00_couplers_WREADY;
  microblaze_1_axi_periph_ACLK_net <= M00_ACLK;
  microblaze_1_axi_periph_ARESETN_net <= M00_ARESETN;
  microblaze_1_axi_periph_to_s00_couplers_ARADDR(31 downto 0) <= S00_AXI_araddr(31 downto 0);
  microblaze_1_axi_periph_to_s00_couplers_ARVALID <= S00_AXI_arvalid;
  microblaze_1_axi_periph_to_s00_couplers_AWADDR(31 downto 0) <= S00_AXI_awaddr(31 downto 0);
  microblaze_1_axi_periph_to_s00_couplers_AWVALID <= S00_AXI_awvalid;
  microblaze_1_axi_periph_to_s00_couplers_BREADY <= S00_AXI_bready;
  microblaze_1_axi_periph_to_s00_couplers_RREADY <= S00_AXI_rready;
  microblaze_1_axi_periph_to_s00_couplers_WDATA(31 downto 0) <= S00_AXI_wdata(31 downto 0);
  microblaze_1_axi_periph_to_s00_couplers_WSTRB(3 downto 0) <= S00_AXI_wstrb(3 downto 0);
  microblaze_1_axi_periph_to_s00_couplers_WVALID <= S00_AXI_wvalid;
  s00_couplers_to_microblaze_1_axi_periph_ARREADY <= M00_AXI_arready;
  s00_couplers_to_microblaze_1_axi_periph_AWREADY <= M00_AXI_awready;
  s00_couplers_to_microblaze_1_axi_periph_BRESP(1 downto 0) <= M00_AXI_bresp(1 downto 0);
  s00_couplers_to_microblaze_1_axi_periph_BVALID <= M00_AXI_bvalid;
  s00_couplers_to_microblaze_1_axi_periph_RDATA(31 downto 0) <= M00_AXI_rdata(31 downto 0);
  s00_couplers_to_microblaze_1_axi_periph_RRESP(1 downto 0) <= M00_AXI_rresp(1 downto 0);
  s00_couplers_to_microblaze_1_axi_periph_RVALID <= M00_AXI_rvalid;
  s00_couplers_to_microblaze_1_axi_periph_WREADY <= M00_AXI_wready;
s00_couplers: entity work.s00_couplers_imp_PF4HSK
     port map (
      M_ACLK => microblaze_1_axi_periph_ACLK_net,
      M_ARESETN => microblaze_1_axi_periph_ARESETN_net,
      M_AXI_araddr(31 downto 0) => s00_couplers_to_microblaze_1_axi_periph_ARADDR(31 downto 0),
      M_AXI_arready => s00_couplers_to_microblaze_1_axi_periph_ARREADY,
      M_AXI_arvalid => s00_couplers_to_microblaze_1_axi_periph_ARVALID,
      M_AXI_awaddr(31 downto 0) => s00_couplers_to_microblaze_1_axi_periph_AWADDR(31 downto 0),
      M_AXI_awready => s00_couplers_to_microblaze_1_axi_periph_AWREADY,
      M_AXI_awvalid => s00_couplers_to_microblaze_1_axi_periph_AWVALID,
      M_AXI_bready => s00_couplers_to_microblaze_1_axi_periph_BREADY,
      M_AXI_bresp(1 downto 0) => s00_couplers_to_microblaze_1_axi_periph_BRESP(1 downto 0),
      M_AXI_bvalid => s00_couplers_to_microblaze_1_axi_periph_BVALID,
      M_AXI_rdata(31 downto 0) => s00_couplers_to_microblaze_1_axi_periph_RDATA(31 downto 0),
      M_AXI_rready => s00_couplers_to_microblaze_1_axi_periph_RREADY,
      M_AXI_rresp(1 downto 0) => s00_couplers_to_microblaze_1_axi_periph_RRESP(1 downto 0),
      M_AXI_rvalid => s00_couplers_to_microblaze_1_axi_periph_RVALID,
      M_AXI_wdata(31 downto 0) => s00_couplers_to_microblaze_1_axi_periph_WDATA(31 downto 0),
      M_AXI_wready => s00_couplers_to_microblaze_1_axi_periph_WREADY,
      M_AXI_wstrb(3 downto 0) => s00_couplers_to_microblaze_1_axi_periph_WSTRB(3 downto 0),
      M_AXI_wvalid => s00_couplers_to_microblaze_1_axi_periph_WVALID,
      S_ACLK => S00_ACLK_1,
      S_ARESETN => S00_ARESETN_1,
      S_AXI_araddr(31 downto 0) => microblaze_1_axi_periph_to_s00_couplers_ARADDR(31 downto 0),
      S_AXI_arready => microblaze_1_axi_periph_to_s00_couplers_ARREADY,
      S_AXI_arvalid => microblaze_1_axi_periph_to_s00_couplers_ARVALID,
      S_AXI_awaddr(31 downto 0) => microblaze_1_axi_periph_to_s00_couplers_AWADDR(31 downto 0),
      S_AXI_awready => microblaze_1_axi_periph_to_s00_couplers_AWREADY,
      S_AXI_awvalid => microblaze_1_axi_periph_to_s00_couplers_AWVALID,
      S_AXI_bready => microblaze_1_axi_periph_to_s00_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => microblaze_1_axi_periph_to_s00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => microblaze_1_axi_periph_to_s00_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => microblaze_1_axi_periph_to_s00_couplers_RDATA(31 downto 0),
      S_AXI_rready => microblaze_1_axi_periph_to_s00_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => microblaze_1_axi_periph_to_s00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => microblaze_1_axi_periph_to_s00_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => microblaze_1_axi_periph_to_s00_couplers_WDATA(31 downto 0),
      S_AXI_wready => microblaze_1_axi_periph_to_s00_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => microblaze_1_axi_periph_to_s00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => microblaze_1_axi_periph_to_s00_couplers_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity axi_qpsk_tx_bd is
  port (
    CLK_IN1_D_clk_n : in STD_LOGIC;
    CLK_IN1_D_clk_p : in STD_LOGIC;
    m_fft_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_fft_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_fft_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_fft_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_rf_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_rf_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_rf_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_rf_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_symbol_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_symbol_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_symbol_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_symbol_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_time_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_time_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_time_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_time_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset_rtl : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of axi_qpsk_tx_bd : entity is "axi_qpsk_tx_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=axi_qpsk_tx_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=13,numReposBlks=10,numNonXlnxBlks=1,numHierBlks=3,maxHierDepth=1,numSysgenBlks=1,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SYSGEN,da_axi4_cnt=1,da_mb_cnt=1,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of axi_qpsk_tx_bd : entity is "axi_qpsk_tx_bd.hwdef";
end axi_qpsk_tx_bd;

architecture STRUCTURE of axi_qpsk_tx_bd is
  component axi_qpsk_tx_bd_axi_qpsk_tx_1_0 is
  port (
    m_rf_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_fft_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_symbol_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_time_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC;
    axi_qpsk_tx_aresetn : in STD_LOGIC;
    axi_qpsk_tx_s_axi_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_qpsk_tx_s_axi_awvalid : in STD_LOGIC;
    axi_qpsk_tx_s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_qpsk_tx_s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_qpsk_tx_s_axi_wvalid : in STD_LOGIC;
    axi_qpsk_tx_s_axi_bready : in STD_LOGIC;
    axi_qpsk_tx_s_axi_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    axi_qpsk_tx_s_axi_arvalid : in STD_LOGIC;
    axi_qpsk_tx_s_axi_rready : in STD_LOGIC;
    m_rf_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_rf_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_rf_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_fft_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_fft_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_fft_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_symbol_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_symbol_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_symbol_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_time_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_time_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_time_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    axi_qpsk_tx_s_axi_awready : out STD_LOGIC;
    axi_qpsk_tx_s_axi_wready : out STD_LOGIC;
    axi_qpsk_tx_s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_qpsk_tx_s_axi_bvalid : out STD_LOGIC;
    axi_qpsk_tx_s_axi_arready : out STD_LOGIC;
    axi_qpsk_tx_s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_qpsk_tx_s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_qpsk_tx_s_axi_rvalid : out STD_LOGIC
  );
  end component axi_qpsk_tx_bd_axi_qpsk_tx_1_0;
  component axi_qpsk_tx_bd_microblaze_1_0 is
  port (
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    Interrupt : in STD_LOGIC;
    Interrupt_Address : in STD_LOGIC_VECTOR ( 0 to 31 );
    Interrupt_Ack : out STD_LOGIC_VECTOR ( 0 to 1 );
    Instr_Addr : out STD_LOGIC_VECTOR ( 0 to 31 );
    Instr : in STD_LOGIC_VECTOR ( 0 to 31 );
    IFetch : out STD_LOGIC;
    I_AS : out STD_LOGIC;
    IReady : in STD_LOGIC;
    IWAIT : in STD_LOGIC;
    ICE : in STD_LOGIC;
    IUE : in STD_LOGIC;
    Data_Addr : out STD_LOGIC_VECTOR ( 0 to 31 );
    Data_Read : in STD_LOGIC_VECTOR ( 0 to 31 );
    Data_Write : out STD_LOGIC_VECTOR ( 0 to 31 );
    D_AS : out STD_LOGIC;
    Read_Strobe : out STD_LOGIC;
    Write_Strobe : out STD_LOGIC;
    DReady : in STD_LOGIC;
    DWait : in STD_LOGIC;
    DCE : in STD_LOGIC;
    DUE : in STD_LOGIC;
    Byte_Enable : out STD_LOGIC_VECTOR ( 0 to 3 );
    M_AXI_DP_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DP_AWVALID : out STD_LOGIC;
    M_AXI_DP_AWREADY : in STD_LOGIC;
    M_AXI_DP_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DP_WVALID : out STD_LOGIC;
    M_AXI_DP_WREADY : in STD_LOGIC;
    M_AXI_DP_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DP_BVALID : in STD_LOGIC;
    M_AXI_DP_BREADY : out STD_LOGIC;
    M_AXI_DP_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DP_ARVALID : out STD_LOGIC;
    M_AXI_DP_ARREADY : in STD_LOGIC;
    M_AXI_DP_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DP_RVALID : in STD_LOGIC;
    M_AXI_DP_RREADY : out STD_LOGIC;
    Dbg_Clk : in STD_LOGIC;
    Dbg_TDI : in STD_LOGIC;
    Dbg_TDO : out STD_LOGIC;
    Dbg_Reg_En : in STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Shift : in STD_LOGIC;
    Dbg_Capture : in STD_LOGIC;
    Dbg_Update : in STD_LOGIC;
    Debug_Rst : in STD_LOGIC;
    Dbg_Disable : in STD_LOGIC
  );
  end component axi_qpsk_tx_bd_microblaze_1_0;
  component axi_qpsk_tx_bd_mdm_1_0 is
  port (
    Debug_SYS_Rst : out STD_LOGIC;
    Dbg_Clk_0 : out STD_LOGIC;
    Dbg_TDI_0 : out STD_LOGIC;
    Dbg_TDO_0 : in STD_LOGIC;
    Dbg_Reg_En_0 : out STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Capture_0 : out STD_LOGIC;
    Dbg_Shift_0 : out STD_LOGIC;
    Dbg_Update_0 : out STD_LOGIC;
    Dbg_Rst_0 : out STD_LOGIC;
    Dbg_Disable_0 : out STD_LOGIC
  );
  end component axi_qpsk_tx_bd_mdm_1_0;
  component axi_qpsk_tx_bd_clk_wiz_1_0 is
  port (
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC;
    reset : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component axi_qpsk_tx_bd_clk_wiz_1_0;
  component axi_qpsk_tx_bd_rst_clk_wiz_1_100M_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component axi_qpsk_tx_bd_rst_clk_wiz_1_100M_0;
  signal CLK_IN1_D_1_CLK_N : STD_LOGIC;
  signal CLK_IN1_D_1_CLK_P : STD_LOGIC;
  signal axi_qpsk_tx_1_m_fft_axis_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_qpsk_tx_1_m_fft_axis_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_fft_axis_TREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_fft_axis_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_rf_axis_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_qpsk_tx_1_m_rf_axis_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_rf_axis_TREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_rf_axis_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_symbol_axis_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_qpsk_tx_1_m_symbol_axis_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_symbol_axis_TREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_symbol_axis_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_time_axis_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_qpsk_tx_1_m_time_axis_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_time_axis_TREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_qpsk_tx_1_m_time_axis_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal clk_wiz_1_locked : STD_LOGIC;
  signal mdm_1_debug_sys_rst : STD_LOGIC;
  signal microblaze_1_Clk : STD_LOGIC;
  signal microblaze_1_axi_dp_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_dp_ARREADY : STD_LOGIC;
  signal microblaze_1_axi_dp_ARVALID : STD_LOGIC;
  signal microblaze_1_axi_dp_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_dp_AWREADY : STD_LOGIC;
  signal microblaze_1_axi_dp_AWVALID : STD_LOGIC;
  signal microblaze_1_axi_dp_BREADY : STD_LOGIC;
  signal microblaze_1_axi_dp_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_1_axi_dp_BVALID : STD_LOGIC;
  signal microblaze_1_axi_dp_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_dp_RREADY : STD_LOGIC;
  signal microblaze_1_axi_dp_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_1_axi_dp_RVALID : STD_LOGIC;
  signal microblaze_1_axi_dp_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_dp_WREADY : STD_LOGIC;
  signal microblaze_1_axi_dp_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_1_axi_dp_WVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_M00_AXI_ARREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_ARVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_M00_AXI_AWREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_AWVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_BREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_1_axi_periph_M00_AXI_BVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_M00_AXI_RREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_1_axi_periph_M00_AXI_RVALID : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_1_axi_periph_M00_AXI_WREADY : STD_LOGIC;
  signal microblaze_1_axi_periph_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_1_axi_periph_M00_AXI_WVALID : STD_LOGIC;
  signal microblaze_1_debug_CAPTURE : STD_LOGIC;
  signal microblaze_1_debug_CLK : STD_LOGIC;
  signal microblaze_1_debug_DISABLE : STD_LOGIC;
  signal microblaze_1_debug_REG_EN : STD_LOGIC_VECTOR ( 0 to 7 );
  signal microblaze_1_debug_RST : STD_LOGIC;
  signal microblaze_1_debug_SHIFT : STD_LOGIC;
  signal microblaze_1_debug_TDI : STD_LOGIC;
  signal microblaze_1_debug_TDO : STD_LOGIC;
  signal microblaze_1_debug_UPDATE : STD_LOGIC;
  signal microblaze_1_dlmb_1_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_1_ADDRSTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_1_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal microblaze_1_dlmb_1_CE : STD_LOGIC;
  signal microblaze_1_dlmb_1_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_1_READSTROBE : STD_LOGIC;
  signal microblaze_1_dlmb_1_READY : STD_LOGIC;
  signal microblaze_1_dlmb_1_UE : STD_LOGIC;
  signal microblaze_1_dlmb_1_WAIT : STD_LOGIC;
  signal microblaze_1_dlmb_1_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_dlmb_1_WRITESTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_1_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_1_ADDRSTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_1_CE : STD_LOGIC;
  signal microblaze_1_ilmb_1_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_1_ilmb_1_READSTROBE : STD_LOGIC;
  signal microblaze_1_ilmb_1_READY : STD_LOGIC;
  signal microblaze_1_ilmb_1_UE : STD_LOGIC;
  signal microblaze_1_ilmb_1_WAIT : STD_LOGIC;
  signal reset_rtl_1 : STD_LOGIC;
  signal rst_clk_wiz_1_100M_bus_struct_reset : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_clk_wiz_1_100M_mb_reset : STD_LOGIC;
  signal rst_clk_wiz_1_100M_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_microblaze_1_Interrupt_Ack_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 1 );
  signal NLW_microblaze_1_M_AXI_DP_ARPROT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_microblaze_1_M_AXI_DP_AWPROT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_rst_clk_wiz_1_100M_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_rst_clk_wiz_1_100M_peripheral_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute BMM_INFO_PROCESSOR : string;
  attribute BMM_INFO_PROCESSOR of microblaze_1 : label is "microblaze-le > axi_qpsk_tx_bd microblaze_1_local_memory/dlmb_bram_if_cntlr";
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of microblaze_1 : label is "yes";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of CLK_IN1_D_clk_n : signal is "xilinx.com:interface:diff_clock:1.0 CLK_IN1_D CLK_N";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of CLK_IN1_D_clk_n : signal is "XIL_INTERFACENAME CLK_IN1_D, CAN_DEBUG false, FREQ_HZ 25599999.999999996";
  attribute X_INTERFACE_INFO of CLK_IN1_D_clk_p : signal is "xilinx.com:interface:diff_clock:1.0 CLK_IN1_D CLK_P";
  attribute X_INTERFACE_INFO of reset_rtl : signal is "xilinx.com:signal:reset:1.0 RST.RESET_RTL RST";
  attribute X_INTERFACE_PARAMETER of reset_rtl : signal is "XIL_INTERFACENAME RST.RESET_RTL, INSERT_VIP 0, POLARITY ACTIVE_HIGH";
  attribute X_INTERFACE_INFO of m_fft_axis_tdata : signal is "xilinx.com:interface:axis:1.0 m_fft_axis TDATA";
  attribute X_INTERFACE_PARAMETER of m_fft_axis_tdata : signal is "XIL_INTERFACENAME m_fft_axis, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of m_fft_axis_tlast : signal is "xilinx.com:interface:axis:1.0 m_fft_axis TLAST";
  attribute X_INTERFACE_INFO of m_fft_axis_tready : signal is "xilinx.com:interface:axis:1.0 m_fft_axis TREADY";
  attribute X_INTERFACE_INFO of m_fft_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 m_fft_axis TVALID";
  attribute X_INTERFACE_INFO of m_rf_axis_tdata : signal is "xilinx.com:interface:axis:1.0 m_rf_axis TDATA";
  attribute X_INTERFACE_PARAMETER of m_rf_axis_tdata : signal is "XIL_INTERFACENAME m_rf_axis, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of m_rf_axis_tlast : signal is "xilinx.com:interface:axis:1.0 m_rf_axis TLAST";
  attribute X_INTERFACE_INFO of m_rf_axis_tready : signal is "xilinx.com:interface:axis:1.0 m_rf_axis TREADY";
  attribute X_INTERFACE_INFO of m_rf_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 m_rf_axis TVALID";
  attribute X_INTERFACE_INFO of m_symbol_axis_tdata : signal is "xilinx.com:interface:axis:1.0 m_symbol_axis TDATA";
  attribute X_INTERFACE_PARAMETER of m_symbol_axis_tdata : signal is "XIL_INTERFACENAME m_symbol_axis, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}, PHASE 0.000, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of m_symbol_axis_tlast : signal is "xilinx.com:interface:axis:1.0 m_symbol_axis TLAST";
  attribute X_INTERFACE_INFO of m_symbol_axis_tready : signal is "xilinx.com:interface:axis:1.0 m_symbol_axis TREADY";
  attribute X_INTERFACE_INFO of m_symbol_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 m_symbol_axis TVALID";
  attribute X_INTERFACE_INFO of m_time_axis_tdata : signal is "xilinx.com:interface:axis:1.0 m_time_axis TDATA";
  attribute X_INTERFACE_PARAMETER of m_time_axis_tdata : signal is "XIL_INTERFACENAME m_time_axis, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of m_time_axis_tlast : signal is "xilinx.com:interface:axis:1.0 m_time_axis TLAST";
  attribute X_INTERFACE_INFO of m_time_axis_tready : signal is "xilinx.com:interface:axis:1.0 m_time_axis TREADY";
  attribute X_INTERFACE_INFO of m_time_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 m_time_axis TVALID";
begin
  CLK_IN1_D_1_CLK_N <= CLK_IN1_D_clk_n;
  CLK_IN1_D_1_CLK_P <= CLK_IN1_D_clk_p;
  axi_qpsk_tx_1_m_fft_axis_TREADY(0) <= m_fft_axis_tready(0);
  axi_qpsk_tx_1_m_rf_axis_TREADY(0) <= m_rf_axis_tready(0);
  axi_qpsk_tx_1_m_symbol_axis_TREADY(0) <= m_symbol_axis_tready(0);
  axi_qpsk_tx_1_m_time_axis_TREADY(0) <= m_time_axis_tready(0);
  m_fft_axis_tdata(31 downto 0) <= axi_qpsk_tx_1_m_fft_axis_TDATA(31 downto 0);
  m_fft_axis_tlast(0) <= axi_qpsk_tx_1_m_fft_axis_TLAST(0);
  m_fft_axis_tvalid(0) <= axi_qpsk_tx_1_m_fft_axis_TVALID(0);
  m_rf_axis_tdata(31 downto 0) <= axi_qpsk_tx_1_m_rf_axis_TDATA(31 downto 0);
  m_rf_axis_tlast(0) <= axi_qpsk_tx_1_m_rf_axis_TLAST(0);
  m_rf_axis_tvalid(0) <= axi_qpsk_tx_1_m_rf_axis_TVALID(0);
  m_symbol_axis_tdata(7 downto 0) <= axi_qpsk_tx_1_m_symbol_axis_TDATA(7 downto 0);
  m_symbol_axis_tlast(0) <= axi_qpsk_tx_1_m_symbol_axis_TLAST(0);
  m_symbol_axis_tvalid(0) <= axi_qpsk_tx_1_m_symbol_axis_TVALID(0);
  m_time_axis_tdata(31 downto 0) <= axi_qpsk_tx_1_m_time_axis_TDATA(31 downto 0);
  m_time_axis_tlast(0) <= axi_qpsk_tx_1_m_time_axis_TLAST(0);
  m_time_axis_tvalid(0) <= axi_qpsk_tx_1_m_time_axis_TVALID(0);
  reset_rtl_1 <= reset_rtl;
axi_qpsk_tx_1: component axi_qpsk_tx_bd_axi_qpsk_tx_1_0
     port map (
      axi_qpsk_tx_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      axi_qpsk_tx_s_axi_araddr(6 downto 0) => microblaze_1_axi_periph_M00_AXI_ARADDR(6 downto 0),
      axi_qpsk_tx_s_axi_arready => microblaze_1_axi_periph_M00_AXI_ARREADY,
      axi_qpsk_tx_s_axi_arvalid => microblaze_1_axi_periph_M00_AXI_ARVALID,
      axi_qpsk_tx_s_axi_awaddr(6 downto 0) => microblaze_1_axi_periph_M00_AXI_AWADDR(6 downto 0),
      axi_qpsk_tx_s_axi_awready => microblaze_1_axi_periph_M00_AXI_AWREADY,
      axi_qpsk_tx_s_axi_awvalid => microblaze_1_axi_periph_M00_AXI_AWVALID,
      axi_qpsk_tx_s_axi_bready => microblaze_1_axi_periph_M00_AXI_BREADY,
      axi_qpsk_tx_s_axi_bresp(1 downto 0) => microblaze_1_axi_periph_M00_AXI_BRESP(1 downto 0),
      axi_qpsk_tx_s_axi_bvalid => microblaze_1_axi_periph_M00_AXI_BVALID,
      axi_qpsk_tx_s_axi_rdata(31 downto 0) => microblaze_1_axi_periph_M00_AXI_RDATA(31 downto 0),
      axi_qpsk_tx_s_axi_rready => microblaze_1_axi_periph_M00_AXI_RREADY,
      axi_qpsk_tx_s_axi_rresp(1 downto 0) => microblaze_1_axi_periph_M00_AXI_RRESP(1 downto 0),
      axi_qpsk_tx_s_axi_rvalid => microblaze_1_axi_periph_M00_AXI_RVALID,
      axi_qpsk_tx_s_axi_wdata(31 downto 0) => microblaze_1_axi_periph_M00_AXI_WDATA(31 downto 0),
      axi_qpsk_tx_s_axi_wready => microblaze_1_axi_periph_M00_AXI_WREADY,
      axi_qpsk_tx_s_axi_wstrb(3 downto 0) => microblaze_1_axi_periph_M00_AXI_WSTRB(3 downto 0),
      axi_qpsk_tx_s_axi_wvalid => microblaze_1_axi_periph_M00_AXI_WVALID,
      clk => microblaze_1_Clk,
      m_fft_axis_tdata(31 downto 0) => axi_qpsk_tx_1_m_fft_axis_TDATA(31 downto 0),
      m_fft_axis_tlast(0) => axi_qpsk_tx_1_m_fft_axis_TLAST(0),
      m_fft_axis_tready(0) => axi_qpsk_tx_1_m_fft_axis_TREADY(0),
      m_fft_axis_tvalid(0) => axi_qpsk_tx_1_m_fft_axis_TVALID(0),
      m_rf_axis_tdata(31 downto 0) => axi_qpsk_tx_1_m_rf_axis_TDATA(31 downto 0),
      m_rf_axis_tlast(0) => axi_qpsk_tx_1_m_rf_axis_TLAST(0),
      m_rf_axis_tready(0) => axi_qpsk_tx_1_m_rf_axis_TREADY(0),
      m_rf_axis_tvalid(0) => axi_qpsk_tx_1_m_rf_axis_TVALID(0),
      m_symbol_axis_tdata(7 downto 0) => axi_qpsk_tx_1_m_symbol_axis_TDATA(7 downto 0),
      m_symbol_axis_tlast(0) => axi_qpsk_tx_1_m_symbol_axis_TLAST(0),
      m_symbol_axis_tready(0) => axi_qpsk_tx_1_m_symbol_axis_TREADY(0),
      m_symbol_axis_tvalid(0) => axi_qpsk_tx_1_m_symbol_axis_TVALID(0),
      m_time_axis_tdata(31 downto 0) => axi_qpsk_tx_1_m_time_axis_TDATA(31 downto 0),
      m_time_axis_tlast(0) => axi_qpsk_tx_1_m_time_axis_TLAST(0),
      m_time_axis_tready(0) => axi_qpsk_tx_1_m_time_axis_TREADY(0),
      m_time_axis_tvalid(0) => axi_qpsk_tx_1_m_time_axis_TVALID(0)
    );
clk_wiz_1: component axi_qpsk_tx_bd_clk_wiz_1_0
     port map (
      clk_in1_n => CLK_IN1_D_1_CLK_N,
      clk_in1_p => CLK_IN1_D_1_CLK_P,
      clk_out1 => microblaze_1_Clk,
      locked => clk_wiz_1_locked,
      reset => reset_rtl_1
    );
mdm_1: component axi_qpsk_tx_bd_mdm_1_0
     port map (
      Dbg_Capture_0 => microblaze_1_debug_CAPTURE,
      Dbg_Clk_0 => microblaze_1_debug_CLK,
      Dbg_Disable_0 => microblaze_1_debug_DISABLE,
      Dbg_Reg_En_0(0 to 7) => microblaze_1_debug_REG_EN(0 to 7),
      Dbg_Rst_0 => microblaze_1_debug_RST,
      Dbg_Shift_0 => microblaze_1_debug_SHIFT,
      Dbg_TDI_0 => microblaze_1_debug_TDI,
      Dbg_TDO_0 => microblaze_1_debug_TDO,
      Dbg_Update_0 => microblaze_1_debug_UPDATE,
      Debug_SYS_Rst => mdm_1_debug_sys_rst
    );
microblaze_1: component axi_qpsk_tx_bd_microblaze_1_0
     port map (
      Byte_Enable(0 to 3) => microblaze_1_dlmb_1_BE(0 to 3),
      Clk => microblaze_1_Clk,
      DCE => microblaze_1_dlmb_1_CE,
      DReady => microblaze_1_dlmb_1_READY,
      DUE => microblaze_1_dlmb_1_UE,
      DWait => microblaze_1_dlmb_1_WAIT,
      D_AS => microblaze_1_dlmb_1_ADDRSTROBE,
      Data_Addr(0 to 31) => microblaze_1_dlmb_1_ABUS(0 to 31),
      Data_Read(0 to 31) => microblaze_1_dlmb_1_READDBUS(0 to 31),
      Data_Write(0 to 31) => microblaze_1_dlmb_1_WRITEDBUS(0 to 31),
      Dbg_Capture => microblaze_1_debug_CAPTURE,
      Dbg_Clk => microblaze_1_debug_CLK,
      Dbg_Disable => microblaze_1_debug_DISABLE,
      Dbg_Reg_En(0 to 7) => microblaze_1_debug_REG_EN(0 to 7),
      Dbg_Shift => microblaze_1_debug_SHIFT,
      Dbg_TDI => microblaze_1_debug_TDI,
      Dbg_TDO => microblaze_1_debug_TDO,
      Dbg_Update => microblaze_1_debug_UPDATE,
      Debug_Rst => microblaze_1_debug_RST,
      ICE => microblaze_1_ilmb_1_CE,
      IFetch => microblaze_1_ilmb_1_READSTROBE,
      IReady => microblaze_1_ilmb_1_READY,
      IUE => microblaze_1_ilmb_1_UE,
      IWAIT => microblaze_1_ilmb_1_WAIT,
      I_AS => microblaze_1_ilmb_1_ADDRSTROBE,
      Instr(0 to 31) => microblaze_1_ilmb_1_READDBUS(0 to 31),
      Instr_Addr(0 to 31) => microblaze_1_ilmb_1_ABUS(0 to 31),
      Interrupt => '0',
      Interrupt_Ack(0 to 1) => NLW_microblaze_1_Interrupt_Ack_UNCONNECTED(0 to 1),
      Interrupt_Address(0 to 31) => B"00000000000000000000000000000000",
      M_AXI_DP_ARADDR(31 downto 0) => microblaze_1_axi_dp_ARADDR(31 downto 0),
      M_AXI_DP_ARPROT(2 downto 0) => NLW_microblaze_1_M_AXI_DP_ARPROT_UNCONNECTED(2 downto 0),
      M_AXI_DP_ARREADY => microblaze_1_axi_dp_ARREADY,
      M_AXI_DP_ARVALID => microblaze_1_axi_dp_ARVALID,
      M_AXI_DP_AWADDR(31 downto 0) => microblaze_1_axi_dp_AWADDR(31 downto 0),
      M_AXI_DP_AWPROT(2 downto 0) => NLW_microblaze_1_M_AXI_DP_AWPROT_UNCONNECTED(2 downto 0),
      M_AXI_DP_AWREADY => microblaze_1_axi_dp_AWREADY,
      M_AXI_DP_AWVALID => microblaze_1_axi_dp_AWVALID,
      M_AXI_DP_BREADY => microblaze_1_axi_dp_BREADY,
      M_AXI_DP_BRESP(1 downto 0) => microblaze_1_axi_dp_BRESP(1 downto 0),
      M_AXI_DP_BVALID => microblaze_1_axi_dp_BVALID,
      M_AXI_DP_RDATA(31 downto 0) => microblaze_1_axi_dp_RDATA(31 downto 0),
      M_AXI_DP_RREADY => microblaze_1_axi_dp_RREADY,
      M_AXI_DP_RRESP(1 downto 0) => microblaze_1_axi_dp_RRESP(1 downto 0),
      M_AXI_DP_RVALID => microblaze_1_axi_dp_RVALID,
      M_AXI_DP_WDATA(31 downto 0) => microblaze_1_axi_dp_WDATA(31 downto 0),
      M_AXI_DP_WREADY => microblaze_1_axi_dp_WREADY,
      M_AXI_DP_WSTRB(3 downto 0) => microblaze_1_axi_dp_WSTRB(3 downto 0),
      M_AXI_DP_WVALID => microblaze_1_axi_dp_WVALID,
      Read_Strobe => microblaze_1_dlmb_1_READSTROBE,
      Reset => rst_clk_wiz_1_100M_mb_reset,
      Write_Strobe => microblaze_1_dlmb_1_WRITESTROBE
    );
microblaze_1_axi_periph: entity work.axi_qpsk_tx_bd_microblaze_1_axi_periph_0
     port map (
      ACLK => microblaze_1_Clk,
      ARESETN => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      M00_ACLK => microblaze_1_Clk,
      M00_ARESETN => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      M00_AXI_araddr(31 downto 0) => microblaze_1_axi_periph_M00_AXI_ARADDR(31 downto 0),
      M00_AXI_arready => microblaze_1_axi_periph_M00_AXI_ARREADY,
      M00_AXI_arvalid => microblaze_1_axi_periph_M00_AXI_ARVALID,
      M00_AXI_awaddr(31 downto 0) => microblaze_1_axi_periph_M00_AXI_AWADDR(31 downto 0),
      M00_AXI_awready => microblaze_1_axi_periph_M00_AXI_AWREADY,
      M00_AXI_awvalid => microblaze_1_axi_periph_M00_AXI_AWVALID,
      M00_AXI_bready => microblaze_1_axi_periph_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => microblaze_1_axi_periph_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => microblaze_1_axi_periph_M00_AXI_BVALID,
      M00_AXI_rdata(31 downto 0) => microblaze_1_axi_periph_M00_AXI_RDATA(31 downto 0),
      M00_AXI_rready => microblaze_1_axi_periph_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => microblaze_1_axi_periph_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => microblaze_1_axi_periph_M00_AXI_RVALID,
      M00_AXI_wdata(31 downto 0) => microblaze_1_axi_periph_M00_AXI_WDATA(31 downto 0),
      M00_AXI_wready => microblaze_1_axi_periph_M00_AXI_WREADY,
      M00_AXI_wstrb(3 downto 0) => microblaze_1_axi_periph_M00_AXI_WSTRB(3 downto 0),
      M00_AXI_wvalid => microblaze_1_axi_periph_M00_AXI_WVALID,
      S00_ACLK => microblaze_1_Clk,
      S00_ARESETN => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      S00_AXI_araddr(31 downto 0) => microblaze_1_axi_dp_ARADDR(31 downto 0),
      S00_AXI_arready => microblaze_1_axi_dp_ARREADY,
      S00_AXI_arvalid => microblaze_1_axi_dp_ARVALID,
      S00_AXI_awaddr(31 downto 0) => microblaze_1_axi_dp_AWADDR(31 downto 0),
      S00_AXI_awready => microblaze_1_axi_dp_AWREADY,
      S00_AXI_awvalid => microblaze_1_axi_dp_AWVALID,
      S00_AXI_bready => microblaze_1_axi_dp_BREADY,
      S00_AXI_bresp(1 downto 0) => microblaze_1_axi_dp_BRESP(1 downto 0),
      S00_AXI_bvalid => microblaze_1_axi_dp_BVALID,
      S00_AXI_rdata(31 downto 0) => microblaze_1_axi_dp_RDATA(31 downto 0),
      S00_AXI_rready => microblaze_1_axi_dp_RREADY,
      S00_AXI_rresp(1 downto 0) => microblaze_1_axi_dp_RRESP(1 downto 0),
      S00_AXI_rvalid => microblaze_1_axi_dp_RVALID,
      S00_AXI_wdata(31 downto 0) => microblaze_1_axi_dp_WDATA(31 downto 0),
      S00_AXI_wready => microblaze_1_axi_dp_WREADY,
      S00_AXI_wstrb(3 downto 0) => microblaze_1_axi_dp_WSTRB(3 downto 0),
      S00_AXI_wvalid => microblaze_1_axi_dp_WVALID
    );
microblaze_1_local_memory: entity work.microblaze_1_local_memory_imp_1O1WDD1
     port map (
      DLMB_abus(0 to 31) => microblaze_1_dlmb_1_ABUS(0 to 31),
      DLMB_addrstrobe => microblaze_1_dlmb_1_ADDRSTROBE,
      DLMB_be(0 to 3) => microblaze_1_dlmb_1_BE(0 to 3),
      DLMB_ce => microblaze_1_dlmb_1_CE,
      DLMB_readdbus(0 to 31) => microblaze_1_dlmb_1_READDBUS(0 to 31),
      DLMB_readstrobe => microblaze_1_dlmb_1_READSTROBE,
      DLMB_ready => microblaze_1_dlmb_1_READY,
      DLMB_ue => microblaze_1_dlmb_1_UE,
      DLMB_wait => microblaze_1_dlmb_1_WAIT,
      DLMB_writedbus(0 to 31) => microblaze_1_dlmb_1_WRITEDBUS(0 to 31),
      DLMB_writestrobe => microblaze_1_dlmb_1_WRITESTROBE,
      ILMB_abus(0 to 31) => microblaze_1_ilmb_1_ABUS(0 to 31),
      ILMB_addrstrobe => microblaze_1_ilmb_1_ADDRSTROBE,
      ILMB_ce => microblaze_1_ilmb_1_CE,
      ILMB_readdbus(0 to 31) => microblaze_1_ilmb_1_READDBUS(0 to 31),
      ILMB_readstrobe => microblaze_1_ilmb_1_READSTROBE,
      ILMB_ready => microblaze_1_ilmb_1_READY,
      ILMB_ue => microblaze_1_ilmb_1_UE,
      ILMB_wait => microblaze_1_ilmb_1_WAIT,
      LMB_Clk => microblaze_1_Clk,
      SYS_Rst => rst_clk_wiz_1_100M_bus_struct_reset(0)
    );
rst_clk_wiz_1_100M: component axi_qpsk_tx_bd_rst_clk_wiz_1_100M_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => rst_clk_wiz_1_100M_bus_struct_reset(0),
      dcm_locked => clk_wiz_1_locked,
      ext_reset_in => reset_rtl_1,
      interconnect_aresetn(0) => NLW_rst_clk_wiz_1_100M_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => mdm_1_debug_sys_rst,
      mb_reset => rst_clk_wiz_1_100M_mb_reset,
      peripheral_aresetn(0) => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      peripheral_reset(0) => NLW_rst_clk_wiz_1_100M_peripheral_reset_UNCONNECTED(0),
      slowest_sync_clk => microblaze_1_Clk
    );
end STRUCTURE;
