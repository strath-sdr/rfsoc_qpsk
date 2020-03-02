# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in System Generator. 
#


namespace eval ::xilinx::dsp::planaheaddriver {
	set Compilation {IP Catalog}
	set CompilationFlow {IP}
	set CreateInterfaceDocument {off}
	set DSPDevice {xczu28dr}
	set DSPFamily {zynquplus}
	set DSPPackage {ffvg1517}
	set DSPSpeed {-2-e}
	set FPGAClockPeriod 39.0625
	set GenerateTestBench 0
	set HDLLanguage {vhdl}
	set IPOOCCacheRootPath {/home/josh/.Xilinx/Sysgen/SysgenVivado/lnx64.o/ip}
	set IP_Auto_Infer {1}
	set IP_Categories_Text {System Generator for DSP}
	set IP_Common_Repos {0}
	set IP_Description {}
	set IP_Dir {}
	set IP_Library_Text {SysGen}
	set IP_LifeCycle_Menu {2}
	set IP_Logo {sysgen_icon_100.png}
	set IP_Name {axi_qpsk_rx_dec}
	set IP_Revision {214065219}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {UoS}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {axi_qpsk_rx_dec}
	set ProjectFiles {
		{{conv_pkg.vhd} -lib {xil_defaultlib}}
		{{synth_reg.vhd} -lib {xil_defaultlib}}
		{{synth_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{srl17e.vhd} -lib {xil_defaultlib}}
		{{srl33e.vhd} -lib {xil_defaultlib}}
		{{synth_reg_reg.vhd} -lib {xil_defaultlib}}
		{{single_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{xlclockdriver_rd.vhd} -lib {xil_defaultlib}}
		{{vivado_ip.tcl}}
		{{axi_qpsk_rx_dec_axi_lite_interface_verilog.v}}
		{{conv_pkg.v}}
		{{synth_reg.v}}
		{{synth_reg_w_init.v}}
		{{convert_type.v}}
		{{axi_qpsk_rx_dec.mdd}}
		{{axi_qpsk_rx_dec_hw.h}}
		{{axi_qpsk_rx_dec.h}}
		{{axi_qpsk_rx_dec_sinit.c}}
		{{axi_qpsk_rx_dec.c}}
		{{axi_qpsk_rx_dec_linux.c}}
		{{axi_qpsk_rx_dec.mtcl}}
		{{Makefile.mak}}
		{{index.html}}
		{{axi_qpsk_rx_dec_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{axi_qpsk_rx_dec.vhd} -lib {xil_defaultlib}}
		{{axi_qpsk_rx_dec_clock.xdc}}
		{{axi_qpsk_rx_dec.xdc}}
	}
	set SimPeriod 3.90625e-08
	set SimTime 10
	set SimulationTime {10000000239.06249809 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {/home/josh/git/rfsoc_qpsk/boards/ip/sysgen/iprepo/zcu111/rx/rx_decimation}
	set TopLevelModule {axi_qpsk_rx_dec}
	set TopLevelSimulinkHandle 1390
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface m_axis_tap_tready Name {m_axis_tap_tready}
	dict set TopLevelPortInterface m_axis_tap_tready Type Bool
	dict set TopLevelPortInterface m_axis_tap_tready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_axis_tap_tready BinaryPoint 0
	dict set TopLevelPortInterface m_axis_tap_tready Width 1
	dict set TopLevelPortInterface m_axis_tap_tready DatFile {axi_qpsk_rx_dec_m_axis_tap_m_axis_tap_tready.dat}
	dict set TopLevelPortInterface m_axis_tap_tready IconText {m_axis_tap_tready}
	dict set TopLevelPortInterface m_axis_tap_tready Direction in
	dict set TopLevelPortInterface m_axis_tap_tready Period 1
	dict set TopLevelPortInterface m_axis_tap_tready Interface 0
	dict set TopLevelPortInterface m_axis_tap_tready InterfaceName {}
	dict set TopLevelPortInterface m_axis_tap_tready InterfaceString {DATA}
	dict set TopLevelPortInterface m_axis_tap_tready ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface m_axis_tap_tready Locs {}
	dict set TopLevelPortInterface m_axis_tap_tready IOStandard {}
	dict set TopLevelPortInterface s_q_axis_tvalid Name {s_q_axis_tvalid}
	dict set TopLevelPortInterface s_q_axis_tvalid Type Bool
	dict set TopLevelPortInterface s_q_axis_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface s_q_axis_tvalid BinaryPoint 0
	dict set TopLevelPortInterface s_q_axis_tvalid Width 1
	dict set TopLevelPortInterface s_q_axis_tvalid DatFile {axi_qpsk_rx_dec_s_q_axis_tvalid.dat}
	dict set TopLevelPortInterface s_q_axis_tvalid IconText {s_Q_axis_tvalid}
	dict set TopLevelPortInterface s_q_axis_tvalid Direction in
	dict set TopLevelPortInterface s_q_axis_tvalid Period 1
	dict set TopLevelPortInterface s_q_axis_tvalid Interface 0
	dict set TopLevelPortInterface s_q_axis_tvalid InterfaceName {}
	dict set TopLevelPortInterface s_q_axis_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface s_q_axis_tvalid ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface s_q_axis_tvalid Locs {}
	dict set TopLevelPortInterface s_q_axis_tvalid IOStandard {}
	dict set TopLevelPortInterface s_q_axis_tdata Name {s_q_axis_tdata}
	dict set TopLevelPortInterface s_q_axis_tdata Type Fix_16_14
	dict set TopLevelPortInterface s_q_axis_tdata ArithmeticType xlSigned
	dict set TopLevelPortInterface s_q_axis_tdata BinaryPoint 14
	dict set TopLevelPortInterface s_q_axis_tdata Width 16
	dict set TopLevelPortInterface s_q_axis_tdata DatFile {axi_qpsk_rx_dec_s_q_axis_tdata.dat}
	dict set TopLevelPortInterface s_q_axis_tdata IconText {s_Q_axis_tdata}
	dict set TopLevelPortInterface s_q_axis_tdata Direction in
	dict set TopLevelPortInterface s_q_axis_tdata Period 1
	dict set TopLevelPortInterface s_q_axis_tdata Interface 0
	dict set TopLevelPortInterface s_q_axis_tdata InterfaceName {}
	dict set TopLevelPortInterface s_q_axis_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface s_q_axis_tdata ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface s_q_axis_tdata Locs {}
	dict set TopLevelPortInterface s_q_axis_tdata IOStandard {}
	dict set TopLevelPortInterface s_i_axis_tvalid Name {s_i_axis_tvalid}
	dict set TopLevelPortInterface s_i_axis_tvalid Type Bool
	dict set TopLevelPortInterface s_i_axis_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface s_i_axis_tvalid BinaryPoint 0
	dict set TopLevelPortInterface s_i_axis_tvalid Width 1
	dict set TopLevelPortInterface s_i_axis_tvalid DatFile {axi_qpsk_rx_dec_s_i_axis_tvalid.dat}
	dict set TopLevelPortInterface s_i_axis_tvalid IconText {s_I_axis_tvalid}
	dict set TopLevelPortInterface s_i_axis_tvalid Direction in
	dict set TopLevelPortInterface s_i_axis_tvalid Period 1
	dict set TopLevelPortInterface s_i_axis_tvalid Interface 0
	dict set TopLevelPortInterface s_i_axis_tvalid InterfaceName {}
	dict set TopLevelPortInterface s_i_axis_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface s_i_axis_tvalid ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface s_i_axis_tvalid Locs {}
	dict set TopLevelPortInterface s_i_axis_tvalid IOStandard {}
	dict set TopLevelPortInterface s_i_axis_tdata Name {s_i_axis_tdata}
	dict set TopLevelPortInterface s_i_axis_tdata Type Fix_16_14
	dict set TopLevelPortInterface s_i_axis_tdata ArithmeticType xlSigned
	dict set TopLevelPortInterface s_i_axis_tdata BinaryPoint 14
	dict set TopLevelPortInterface s_i_axis_tdata Width 16
	dict set TopLevelPortInterface s_i_axis_tdata DatFile {axi_qpsk_rx_dec_s_i_axis_tdata.dat}
	dict set TopLevelPortInterface s_i_axis_tdata IconText {s_I_axis_tdata}
	dict set TopLevelPortInterface s_i_axis_tdata Direction in
	dict set TopLevelPortInterface s_i_axis_tdata Period 1
	dict set TopLevelPortInterface s_i_axis_tdata Interface 0
	dict set TopLevelPortInterface s_i_axis_tdata InterfaceName {}
	dict set TopLevelPortInterface s_i_axis_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface s_i_axis_tdata ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface s_i_axis_tdata Locs {}
	dict set TopLevelPortInterface s_i_axis_tdata IOStandard {}
	dict set TopLevelPortInterface s_i_axis_tready Name {s_i_axis_tready}
	dict set TopLevelPortInterface s_i_axis_tready Type Bool
	dict set TopLevelPortInterface s_i_axis_tready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface s_i_axis_tready BinaryPoint 0
	dict set TopLevelPortInterface s_i_axis_tready Width 1
	dict set TopLevelPortInterface s_i_axis_tready DatFile {axi_qpsk_rx_dec_s_i_axis_tready.dat}
	dict set TopLevelPortInterface s_i_axis_tready IconText {s_I_axis_tready}
	dict set TopLevelPortInterface s_i_axis_tready Direction out
	dict set TopLevelPortInterface s_i_axis_tready Period 1
	dict set TopLevelPortInterface s_i_axis_tready Interface 0
	dict set TopLevelPortInterface s_i_axis_tready InterfaceName {}
	dict set TopLevelPortInterface s_i_axis_tready InterfaceString {DATA}
	dict set TopLevelPortInterface s_i_axis_tready ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface s_i_axis_tready Locs {}
	dict set TopLevelPortInterface s_i_axis_tready IOStandard {}
	dict set TopLevelPortInterface s_q_axis_tready Name {s_q_axis_tready}
	dict set TopLevelPortInterface s_q_axis_tready Type Bool
	dict set TopLevelPortInterface s_q_axis_tready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface s_q_axis_tready BinaryPoint 0
	dict set TopLevelPortInterface s_q_axis_tready Width 1
	dict set TopLevelPortInterface s_q_axis_tready DatFile {axi_qpsk_rx_dec_s_q_axis_tready.dat}
	dict set TopLevelPortInterface s_q_axis_tready IconText {s_Q_axis_tready}
	dict set TopLevelPortInterface s_q_axis_tready Direction out
	dict set TopLevelPortInterface s_q_axis_tready Period 1
	dict set TopLevelPortInterface s_q_axis_tready Interface 0
	dict set TopLevelPortInterface s_q_axis_tready InterfaceName {}
	dict set TopLevelPortInterface s_q_axis_tready InterfaceString {DATA}
	dict set TopLevelPortInterface s_q_axis_tready ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface s_q_axis_tready Locs {}
	dict set TopLevelPortInterface s_q_axis_tready IOStandard {}
	dict set TopLevelPortInterface m_axis_tdata Name {m_axis_tdata}
	dict set TopLevelPortInterface m_axis_tdata Type UFix_32_0
	dict set TopLevelPortInterface m_axis_tdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_axis_tdata BinaryPoint 0
	dict set TopLevelPortInterface m_axis_tdata Width 32
	dict set TopLevelPortInterface m_axis_tdata DatFile {axi_qpsk_rx_dec_m_axis_decimation_m_axis_tdata.dat}
	dict set TopLevelPortInterface m_axis_tdata IconText {m_axis_tdata}
	dict set TopLevelPortInterface m_axis_tdata Direction out
	dict set TopLevelPortInterface m_axis_tdata Period 6400
	dict set TopLevelPortInterface m_axis_tdata Interface 0
	dict set TopLevelPortInterface m_axis_tdata InterfaceName {}
	dict set TopLevelPortInterface m_axis_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface m_axis_tdata ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface m_axis_tdata Locs {}
	dict set TopLevelPortInterface m_axis_tdata IOStandard {}
	dict set TopLevelPortInterface m_axis_tvalid Name {m_axis_tvalid}
	dict set TopLevelPortInterface m_axis_tvalid Type Bool
	dict set TopLevelPortInterface m_axis_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_axis_tvalid BinaryPoint 0
	dict set TopLevelPortInterface m_axis_tvalid Width 1
	dict set TopLevelPortInterface m_axis_tvalid DatFile {axi_qpsk_rx_dec_m_axis_decimation_m_axis_tvalid.dat}
	dict set TopLevelPortInterface m_axis_tvalid IconText {m_axis_tvalid}
	dict set TopLevelPortInterface m_axis_tvalid Direction out
	dict set TopLevelPortInterface m_axis_tvalid Period 6400
	dict set TopLevelPortInterface m_axis_tvalid Interface 0
	dict set TopLevelPortInterface m_axis_tvalid InterfaceName {}
	dict set TopLevelPortInterface m_axis_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface m_axis_tvalid ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface m_axis_tvalid Locs {}
	dict set TopLevelPortInterface m_axis_tvalid IOStandard {}
	dict set TopLevelPortInterface m_axis_tap_tdata Name {m_axis_tap_tdata}
	dict set TopLevelPortInterface m_axis_tap_tdata Type UFix_32_0
	dict set TopLevelPortInterface m_axis_tap_tdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_axis_tap_tdata BinaryPoint 0
	dict set TopLevelPortInterface m_axis_tap_tdata Width 32
	dict set TopLevelPortInterface m_axis_tap_tdata DatFile {axi_qpsk_rx_dec_m_axis_tap_m_axis_tap_tdata.dat}
	dict set TopLevelPortInterface m_axis_tap_tdata IconText {m_axis_tap_tdata}
	dict set TopLevelPortInterface m_axis_tap_tdata Direction out
	dict set TopLevelPortInterface m_axis_tap_tdata Period 1
	dict set TopLevelPortInterface m_axis_tap_tdata Interface 0
	dict set TopLevelPortInterface m_axis_tap_tdata InterfaceName {}
	dict set TopLevelPortInterface m_axis_tap_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface m_axis_tap_tdata ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface m_axis_tap_tdata Locs {}
	dict set TopLevelPortInterface m_axis_tap_tdata IOStandard {}
	dict set TopLevelPortInterface m_axis_tap_tlast Name {m_axis_tap_tlast}
	dict set TopLevelPortInterface m_axis_tap_tlast Type Bool
	dict set TopLevelPortInterface m_axis_tap_tlast ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_axis_tap_tlast BinaryPoint 0
	dict set TopLevelPortInterface m_axis_tap_tlast Width 1
	dict set TopLevelPortInterface m_axis_tap_tlast DatFile {axi_qpsk_rx_dec_m_axis_tap_m_axis_tap_tlast.dat}
	dict set TopLevelPortInterface m_axis_tap_tlast IconText {m_axis_tap_tlast}
	dict set TopLevelPortInterface m_axis_tap_tlast Direction out
	dict set TopLevelPortInterface m_axis_tap_tlast Period 1
	dict set TopLevelPortInterface m_axis_tap_tlast Interface 0
	dict set TopLevelPortInterface m_axis_tap_tlast InterfaceName {}
	dict set TopLevelPortInterface m_axis_tap_tlast InterfaceString {DATA}
	dict set TopLevelPortInterface m_axis_tap_tlast ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface m_axis_tap_tlast Locs {}
	dict set TopLevelPortInterface m_axis_tap_tlast IOStandard {}
	dict set TopLevelPortInterface m_axis_tap_tvalid Name {m_axis_tap_tvalid}
	dict set TopLevelPortInterface m_axis_tap_tvalid Type Bool
	dict set TopLevelPortInterface m_axis_tap_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_axis_tap_tvalid BinaryPoint 0
	dict set TopLevelPortInterface m_axis_tap_tvalid Width 1
	dict set TopLevelPortInterface m_axis_tap_tvalid DatFile {axi_qpsk_rx_dec_m_axis_tap_m_axis_tap_tvalid.dat}
	dict set TopLevelPortInterface m_axis_tap_tvalid IconText {m_axis_tap_tvalid}
	dict set TopLevelPortInterface m_axis_tap_tvalid Direction out
	dict set TopLevelPortInterface m_axis_tap_tvalid Period 1
	dict set TopLevelPortInterface m_axis_tap_tvalid Interface 0
	dict set TopLevelPortInterface m_axis_tap_tvalid InterfaceName {}
	dict set TopLevelPortInterface m_axis_tap_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface m_axis_tap_tvalid ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface m_axis_tap_tvalid Locs {}
	dict set TopLevelPortInterface m_axis_tap_tvalid IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn Name {axi_qpsk_rx_dec_aresetn}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn IconText {axi_qpsk_rx_dec_aresetn}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn Interface 8
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn InterfaceString {ARESETN}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_aresetn IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr Name {axi_qpsk_rx_dec_s_axi_awaddr}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr Width 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr IconText {axi_qpsk_rx_dec_s_axi_awaddr}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awaddr IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid Name {axi_qpsk_rx_dec_s_axi_awvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid IconText {axi_qpsk_rx_dec_s_axi_awvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awvalid IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready Name {axi_qpsk_rx_dec_s_axi_awready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready IconText {axi_qpsk_rx_dec_s_axi_awready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_awready IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata Name {axi_qpsk_rx_dec_s_axi_wdata}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata Width 32
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata IconText {axi_qpsk_rx_dec_s_axi_wdata}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wdata IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb Name {axi_qpsk_rx_dec_s_axi_wstrb}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb Width 4
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb IconText {axi_qpsk_rx_dec_s_axi_wstrb}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wstrb IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid Name {axi_qpsk_rx_dec_s_axi_wvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid IconText {axi_qpsk_rx_dec_s_axi_wvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wvalid IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready Name {axi_qpsk_rx_dec_s_axi_wready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready IconText {axi_qpsk_rx_dec_s_axi_wready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_wready IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp Name {axi_qpsk_rx_dec_s_axi_bresp}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp Width 2
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp IconText {axi_qpsk_rx_dec_s_axi_bresp}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bresp IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid Name {axi_qpsk_rx_dec_s_axi_bvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid IconText {axi_qpsk_rx_dec_s_axi_bvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bvalid IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready Name {axi_qpsk_rx_dec_s_axi_bready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready IconText {axi_qpsk_rx_dec_s_axi_bready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_bready IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr Name {axi_qpsk_rx_dec_s_axi_araddr}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr Width 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr IconText {axi_qpsk_rx_dec_s_axi_araddr}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_araddr IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid Name {axi_qpsk_rx_dec_s_axi_arvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid IconText {axi_qpsk_rx_dec_s_axi_arvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arvalid IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready Name {axi_qpsk_rx_dec_s_axi_arready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready IconText {axi_qpsk_rx_dec_s_axi_arready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_arready IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata Name {axi_qpsk_rx_dec_s_axi_rdata}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata Width 32
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata IconText {axi_qpsk_rx_dec_s_axi_rdata}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rdata IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp Name {axi_qpsk_rx_dec_s_axi_rresp}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp Width 2
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp IconText {axi_qpsk_rx_dec_s_axi_rresp}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rresp IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid Name {axi_qpsk_rx_dec_s_axi_rvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid IconText {axi_qpsk_rx_dec_s_axi_rvalid}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid Direction out
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rvalid IOStandard {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready Name {axi_qpsk_rx_dec_s_axi_rready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready Type -
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready BinaryPoint 0
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready Width 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready DatFile {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready IconText {axi_qpsk_rx_dec_s_axi_rready}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready Direction in
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready Period 1
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready Interface 5
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready InterfaceName {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready ClockDomain {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready Locs {}
	dict set TopLevelPortInterface axi_qpsk_rx_dec_s_axi_rready IOStandard {}
	dict set TopLevelPortInterface clk Name {clk}
	dict set TopLevelPortInterface clk Type -
	dict set TopLevelPortInterface clk ArithmeticType xlUnsigned
	dict set TopLevelPortInterface clk BinaryPoint 0
	dict set TopLevelPortInterface clk Width 1
	dict set TopLevelPortInterface clk DatFile {}
	dict set TopLevelPortInterface clk Direction in
	dict set TopLevelPortInterface clk Period 1
	dict set TopLevelPortInterface clk Interface 6
	dict set TopLevelPortInterface clk InterfaceName {}
	dict set TopLevelPortInterface clk InterfaceString {CLOCK}
	dict set TopLevelPortInterface clk ClockDomain {axi_qpsk_rx_dec}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {axi_qpsk_rx_dec_s_axi }
	dict set TopLevelPortInterface clk AssociatedResets {axi_qpsk_rx_dec_aresetn }
	set MemoryMappedPort {}
	dict set MemoryMappedPort transfer Name {transfer}
	dict set MemoryMappedPort transfer Type UFix_32_0
	dict set MemoryMappedPort transfer ArithmeticType xlUnsigned
	dict set MemoryMappedPort transfer BinaryPoint 0
	dict set MemoryMappedPort transfer Width 32
	dict set MemoryMappedPort transfer DatFile {axi_qpsk_rx_dec_transfer.dat}
	dict set MemoryMappedPort transfer AddressOffset 16
	dict set MemoryMappedPort transfer IconText {transfer}
	dict set MemoryMappedPort transfer Direction in
	dict set MemoryMappedPort transfer Period 1
	dict set MemoryMappedPort transfer Interface 2
	dict set MemoryMappedPort transfer InterfaceName {}
	dict set MemoryMappedPort transfer InterfaceString {CONTROL}
	dict set MemoryMappedPort transfer ClockDomain {axi_qpsk_rx_dec}
	dict set MemoryMappedPort transfer Locs {}
	dict set MemoryMappedPort transfer IOStandard {}
	dict set MemoryMappedPort auto_restart Name {auto_restart}
	dict set MemoryMappedPort auto_restart Type UFix_32_0
	dict set MemoryMappedPort auto_restart ArithmeticType xlUnsigned
	dict set MemoryMappedPort auto_restart BinaryPoint 0
	dict set MemoryMappedPort auto_restart Width 32
	dict set MemoryMappedPort auto_restart DatFile {axi_qpsk_rx_dec_auto_restart.dat}
	dict set MemoryMappedPort auto_restart AddressOffset 12
	dict set MemoryMappedPort auto_restart IconText {auto_restart}
	dict set MemoryMappedPort auto_restart Direction in
	dict set MemoryMappedPort auto_restart Period 1
	dict set MemoryMappedPort auto_restart Interface 2
	dict set MemoryMappedPort auto_restart InterfaceName {}
	dict set MemoryMappedPort auto_restart InterfaceString {CONTROL}
	dict set MemoryMappedPort auto_restart ClockDomain {axi_qpsk_rx_dec}
	dict set MemoryMappedPort auto_restart Locs {}
	dict set MemoryMappedPort auto_restart IOStandard {}
	dict set MemoryMappedPort rxreset Name {rxreset}
	dict set MemoryMappedPort rxreset Type UFix_32_0
	dict set MemoryMappedPort rxreset ArithmeticType xlUnsigned
	dict set MemoryMappedPort rxreset BinaryPoint 0
	dict set MemoryMappedPort rxreset Width 32
	dict set MemoryMappedPort rxreset DatFile {axi_qpsk_rx_dec_rxreset.dat}
	dict set MemoryMappedPort rxreset AddressOffset 0
	dict set MemoryMappedPort rxreset IconText {RxReset}
	dict set MemoryMappedPort rxreset Direction in
	dict set MemoryMappedPort rxreset Period 1
	dict set MemoryMappedPort rxreset Interface 2
	dict set MemoryMappedPort rxreset InterfaceName {}
	dict set MemoryMappedPort rxreset InterfaceString {CONTROL}
	dict set MemoryMappedPort rxreset ClockDomain {axi_qpsk_rx_dec}
	dict set MemoryMappedPort rxreset Locs {}
	dict set MemoryMappedPort rxreset IOStandard {}
	dict set MemoryMappedPort packetsizerf Name {packetsizerf}
	dict set MemoryMappedPort packetsizerf Type UFix_32_0
	dict set MemoryMappedPort packetsizerf ArithmeticType xlUnsigned
	dict set MemoryMappedPort packetsizerf BinaryPoint 0
	dict set MemoryMappedPort packetsizerf Width 32
	dict set MemoryMappedPort packetsizerf DatFile {axi_qpsk_rx_dec_packetsizerf.dat}
	dict set MemoryMappedPort packetsizerf AddressOffset 4
	dict set MemoryMappedPort packetsizerf IconText {PacketSizeRF}
	dict set MemoryMappedPort packetsizerf Direction in
	dict set MemoryMappedPort packetsizerf Period 1
	dict set MemoryMappedPort packetsizerf Interface 2
	dict set MemoryMappedPort packetsizerf InterfaceName {}
	dict set MemoryMappedPort packetsizerf InterfaceString {CONTROL}
	dict set MemoryMappedPort packetsizerf ClockDomain {axi_qpsk_rx_dec}
	dict set MemoryMappedPort packetsizerf Locs {}
	dict set MemoryMappedPort packetsizerf IOStandard {}
	dict set MemoryMappedPort enable Name {enable}
	dict set MemoryMappedPort enable Type UFix_32_0
	dict set MemoryMappedPort enable ArithmeticType xlUnsigned
	dict set MemoryMappedPort enable BinaryPoint 0
	dict set MemoryMappedPort enable Width 32
	dict set MemoryMappedPort enable DatFile {axi_qpsk_rx_dec_enable.dat}
	dict set MemoryMappedPort enable AddressOffset 8
	dict set MemoryMappedPort enable IconText {Enable}
	dict set MemoryMappedPort enable Direction in
	dict set MemoryMappedPort enable Period 1
	dict set MemoryMappedPort enable Interface 2
	dict set MemoryMappedPort enable InterfaceName {}
	dict set MemoryMappedPort enable InterfaceString {CONTROL}
	dict set MemoryMappedPort enable ClockDomain {axi_qpsk_rx_dec}
	dict set MemoryMappedPort enable Locs {}
	dict set MemoryMappedPort enable IOStandard {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project