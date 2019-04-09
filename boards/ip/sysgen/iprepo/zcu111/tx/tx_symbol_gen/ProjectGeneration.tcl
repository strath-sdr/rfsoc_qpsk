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
	set IPOOCCacheRootPath {C:/Users/jgoldsmi/AppData/Local/Xilinx/Sysgen/SysgenVivado/win64.o/ip}
	set IP_Auto_Infer {1}
	set IP_Categories_Text {System_Generator_for_DSP}
	set IP_Common_Repos {0}
	set IP_Description {}
	set IP_Dir {}
	set IP_Library_Text {SysGen}
	set IP_LifeCycle_Menu {2}
	set IP_Logo {sysgen_icon_100.png}
	set IP_Name {}
	set IP_Revision {185643067}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {User_Company}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {qpsk_tx_symbol_gen}
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
		{{qpsk_tx_symbol_gen_axi_lite_interface_verilog.v}}
		{{conv_pkg.v}}
		{{synth_reg.v}}
		{{synth_reg_w_init.v}}
		{{convert_type.v}}
		{{qpsk_tx_symbol_gen.mdd}}
		{{qpsk_tx_symbol_gen_hw.h}}
		{{qpsk_tx_symbol_gen.h}}
		{{qpsk_tx_symbol_gen_sinit.c}}
		{{qpsk_tx_symbol_gen.c}}
		{{qpsk_tx_symbol_gen_linux.c}}
		{{qpsk_tx_symbol_gen.mtcl}}
		{{Makefile.mak}}
		{{index.html}}
		{{qpsk_tx_symbol_gen_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{qpsk_tx_symbol_gen.vhd} -lib {xil_defaultlib}}
		{{qpsk_tx_symbol_gen_clock.xdc}}
		{{qpsk_tx_symbol_gen.xdc}}
	}
	set SimPeriod 3.90625e-08
	set SimTime 0.2
	set SimulationTime {200000239.06250000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {Y:/git/rfsoc_qpsk/boards/ip/sysgen/iprepo/zcu111/tx/tx_symbol_gen}
	set TopLevelModule {qpsk_tx_symbol_gen}
	set TopLevelSimulinkHandle 4230
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface m_symbol_axis_tready Name {m_symbol_axis_tready}
	dict set TopLevelPortInterface m_symbol_axis_tready Type Bool
	dict set TopLevelPortInterface m_symbol_axis_tready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_symbol_axis_tready BinaryPoint 0
	dict set TopLevelPortInterface m_symbol_axis_tready Width 1
	dict set TopLevelPortInterface m_symbol_axis_tready DatFile {qpsk_tx_symbol_gen_m_axis_symbol_m_symbol_axis_tready.dat}
	dict set TopLevelPortInterface m_symbol_axis_tready IconText {m_symbol_axis_tready}
	dict set TopLevelPortInterface m_symbol_axis_tready Direction in
	dict set TopLevelPortInterface m_symbol_axis_tready Period 1
	dict set TopLevelPortInterface m_symbol_axis_tready Interface 0
	dict set TopLevelPortInterface m_symbol_axis_tready InterfaceName {}
	dict set TopLevelPortInterface m_symbol_axis_tready InterfaceString {DATA}
	dict set TopLevelPortInterface m_symbol_axis_tready ClockDomain {qpsk_tx_symbol_gen}
	dict set TopLevelPortInterface m_symbol_axis_tready Locs {}
	dict set TopLevelPortInterface m_symbol_axis_tready IOStandard {}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 Name {m_symbol_axis_tdata_x0}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 Type UFix_8_0
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 BinaryPoint 0
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 Width 8
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 DatFile {qpsk_tx_symbol_gen_m_axis_symbol_m_symbol_axis_tdata.dat}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 IconText {qpsk_tx_symbol_gen/M_AXIS_SYMBOL/m_symbol_axis_tdata}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 Direction out
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 Period 1
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 Interface 0
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 InterfaceName {}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 InterfaceString {DATA}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 ClockDomain {qpsk_tx_symbol_gen}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 Locs {}
	dict set TopLevelPortInterface m_symbol_axis_tdata_x0 IOStandard {}
	dict set TopLevelPortInterface m_symbol_axis_tlast Name {m_symbol_axis_tlast}
	dict set TopLevelPortInterface m_symbol_axis_tlast Type Bool
	dict set TopLevelPortInterface m_symbol_axis_tlast ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_symbol_axis_tlast BinaryPoint 0
	dict set TopLevelPortInterface m_symbol_axis_tlast Width 1
	dict set TopLevelPortInterface m_symbol_axis_tlast DatFile {qpsk_tx_symbol_gen_m_axis_symbol_m_symbol_axis_tlast.dat}
	dict set TopLevelPortInterface m_symbol_axis_tlast IconText {m_symbol_axis_tlast}
	dict set TopLevelPortInterface m_symbol_axis_tlast Direction out
	dict set TopLevelPortInterface m_symbol_axis_tlast Period 1
	dict set TopLevelPortInterface m_symbol_axis_tlast Interface 0
	dict set TopLevelPortInterface m_symbol_axis_tlast InterfaceName {}
	dict set TopLevelPortInterface m_symbol_axis_tlast InterfaceString {DATA}
	dict set TopLevelPortInterface m_symbol_axis_tlast ClockDomain {qpsk_tx_symbol_gen}
	dict set TopLevelPortInterface m_symbol_axis_tlast Locs {}
	dict set TopLevelPortInterface m_symbol_axis_tlast IOStandard {}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 Name {m_symbol_axis_tvalid_x0}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 Type Bool
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 BinaryPoint 0
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 Width 1
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 DatFile {qpsk_tx_symbol_gen_m_axis_symbol_m_symbol_axis_tvalid.dat}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 IconText {qpsk_tx_symbol_gen/M_AXIS_SYMBOL/m_symbol_axis_tvalid}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 Direction out
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 Period 1
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 Interface 0
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 InterfaceName {}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 InterfaceString {DATA}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 ClockDomain {qpsk_tx_symbol_gen}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 Locs {}
	dict set TopLevelPortInterface m_symbol_axis_tvalid_x0 IOStandard {}
	dict set TopLevelPortInterface m_symbol_axis_tdata Name {m_symbol_axis_tdata}
	dict set TopLevelPortInterface m_symbol_axis_tdata Type UFix_8_0
	dict set TopLevelPortInterface m_symbol_axis_tdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_symbol_axis_tdata BinaryPoint 0
	dict set TopLevelPortInterface m_symbol_axis_tdata Width 8
	dict set TopLevelPortInterface m_symbol_axis_tdata DatFile {qpsk_tx_symbol_gen_m_axis_symbol1_m_symbol_axis_tdata.dat}
	dict set TopLevelPortInterface m_symbol_axis_tdata IconText {qpsk_tx_symbol_gen/M_AXIS_SYMBOL1/m_symbol_axis_tdata}
	dict set TopLevelPortInterface m_symbol_axis_tdata Direction out
	dict set TopLevelPortInterface m_symbol_axis_tdata Period 51200
	dict set TopLevelPortInterface m_symbol_axis_tdata Interface 0
	dict set TopLevelPortInterface m_symbol_axis_tdata InterfaceName {}
	dict set TopLevelPortInterface m_symbol_axis_tdata InterfaceString {DATA}
	dict set TopLevelPortInterface m_symbol_axis_tdata ClockDomain {qpsk_tx_symbol_gen}
	dict set TopLevelPortInterface m_symbol_axis_tdata Locs {}
	dict set TopLevelPortInterface m_symbol_axis_tdata IOStandard {}
	dict set TopLevelPortInterface m_symbol_axis_tvalid Name {m_symbol_axis_tvalid}
	dict set TopLevelPortInterface m_symbol_axis_tvalid Type Bool
	dict set TopLevelPortInterface m_symbol_axis_tvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface m_symbol_axis_tvalid BinaryPoint 0
	dict set TopLevelPortInterface m_symbol_axis_tvalid Width 1
	dict set TopLevelPortInterface m_symbol_axis_tvalid DatFile {qpsk_tx_symbol_gen_m_axis_symbol1_m_symbol_axis_tvalid.dat}
	dict set TopLevelPortInterface m_symbol_axis_tvalid IconText {qpsk_tx_symbol_gen/M_AXIS_SYMBOL1/m_symbol_axis_tvalid}
	dict set TopLevelPortInterface m_symbol_axis_tvalid Direction out
	dict set TopLevelPortInterface m_symbol_axis_tvalid Period 51200
	dict set TopLevelPortInterface m_symbol_axis_tvalid Interface 0
	dict set TopLevelPortInterface m_symbol_axis_tvalid InterfaceName {}
	dict set TopLevelPortInterface m_symbol_axis_tvalid InterfaceString {DATA}
	dict set TopLevelPortInterface m_symbol_axis_tvalid ClockDomain {qpsk_tx_symbol_gen}
	dict set TopLevelPortInterface m_symbol_axis_tvalid Locs {}
	dict set TopLevelPortInterface m_symbol_axis_tvalid IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn Name {qpsk_tx_symbol_gen_aresetn}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn IconText {qpsk_tx_symbol_gen_aresetn}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn Interface 8
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn InterfaceString {ARESETN}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_aresetn IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr Name {qpsk_tx_symbol_gen_s_axi_awaddr}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr Width 6
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr IconText {qpsk_tx_symbol_gen_s_axi_awaddr}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awaddr IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid Name {qpsk_tx_symbol_gen_s_axi_awvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid IconText {qpsk_tx_symbol_gen_s_axi_awvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awvalid IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready Name {qpsk_tx_symbol_gen_s_axi_awready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready IconText {qpsk_tx_symbol_gen_s_axi_awready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_awready IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata Name {qpsk_tx_symbol_gen_s_axi_wdata}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata Width 32
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata IconText {qpsk_tx_symbol_gen_s_axi_wdata}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wdata IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb Name {qpsk_tx_symbol_gen_s_axi_wstrb}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb Width 4
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb IconText {qpsk_tx_symbol_gen_s_axi_wstrb}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wstrb IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid Name {qpsk_tx_symbol_gen_s_axi_wvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid IconText {qpsk_tx_symbol_gen_s_axi_wvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wvalid IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready Name {qpsk_tx_symbol_gen_s_axi_wready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready IconText {qpsk_tx_symbol_gen_s_axi_wready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_wready IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp Name {qpsk_tx_symbol_gen_s_axi_bresp}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp Width 2
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp IconText {qpsk_tx_symbol_gen_s_axi_bresp}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bresp IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid Name {qpsk_tx_symbol_gen_s_axi_bvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid IconText {qpsk_tx_symbol_gen_s_axi_bvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bvalid IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready Name {qpsk_tx_symbol_gen_s_axi_bready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready IconText {qpsk_tx_symbol_gen_s_axi_bready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_bready IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr Name {qpsk_tx_symbol_gen_s_axi_araddr}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr Width 6
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr IconText {qpsk_tx_symbol_gen_s_axi_araddr}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_araddr IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid Name {qpsk_tx_symbol_gen_s_axi_arvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid IconText {qpsk_tx_symbol_gen_s_axi_arvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arvalid IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready Name {qpsk_tx_symbol_gen_s_axi_arready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready IconText {qpsk_tx_symbol_gen_s_axi_arready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_arready IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata Name {qpsk_tx_symbol_gen_s_axi_rdata}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata Width 32
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata IconText {qpsk_tx_symbol_gen_s_axi_rdata}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rdata IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp Name {qpsk_tx_symbol_gen_s_axi_rresp}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp Width 2
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp IconText {qpsk_tx_symbol_gen_s_axi_rresp}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rresp IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid Name {qpsk_tx_symbol_gen_s_axi_rvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid IconText {qpsk_tx_symbol_gen_s_axi_rvalid}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid Direction out
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rvalid IOStandard {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready Name {qpsk_tx_symbol_gen_s_axi_rready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready Type -
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready ArithmeticType xlUnsigned
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready BinaryPoint 0
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready Width 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready DatFile {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready IconText {qpsk_tx_symbol_gen_s_axi_rready}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready Direction in
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready Period 1
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready Interface 5
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready InterfaceName {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready InterfaceString {WIRE_AXI_LITE}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready ClockDomain {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready Locs {}
	dict set TopLevelPortInterface qpsk_tx_symbol_gen_s_axi_rready IOStandard {}
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
	dict set TopLevelPortInterface clk ClockDomain {qpsk_tx_symbol_gen}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {qpsk_tx_symbol_gen_s_axi }
	dict set TopLevelPortInterface clk AssociatedResets {qpsk_tx_symbol_gen_aresetn }
	set MemoryMappedPort {}
	dict set MemoryMappedPort transfersymbol Name {transfersymbol}
	dict set MemoryMappedPort transfersymbol Type UFix_32_0
	dict set MemoryMappedPort transfersymbol ArithmeticType xlUnsigned
	dict set MemoryMappedPort transfersymbol BinaryPoint 0
	dict set MemoryMappedPort transfersymbol Width 32
	dict set MemoryMappedPort transfersymbol DatFile {qpsk_tx_symbol_gen_ctrl_transfersymbol.dat}
	dict set MemoryMappedPort transfersymbol AddressOffset 0
	dict set MemoryMappedPort transfersymbol IconText {TransferSymbol}
	dict set MemoryMappedPort transfersymbol Direction in
	dict set MemoryMappedPort transfersymbol Period 1
	dict set MemoryMappedPort transfersymbol Interface 2
	dict set MemoryMappedPort transfersymbol InterfaceName {}
	dict set MemoryMappedPort transfersymbol InterfaceString {CONTROL}
	dict set MemoryMappedPort transfersymbol ClockDomain {qpsk_tx_symbol_gen}
	dict set MemoryMappedPort transfersymbol Locs {}
	dict set MemoryMappedPort transfersymbol IOStandard {}
	dict set MemoryMappedPort resetsymbol Name {resetsymbol}
	dict set MemoryMappedPort resetsymbol Type UFix_32_0
	dict set MemoryMappedPort resetsymbol ArithmeticType xlUnsigned
	dict set MemoryMappedPort resetsymbol BinaryPoint 0
	dict set MemoryMappedPort resetsymbol Width 32
	dict set MemoryMappedPort resetsymbol DatFile {qpsk_tx_symbol_gen_ctrl_resetsymbol.dat}
	dict set MemoryMappedPort resetsymbol AddressOffset 8
	dict set MemoryMappedPort resetsymbol IconText {ResetSymbol}
	dict set MemoryMappedPort resetsymbol Direction in
	dict set MemoryMappedPort resetsymbol Period 1
	dict set MemoryMappedPort resetsymbol Interface 2
	dict set MemoryMappedPort resetsymbol InterfaceName {}
	dict set MemoryMappedPort resetsymbol InterfaceString {CONTROL}
	dict set MemoryMappedPort resetsymbol ClockDomain {qpsk_tx_symbol_gen}
	dict set MemoryMappedPort resetsymbol Locs {}
	dict set MemoryMappedPort resetsymbol IOStandard {}
	dict set MemoryMappedPort packetsizesymbol Name {packetsizesymbol}
	dict set MemoryMappedPort packetsizesymbol Type UFix_32_0
	dict set MemoryMappedPort packetsizesymbol ArithmeticType xlUnsigned
	dict set MemoryMappedPort packetsizesymbol BinaryPoint 0
	dict set MemoryMappedPort packetsizesymbol Width 32
	dict set MemoryMappedPort packetsizesymbol DatFile {qpsk_tx_symbol_gen_ctrl_packetsizesymbol.dat}
	dict set MemoryMappedPort packetsizesymbol AddressOffset 16
	dict set MemoryMappedPort packetsizesymbol IconText {PacketSizeSymbol}
	dict set MemoryMappedPort packetsizesymbol Direction in
	dict set MemoryMappedPort packetsizesymbol Period 1
	dict set MemoryMappedPort packetsizesymbol Interface 2
	dict set MemoryMappedPort packetsizesymbol InterfaceName {}
	dict set MemoryMappedPort packetsizesymbol InterfaceString {CONTROL}
	dict set MemoryMappedPort packetsizesymbol ClockDomain {qpsk_tx_symbol_gen}
	dict set MemoryMappedPort packetsizesymbol Locs {}
	dict set MemoryMappedPort packetsizesymbol IOStandard {}
	dict set MemoryMappedPort lfsr_rst Name {lfsr_rst}
	dict set MemoryMappedPort lfsr_rst Type UFix_32_0
	dict set MemoryMappedPort lfsr_rst ArithmeticType xlUnsigned
	dict set MemoryMappedPort lfsr_rst BinaryPoint 0
	dict set MemoryMappedPort lfsr_rst Width 32
	dict set MemoryMappedPort lfsr_rst DatFile {qpsk_tx_symbol_gen_ctrl_lfsr_rst.dat}
	dict set MemoryMappedPort lfsr_rst AddressOffset 28
	dict set MemoryMappedPort lfsr_rst IconText {LFSR_rst}
	dict set MemoryMappedPort lfsr_rst Direction in
	dict set MemoryMappedPort lfsr_rst Period 51200
	dict set MemoryMappedPort lfsr_rst Interface 2
	dict set MemoryMappedPort lfsr_rst InterfaceName {}
	dict set MemoryMappedPort lfsr_rst InterfaceString {CONTROL}
	dict set MemoryMappedPort lfsr_rst ClockDomain {qpsk_tx_symbol_gen}
	dict set MemoryMappedPort lfsr_rst Locs {}
	dict set MemoryMappedPort lfsr_rst IOStandard {}
	dict set MemoryMappedPort enable Name {enable}
	dict set MemoryMappedPort enable Type UFix_32_0
	dict set MemoryMappedPort enable ArithmeticType xlUnsigned
	dict set MemoryMappedPort enable BinaryPoint 0
	dict set MemoryMappedPort enable Width 32
	dict set MemoryMappedPort enable DatFile {qpsk_tx_symbol_gen_ctrl_enable.dat}
	dict set MemoryMappedPort enable AddressOffset 32
	dict set MemoryMappedPort enable IconText {Enable}
	dict set MemoryMappedPort enable Direction in
	dict set MemoryMappedPort enable Period 51200
	dict set MemoryMappedPort enable Interface 2
	dict set MemoryMappedPort enable InterfaceName {}
	dict set MemoryMappedPort enable InterfaceString {CONTROL}
	dict set MemoryMappedPort enable ClockDomain {qpsk_tx_symbol_gen}
	dict set MemoryMappedPort enable Locs {}
	dict set MemoryMappedPort enable IOStandard {}
	dict set MemoryMappedPort autorestartsymbol Name {autorestartsymbol}
	dict set MemoryMappedPort autorestartsymbol Type UFix_32_0
	dict set MemoryMappedPort autorestartsymbol ArithmeticType xlUnsigned
	dict set MemoryMappedPort autorestartsymbol BinaryPoint 0
	dict set MemoryMappedPort autorestartsymbol Width 32
	dict set MemoryMappedPort autorestartsymbol DatFile {qpsk_tx_symbol_gen_ctrl_autorestartsymbol.dat}
	dict set MemoryMappedPort autorestartsymbol AddressOffset 36
	dict set MemoryMappedPort autorestartsymbol IconText {AutoRestartSymbol}
	dict set MemoryMappedPort autorestartsymbol Direction in
	dict set MemoryMappedPort autorestartsymbol Period 1
	dict set MemoryMappedPort autorestartsymbol Interface 2
	dict set MemoryMappedPort autorestartsymbol InterfaceName {}
	dict set MemoryMappedPort autorestartsymbol InterfaceString {CONTROL}
	dict set MemoryMappedPort autorestartsymbol ClockDomain {qpsk_tx_symbol_gen}
	dict set MemoryMappedPort autorestartsymbol Locs {}
	dict set MemoryMappedPort autorestartsymbol IOStandard {}
	dict set MemoryMappedPort packetsizerf Name {packetsizerf}
	dict set MemoryMappedPort packetsizerf Type UFix_32_0
	dict set MemoryMappedPort packetsizerf ArithmeticType xlUnsigned
	dict set MemoryMappedPort packetsizerf BinaryPoint 0
	dict set MemoryMappedPort packetsizerf Width 32
	dict set MemoryMappedPort packetsizerf DatFile {qpsk_tx_symbol_gen_ctrl_packetsizerf.dat}
	dict set MemoryMappedPort packetsizerf AddressOffset 20
	dict set MemoryMappedPort packetsizerf IconText {PacketSizeRF}
	dict set MemoryMappedPort packetsizerf Direction in
	dict set MemoryMappedPort packetsizerf Period 51200
	dict set MemoryMappedPort packetsizerf Interface 2
	dict set MemoryMappedPort packetsizerf InterfaceName {}
	dict set MemoryMappedPort packetsizerf InterfaceString {CONTROL}
	dict set MemoryMappedPort packetsizerf ClockDomain {qpsk_tx_symbol_gen}
	dict set MemoryMappedPort packetsizerf Locs {}
	dict set MemoryMappedPort packetsizerf IOStandard {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project