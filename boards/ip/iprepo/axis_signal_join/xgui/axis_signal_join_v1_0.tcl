# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "INPUT_WIDTH_L" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INPUT_WIDTH_U" -parent ${Page_0}


}

proc update_PARAM_VALUE.INPUT_WIDTH_L { PARAM_VALUE.INPUT_WIDTH_L } {
	# Procedure called to update INPUT_WIDTH_L when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INPUT_WIDTH_L { PARAM_VALUE.INPUT_WIDTH_L } {
	# Procedure called to validate INPUT_WIDTH_L
	return true
}

proc update_PARAM_VALUE.INPUT_WIDTH_U { PARAM_VALUE.INPUT_WIDTH_U } {
	# Procedure called to update INPUT_WIDTH_U when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INPUT_WIDTH_U { PARAM_VALUE.INPUT_WIDTH_U } {
	# Procedure called to validate INPUT_WIDTH_U
	return true
}


proc update_MODELPARAM_VALUE.INPUT_WIDTH_U { MODELPARAM_VALUE.INPUT_WIDTH_U PARAM_VALUE.INPUT_WIDTH_U } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INPUT_WIDTH_U}] ${MODELPARAM_VALUE.INPUT_WIDTH_U}
}

proc update_MODELPARAM_VALUE.INPUT_WIDTH_L { MODELPARAM_VALUE.INPUT_WIDTH_L PARAM_VALUE.INPUT_WIDTH_L } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INPUT_WIDTH_L}] ${MODELPARAM_VALUE.INPUT_WIDTH_L}
}

