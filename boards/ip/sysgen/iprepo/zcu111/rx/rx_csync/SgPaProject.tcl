namespace eval ::xilinx::dsp::planaheadworker {

   #-------------------------------------------------------
   # return name space qualifiers for worker tcl
   #-------------------------------------------------------
   proc dsp_get_worker_tcl_namespace_qualifiers {} {
      return [ namespace current ]
   }
   #-------------------------------------------------------
   # return name space qualifiers for driver tcl
   #-------------------------------------------------------
   proc dsp_get_driver_tcl_namespace_qualifiers {} {
      return ::xilinx::dsp::planaheaddriver
   }
   #-------------------------------------------------------
   # return name space qualifiers for sysgen submodule tcl
   #-------------------------------------------------------
   proc dsp_get_sysgensubmodule_tcl_namespace_qualifiers {} {
      return ::xilinx::dsp::sysgensubmodule
   }
   #-------------------------------------------------------
   # return value of the param under driver tcl name space
   #-------------------------------------------------------
   proc dsp_get_param_value_in_driver_tcl_namespace { param } {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      return [ dsp_get_param_value_in_tcl_namespace ${param} ${driverns} ]
   }
   #-------------------------------------------------------
   # return value of the param under driver tcl name space
   #-------------------------------------------------------
   proc dsp_get_param_value_in_sysgensubmodule_tcl_namespace { param } {
      set submodns [ dsp_get_sysgensubmodule_tcl_namespace_qualifiers ]
      return [ dsp_get_param_value_in_tcl_namespace ${param} ${submodns} ]
   }
   #-------------------------------------------------------
   # return value of the param under driver tcl name space
   #-------------------------------------------------------
   proc dsp_get_param_value_in_tcl_namespace { param tclns } {
      if { ![ info exists ${tclns}::${param} ] } {
         return ""
      }
      set paramvalue [ set ${tclns}::${param} ]
      return $paramvalue
   }
   #-------------------------------------------------------
   # return value device name
   # if bformat is 1 then it returns the device name in  a format
   # that is suitable for the board infrastructure
   #-------------------------------------------------------
   proc dsp_get_devicename { {bformat 0} } {
      set paramvalueFamily [ dsp_get_param_value_in_driver_tcl_namespace DSPFamily ]
      set paramvalueDevice [ dsp_get_param_value_in_driver_tcl_namespace DSPDevice ]
      set paramvaluePackage [ dsp_get_param_value_in_driver_tcl_namespace DSPPackage ]
      set paramvalueSpeed [ dsp_get_param_value_in_driver_tcl_namespace DSPSpeed ]
      if { $bformat == 1 } {
          set devicename ${paramvalueDevice}${paramvaluePackage}${paramvalueSpeed}
      } else {
          set devicename ${paramvalueDevice}-${paramvaluePackage}${paramvalueSpeed}
      }
      return $devicename
   }
   #-----------------------------------------------------
   # return the vhdl library name
   #-----------------------------------------------------
   proc dsp_get_vhdllib { } {
     set vhdllib [ dsp_get_param_value_in_driver_tcl_namespace VHDLLib ]
     return $vhdllib
   }
   #-------------------------------------------------------
   # return name space qualifiers for tester tcl
   #-------------------------------------------------------
   proc dsp_get_tester_tcl_namespace_qualifiers {} {
      return ::xilinx::dsp::planaheadtester
   }
   #-------------------------------------------------------
   # return exename of current tcl shell
   # the return string are vivado or plahAhead
   #-------------------------------------------------------
   proc dsp_get_currentshellname {} {
      set exename [ info nameofexecutable ]
      set currenttclshell [ file tail [ file rootname $exename ] ]
      return $currenttclshell
   }
   #-------------------------------------------------------
   # return 1 if the name of currently running tcl shell
   # matches with match_shellname
   #-------------------------------------------------------
   proc dsp_match_currentshellname { match_shellname } {
      set current_shellname [ dsp_get_currentshellname ]
      return [ string match $match_shellname $current_shellname ]
   }
   #-------------------------------------------------------
   # return 1 if running vivado tcl shell
   #-------------------------------------------------------
   proc dsp_is_running_vivado {} {
      return [ dsp_match_currentshellname vivado ]
   }
   #-------------------------------------------------------
   # return 1 if running planAhead tcl shell
   #-------------------------------------------------------
   proc dsp_is_running_planAhead {} {
      return [ dsp_match_currentshellname planAhead ]
   }
   #-------------------------------------------------------
   # return 1 if running in supported tcl shell vivado/planAhead
   #-------------------------------------------------------
   proc dsp_is_running_supportedshell {} {
      return [ expr { [ dsp_is_running_vivado ] || [ dsp_is_running_planAhead ] } ]
   }
   #-------------------------------------------------------
   # return 1 if in test mode
   #-------------------------------------------------------
   proc dsp_is_running_in_testmode {} {
      set testerns [ dsp_get_tester_tcl_namespace_qualifiers ]
      return [ expr { [ info exists ${testerns}::is_doing_planAheadGenTest ]
         || [ info exists ${testerns}::is_doing_planAheadGenPostSynthTest ] } ]
   }
   #-------------------------------------------------------
   # main program begins here
   #-------------------------------------------------------
   if { ![ dsp_is_running_supportedshell ] } {
      error "ERROR: Please run vivado or planAhead tcl."
      return
   }
   #-------------------------------------------------------------------------
   # Checks for a required parameter.
   #
   # @param  param          Parameter name.
   # @param  postproc       Post processor.
   # @return the parameter value.
   #-------------------------------------------------------------------------
   proc dsp_required_parameter {param {postproc ""}} {
      upvar $param p
      if { ![ info exists p ] } {
         error "ERROR: Required parameter \"[namespace tail $param]\" is not specified."
      }
      if { $postproc != "" } {
         eval $postproc p
      }
      return $p
   }
   #-------------------------------------------------------------------------
   # Checks for an optional parameter.
   #
   # @param  param          Parameter name.
   # @param  defval         Default value of the parameter if unspecified.
   # @param  postproc       Post processor.
   # @return the parameter value.
   #-------------------------------------------------------------------------
   proc dsp_optional_parameter {param {defval ""} {postproc ""}} {
      upvar $param p
      if { ![ info exists p ] } {
         set p $defval
      }
      if { $postproc != "" } {
         eval $postproc p
      }
      return $p
   }
   #-------------------------------------------------------------------------
   # Deletes an existing empty parameter.
   #
   # @param  param          Parameter name.
   #-------------------------------------------------------------------------
   proc dsp_clear_empty_parameter {param} {
      upvar $param p
      if { [ info exists p ] && [ expr { [ string length $p ] == 0 } ] } {
         unset p
      }
   }
   #-------------------------------------------------------------------------
   # Checks a Boolean flag.
   #
   # @param  param          Parameter name.
   # @param  defval         Default value of the parameter if unspecified.
   # @return 1 if the flag is specified and is true, or 0 othewise.
   #-------------------------------------------------------------------------
   proc dsp_check_flag {param {defval ""}} {
      upvar $param p
      return [ expr { [ info exists p ] && $p } ]
   }

   #-------------------------------------------------------------------------
   # return 1 if HDL language is VHDL
   #-------------------------------------------------------------------------
   proc dsp_hdllang_is_vhdl {} {
      set langtype [ dsp_get_param_value_in_driver_tcl_namespace HDLLanguage ]
      return [ expr { $langtype eq "VHDL" } ]
   }

   #-------------------------------------------------------------------------
   # read contents of a file and return the contents
   #
   # @param  targetfile     name of the file to read.
   # @return                contents of the file as one string.
   #-------------------------------------------------------------------------
   proc dsp_read_file { targetfile } {
      if { [ file exists $targetfile ] == 0 } {
         return ""
      }

      if { [ catch { set fp [open $targetfile r] } err ] } {
         puts "WARNING: can not open file $targetfile for reading"
         return ""
      } else {
         set data [read $fp]
         close $fp
         return $data
      }
   }

   #-------------------------------------------------------------------------
   # merge two list into one and return the merged list
   # @param fromlist1      list 1 to merge
   # @param fromlist2      list 2 to merge
   #-------------------------------------------------------------------------
   proc dsp_merge_lists { fromlist1 fromlist2 } {
      set mergedlist [list]
      foreach item $fromlist1 {
         lappend mergedlist $item
      }
      foreach item $fromlist2 {
         lappend mergedlist $item
      }
      return $mergedlist
   }

   #-------------------------------------------------------------------------
   # read input file, print to stdout
   # @param targetfile       the content of this file will be printed to stdout
   #-------------------------------------------------------------------------
   proc dsptest_print_file_to_stdout { targetfile } {
      set filetext [ dsp_read_file $targetfile ]
      if { [ string length $filetext ] > 0 } {
         puts $filetext
      }
   }

   #-------------------------------------------------------------------------
   # checks whether isim run through without problem, for xt smoket test
   #
   # @param  isimlog          isim log file name.
   # @return error string based on parsing isim log file
   #  1. find mismatch points isim and simulink
   #  2. find error message in log
   #  3. log file does not exist
   #-------------------------------------------------------------------------
   proc dsptest_parse_isimlog {isimlog} {
      if { [ file exists $isimlog ] == 0 } {
         return "$isimlog file not exists"
      }

      set filetext [ dsp_read_file $isimlog ]

      if { [ string length $filetext ] > 0 } {
         set lines [split $filetext \n]
         # set lastline [lindex $lines end-1]
         foreach st $lines {
            if { [string match {* mismatch*} $st] } {
               return "find mismatch"
            }
         }
      } 

      return ""
   }

   #-------------------------------------------------------------------------
   # create and run post-synth sim
   #-------------------------------------------------------------------------
   proc dsptest_run_post_synth_sim {} {
      ::open_netlist_design -name netlist_1
      ::set_property is_enabled false [::get_files -of_objects [ get_filesets sources_1 ]]

      set synthesistooltype [ dsp_get_param_value_in_driver_tcl_namespace SynthesisTool ]
      switch -- $synthesistooltype {
         "RDS" {
            ::set_param simulation.netlist.rodin 1 
         }
         "Vidado" {
            ::set_param simulation.netlist.rodin 1 
         }
      }

      #set srcfiles [planahead::get_files -of_objects sources_1]
      #foreach srcfile $srcfiles {
      #set_property is_enabled false [get_files -of_objects sources_1 $srcfile]
      #}

      set currentdir [ pwd ]
      set paramvalueProjDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set projDir [file normalize $paramvalueProjDir ]
      [cd $projDir]

      if { [ dsp_hdllang_is_vhdl ] } {
         set ext {.vhd}
         ::write_vhdl -force $projDir/post_synth.vhd
      } else {
         set ext {.v}
         ::write_verilog -force -mode sim $projDir/post_synth.v
      }

      ::add_files -fileset sim_1 -norecurse -scan_for_includes post_synth${ext}
      ::import_files -fileset sim_1 -norecurse -force post_synth${ext}

      [cd $currentdir]

      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
      set postsynthvhd $projDir/${paramvalueProject}.srcs/sim_1/imports/hdl_netlist/post_synth${ext}
      ::reorder_files -fileset sim_1 -front $postsynthvhd

      ::launch_isim -batch -simset sim_1 -mode behavioral
   }

   #-------------------------------------------------------------------------
   # clean up post-synth sim
   #-------------------------------------------------------------------------
   proc dsptest_clean_up_post_synth_sim {} {
      set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set projDir [ file normalize $paramvalueProjectDir ]

      if { [ dsp_hdllang_is_vhdl ] } {
         set ext {.vhd}
      } else {
         set ext {.v}
      }

      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
      set postsynthvhd $projDir/${paramvalueProject}.srcs/sim_1/imports/hdl_netlist/post_synth${ext}

      ::remove_files -fileset sim_1 $postsynthvhd
      ::set_property is_enabled true [::get_files -of_objects [ get_filesets sources_1 ]]

      #set srcfiles [::get_files -of_objects sources_1]
      #foreach srcfile $srcfiles {
      #set_property is_enabled true [get_files -of_objects sources_1 $srcfile]
      #}
   }

   #-------------------------------------------------------------------------
   # add files with certain extenstion in certain directory to project
   #
   # @param  filedir          directory to look at
   # @param  fileext          file extension which should add
   # @param  skipfiles        list of files which should not add
   #-------------------------------------------------------------------------
   proc dsp_add_file_to_project {filedir fileext { skipfiles "" }} {
      if { [llength $skipfiles] > 0 } {
         upvar $skipfiles skipfls
         set localcopyskipfl $skipfls
         set extfiles [ dsp_get_file_name_list $filedir $fileext 0 localcopyskipfl ]
      } else {
         set extfiles [ dsp_get_file_name_list $filedir $fileext ]
      }
      if { [llength $extfiles] > 0 } {
         ::import_files -fileset [ get_filesets sources_1 ] -force -norecurse $extfiles
      }
   }

   #-------------------------------------------------------------------------
   # wait until isim is finished
   #
   # @param  isimlog          isim log file name.
   # @param  simtype          behavior/post-synth/timing
   # @param  deleteisimlog    0/1, 1 is to delete
   # @return msgtext          empty string means no error
   #-------------------------------------------------------------------------
   proc dsptest_wait_on_isim {isimlog simtype deleteisimlog} {
      set ncount 0
      while { [ expr {[ dsptest_isim_done $isimlog ] == 0} ] && $ncount < 360} {
         [ exec sleep 10 ]
         incr ncount
      }

      set isimerrmsg0 ""

      if { $ncount >= 360 } {
         set stmpmsg0 "error happened while running $simtype simulation.\n"
         set isimerrmsg0 [concat $isimerrmsg0 $stmpmsg0]
      } else {
         set isimmsg [ dsptest_parse_isimlog $isimlog ]
         if { [ dsp_is_good_string $isimmsg ] } {
            set stmpmsg0 "$isimmsg in $simtype simulation.\n"
            set isimerrmsg0 [concat $isimerrmsg0 $stmpmsg0]
         }
      }

      if { $deleteisimlog == 1 && [ file exists $isimlog ] == 1 } {
         #file delete $isimlog
         file rename -force $isimlog ${isimlog}_${simtype}
      }

      if { [string length $isimerrmsg0] > 0 } {
         ::close_project
         error "ERROR: $isimerrmsg0"
      }

      return $isimerrmsg0;
   }

   #-------------------------------------------------------------------------
   # checks whether a previous isim has finished
   #
   # @param  isimlog          isim log file name.
   # @return 1 if there is a previous isim has finished before.
   #-------------------------------------------------------------------------
   proc dsptest_isim_done { isimlog } {
      if { [ file exists $isimlog ] == 0 } {
         return 0
      }

      set data [ dsp_read_file $isimlog ]
      set lines [ split $data \n ]

      set lastline [ lindex $lines end-1 ]
      if { [ string match -nocase {*#*quit*-f*} $lastline ] } {
         return 1
      } else {
         set lastline [ lindex $lines end ]
         return [ string match -nocase {*#*quit*-f*} $lastline ]
      }
   }

   #-------------------------------------------------------------------------
   # Post processor to turn the given parameter to lower case.
   #
   # @param  param          Parameter name.
   # @return the processed parameter value.
   #-------------------------------------------------------------------------
   proc dsp_lowercase_pp { param } {
      upvar $param p
      set p [ string tolower $p ]
      return $p
   }

   #-------------------------------------------------------------------------
   # Post processor for the SynthesisTool parameter.
   #
   # @param  param          Parameter name.
   # @return the processed parameter value.
   #-------------------------------------------------------------------------
   proc dsp_synthesis_tool_pp { param } {
      upvar $param p
      switch [ string tolower $p ] {
         "vivado" {
            set p "Vivado"
         }
         default {
            error "ERROR: Invalid value for parameter \"SynthesisTool\": $p"
         }
      }
   }

   #-------------------------------------------------------------------------
   # Post processor for the HDLLanguage parameter.
   #
   # @param  param          Parameter name.
   # @return the processed parameter value.
   #-------------------------------------------------------------------------
   proc dsp_hdl_language_pp {param} {
      upvar $param p
      switch [string tolower $p] {
         "vhdl" {
            set p "VHDL"
         }
         "verilog" {
            set p "Verilog"
         }
         default {
            error "ERROR: Invalid value for parameter \"HDLLanguage\": $p"
         }
      }
   }

   #-------------------------------------------------------------------------
   # Dumps all variables of a given namespace. The current namespace is used
   # if no namespace is specified.
   #
   # @param  ns             Target namespace.
   #-------------------------------------------------------------------------
   proc dsp_dump_variables {{ns ""}} {
      if { $ns eq "" } {
         set ns [ namespace current ]
      }

      foreach param [ lsort [info vars $ns\::*] ] {
         upvar $param p
         # TODO : print array, remove upvar
         puts [namespace tail $param]\ =\ $p
      }
   }

   #-------------------------------------------------------------------------
   # Handles an exception when evaluating the given script and displays an
   # appropriate error message.
   #
   # @param  script         Script to evaluate.
   # @param  msg            Message to display upon an exception.
   # @param  append_msg     Specifies whether any returned error message is
   #                        also displayed.
   # @return 1 if the script is evaluated successfully, or 0 othewise.
   #-------------------------------------------------------------------------
   proc dsp_handle_exception {script {msg ""} {append_msg True}} {
      if [catch { uplevel $script } result] {
         if {$msg eq ""} {
            set msg "ERROR: An internal error occurred."
         }
         puts stderr "$msg"
         if {$append_msg} {
            puts stderr "$result"
         }
         return 0
      }
      return 1
   }

   #-------------------------------------------------------
   # return compilation flow name which represents the
   # compilation field in Sysgen token: HDL Netlist, Bitstream etc
   # return empty string if error
   #-------------------------------------------------------
   proc dsp_get_compilation_flow_name {} {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      if { [ info exists ${driverns}::Compilation ] } {
         return [ dsp_get_param_value_in_driver_tcl_namespace Compilation ]
      } else {
         return ""
      }
   }

   #-------------------------------------------------------
   # return 1 if the name of compilation flow name
   # matches with shellNameToMatch
   #-------------------------------------------------------
   proc dsp_match_compilation_flow_name { flowNameToMatch } {
      set compilationFlowName [ dsp_get_compilation_flow_name ]
      return [ string match $flowNameToMatch $compilationFlowName ]
   }

   #-------------------------------------------------------
   # return 1 if running HDL Netlist compilation
   #-------------------------------------------------------
   proc dsp_is_hdlnetlist_compilation {} {
      set compilationFlowName {HDL Netlist}
      return [ dsp_match_compilation_flow_name $compilationFlowName ]
   }

   #-------------------------------------------------------
   # return 1 if running Bitstream compilation
   #-------------------------------------------------------
   proc dsp_is_bitstream_compilation {} {
     #Commenting this in Vivado because Bitstrema target is not supported natively in Vivado
     #return [ dsp_match_compilation_flow_name Bitstream ]
     return false
   }
   proc dsp_is_ipxact_compilation {} {
      return [ dsp_match_compilation_flow_name {IP Catalog} ]
   }
 
   #-------------------------------------------------------------------------
   # check a proc exists, if yes run the proc and return 1 
   # if proc does not exist, return 0
   # @param  procname       name of the proc to run.
   # @param  np             name space for the proc.
   # @return 1 if proc found and run, otherwise return 0
   #-------------------------------------------------------------------------
   proc dsp_check_and_run_proc { procname {np ""} } {
      if { [ string length $np ] > 0 } {
         if { $np == "::" } {
            set decoratedprocname ::${procname}
         } else {
            set decoratedprocname ${np}::${procname}
         }
      } else {
         set decoratedprocname $procname
      }

      set findproc [ info proc $decoratedprocname ]
      if { [ string length $findproc ] > 0  } {
         eval $decoratedprocname
         return 1
      } else {
         return 0
      }
   }


   #-------------------------------------------------------
   # run tcl proc in dsp namespaces with precedence
   #-------------------------------------------------------
   proc dsp_run_proc_in_dsp_namespaces { procname } {
      if { [ string length $procname ] < 1 } {
         return
      }

      set ns [ namespace qualifiers $procname ]
      if { $ns > 0 } {
         if { [ dsp_check_and_run_proc $procname ] } {
            return
         }
      } else {
         set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
         if { [ dsp_check_and_run_proc $procname ${driverns} ] } {
            return
         }

         set wrokerns [ dsp_get_worker_tcl_namespace_qualifiers ]
         if { [ dsp_check_and_run_proc $procname ${wrokerns} ] } {
            return
         }

         if { [ dsp_check_and_run_proc $procname {::} ] } {
            return
         }

         if { [ dsp_check_and_run_proc $procname ] } {
            return
         }
     } 

     puts "WARNING: can not find proc: $procname"
   }

   #-------------------------------------------------------------------------
   # Processes all project parameters.
   #
   # REQUIRED PARAMETERS
   # ======================================================================
   #   Project
   #     PlanAhead project name.
   #
   #   DSPFamily
   #     Device family into which the design is implemented.
   #
   #   DSPDevice
   #     Device into which the design is implemented.
   #
   #   DSPPackage
   #     Package for the device being targeted.
   #
   #   DSPSpeed
   #     Speed grade of the device being targeted.
   #
   #   ProjectFiles
   #     Source files to be added in the project.
   #
   #  HDLLanguage
   #   Top level HDL Langauge 
   #     ::= "VHDL" | "Verilog"
   #
   #  VHDLLib
   #   Top level default VHDL library name - required only if top level language is VHDL 
   #
   # OPTIONAL PARAMETERS
   # ======================================================================
   # (*) Notes:
   #     "::=" denotes the list of supported values for each parameter.
   #
   # ----------------------------------------------------------------------
   #  Compilation
   #   Compilation target as set on the System Generator Token. 
   #      eg. "HDL Netlist", "Synthesized Checkpoint", "IP Catalog" etc.
   #
   #   CompilationFlow
   #     Compilation flow - either Project or IP 
   #
   #  ImplStrategyName
   #   Name of the implemntation strategy. Must be able to see this 
   #   in Vivado
   #
   #  SimulationTime
   #    Simulation time that will be used by XSIM Simulator for running the testbench
   #
   #   SynthesisTool
   #   Name of the SynthesisTool that will be invoked for backend compilation.
   #   ::= "Vivado"
   #
   #  SynthStrategyName    
   #   Name of the Synthesis Strategy to use. Must be able to see this
   #   in vivado.
   #
   #  TopLevelModule
   #    Top-level module of the design.
   #
   #   TestBenchModule
   #     Test-bench module.
   #
   #
   #   ProjectGenerator
   #
   #   PostProjectCreationProc
   #     optional param in driver tcl, tclsh will call this proc after project creation.
   #
   #   CustomUpdateParametersProc
   #     optional param in driver tcl, this tcl proc will be called to update parameters.
   #
   #   CustomUpdateSynthesisSettingsProc
   #     optional param in driver tcl, this tcl proc will be called to update synthesis settings.
   #
   #   CustomUpdateImplementationSettingsProc
   #     optional param in driver tcl, this tcl proc will be called to update implementation settings.
   #
   #   CustomUpdateSimulationSettingsProc
   #     optional param in driver tcl, this tcl proc will be called to update simulation settings.
   #
   #   CustomProjectDir
   #     optional param in driver tcl, this is dir name relative to tcl working dir, planAhead or vivado
   #     project will be generated in this dir
   #
   #   Board
   #      optional param in driver tcl. If the param exists then the board_part property of the project
   #      will be set to this parameter. This is a mechanism to force a particular board in the flow. 
   #
   #  EnableIPOOCCaching
   #     optional param in driver tcl. If param exists and it is true then set cache paths for the IP OOCs
   #     in System Generator netlist. Synthesized_Checkpoint and HWCosim can benefit from this as it speeds
   #     up backend compilation
   #
   #  IPOOCCacheRootPath
   #     optional param in driver tcl. If param exists and provides a valid system path the IP OOC synthesis
   #     results are cached in this location. This improves incremental compilation performance for 
   #     HWCosim and Synthesized_Checkpoint compilation targets    
   #-------------------------------------------------------------------------
   proc dsp_process_parameters {} {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      dsp_required_parameter ${driverns}::Project
      dsp_required_parameter ${driverns}::DSPFamily dsp_lowercase_pp
      dsp_required_parameter ${driverns}::DSPDevice dsp_lowercase_pp
      dsp_required_parameter ${driverns}::DSPPackage dsp_lowercase_pp
      dsp_required_parameter ${driverns}::DSPSpeed
    dsp_required_parameter ${driverns}::HDLLanguage dsp_hdl_language_pp
      if {[dsp_hdllang_is_vhdl]} {
         dsp_required_parameter ${driverns}::VHDLLib
      }
    dsp_required_parameter ${driverns}::ProjectFiles

      dsp_optional_parameter ${driverns}::Compilation {HDL Netlist}
      dsp_optional_parameter ${driverns}::SynthStrategyName {}
      dsp_optional_parameter ${driverns}::ImplStrategyName {}
      dsp_optional_parameter ${driverns}::CompilationFlow {Project}
    dsp_optional_parameter ${driverns}::SynthesisTool {Vivado} dsp_synthesis_tool_pp
      set is_vhdl [ dsp_hdllang_is_vhdl ]
    dsp_optional_parameter ${driverns}::SimulationTime {0} 

    # Added for IP/IP Catalog Flow
      dsp_optional_parameter ${driverns}::IP_Dir {}
      dsp_optional_parameter ${driverns}::IP_Common_Repos {0}
    dsp_optional_parameter ${driverns}::EnableIPOOCCaching {0}
    dsp_optional_parameter ${driverns}::IPOOCCacheRootPath {}

      # Added for Sysgen timing analysis flow
      dsp_optional_parameter ${driverns}::AnalyzeTiming {}
      dsp_optional_parameter ${driverns}::AnalyzeTimingNumPaths {1}
      dsp_optional_parameter ${driverns}::AnalyzeTimingPostSynthesis {}
      dsp_optional_parameter ${driverns}::AnalyzeTimingPostImplementation {}
      dsp_optional_parameter ${driverns}::AnalyzeTimingHoldConstraints {}
      # Added for Sysgen resource estimation flow
      dsp_optional_parameter ${driverns}::ResourceUtilization {}

      dsp_clear_empty_parameter ${driverns}::TopLevelModule
      dsp_clear_empty_parameter ${driverns}::TestBenchModule
      dsp_clear_empty_parameter ${driverns}::PostProjectCreationProc
      dsp_clear_empty_parameter ${driverns}::CustomUpdateParametersProc
      dsp_clear_empty_parameter ${driverns}::CustomUpdateSynthesisSettingsProc
      dsp_clear_empty_parameter ${driverns}::CustomUpdateImplementationSettingsProc
      dsp_clear_empty_parameter ${driverns}::CustomUpdateSimulationSettingsProc
      dsp_clear_empty_parameter ${driverns}::CustomProjectDir
      dsp_clear_empty_parameter ${driverns}::FileRepository
      dsp_clear_empty_parameter ${driverns}::Board

      if { [ info exists ${driverns}::CustomProjectDir ] } {
         set paramvalueCustomUpdateProjectDir [ dsp_get_param_value_in_driver_tcl_namespace CustomProjectDir ]
         if { [dsp_is_good_string $paramvalueCustomUpdateProjectDir] } {
            dsp_optional_parameter ${driverns}::ProjectDir ${paramvalueCustomUpdateProjectDir}
         }
      }

      if { ![ info exists ${driverns}::ProjectDir ] } {
         if { [ dsp_is_hdlnetlist_compilation ] } {
            dsp_optional_parameter ${driverns}::ProjectDir {hdl_netlist}
         } elseif { [ dsp_is_bitstream_compilation ] } {
            dsp_optional_parameter ${driverns}::ProjectDir {bitstream}
         } elseif { [ dsp_is_ipxact_compilation ] } {
            dsp_optional_parameter ${driverns}::ProjectDir [dsp_ip_packager_get_location]
         } else {      
            dsp_optional_parameter ${driverns}::ProjectDir {hwcosim}
         }
      }

      if { [ info exists ${driverns}::CustomUpdateParametersProc ] } {
         set paramvalueCustomUpdateParametersProc [ dsp_get_param_value_in_driver_tcl_namespace CustomUpdateParametersProc ]
         dsp_run_proc_in_dsp_namespaces $paramvalueCustomUpdateParametersProc
      }
   } 
   
   #-------------------------------------------------------------------------
   # Dumps all parameters.
   #-------------------------------------------------------------------------
   proc dsp_dump_parameters {} {
    dsp_dump_variables param
   }

   #-------------------------------------------------------------------------
   # a good string has length > 0 and has at least one non-white space char
   # return 0 if string is empty or only has white spaces
   # return 1 if string is good as descriped above
   # @param  str          Parameter name.
   #-------------------------------------------------------------------------
   proc dsp_is_good_string { str } {
      set strtmp [ string trim $str ]
      set length [ string length $strtmp ]
      if { $length == 0 } {
         return 0
      } else {
         return 1
      }
   }

   #-------------------------------------------------------------------------
   # return core part of file name. For example abc.d will return abc
   # @param filename       file name 
   #-------------------------------------------------------------------------
   proc dsp_get_file_core_name { filename } {
      if { ![dsp_is_good_string $filename] } {
         return ""
      }

      set dirnames [split $filename /]
      set fname [lindex $dirnames end]
      if { [dsp_is_good_string $fname] } {
         set names [split $fname .]
         set name [lindex $names end-1]
         return $name
      }

      return ""
   }

   #-------------------------------------------------------------------------
   # return the list of of search pathes for sysgen project files
   #-------------------------------------------------------------------------
   proc dsp_get_sysgen_project_file_search_path_list {} {
      set tmplist [list]

      set paramvalueFileRepository [ dsp_get_param_value_in_driver_tcl_namespace FileRepository ]
      if { [ dsp_is_good_string $paramvalueFileRepository ] } {
         set filereposdir [file normalize ${paramvalueFileRepository} ]
         if { [file exists ${filereposdir} ] } {
            lappend tmplist ${filereposdir}
         }
      }

      set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set projDir [file normalize $paramvalueProjectDir ]

      set filedir "$projDir/../sysgen"
      set filedir [file normalize ${filedir} ]
      if { [file exists ${filedir} ] } {
         if { [ lsearch $tmplist ${filedir} ] < 0 } {
            lappend tmplist ${filedir}
         }
      }

      set filedir "$projDir/.."
      set filedir [file normalize ${filedir} ]
      if { [file exists ${filedir} ] } {
         if { [ lsearch $tmplist ${filedir} ] < 0 } {
            lappend tmplist ${filedir}
         }
      }

      return $tmplist
   }

   #-------------------------------------------------------------------------
   # return the full path to scoped ip dir for bxml flow
   #-------------------------------------------------------------------------
   proc dsp_get_scoped_ip_dir_full_path {} {
      set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set projDir [ file normalize $paramvalueProjectDir ]

      set ipdir "$projDir/../ip"
      set ipdir [ file normalize ${ipdir} ]
      return ${ipdir}
   }

   #-------------------------------------------------------------------------
   # return the dir which has sysgen project files
   #-------------------------------------------------------------------------
   proc dsp_get_sysgen_project_file_dir {} {
      set paramvalueFileRepository [ dsp_get_param_value_in_driver_tcl_namespace FileRepository ]
      if { [ dsp_is_good_string $paramvalueFileRepository ] } {
         set filereposdir [file normalize ${paramvalueFileRepository} ]
         if { [file exists ${filereposdir} ] } {
            return ${filereposdir}
         }
      }

      set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set projDir [file normalize $paramvalueProjectDir ]

      set filedir "$projDir/../sysgen"
      set filedir [file normalize ${filedir} ]
      if { [file exists ${filedir} ] } {
         return ${filedir}
      }

      set filedir "$projDir/.."
      set filedir [file normalize ${filedir} ]
      if { [file exists ${filedir} ] } {
         return ${filedir}
      }
   }

   #-------------------------------------------------------------------------
   # return a list of file names
   # when return list of core names, the file named abc.d, only abc will be in the return list
   # when return list of full names, the file named with full path will be in the return list
   # @param filedir          the dir in which to do glob
   # @param fileext          the file extention used to do glob
   # @param corenameonly     return list of core names if 1, otherwise return list of full names
   # @param skipfiles        list of files which should be skipped
   #-------------------------------------------------------------------------
   proc dsp_get_file_name_list { filedir fileext {corenameonly 0} {skipfiles ""}} {
      set skiplist [list]
      if { [llength $skipfiles] > 0 } {
         upvar $skipfiles skipfl
         if { [llength $skipfl] > 0 } {
            foreach skipfname $skipfl {
               set fullname [file normalize $skipfname]
               set name [ dsp_get_file_core_name $fullname ]
               if { [ dsp_is_good_string $name] } {
                  lappend skiplist $name
               }
            }
         }
      }

      set namelist [list]
      set sourcefiles [ glob -nocomplain ${filedir}/*${fileext} ]
      foreach fullname $sourcefiles {
         set fullname [file normalize $fullname]
         set name [ dsp_get_file_core_name $fullname ]

         if { [llength $skiplist] > 0} {
            if { [ dsp_is_good_string $name] } {
               if { [lsearch $skiplist $name] >= 0 } {
                  continue
               }
            }
         }

         if { $corenameonly == 0 } {
            lappend namelist $fullname
         } else {
            if { [ dsp_is_good_string $name] } {
               lappend namelist $name
            }
         }
      }
      return $namelist
   }

   #-------------------------------------------------------------------------
   # return a list of file names
   # when return list of core names, the file named abc.d, only abc will be in the return list
   # when return list of full names, the file named with full path will be in the return list
   # @param pathlist         list of the dirs in which to do glob, if same file name appears in 
   #                          mulitiple dir, the one in the front of dir list are used, and the rest
   #                          files with same name are ignored
   # @param fileext          the file extention used to do glob
   # @param corenameonly     return list of core names if 1, otherwise return list of full names
   #-------------------------------------------------------------------------
   proc dsp_get_file_name_list_from_pathlist { pathlist fileext {corenameonly 0} } {
      set namelist [list]
      set addedfiles [list]
      foreach filedir $pathlist {
         set filedir [file normalize ${filedir} ]
         if { ![file exists ${filedir} ] } {
            continue
         }

         set tmplist [ dsp_get_file_name_list ${filedir} ${fileext} $corenameonly]
         foreach tmpfilename $tmplist {
            if { $corenameonly == 0 } {
               set corename [ dsp_get_file_core_name ${tmpfilename} ]
            } else {
               set corename ${tmpfilename}
            }

            if { [ dsp_is_good_string ${corename} ] } {
               if { [ lsearch $addedfiles ${corename} ] < 0 } {
                  lappend namelist ${tmpfilename}
                  lappend  addedfiles ${corename}
               }
            }
         }
      }
      return $namelist
   }

   #-------------------------------------------------------------------------
   # return 1 if project has test bench
   #-------------------------------------------------------------------------
   proc dsp_has_testbench {} {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      return [info exists ${driverns}::TestBenchModule]
   }

   #-------------------------------------------------------------------------
   # return 1 if project has created interface document
   #-------------------------------------------------------------------------
   proc dsp_has_create_interface_document {} {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      if { [info exists ${driverns}::CreateInterfaceDocument] } {
         set paramvalueCreateInterfaceDocument [ dsp_get_param_value_in_driver_tcl_namespace CreateInterfaceDocument ]
         if { [string equal -nocase ${paramvalueCreateInterfaceDocument} "on"] } {
            return 1
         } else {
            return 0
         }
      } else {
         return 0
      }
   }

   #-------------------------------------------------------------------------
   # return name of the list var which is used to store files with specific extension
   # @param extname              file extension string
   #-------------------------------------------------------------------------
   proc dsp_get_list_var_name { extname } {
      set extlower [ string tolower $extname ]
      return hidden_list_var_to_hold_file_$extlower
   }
   #-------------------------------------------------------------------------
   # return name of the list variables which are used to store testbench files with specific extension
   # @param extname              file extension string
   #------------------------------------------------------------------------
   proc dsp_get_testbench_list_var_name { extname } {
      set extlower [ string tolower $extname ]
      return hidden_testbench_list_var_to_hold_file_$extlower
   }

   #-------------------------------------------------------------------------
   # return value of the list var which is used to store files with specific extension
   # @param extname              file extension string
   #-------------------------------------------------------------------------
   #proc dsp_get_list_var_value { extname } {
   #   set tmplist [list]
   #   set listvarname [ dsp_get_list_var_name $extname ]
   #   if { [info exists $listvarname] } {
   #      set tmplist [set $listvarname] 
   #   } else {
   #      set tmplist [list] 
   #   }
   #   return $tmplist
   #}

   #-------------------------------------------------------------------------
   # return name of the list var which is used to store files with specific extension
   # @param extnamelist          list of file extentions
   #-------------------------------------------------------------------------
   proc dsp_reset_project_file_list_var { extnamelist } {
      foreach ext $extnamelist {
         set vn [ dsp_get_list_var_name $ext ]
         if { [ info exists $vn ] } {
            unset $vn
         }
      }
   }

   #-------------------------------------------------------------------------
   # return name of the handler proc for add project files with extension
   # @param extname              file extension string
   #-------------------------------------------------------------------------
   proc dsp_get_add_project_files_handler_name { extname } {
      set extlower [ string tolower $extname ]
      return dsp_add_project_files_handler_$extlower
   }

   #-------------------------------------------------------------------------
   # return name of the handler proc for add project files with extension to bxml
   # @param extname              file extension string
   #-------------------------------------------------------------------------
   proc dsp_get_bxml_add_project_files_handler_name { extname } {
      set extlower [ string tolower $extname ]
      return dsp_bxml_add_project_files_handler_$extlower
   }

   #-------------------------------------------------------------------------
   # handler for .ucf files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_ucf { filelist } {
      upvar $filelist ucffl
      if { [llength $ucffl] > 0 } {
         if { [ dsp_is_running_planAhead ] } {
            ::import_files -fileset [ get_filesets constrs_1 ] -force -norecurse $ucffl
         } 
      }
   }

   #-------------------------------------------------------------------------
   # handler for .ucf files when add project files to bxml
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_project_files_handler_ucf { fpbxml filelist } {
      upvar $filelist ucffl
      if { [llength $ucffl] > 0 } {
         if { [ dsp_is_running_planAhead ] } {
            #dsp_bxml_add_file_list $fpbxml $ucffl
            dsp_bxml_copy_ucf_add_ncf $fpbxml $ucffl
         }
      }
   }

   #-------------------------------------------------------------------------
   # handler for .tcl files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_tcl { filelist } {
      upvar $filelist tclfl
      if { [llength $tclfl] > 0 } {
         foreach tclf $tclfl {
            source ${tclf} -notrace
         }
      }
   }
   
   #-------------------------------------------------------------------------
   # handler for .coe files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_coe { filelist } {
      upvar $filelist coefl
      set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
      set ipdir ${paramvalueProjectDir}/${paramvalueProject}.srcs/sources_1/ip
      if { ![ file exists $ipdir ] } {
         file mkdir $ipdir
      }
      if { [llength $coefl] > 0 } {
         foreach coef $coefl {
             file copy -force $coef $ipdir
         }
      }
   }



 
   #-------------------------------------------------------------------------
   # handler for .xdc files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_xdc { filelist } {
      upvar $filelist xdcfl
      if { [llength $xdcfl] > 0 } {
         if { [ dsp_is_running_vivado ] } {
            set_property constrs_type XDC [get_filesets constrs_1]
            ::import_files -fileset [ get_filesets constrs_1 ] -force -norecurse $xdcfl
         }
      }
   }
   #-------------------------------------------------------------------------
   # handler for .dcp files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_dcp { filelist } {
      upvar $filelist dcpfl
      if { [llength $dcpfl] > 0 } {
          ::import_files -fileset [ get_filesets sources_1 ] -force -norecurse $dcpfl
      }
   }

   #-------------------------------------------------------------------------
   # handler for .xco files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_xco { filelist } {
      upvar $filelist xcofl
      if { [llength $xcofl] > 0 } {
         foreach xcofile $xcofl {
            set xcofile [file normalize $xcofile]
            set xcofilerootname [ file rootname $xcofile ]
            set ipname [ file tail $xcofilerootname ]
            if [dsp_is_good_string $ipname] {
               ::import_ip -file $xcofile -name  $ipname
            }
         }
      }
   }

   #-------------------------------------------------------------------------
   # handler for .xdc files when add project files to bxml
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_project_files_handler_xdc { fpbxml filelist } {
      upvar $filelist xdcfl
      if { [llength $xdcfl] > 0 } {
         if { [ dsp_is_running_vivado ] } {
            dsp_bxml_add_file_list $fpbxml $xdcfl
         }
      }
   }

   #-------------------------------------------------------------------------
   # handler for .ngc files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_ngc { filelist } {
      upvar $filelist ngcfl
      if { [llength $ngcfl] > 0 } {
         ::import_files -fileset [ get_filesets sources_1 ] -force -norecurse $ngcfl
      }
   }

   #-------------------------------------------------------------------------
   # handler for .ngc files when add project files to bxml
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_project_files_handler_ngc { fpbxml filelist } {
      upvar $filelist ngcfl
      if { [llength $ngcfl] > 0 } {
         dsp_bxml_add_file_list $fpbxml $ngcfl
      }
   }

   #-------------------------------------------------------------------------
   # handler for .mif files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_mif { filelist } {
      upvar $filelist miffl
   #   if { [ dsp_has_testbench ] } {
         if { [llength $miffl] > 0 } {
            ::import_files -fileset [ get_filesets sim_1 ] -force -norecurse $miffl
         }
   #   }
   }
   
   proc dsp_add_project_files_handler_dat { filelist } {
      upvar $filelist datl
      if { [llength $datl] > 0 } {
         ::import_files -fileset [ get_filesets sources_1 ] -force -norecurse $datl
      }
   }
   #-------------------------------------------------------------------------
   # handler for .mif files when add project files to bxml
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_project_files_handler_mif { filebxml filelist } {
      upvar $filelist miffl
      dsp_bxml_add_file_list $filebxml $miffl
   }

   #-------------------------------------------------------------------------
   # handler for .dat files when add project files to bxml
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_project_files_handler_dat { filebxml filelist } {
      upvar $filelist datl
      dsp_bxml_add_file_list $filebxml $datl
   }
 
   #-------------------------------------------------------------------------
   # handler for testbench files when add project files
   # @param filelist    the list holds file names
   #-------------------------------------------------------------------------
   proc dsp_add_project_files_handler_testbench { filelist } {
      upvar $filelist tbfl
      if { [ dsp_has_testbench ] } {
         if { [llength $tbfl] > 0 } {
            ::import_files -fileset [ get_filesets sim_1 ] -force -norecurse $tbfl
         }
      }
   }
   
   #------------------------------------------------------------------------
   # Add DAT files to the project as testbench files
   #------------------------------------------------------------------------
   proc dsp_add_project_testbench_dat_files {} {
        set datapath [ dsp_get_sysgen_project_file_search_path_list ]
        set datfiles [ dsp_get_file_name_list_from_pathlist $datapath {.dat} ]
         if { [llength $datfiles] > 0 } {
            ::add_files -fileset [ get_filesets sim_1 ] $datfiles
         }
   }

   #-------------------------------------------------------------------------
   # Adds source files to the project.
   #-------------------------------------------------------------------------
   proc dsp_add_project_files {} {
      set projfilesexts "xco ucf xdc mif mem coe ngc v vhd vhdl vh testbench tcl dat dcp"
      set retcode [ dsp_reset_project_file_list_var $projfilesexts ]
      set_property design_mode RTL [ get_filesets sources_1]
      set filedir [ dsp_get_sysgen_project_file_dir ]

      set paramvalueTestBenchModule [ dsp_get_param_value_in_driver_tcl_namespace TestBenchModule ]
      set paramvalueProjectFiles [ dsp_get_param_value_in_driver_tcl_namespace ProjectFiles ]
      foreach p $paramvalueProjectFiles {
         set filen [list]
         set origname [lindex $p 0]
         set origrootname [ file rootname [lindex $p 0] ]
         set filenameraw "$filedir/$origname"
         if { [ file exists $filenameraw ] } {
            set filename [file normalize $filenameraw]
         } else {
            set filename [file normalize $origname]
         }
         #set filename [file normalize [lindex $p 0]]
         set opts [lrange $p 1 end]
         set nopts [llength $opts]
         if {$nopts % 2 != 0} {
            error "Parameter \"ProjectFiles\" contains an invalid value \"$p\"."
         }
         # Remember it if the project contains a Verilog source file.
         if { [string match -nocase "*.v" $filename] || [string match -nocase "*.vh" $filename] } {
            set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
         }

         foreach curext $projfilesexts {
            if { [string match -nocase "*.$curext" $filename] } {
               if { [string match -nocase "*.v" $filename] || [string match -nocase "*.vhd" $filename] || [string match -nocase "*.vh" $filename] || [string match -nocase "*.vhdl" $filename] || [string match -nocase "*.mem" $filename]} {
                  if { [ dsp_has_testbench ] && [ string match -nocase ${paramvalueTestBenchModule} ${origrootname} ] } {
                     set listvarname [ dsp_get_list_var_name "testbench" ]
                     lappend $listvarname $filename
                  } else {
                     lappend filen $filename
                     ::import_files -fileset [ get_filesets sources_1 ] -force -norecurse $filen

                     for {set i 0} {$i < $nopts} {set i [expr {$i + 2}]} {
                        set key [lindex $opts $i]
                        set val [lindex $opts [expr {$i + 1}]]
                        switch -- $key {
                           "-lib" {
                               set_property library $val [get_files -of_object [ get_filesets sources_1 ] [file tail $origname]]
                           }
                        }
                     }
                  }
               } else {
                  set listvarname [ dsp_get_list_var_name $curext ]
                  lappend $listvarname $filename
               }
               break
            }
         }
      }
      # At this point all VHDL & Verilog Files need have been addressed
      # Addressing CR#727593 : .do file passed to questsim doesn't work
      set_property -quiet FILE_TYPE {Verilog Header} [get_files -quiet conv_pkg.v]  

      foreach curext $projfilesexts {
         set listvarname [ dsp_get_list_var_name $curext ]
         if { [ info exists $listvarname ] } {
            set handlername [ dsp_get_add_project_files_handler_name $curext ]
            set findproc [ info proc $handlername ]
            if { [ string length $findproc ] > 0  } {
               eval $handlername $listvarname
            }
         }
      }

      set paramvalueSynthesisTool [ dsp_get_param_value_in_driver_tcl_namespace SynthesisTool ]
      if { [string equal -nocase ${paramvalueSynthesisTool} "RDS"]
         || [string equal -nocase ${paramvalueSynthesisTool} "Vivado"] } {

         set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
         set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
         set ipdir ${paramvalueProjectDir}/${paramvalueProject}.srcs/sources_1/ip
         
         set listvarname [ dsp_get_list_var_name ngc ]
         if { [ info exists $listvarname ] } {
            set ngcfiles [ dsp_get_file_name_list $filedir {.ngc} 0 $listvarname]
         } else {
            set ngcfiles [ dsp_get_file_name_list $filedir {.ngc} ]
         }
         if { [llength $ngcfiles] > 0 } {
            ::import_files -fileset [ get_filesets sources_1 ] -force -norecurse $ngcfiles
         }
      } else {
         set fileext ".ngc"
         set listvarname [ dsp_get_list_var_name ngc ]
         if { [ info exists $listvarname ] } {
            dsp_add_file_to_project $filedir $fileext $listvarname
         } else {
            dsp_add_file_to_project $filedir $fileext
         }
      }

      set fileextlist [list]
      lappend fileextlist ".edn"
      lappend fileextlist ".edf"
      lappend fileextlist ".ndf"

      foreach fileext $fileextlist {
         dsp_add_file_to_project $filedir $fileext
      }

      if { [ dsp_has_testbench ] } {
          dsp_add_project_testbench_dat_files
      }

      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      if [info exists ${driverns}::TopLevelModule] {
         set paramvalueTopLevelModule [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
         ::set_property top ${paramvalueTopLevelModule} [ get_property srcset [ current_run ] ]
      }
   }

   #-------------------------------------------------------------------------
   # Sets the synthesis settings for vivado.
   #-------------------------------------------------------------------------
   proc dsp_set_vivado_synthesis_settings {} {
      set paramvalueSynthStrategyName [ dsp_get_param_value_in_driver_tcl_namespace SynthStrategyName ]
      if { [string length ${paramvalueSynthStrategyName}] > 0 } {
         set_property strategy ${paramvalueSynthStrategyName} [get_runs synth_1]
         return
      }
   } 

   #-------------------------------------------------------------------------
   # Sets target language settings.
   #-------------------------------------------------------------------------
   proc dsp_set_target_language_settings {} {
      if { [ dsp_hdllang_is_vhdl ] } {
         set_property target_language VHDL [current_project]
         if { [ dsp_has_testbench ] } {
            set_property -quiet ng.output_hdl_format VHDL [get_filesets sim_1]
         }
      } else {
         set_property target_language Verilog [current_project]
         if { [ dsp_has_testbench ] } {
            set_property -quiet ng.output_hdl_format Verilog [get_filesets sim_1]
         }
      }
   }
    
   #-------------------------------------------------------------------------
   # Sets the synthesis settings.
   #-------------------------------------------------------------------------
   proc dsp_set_synthesis_settings {} {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      if { [ info exists ${driverns}::CustomUpdateSynthesisSettingsProc ] } {
         set paramvalueCustomUpdateSynthesisSettingsProc [ dsp_get_param_value_in_driver_tcl_namespace CustomUpdateSynthesisSettingsProc ]
         dsp_run_proc_in_dsp_namespaces ${paramvalueCustomUpdateSynthesisSettingsProc}
      } else {
         set paramvalueSynthesisTool [ dsp_get_param_value_in_driver_tcl_namespace SynthesisTool ]
               dsp_set_vivado_synthesis_settings 
            }
      }
    
   #-------------------------------------------------------------------------
   # Sets the implementation settings.
   #-------------------------------------------------------------------------
   proc dsp_set_implementation_settings {} {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      if { [ info exists ${driverns}::CustomUpdateImplementationSettingsProc] } {
         set paramvalueCustomUpdateImplementationSettingsProc [ dsp_get_param_value_in_driver_tcl_namespace CustomUpdateImplementationSettingsProc ]
         dsp_run_proc_in_dsp_namespaces ${paramvalueCustomUpdateImplementationSettingsProc}
      } else {
         set paramvalueSynthesisTool [ dsp_get_param_value_in_driver_tcl_namespace SynthesisTool ]
               dsp_set_vivado_implementation_settings
            }
      }

   #-------------------------------------------------------------------------
   # Sets the vivado implementation settings.
   #-------------------------------------------------------------------------
   proc dsp_set_vivado_implementation_settings {} {
      set paramvalueImplStrategyName [ dsp_get_param_value_in_driver_tcl_namespace ImplStrategyName ]
      if { [string length ${paramvalueImplStrategyName}] > 0 } {
         set_property strategy ${paramvalueImplStrategyName} [get_runs impl_1]
         return
      }
   }
    
   #-------------------------------------------------------------------------
   # Sets the simulation settings
   #-------------------------------------------------------------------------
   proc dsp_set_simulation_settings {} {
      if { ![ dsp_has_testbench ] } {
         return
      } else {
         #create_fileset -simset sim_1
         set_property SOURCE_SET sources_1 [ get_filesets sim_1 ]
         set paramvalueTestBenchModule [ dsp_get_param_value_in_driver_tcl_namespace TestBenchModule ]
         set_property top ${paramvalueTestBenchModule} [ get_filesets sim_1 ]
      }

      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      set has_simtime [info exists ${driverns}::SimulationTime]
      if {$has_simtime} {
         set paramvalueSimulationTime [ dsp_get_param_value_in_driver_tcl_namespace SimulationTime ]
         set_property xsim.simulate.runtime ${paramvalueSimulationTime} [ get_filesets sim_1 ]
      }

      if { [ info exists ${driverns}::CustomUpdateSimulationSettingsProc] } {
         set paramvalueCustomUpdateSimulationSettingsProc [ dsp_get_param_value_in_driver_tcl_namespace CustomUpdateSimulationSettingsProc ]
         dsp_run_proc_in_dsp_namespaces ${paramvalueCustomUpdateSimulationSettingsProc}
      } else {
         #set_property NG.MORE_NETGEN_OPTIONS {-sdf_anno false} [ get_filesets sim_1 ]
         set propertylist [string tolower [list_property [get_filesets sim_1]]]
         if { [lsearch $propertylist nl.sdf_anno] >= 0 } {
            set_property nl.sdf_anno false [get_filesets sim_1]
         }

         if { [lsearch $propertylist ng.sdf_anno] >= 0 } {
            set_property ng.sdf_anno false [get_filesets sim_1]
         }
         set_property source_mgmt_mode DisplayOnly [current_project]

         if { ![ dsp_hdllang_is_vhdl ] } {
            set_property xsim.elaborate.xelab.more_options { --timescale 1ns/10ps } [get_filesets sim_1]
         }

         # Commenting out library setting for ISim simulation for Verilog 
         # Setting of MORE_OPTIONS for verilog specific simulation libraries is not requires as of P.15 release
         #  set paramvalueHDLLanguage [ dsp_get_param_value_in_driver_tcl_namespace HDLLanguage ]
         #  set is_vhdl [expr { ${paramvalueHDLLanguage} eq "VHDL" }]
         #  if { !$is_vhdl } {
         #      #set_property -property_name FUSE.MORE_OPTIONS -property_value {-L unisims_ver -L simprims_ver -L xilinxcorelib_ver -L secureip} -object [get_filesets sim_1]
         #      set_property -name FUSE.MORE_OPTIONS -value "-L unisims_ver -L simprims_ver -L xilinxcorelib_ver -L secureip" -object [get_filesets sim_1]
         #  }
      }
   }

   #-------------------------------------------------------------------------
   # Starts the project creation.
   #-------------------------------------------------------------------------
   proc dsp_start_project_creation {} {
      set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      if { [file exists ${paramvalueProjectDir}] } {
         file delete -force ${paramvalueProjectDir}
      }

      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
      set devicenamevalue [ dsp_get_devicename ]
      ::create_project ${paramvalueProject} ${paramvalueProjectDir} -part ${devicenamevalue}
      dsp_setboardpart 
      if { [ dsp_hdllang_is_vhdl ] } {
         set vhdl_lib [ dsp_get_vhdllib ]
         dsp_setvhdllib $vhdl_lib
      }
  		dsp_setipooccache
   }

   #-------------------------------------------------------------------------
   # Set the VHDL Default Lib Name
   #------------------------------------------------------------------------
   proc dsp_setvhdllib { vhdl_lib } {
      set_property Default_Lib $vhdl_lib [current_project]
   }
   #--------------------------------------------------------------------------
   # Infer the board that is necessary
   #--------------------------------------------------------------------------
   proc dsp_setboardpart {} {
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      # Force board part to user specified value if it exists
      if { [ info exists ${driverns}::Board] } {
         set paramvalueBoard [ dsp_get_param_value_in_driver_tcl_namespace Board ]
	     set_property board_part $paramvalueBoard [current_project]
         return
      }

      # Starting in 2016.1 we get Vivado Board Support, i.e. board name, vendor name and file version passed down from the Sysgen Token
      if { [ info exists ${driverns}::BoardName] } {
         if { [ info exists ${driverns}::BoardVendor] } {
            set boardPartString [ dsp_get_param_value_in_driver_tcl_namespace BoardVendor ]
         } else {
            # if for any reason there is no Board Vendor string set, default to Xilinx
            set boardPartString "xilinx.com"
         }
         set paramvalueBoardName [ dsp_get_param_value_in_driver_tcl_namespace BoardName ]
         append boardPartString ":" $paramvalueBoardName ":part0"
         if { [ info exists ${driverns}::BoardFileVersion] } {
            append boardPartString ":" [ dsp_get_param_value_in_driver_tcl_namespace BoardFileVersion ]
         } else {
            append boardPartString ":1.0"
         }
         set_property board_part $boardPartString [current_project]
         return
      }
   }

  #-------------------------------------------------------------------------
  # Set Remote IP cache if specified from Model Setting.
  # Set IPOOC cache if requested. Also creates the cache root path if it does not exixt
  #-------------------------------------------------------------------------
  proc dsp_setipooccache {} {
    set enableIPCaching [ dsp_get_param_value_in_driver_tcl_namespace EnableIPCaching ]
    if {$enableIPCaching == 1} {
      set ipCachePath [ dsp_get_param_value_in_driver_tcl_namespace IPCachePath ]
      if { $ipCachePath ne "" } {
        if {[file isdirectory $ipCachePath] == 0} {
          file mkdir $ipCachePath
        } 
      } 
    	config_ip_cache -import_from_project -use_cache_location "$ipCachePath"
		update_ip_catalog    
    }

    set enableIPOOCCaching [ dsp_get_param_value_in_driver_tcl_namespace EnableIPOOCCaching ]
    if {$enableIPOOCCaching == 1} {
      set ipOOCCacheRootPath [ dsp_get_param_value_in_driver_tcl_namespace IPOOCCacheRootPath ]
      if { $ipOOCCacheRootPath ne "" } {
        if {[file isdirectory $ipOOCCacheRootPath] == 0} {
          file mkdir $ipOOCCacheRootPath
        } 
      } 
      config_ip_cache -use_cache_location "$ipOOCCacheRootPath"
    }
  }

   #-------------------------------------------------------------------------
   # Finishes the project creation.
   #-------------------------------------------------------------------------
   proc dsp_finish_project_creation {} {
      #puts "PRINT: Entered dsp_finish_project_creation"
      if { [catch current_project] } {
         return
      }
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      if { [ info exists ${driverns}::PostProjectCreationProc ] } {
         set paramvaluePostProjectCreationProc [ dsp_get_param_value_in_driver_tcl_namespace PostProjectCreationProc ]
         dsp_run_proc_in_dsp_namespaces ${paramvaluePostProjectCreationProc}
      }
      # generate SysGen timing analysis report
      set analyzeTiming [ dsp_get_param_value_in_driver_tcl_namespace AnalyzeTiming ]
      if { [ dsp_is_good_string $analyzeTiming ] && [string equal $analyzeTiming "1"] } {
          dsp_generate_timing_report
          # generate SysGen resource utilization report
          # dsp_generate_resource_utilization_report
      }
       # NOTE: No need for separate param to collect resource utilization data
       # The function should be called based on analyzeTiming parameters only
#      set resourceUtilization [ dsp_get_param_value_in_driver_tcl_namespace ResourceUtilization ]
#      if { [ dsp_is_good_string $resourceUtilization ] && [string equal $resourceUtilization "1"] } {
#          dsp_generate_resource_utilization_report
#      }

      ::close_project
   }

   #-------------------------------------------------------------------------
   # return relative file path
   #-------------------------------------------------------------------------
   proc dsp_get_proj_relative_path {filepath} {
      set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set projDir [file normalize ${paramvalueProjectDir} ]
      set toppath "$projDir/.."
      set toppath [ file normalize $toppath ]
      set normalpath [ file normalize $filepath ]
      set toppathsize [ string length $toppath ]
      set endidx [ expr $toppathsize - 1 ]
      set topsub [ string range $normalpath 0 $endidx ]
      if { [ string match $topsub $toppath ]} {
         set startidx [ expr $toppathsize + 1 ]
         set relativepath [ string range $normalpath $startidx end ]
         return $relativepath
      } else {
         return $filepath
      }
   }

   #-------------------------------------------------------------------------
   # add file with specific extention as  nodes to bxml
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_file_ext {fpbxml filedir fileext { skipfiles "" }} {
      if { [llength $skipfiles] > 0 } {
         upvar $skipfiles skipfls
         set localcopyskipfl $skipfls
         set extfiles [ dsp_get_file_name_list $filedir $fileext 0 localcopyskipfl ]
      } else {
         set extfiles [ dsp_get_file_name_list $filedir $fileext ]
      }

      if { [llength $extfiles] > 0 } {
         dsp_bxml_add_file_list $fpbxml $extfiles
      }
   }

   #-------------------------------------------------------------------------
   # copy a list of ucf files to ncf files and add ncf files to bxml
   #-------------------------------------------------------------------------
   proc dsp_bxml_copy_ucf_add_ncf {fpbxml ucffilenamelist} {
      if { [llength $ucffilenamelist] > 0 } {
         foreach ucffname $ucffilenamelist {
            if { [dsp_is_good_string $ucffname] } {
               set nlength [string length $ucffname]
               set nidxstart [ expr { $nlength - 3 } ]
               set nidxend [ expr { $nlength - 1 } ]
               set ncffname [string replace $ucffname $nidxstart $nidxend "ncf"]
               if { ![file exists $ncffname ] } {
                  file copy -force $ucffname $ncffname
               }
               dsp_bxml_add_file $fpbxml $ncffname
            }
         }
      }
   }

   #-------------------------------------------------------------------------
   # write sime files which need dsp module to handle in pa project
   #-------------------------------------------------------------------------
   proc dsp_write_manualsimfile_list {filenamelist} {

      set subname [ dsp_get_param_value_in_sysgensubmodule_tcl_namespace submodule_name ]
      set filename ${subname}.simset
      set tmpfilename "./sysgen/$filename"
      set tmpfilename [file normalize $tmpfilename ]
      set fp [open $tmpfilename w]

      if { [llength $filenamelist] > 0 } {
         foreach fname $filenamelist {
            if { [dsp_is_good_string $fname] } {
               if { [file exists $fname] } {
                  puts $fp $fname
               }
            }
         }
      }

      close $fp
   }

   #-------------------------------------------------------------------------
   # add a list of files nodes to bxml
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_file_list {fpbxml filenamelist {vhdllibname ""}} {
      if { [llength $filenamelist] > 0 } {
         foreach fname $filenamelist {
            if { [dsp_is_good_string $fname] } {
               dsp_bxml_add_file $fpbxml $fname $vhdllibname
            }
         }
      }
   }

   #-------------------------------------------------------------------------
   # add a file node to bxml
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_file {fpbxml filename {vhdllibname ""}} {
      set filename [dsp_get_proj_relative_path $filename]
      set fnameext [split $filename .]
      set ntmp [llength $fnameext]
      if { $ntmp > 1} {
         set sext [lindex $fnameext end]
         dsp_bxml_add_file_type $fpbxml $filename $sext $vhdllibname
      }
   }

   #-------------------------------------------------------------------------
   # add a file node to bxml
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_file_type {fpbxml filename filetype {vhdllibname ""}} {
      set filetimestamp 0
      if { [file exists $filename] } {
         set filetimestamp [file mtime $filename]
      }

      puts -nonewline $fpbxml {<File Name="}
      puts -nonewline $fpbxml $filename
      puts -nonewline $fpbxml {" Type="}

      if {[string match -nocase "vhd" $filetype] || [string match -nocase "vhdl" $filetype] } {
         puts -nonewline $fpbxml {VHDL}
      } elseif [string match -nocase "v" $filetype] {
         if [string match -nocase "conv_pkg.v" [file tail $filename]] {
            puts -nonewline $fpbxml {VHeader}
         } else {
            puts -nonewline $fpbxml {Verilog}
         }
      } elseif [string match -nocase "dat" $filetype] {
            puts -nonewline $fpbxml {MIF}
	
      } elseif [string match -nocase "mem" $filetype]{
	    puts -nonewline $fpbxml {MEM}

      }else {
         puts -nonewline $fpbxml [string toupper $filetype]
      }

      puts $fpbxml {">}
      puts $fpbxml "<Description>This is $filetype file</Description>"
      if { [string match -nocase "ncf" $filetype] } {
         puts -nonewline $fpbxml {<Properties IsEditable="false" IsTrackable="false" IsVisible="false" Timestamp="}
      } elseif { [string match -nocase "xdc" $filetype] } {
         puts -nonewline $fpbxml {<Properties IsEditable="false" IsTrackable="false" IsVisible="true" ScopedToRef="}
         set paramvalueTopLevelModule [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
         puts -nonewline $fpbxml ${paramvalueTopLevelModule}
         puts -nonewline $fpbxml {" Timestamp="}
      } else {
         puts -nonewline $fpbxml {<Properties IsEditable="false" IsTrackable="false" IsVisible="true" Timestamp="}
      }
      puts $fpbxml "$filetimestamp\"/>"
      if { [string match -nocase "ngc" $filetype] } {
         puts $fpbxml {<UsedIn Val="SYNTHESIS"/>}
         puts $fpbxml {<UsedIn Val="IMPLEMENTATION"/>}
      } elseif { [string match -nocase "v" $filetype] || [string match -nocase "vhd" $filetype] || [string match -nocase "vhdl" $filetype] } {
         set dirnames [split $filename /]
         set sfilename [lindex $dirnames end]
         set origrootname [ file rootname [lindex $sfilename 0] ]
         set paramvalueTestBenchModule [ dsp_get_param_value_in_driver_tcl_namespace TestBenchModule ]
         if { [ dsp_has_testbench ] && [ string match -nocase ${paramvalueTestBenchModule} $origrootname ] } {
            puts $fpbxml {<UsedIn Val="SIMULATION"/>}
         } else {
            if { [string match -nocase "vhd" $filetype] || [string match -nocase "vhdl" $filetype]} {
               if { ![string equal $vhdllibname ""] } {
                  puts -nonewline $fpbxml {<Library Name="}
                  puts -nonewline $fpbxml ${vhdllibname}
                  puts $fpbxml {"/>}
               }
            }
            puts $fpbxml {<UsedIn Val="SYNTHESIS"/>}
            puts $fpbxml {<UsedIn Val="SIMULATION"/>}
         }
      } elseif { [string match -nocase "ucf" $filetype] || [string match -nocase "ncf" $filetype] || [string match -nocase "xcf" $filetype]} {
         puts $fpbxml {<UsedIn Val="IMPLEMENTATION"/>}
      } elseif { [string match -nocase "xdc" $filetype] } {
         puts $fpbxml {<UsedIn Val="SYNTHESIS"/>}
         puts $fpbxml {<UsedIn Val="IMPLEMENTATION"/>}
      } elseif { [string match -nocase "dat" $filetype] } {
         puts $fpbxml {<UsedIn Val="SYNTHESIS"/>}
         puts $fpbxml {<UsedIn Val="SIMULATION"/>}
      } elseif { [string match -nocase "mif" $filetype] || [string match -nocase "coe" $filetype] || [string match -nocase "mem" $filetype] } {
         puts $fpbxml {<UsedIn Val="SIMULATION"/>}
      } else {
         puts $fpbxml {<UsedIn Val="SYNTHESIS"/>}
      }
      puts $fpbxml {</File>}
   }

   #-------------------------------------------------------------------------
   # add files to bxml
   #-------------------------------------------------------------------------
   proc dsp_bxml_add_files {fp} {
      set projfilesexts "ucf xdc mif ngc v vh vhd vhdl testbench dat mem"
      set retcode [ dsp_reset_project_file_list_var $projfilesexts ]

      set manualsimfiles [list]
      set filedir [ dsp_get_sysgen_project_file_dir ]

      set paramvalueTestBenchModule [ dsp_get_param_value_in_driver_tcl_namespace TestBenchModule ]
      set paramvalueProjectFiles [ dsp_get_param_value_in_driver_tcl_namespace ProjectFiles ]
      foreach p ${paramvalueProjectFiles} {
         set filen [list]
         set origname [lindex $p 0]
         set origrootname [ file rootname [lindex $p 0] ]
         set filenameraw "$filedir/$origname"
         if { [file exists $filenameraw] } {
            set filename [file normalize $filenameraw]
         } else {
            set filename [file normalize $origname]
         }
         set opts [lrange $p 1 end]
         set nopts [llength $opts]
         if {$nopts % 2 != 0} {
            error "Parameter \"ProjectFiles\" contains an invalid value \"$p\"."
         }
         # Remember it if the project contains a Verilog source file.
         if { [string match -nocase "*.v" $filename] || [string match -nocase "*.vh" $filename]  } {
            set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
         }

         foreach curext $projfilesexts {
            if { [string match -nocase "*.$curext" $filename] } {
               if { [string match -nocase "*.v" $filename] || [string match -nocase "*.vhd" $filename] || [string match -nocase "*.vh" $filename]  || [string match -nocase "*.vhdl" $filename]} {
                  if { [ dsp_has_testbench ] && [ string match -nocase ${paramvalueTestBenchModule} ${origrootname} ] } {
                     set listvarname [ dsp_get_list_var_name "testbench" ]
                     lappend $listvarname $filename
                  } else {
                     lappend filen $filename
                     set vhdllibname ""

                     for {set i 0} {$i < $nopts} {set i [expr {$i + 2}]} {
                        set key [lindex $opts $i]
                        set val [lindex $opts [expr {$i + 1}]]
                        switch -- $key {
                           "-lib" {
                              set vhdllibname $val
                              #puts $fpcallback2 "set_property library ${val} \[get_files -of_object \{sources_1\} ${origname}\]"
                              #set_property library $val [get_files -of_object {sources_1} $origname]
                           }
                        }
                     }

                     if { [string equal $vhdllibname "work"] } {
                        dsp_bxml_add_file_list $fp $filen
                     } else {
                        dsp_bxml_add_file_list $fp $filen $vhdllibname
                     }
                  }
               } else {
                  set listvarname [ dsp_get_list_var_name $curext ]
                  lappend $listvarname $filename
               }
               break
            }
         }
      }

      foreach curext $projfilesexts {
         set listvarname [ dsp_get_list_var_name $curext ]
         if { [ info exists $listvarname ] } {
            set handlername [ dsp_get_bxml_add_project_files_handler_name $curext ]
            set findproc [ info proc $handlername ]
            if { [ string length $findproc ] > 0  } {
               eval $handlername $fp $listvarname
            }
         }
      }

      set synthesistooltype [ dsp_get_param_value_in_driver_tcl_namespace SynthesisTool ]
      if {[string equal -nocase ${synthesistooltype} "RDS"]
         || [string equal -nocase ${synthesistooltype} "Vivado"] } {

         set ipdir [ dsp_get_scoped_ip_dir_full_path ]
         if { ![ file exists $ipdir ] } {
            file mkdir $ipdir
         }
         set coeSources [ glob -nocomplain $filedir/*.coe ]
         foreach coefile $coeSources {
            file copy -force $coefile $ipdir
            dsp_bxml_add_file $fp $coefile
         }
 	 set memSources [ glob -nocomplain $filedir/*.mem ]
         foreach memfile $memSources {
            file copy -force $memfile $ipdir
            dsp_bxml_add_file $fp $memfile
         }	

         set callbackname "sgpaintcallback.tcl"
         if { [file exists $callbackname ] } {
             file delete -force $callbackname
         }
         # Added for SgVivadoCore.tcl file for callback from Vivado project
         set CoreConfigTclFile "${filedir}/SgVivadoCore.tcl"
         set CoreConfigTclFile [file normalize ${CoreConfigTclFile}]

         set listvarname [ dsp_get_list_var_name ngc ]
         if { [ info exists $listvarname ] } {
            set ngcfiles [ dsp_get_file_name_list $filedir {.ngc} 0 $listvarname]
         } else {
            set ngcfiles [ dsp_get_file_name_list $filedir {.ngc} ]
         }

         if { [llength $ngcfiles] > 0} {
            dsp_bxml_add_file_list $fp $ngcfiles
         }
      } else {
         set fileext ".ngc"
         set listvarname [ dsp_get_list_var_name ngc ]
         if { [ info exists $listvarname ] } {
            dsp_bxml_add_file_ext $fp $filedir $fileext $listvarname
         } else {
            dsp_bxml_add_file_ext $fp $filedir $fileext
         }
     }
 
     set fileextlist [list]
     lappend fileextlist ".edn"
     lappend fileextlist ".edf"
     lappend fileextlist ".ndf"

     foreach fileext $fileextlist {
        dsp_bxml_add_file_ext $fp $filedir $fileext
     }

     if { [ dsp_has_testbench ] } {
        set listvarname [ dsp_get_list_var_name "testbench" ]
        if { [info exists $listvarname] } {
           set tbfiles [set $listvarname] 
        } else {
           set tbfiles ""
        }
        if { [llength $tbfiles] > 0 } {
           set manualsimfiles [ dsp_merge_lists $manualsimfiles $tbfiles ]
        }
 
        set datapath [ dsp_get_sysgen_project_file_search_path_list ]
        set datfiles [ dsp_get_file_name_list_from_pathlist $datapath {.dat} ]

        if { [llength $datfiles] > 0 } {
           set manualsimfiles [ dsp_merge_lists $manualsimfiles $datfiles ]
        }

        if { [llength $manualsimfiles] > 0 } {
           dsp_write_manualsimfile_list $manualsimfiles
        } else {
           set subname [ dsp_get_param_value_in_sysgensubmodule_tcl_namespace submodule_name ]
           set filename ${subname}.simset
           set tmpfilename "./sysgen/$filename"
           set tmpfilename [file normalize $tmpfilename ]

           if { [ file exists $tmpfilename ] == 1 } {
              file delete $tmpfilename
           }
        }

     }
   }

   #-------------------------------------------------------------------------
   # Creates bxml for SysGen sub module in a PA project
   #-------------------------------------------------------------------------
   proc dsp_write_bxml_file {} {
      set subname [ dsp_get_param_value_in_sysgensubmodule_tcl_namespace submodule_name ]
      set filename ${subname}.bxml
      set bxmlfilename "./$filename"
      set bxmlfilename [file normalize $bxmlfilename ]
      set fp [open $bxmlfilename w]
      set smachinetimestamp [clock seconds]
      puts $fp {<Root MajorVersion="0" MinorVersion="18" xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="Compositefile.xsd">}
      set paramvalueTopLevelModule [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
      set devicenamevalue [ dsp_get_devicename ]
      puts $fp "<CompositeFile CompositeFileTopName=\"${paramvalueTopLevelModule}\" CanBeSetAsTop=\"false\" CanDisplayChildGraph=\"true\" Part=\"${devicenamevalue}\">"
      puts $fp {<Description>A description of the composite file</Description>}

      puts -nonewline $fp {<Generation Name="SYNTHESIS" State="GENERATED" Timestamp="}
      puts $fp "$smachinetimestamp\"/>"

      puts -nonewline $fp {<Generation Name="IMPLEMENTATION" State="GENERATED" Timestamp="}
      puts $fp "$smachinetimestamp\"/>"

      puts -nonewline $fp {<Generation Name="SIMULATION" State="GENERATED" Timestamp="}
      puts $fp "$smachinetimestamp\"/>"

      puts $fp {<FileCollection Name="SOURCES" Type="SOURCES">
<Description>A description for this file collection</Description>}

      dsp_bxml_add_files $fp

      puts $fp {</FileCollection>
</CompositeFile>
</Root>}
      close $fp
   }

   #-------------------------------------------------------------------------
   # Creates a SysGen sub module for existing PlanAhead project.
   #-------------------------------------------------------------------------
   proc dsp_create_sysgen_submodule {} {
      dsp_write_bxml_file
    }

   #-------------------------------------------------------------------------
   # Creates a new PlanAhead project.
   #-------------------------------------------------------------------------
   proc dsp_create_planahead_project {} {
      #puts "PRINT: Entered dsp_create_planahead_project"
      dsp_start_project_creation
      dsp_set_synthesis_settings
      dsp_set_implementation_settings
      dsp_set_simulation_settings
      dsp_set_target_language_settings
      if { [ dsp_get_param_value_in_driver_tcl_namespace CompilationFlow ] == "IP" } {
          dsp_ipp_create_ips 
      } else {
          dsp_add_project_files
      }

      if { [ dsp_is_bitstream_compilation ] } {
         dsp_generate_planahead_bitstream
      }  
      dsp_finish_project_creation
   }

   #-------------------------------------------------------------------------
   # check bitstream file.
   #-------------------------------------------------------------------------
   proc dsp_check_bitstream_file {} {
      set paramvalueProjDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
 
      set bitfile ${paramvalueProjDir}/${paramvalueProject}.runs/impl_1/${paramvalueProject}.bit 
      if { ! [ file exists $bitfile ] } {
         set bitgenerrmsg "failed to generate bitstream file $bitfile.\n"
         #error "ERROR: $bitgenerrmsg"
         puts "ERROR: $bitgenerrmsg"
         exit 1
      }
   }

   #-------------------------------------------------------------------------
   # Compiles an PlanAhead project into a bitstream.
   #-------------------------------------------------------------------------
   proc dsp_generate_planahead_bitstream {} {
      set paramvalueProjDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
       
      ::reset_run synth_1
      ::reset_run impl_1

      #::set_param logicopt.enableMandatoryLopt no

      ::launch_runs synth_1
      ::wait_on_run synth_1

      set runmelog ${paramvalueProjDir}/${paramvalueProject}.runs/synth_1/runme.log
      dsptest_print_file_to_stdout $runmelog

      #::set_property add_step Bitgen [get_runs impl_1] 

      ::launch_runs impl_1 -to_step bitgen
      ::wait_on_run impl_1

      set runmelog ${paramvalueProjDir}/${paramvalueProject}.runs/impl_1/runme.log
      dsptest_print_file_to_stdout $runmelog

      dsp_check_bitstream_file
   }

   #-------------------------------------------------------------------------
   # Do smoket test for an PlanAhead project
   #-------------------------------------------------------------------------
   proc dsptest_compile_planahead_project {} {
      set status [dsp_handle_exception {
         dsp_process_parameters
         dsp_dump_parameters
      } "ERROR: An error occurred when processing project parameters."]
      if {!$status} { return }

      set paramvalueProjDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]

      ::set_param logicopt.enableMandatoryLopt no

      set ext {.xpr}
      if { [ dsp_is_running_vivado ]} {
         set ext {.xpr}
      } else {
         set ext {.ppr}
      }
      ::open_project ${paramvalueProjDir}/${paramvalueProject}${ext}

      if { [ dsp_is_bitstream_compilation ] } {
         ::open_rtl_design -name rtl_1
         ::open_impl_design
         ::close_project
         dsp_check_bitstream_file
         return;
      }

      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      set has_simtime [info exists ${driverns}::SimulationTime]
      if {$has_simtime && [ dsp_is_running_planAhead ]} {
         set isimcmdfn [file normalize "xt_isim.cmd"]
         set isimcmd [open $isimcmdfn w]
         puts $isimcmd {onerror {resume}}
         set paramvalueSimulationTime [ dsp_get_param_value_in_driver_tcl_namespace SimulationTime ]
         puts $isimcmd "run ${paramvalueSimulationTime}"
         puts $isimcmd "quit -f"
         set_property isim.cmdfile $isimcmdfn [get_filesets sim_1]
         close $isimcmd
      }

      set ips [::get_ips -quiet]
      set nips [llength $ips]
      if { $nips > 0 } {
         ::reset_ip -ips [::get_ips]
         ::generate_ip -ips [::get_ips]
      }

      ::reset_run synth_1
      ::reset_run impl_1

      ::open_rtl_design -name rtl_1

      if { [ dsp_has_testbench ] } {
         if { [dsptest_launch_sim behavioral] == 0 } {
            ::close_project
            return
         }
      }

      ::launch_runs synth_1
      ::wait_on_run synth_1

      set runmelog ${paramvalueProjDir}/${paramvalueProject}.runs/synth_1/runme.log
      dsptest_print_file_to_stdout $runmelog

      set testerns [ dsp_get_tester_tcl_namespace_qualifiers ]
      if { [info exists ${testerns}::is_doing_planAheadGenPostSynthTest] } {
         ::close_project
         return
      }

      ::launch_runs impl_1
      ::wait_on_run impl_1

      set runmelog ${paramvalueProjDir}/${paramvalueProject}.runs/impl_1/runme.log
      dsptest_print_file_to_stdout $runmelog

      ::open_impl_design

      if { [ dsp_has_testbench ] } {
         if { [dsptest_launch_sim timing] == 0 } {
            ::close_project
            return
           }
      }

      ::close_project
   }

   #-------------------------------------------------------------------------
   # Entry point for creating a new PlanAhead project.
   #-------------------------------------------------------------------------
   proc dsp_create_project {} {
      set status [dsp_handle_exception {
         dsp_process_parameters
         dsp_dump_parameters
      } "ERROR: An error occurred when processing project parameters."]
      if {!$status} { return }

      set sysgensubns [ dsp_get_sysgensubmodule_tcl_namespace_qualifiers ]
      if { [info exists ${sysgensubns}::is_generating_sysgensubmodule] } {
         set status [dsp_handle_exception {
            dsp_create_sysgen_submodule
         } "ERROR: An error occurred when creating the Vivado project."]
         if {!$status} { return }
      } else {
         set status [dsp_handle_exception {
            dsp_create_planahead_project
         } "ERROR: An error occurred when creating the Vivado project."]
         if {!$status} { return }
      }
   }

   #-------------------------------------------------------
   # Check is the flow is Vivado or PlanAhead. Returns
   # 1 for vivado
   #-------------------------------------------------------
   proc dsp_isLinuxOS {} {
      set isLinux 0
      package require platform
      set osType [platform::generic]
      if { [string equal -nocase -length 5 $osType "linux"] == 1 } {
         set isLinux 1
      }
      return $isLinux
   }

   #-------------------------------------------------------
   # Launch the simulator based on the right context with options
   # passed as arguments 
   #-------------------------------------------------------
   proc dsptest_launch_sim { mode } {
      set simlog [dsptest_sim_log_file]
      if {[ dsp_is_running_vivado ]} {
      	set_property target_simulator XSim [current_project]
         if { [ string match $mode timing ] } {
            ::launch_simulation -mode [dsptest_translate_sim_mode $mode] -type [dsptest_get_sim_type $mode] -simset sim_1 
     } else {
            ::launch_simulation -mode [dsptest_translate_sim_mode $mode] -simset sim_1 
     }
         # use this check until close_sim works correctly on Windows also
         if { [dsp_isLinuxOS] } {
            ::close_sim
         }
      } else {
         ::launch_isim -batch -mode $mode -simset sim_1
         set simlog [dsptest_sim_log_file]
         set isimerrmsg [ dsptest_wait_on_isim $simlog $mode 1 ]
         if { [string length $isimerrmsg] > 0 } {
            return 0
         }
      }
      return 1
   }

   #--------------------------------------------------------
   # Return the simulation mode by mapping isim simulation mode
   # with xsim
   # -------------------------------------------------------
   proc dsptest_translate_sim_mode { mode } {
      switch -exact $mode {
         "timing"
         {return "post-implementation"}
         default
         {return $mode}
      }
   }

   #--------------------------------------------------------
   # Return the simulation type
   # with xsim
   # when we say 'timing', what we really want is 'functional'
   # -------------------------------------------------------
   proc dsptest_get_sim_type { mode } {
      switch -exact $mode {
         "timing"
         {return "functional"}
         default
         {return ""}
      }
   }

   #-------------------------------------------------------
   # Return path to the simulation log file to parse for errors
   # Used only by PlanAhead as in Vivado the error appears in
   # the vivad.log file 
   #-------------------------------------------------------
   proc dsptest_sim_log_file {} {
      set paramvalueProjDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
      set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
      if {[ dsp_is_running_vivado ]} {
         return ${paramvalueProjDir}/${paramvalueProject}.sim/sim_1/isim.log
      } else {
         return ${paramvalueProjDir}/${paramvalueProject}.sim/sim_1/isim.log
      }
   }
  
  #-------------------------------------------------------
  # Here are some file processing libraries that used in dsp_ip_packager.
  # There file processing libraries are very important.
  # You can use these functions to find files with patterns, 
  # read in file, write data to file, replace certain string with file. 
  # If you find any mistakes, please contact Guosheng Wu
  # Emial:guoshen@xilinx.com
  #-------------------------------------------------------
  #-------------------------------------------------------
  # Return file list of full path names under base director with pattern
  # basedir - the directory to start looking in 
  # pattern - A pattern, as defined by the glob command, that the files must match 
  #-------------------------------------------------------
    proc dsp_find_files_with_pattern { basedir pattern } {  
       set basedir [string trimright [file join [file normalize $basedir] { }]]
       set fileList {}
       foreach fileName [glob -nocomplain -type {f r} -path $basedir $pattern] {
          lappend fileList $fileName
       }
       foreach dirName [glob -nocomplain -type {d  r} -path $basedir *] {
          set subDirList [dsp_find_files_with_pattern $dirName $pattern]
          if { [llength $subDirList] > 0 } {
             foreach subDirFile $subDirList {
                lappend fileList $subDirFile
             }
         }
      }
      return $fileList
 }
  #-------------------------------------------------------
  # Read file to memory
  # filename: the full path file 
  # return data from filename
  #-------------------------------------------------------
    proc dsp_read_file {filename} { 
       set fd [open $filename]
       set data [read $fd]
       close $fd
       return $data
    }     
  #-------------------------------------------------------
  # Write file with data
  # filename: the full path file 
  # data: data need to write to file
  #-------------------------------------------------------
    proc dsp_write_file {filename data} { 
       set fd [open $filename w]
       puts -nonewline $fd $data
       close $fd
    } 
  
  #-------------------------------------------------------
  # replace data in file 
  # filename: the full path file 
  # pattern: pattern for replace
  # replacement: new string used to replace stirng
  #-------------------------------------------------------
    proc dsp_replace_in_file {filename pattern replacement} { 
       set cont [dsp_read_file $filename]
       regsub -all $pattern $cont $replacement result
       dsp_write_file $filename $result
    } 
  #-------------------------------------------------------
  # Copy file to specified location
  # baseDir: base directory, from which to copy files
  # destDir: Destination Directory
  # patterns: pattern list. for example, set a {"*.v"} or set a {"*.v" "*.hdl" "*.ngc"}, using space to seperate
  #-------------------------------------------------------
   proc dsp_ip_packager_copy_files {baseDir destDir patterns} {  
       file mkdir $destDir
       foreach pattern $patterns {
          set ipFiles [dsp_find_files_with_pattern $baseDir $pattern]
          foreach absFile $ipFiles {
           if { [dsp_isLinuxOS] } {
      file copy -force $absFile $destDir
      
           } else {
      if { [string length $absFile] <256 } {
        file copy -force $absFile $destDir
           } else {

      error "ERROR:file path too long, please reduce the path length: $absFile" 

            }
           }
    
          }
      }
  }
 
  #-------------------------------------------------------
  # Here are some element functions for dsp_ip_packager.
  # If you find any mistakes, please contact Guosheng Wu
  # Emial:guoshen@xilinx.com
  #-------------------------------------------------------
  #-------------------------------------------------------
  # Return the IP Packager file location
  #-------------------------------------------------------
    proc dsp_ip_packager_get_location { } {
       return "ip_catalog"
    }
  #-------------------------------------------------------
  # Return the top level module name
  #-------------------------------------------------------
    proc dsp_ip_packager_get_top_name { } {
       set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
       return [dsp_required_parameter ${driverns}::TopLevelModule]
    }
  #-------------------------------------------------------
  # Return vendor value
  #-------------------------------------------------------    
    proc dsp_ip_packager_get_vendor {} {
       set text [dsp_get_param_value_in_driver_tcl_namespace IP_Vendor_Text]
       set replace [string map {" " "_"} $text]
       return $replace
    }
  #-------------------------------------------------------
  # Return library value
  #-------------------------------------------------------
    proc dsp_ip_packager_get_library {} {
       set lib [dsp_get_param_value_in_driver_tcl_namespace IP_Library_Text]
       set replace [string map {" " "_"} $lib]
       return $replace
    }
  #-------------------------------------------------------
  # Return Version number
  #-------------------------------------------------------
    proc dsp_ip_packager_get_version {} {
       set version [dsp_get_param_value_in_driver_tcl_namespace IP_Version_Text]
       set result [split $version "."]
       if { [llength $result] < 2 } {
          set ver [format "%s.0" $version]
          return $ver
       } else {
          return $version
       }
    }
  #----------------------------------------------------
  # Returns version number by replacing . with _ useful to create
  # directories
  #----------------------------------------------------
    proc dsp_ip_packager_get_version_no_dot {} {
        set version [string map {"." "_"} [dsp_ip_packager_get_version]]
        return $version
    }
    
    proc dsp_ip_packager_get_revision {} {
       set revision [dsp_get_param_value_in_driver_tcl_namespace IP_Revision]
       return $revision
    }
  #-------------------------------------------------------
  # Return taxonomy
  #-------------------------------------------------------
    proc dsp_ip_packager_get_taxonomy {} {
       set taxonomy [dsp_get_param_value_in_driver_tcl_namespace IP_Categories_Text]
       set replace [string map {" " "_"} $taxonomy]
       set final [format "{/%s}" $replace]
       return $final
    }
    
  #-------------------------------------------------------
  # Return ip dir
  #-------------------------------------------------------
    proc dsp_ip_packager_get_common_Repos_flag {} {
       return [dsp_get_param_value_in_driver_tcl_namespace IP_Common_Repos]
    }
    proc dsp_ip_packager_get_common_Repos {} {
       set repos [dsp_get_param_value_in_driver_tcl_namespace IP_Dir]
       return $repos
    }

  #-------------------------------------------------------
  # Return Auto Infer
  #-------------------------------------------------------
    proc dsp_ip_packager_get_Auto_Infer_flag {} {
       return [dsp_get_param_value_in_driver_tcl_namespace IP_Auto_Infer]
    }
    
    
  #-------------------------------------------------------
  # Return Use Socketable IP flow
  #-------------------------------------------------------
    proc dsp_ip_packager_get_Socket_IP_Flag {} {
       return [dsp_get_param_value_in_driver_tcl_namespace IP_Socket_IP]
    }
    
  #-------------------------------------------------------
  # Return the socketable IP project
  #-------------------------------------------------------
    proc dsp_ip_packager_get_Socket_IP_Project {} {
       set repos [dsp_get_param_value_in_driver_tcl_namespace IP_Socket_IP_Proj_Path]
       return $repos
    }
  #-------------------------------------------------------
  # get the status of this IP
  #-------------------------------------------------------    
    proc dsp_ip_packager_get_life_cycle {} {
       set cycle [dsp_get_param_value_in_driver_tcl_namespace IP_LifeCycle_Menu]
       if {$cycle == "1"} {
          return {Production}
       }
       if {$cycle == "2"} {
          return {Beta}
       }
       if {$cycle == "3"} {
          return "Pre-Production"
       }
    }
  #-------------------------------------------------------
  # get the descriptions for the ip
  #-------------------------------------------------------    
    proc dsp_ip_packager_get_description {} {
       set text [dsp_get_param_value_in_driver_tcl_namespace IP_Description]
       set descrip [format " This IP was generated from System Generator. All changes must be made in SysGen model. %s " $text]
       return $descrip
    }
  #-------------------------------------------------------
  # Set the default values for ip packager process
  #-------------------------------------------------------
    proc dsp_ip_packager_set_default_value { } {  
       set currentCore [ipx::current_core]
       set_property vendor [dsp_ip_packager_get_vendor] $currentCore
       set_property library [dsp_ip_packager_get_library] $currentCore
       set_property name [dsp_ip_packager_get_top_name] $currentCore
       set_property version [dsp_ip_packager_get_version] $currentCore
       set_property core_revision [dsp_ip_packager_get_revision] $currentCore
       set_property display_name [dsp_ip_packager_get_top_name] $currentCore
       set_property description [dsp_ip_packager_get_description] $currentCore
       set_property company_url {} $currentCore
       set_property taxonomy [dsp_ip_packager_get_taxonomy] $currentCore
       set_property definition_source {sysgen} $currentCore
    } 
  #-------------------------------------------------------
  # Set support family for ip packager process
  #-------------------------------------------------------
    proc dsp_ip_packager_set_support_family { } { 
        #set the support family
       set currentCore [ipx::current_core]
       set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
       set tmplist [list]
       lappend tmplist [dsp_required_parameter ${driverns}::DSPFamily]
       lappend tmplist [dsp_ip_packager_get_life_cycle]
       set_property supported_families $tmplist $currentCore
    }
 
  #-------------------------------------------------------
  #Set the payment property for IP
  #required: true or false. If true, it requires payment, else no payment needs
  # 
  #-------------------------------------------------------
  proc dsp_ip_packager_set_payment {required} { 
      set currentCore [ipx::current_core]
      set_property payment_required $required $currentCore
      #set_property supports_coregen {false} $currentCore
  } 

  #-------------------------------------------------------
  #Set the license property for IP
  #license: license key
  #descrip: description for the license key
  #-------------------------------------------------------
    proc dsp_ip_packager_set_license {license descrip} { 
       set currentCore [ipx::current_core]
       ipx::add_license_key $license $currentCore
       set_property description $descrip [ipx::get_license_key $license $currentCore]
    } 
  #-------------------------------------------------------
  # Get IP path based on filled property 
  #-------------------------------------------------------
    proc dsp_ip_packager_get_full_path {} {  
       set currentCore [ipx::current_core]
       dsp_ip_packager_set_default_value
       dsp_ip_packager_set_support_family
       set root [get_property root_directory $currentCore]
       set ven [get_property vendor $currentCore]
       set lib [get_property library $currentCore]
       set nam [get_property name $currentCore]
       set ver [get_property version $currentCore]
       set folder [dsp_ip_packager_get_location]
       set verlist [split $ver {.}]
       set verstr ""
       foreach verpart $verlist {
          if { [string length $verstr] < 1 } {
             set verstr $verpart
          } else {
             set verstr [format "%s_%s" $verstr $verpart]
          }
       }
       set ipname [format "%s/%s/%s_%s_%s_v%s" $root $folder $ven $lib $nam $verstr]
       return $ipname
    } 
  #-------------------------------------------------------
  # Get IP name based on filled property 
  #-------------------------------------------------------
    proc dsp_ip_packager_get_ip_name {} {  
       set currentCore [ipx::current_core]
       dsp_ip_packager_set_default_value
       dsp_ip_packager_set_support_family
       set ven [get_property vendor $currentCore]
       set lib [get_property library $currentCore]
       set nam [get_property name $currentCore]
       set ver [get_property version $currentCore]
       set verlist [split $ver {.}]
       set verstr ""
       foreach verpart $verlist {
          if { [string length $verstr] < 1 } {
             set verstr $verpart
          } else {
             set verstr [format "%s_%s" $verstr $verpart]
          }
       }
       set ipname [format "%s_%s_%s_v%s" $ven $lib $nam $verstr ]
       return $ipname
    } 
  #-------------------------------------------------------
  # Here are some functions that actually doing dsp_ip_packager.
  # If you find any mistakes, please contact Guosheng Wu
  # Emial:guoshen@xilinx.com
  #-------------------------------------------------------
  #-------------------------------------------------------
  # add files to file group
  # dir: directory to find files
  # pattern: pattern file format
  #-------------------------------------------------------
   proc dsp_ip_packager_add_files_to_group_xci {dir group patterns libname} {  
      set root [get_property root_directory [ipx::current_core]]
      foreach pattern $patterns {
         set ipFiles [dsp_find_files_with_pattern $dir $pattern]
         foreach absFile $ipFiles {
            set file [string range $absFile [expr [string length $root] + 1] [string length $absFile]]
            ipx::add_file $file $group
            set_property library_name $libname [ipx::get_file $file $group]
         }
      }
  }
  #-------------------------------------------------------
  # add files to file group
  # dir: directory to find files
  # pattern: pattern file format
  #-------------------------------------------------------
   proc dsp_ip_packager_add_files_to_group {dir group patterns libname} {  
      set root [get_property root_directory [ipx::current_core]]
      set folder [dsp_ip_packager_get_location]
      set ippath [format "%s/" [dsp_ip_packager_get_full_path]]
      set nam [dsp_ip_packager_get_top_name]
      foreach pattern $patterns {
         set ipFiles [dsp_find_files_with_pattern $dir $pattern]
         foreach absFile $ipFiles {
            set file [string range $absFile [string length $ippath] [string length $absFile]]
            ipx::add_file $file $group
            set_property library_name $libname [ipx::get_file $file $group]
         }
      }
  }

  #-------------------------------------------------------
  # Add sub IPs using subcore reference. Will deprecate soon
  #-------------------------------------------------------
   proc dsp_ip_packager_add_sub_ips {} { 
        set currentCore [ipx::current_core]
        set synth [ipx::get_file_groups xilinx_anylanguagesynthesis -of $currentCore] 
        set sim [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of $currentCore]
        set root [get_property root_directory $currentCore]
        set nam [dsp_ip_packager_get_top_name] 
        set ippath [dsp_ip_packager_get_full_path]
        set folder [dsp_ip_packager_get_location]
        set ips [get_ips]
        
        if {[llength $ips] > 0 } {
            generate_target {simulation Synthesis} $ips
            #special handler for only one IP situation, as if the result is only one ip, it returns string, not list.
            if {[llength $ips] == 1} {
                set ips [list $ips]
            }
            
            foreach ipName $ips {
                set ipPath [get_property IP_DIR $ipName]
                set vlnv [get_property IPDEF $ipName]
                set result [split $vlnv ":"]
                if { [llength $result] != 4} {
                    error "ERROR: Bad VLNV value for IP: $ips\n V:Vendor, L: Library, N: Name, V: Version " 
                }
                set vendor [lindex $result 0] 
                set library [lindex $result 1]
                set name [lindex $result 2] 
                set version [lindex $result 3] 
                # Add subcore reference to Synthesis 
                set baseDir [format "%s/synth" $ipPath]
                set destDirSynth [format "%s/ips/%s/synth" $ippath $ipName]
                dsp_ip_packager_copy_files $baseDir $destDirSynth {"*.ngc" "*.v" "*.vhd" "*.vhdl" "*.mif" "*.coe" "*.mem"}
                ipx::add_component_subcore_ref $vendor $library $name $version $synth
                dsp_ip_packager_add_files_to_group $destDirSynth $synth {"*.ngc" "*.v" "*.vhd" "*.vhdl" "*.mif" "*.coe" "*.mem"} {work}
                # Add subcore reference to Simulation    
                set baseDir [format "%s/sim" $ipPath]
                set destDirSim [format "%s/ips/%s/sim" $ippath $ipName]
                dsp_ip_packager_copy_files $baseDir $destDirSim {"*.ngc" "*.v" "*.vhd" "*.vhdl" "*.mif" "*.coe" "*.mem"}
                ipx::add_component_subcore_ref $vendor $library $name $version $sim
                dsp_ip_packager_add_files_to_group $destDirSim $sim {"*.ngc" "*.v" "*.vhd" "*.vhdl" "*.mif" "*.coe" "*.mem"}  {work}

                # Add COE file into synthesis and simulation
                set baseDir [format "%s/%s/%s.srcs/sources_1/ip/" $root $folder $nam]
                set destDir [format "%s/ips" $ippath]
                dsp_ip_packager_copy_files $baseDir $destDir {"*.coe"}
                dsp_ip_packager_add_files_to_group $destDir $synth {"*.coe"} {work}
                dsp_ip_packager_add_files_to_group $destDir $sim {"*.coe"}  {work}

            }    
            
        }
    }
  #-------------------------------------------------------
  # Add sub IPs
  # Package "XCI" and "XCO" files into IP
  #-------------------------------------------------------
    proc dsp_ip_packager_add_sub_core {} { 
        set currentCore [ipx::current_core]
        set synth [ipx::get_file_groups xilinx_anylanguagesynthesis -of $currentCore] 
        set sim [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of $currentCore]
        set root [get_property root_directory $currentCore]
        set nam [dsp_ip_packager_get_top_name] 
        set folder [dsp_ip_packager_get_location]
        set ippath [dsp_ip_packager_get_full_path]
        set ips [get_ips]
        
        if {[llength $ips] > 0 } {
            #generate_target {simulation Synthesis} $ips
            #special handler for only one IP situation, as if the result is only one ip, it returns string, not list.
            if {[llength $ips] == 1} {
                set ips [list $ips]
            }
            
            foreach ipName $ips {
                set srcPath [get_property IP_DIR $ipName]
                # Add subcore reference to Synthesis 
                set baseDir [format "%s" $srcPath]
                set destDirSynth [format "%s/ips/%s/synth" $ippath $ipName]
                dsp_ip_packager_copy_files $baseDir $destDirSynth {"*.xci" "*.xco"}
                dsp_ip_packager_add_files_to_group $destDirSynth $synth {"*.xci" "*.xco"} {work}
                # Add subcore reference to Simulation    
                set baseDir [format "%s" $srcPath]
                set destDirSim [format "%s/ips/%s/sim" $ippath $ipName]
                dsp_ip_packager_copy_files $baseDir $destDirSim {"*.xci" "*.xco"}
                dsp_ip_packager_add_files_to_group $destDirSim $sim {"*.xci" "*.xco"}  {work}
            }    
            
        }
    }
  #-------------------------------------------------------
  #Check whether the packaged IP contains sub IPs
  # if there is sub IPs,generate files then add all the files 
  #-------------------------------------------------------
    proc dsp_ip_packager_add_files {} {
        set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
        set currentCore [ipx::current_core]
     # remove all the file groups that automatical generated by ip packager
        ipx::remove_file_group {xilinx_verilogsynthesis} $currentCore
        ipx::remove_file_group {xilinx_verilogbehavioralsimulation} $currentCore
        ipx::remove_file_group {xilinx_verilogtestbench} $currentCore
        ipx::remove_file_group {xilinx_vhdlsynthesis} $currentCore
        ipx::remove_file_group {xilinx_vhdlbehavioralsimulation} $currentCore
        ipx::remove_file_group {xilinx_vhdltestbench} $currentCore
        ipx::remove_file_group {xilinx_implementation} $currentCore
        
     # create file group for adding files.
        ipx::add_file_group -type {synthesis} {} $currentCore 
        ipx::add_file_group -type {simulation} {} $currentCore    
        set synth [ipx::get_file_groups xilinx_anylanguagesynthesis -of $currentCore]
        set sim [ipx::get_file_groups xilinx_anylanguagebehavioralsimulation -of $currentCore]
        set_property model_name [dsp_ip_packager_get_top_name] $synth
        set_property model_name [dsp_ip_packager_get_top_name] $sim 
        set ippath [dsp_ip_packager_get_full_path]        
        set folder [dsp_ip_packager_get_location]
        
      # handling sub ips before copying all source files.
        dsp_ip_packager_add_sub_ips
        
      #copy and add files.
        set root [get_property root_directory $currentCore]
        set nam [dsp_ip_packager_get_top_name] 
        set baseDir [format "%s/%s/%s.srcs/sources_1/imports/sysgen/" $root $folder $nam]
        set destDir [format "%s/src/" $ippath]
        dsp_ip_packager_copy_files $baseDir $destDir {"*.ngc" "*.v" "*.vhd" "*.vhdl" "*.mem"}
        dsp_ip_packager_add_files_to_group $destDir $synth {"*.ngc" "*.v" "*.vhd" "*.vhdl" "*.mem"}  {work}
        dsp_ip_packager_add_files_to_group $destDir $sim {"*.ngc" "*.v" "*.vhd" "*.vhdl" "*.mem"} {work}
        
        set baseDir [format "%s/%s/%s.srcs/constrs_1/imports/sysgen/" $root $folder $nam]
        set destDir [format "%s/constrain/" $ippath]
        dsp_ip_packager_copy_files $baseDir $destDir {"*.xdc"}
        dsp_ip_packager_add_files_to_group $destDir $synth {"*.xdc"} {work}
        dsp_ip_packager_add_files_to_group $destDir $sim {"*.xdc"} {work}

        if { [ dsp_has_testbench ] }    {
            ipx::add_file_group -type {testbench} {} $currentCore
            set test [ipx::get_file_groups xilinx_testbench -of $currentCore]
            set_property model_name [dsp_ip_packager_get_top_name] $test
            set baseDir [format "%s/%s/%s.srcs/sim_1/imports/sysgen/" $root $folder $nam]
            set destDir [format "%s/testbench/" $ippath]
            dsp_ip_packager_copy_files $baseDir $destDir {"*.v" "*.vhd" "*.vhdl" "*.mem"}
            dsp_ip_packager_add_files_to_group $destDir $test {"*.v" "*.vhd" "*.vhdl" "*.mem"} {work}
        
            set baseDir [format "%s/%s/%s.srcs/sim_1/imports/" $root $folder $nam]
            set destDir [format "%s/testbench/" $ippath]
            dsp_ip_packager_copy_files $baseDir $destDir {"*.dat"}
            dsp_ip_packager_add_files_to_group $destDir $test {"*.dat"} {work}
        }
        ipx::add_file_group -type {utility} {} $currentCore
        set utility [ipx::get_file_groups xilinx_utilityxitfiles -of $currentCore]
        if { [ dsp_has_create_interface_document ] }    {
            ipx::add_file_group -type {version_info} {} $currentCore
            set versionInfo [ipx::get_file_groups xilinx_versioninformation -of $currentCore]
            set baseDir [format "%s/documentation/" $root]
            set destDir [format "%s/version_info/" $ippath]
            dsp_ip_packager_copy_files $baseDir $destDir {"*.htm"}
            dsp_ip_packager_add_files_to_group $destDir $versionInfo {"*.htm"} {work}
        
            set baseDir [format "%s/documentation/images/" $root]
            set destDir [format "%s/version_info/images/" $ippath]
            dsp_ip_packager_copy_files $baseDir $destDir {"*.jpg" "*.gif" "*.bmp" "*.png"}
            dsp_ip_packager_add_files_to_group $destDir $utility {"*.jpg" "*.gif" "*.bmp" "*.png"} {work}
        }
        
        if { [ dsp_has_create_interface_document ] }    {
            ipx::add_file_group -type {datasheet} {} $currentCore
            set datasheet [ipx::get_file_groups xilinx_datasheet -of $currentCore]
            set baseDir [format "%s/documentation/" $root]
            set destDir [format "%s/datasheet/" $ippath]
            dsp_ip_packager_copy_files $baseDir $destDir {"*.htm"}
            dsp_ip_packager_add_files_to_group $destDir $datasheet {"*.htm"} {work}
        
            set baseDir [format "%s/documentation/images/" $root]
            set destDir [format "%s/datasheet/images/" $ippath]
            dsp_ip_packager_copy_files $baseDir $destDir {"*.jpg" "*.gif" "*.bmp" "*.png"}
            dsp_ip_packager_add_files_to_group $destDir $utility {"*.jpg" "*.gif" "*.bmp" "*.png"} {work}
        }
    } 
    
  #-------------------------------------------------------
  # Ip packager remove sources
  # remove the source file of project
  # 
  #-------------------------------------------------------
    proc dsp_ip_packager_remove_sources {} {
       set filelist [get_files -of_objects {sources_1} *.v]
       if {[llength $filelist] > 0 } {
          remove_files $filelist
       }
       set filelist [get_files -of_objects {sources_1} *.vhd]
       if {[llength $filelist] > 0 } {
          remove_files $filelist
       }
       set filelist [get_files -of_objects {sources_1} *.vhdl]
       if {[llength $filelist] > 0 } {
          remove_files $filelist
       }
       set filelist [get_files -of_objects {sources_1} *.coe]
       if {[llength $filelist] > 0 } {
          remove_files $filelist
       }
       set filelist [get_files -of_objects {sources_1} *.mem]
       if {[llength $filelist] > 0 } {
          remove_files $filelist
       }
       #remove subips
       set ips [get_files -of_objects {sources_1} *.xci]
       if {[llength $ips ] > 0 } {
          remove_files -fileset sources_1 $ips
       }
   }
  #-------------------------------------------------------
  # Add IP to project
  #-------------------------------------------------------
    proc dsp_ip_packager_add_ip {} {  
       set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
       set currentCore [ipx::current_core]
       set root [get_property root_directory $currentCore]
       set ven [get_property vendor $currentCore]
       set lib [get_property library $currentCore]
       set nam [get_property name $currentCore]
       set ver [get_property version $currentCore]
       set vlnvs [format "%s:%s:%s:%s" $ven $lib $nam $ver]
       set instant [format "%s_0" [dsp_ip_packager_get_ip_name]]
       create_ip -vlnv $vlnvs -module_name $instant
       if { [ dsp_has_testbench ] }    {
          if { [dsp_hdllang_is_vhdl] } {
             set testbench [lindex [get_files -of_objects {sim_1} *_tb.vhd] 0]
             if { [string length $testbench] > 0} {
                set pattern [format "work.%s" [dsp_ip_packager_get_top_name]]
                set replace [format "work.%s" $instant]
                dsp_replace_in_file $testbench $pattern $replace
             }
          } else {
            set testbench [lindex [get_files -of_objects {sim_1} *_tb.v] 0]
            if { [string length $testbench] > 0} {
               set pattern [format " %s " [dsp_ip_packager_get_top_name]]
               set replace [format " %s " $instant]
               dsp_replace_in_file $testbench $pattern $replace
            }
        }
            
       set_property top $instant [current_fileset]
       update_compile_order -fileset sources_1
       generate_target {Simulation Synthesis instantiation_template} [get_ips]
     }
  }
  
  
   #-------------------------------------------------------
   # Get Sysgen location
   #-------------------------------------------------------
   proc dsp_ip_packager_sysgen_location {} {
     return "sysgen"
   }

   #-------------------------------------------------------
   # Get Documentation location
   #-------------------------------------------------------
   proc dsp_ip_packager_sysgen_documentation {} {
     return "documentation"
   }

   #-------------------------------------------------------
   # Based on extension name to get the corresponding handler
   #-------------------------------------------------------
   proc dsp_ip_packager_get_handler_name { extname } {
      set extlower [ string tolower $extname ]
      return dsp_ip_packager_handler_$extlower
   }
 #-----------------------------------------------------------------
 # Locates the root of Xilinx IP Repository. Returns empty if not found
 #-----------------------------------------------------------------
 proc dsp_get_xilinx_ip_repository_root {} {
     set rdi_data_dir_env $::env(RDI_DATADIR)
     if {[dsp_isLinuxOS]} {
         set path_sep ":"
     } else {
         set path_sep ";"
     }
     set index_file_name ""
     set rdi_data_dirs [split $rdi_data_dir_env $path_sep]
     foreach rdi_data_dir $rdi_data_dirs {
         set index_file_name [file normalize [file join $rdi_data_dir "ip/vv_index.xml"]]
         if { [file exists $index_file_name ] } {
             return [file dirname $index_file_name] 
         }
      }
      return ""
 }
 
 #
 # Constructs the handler name based on file extension
 #
 proc dsp_ipp_get_files_handler_name { ext } {
     return dsp_ipp_handler_$ext
 }
 
 #
 # Constructs the handler name based on testbench file extension
 #
 proc dsp_ipp_get_testbench_files_handler_name { ext } {
     return dsp_ipp_handler_testbench_$ext
 }
 
 #
 # Get synthesis file group based on top level language
 #
 proc dsp_ipp_get_synthesis_file_group {} {
     if { [dsp_hdllang_is_vhdl] } {
         set synth_file_group_text "xilinx_vhdlsynthesis"
     } else {
          set synth_file_group_text "xilinx_verilogsynthesis"    
     }
     set synth_file_group [ipx::get_file_groups -quiet $synth_file_group_text -of [ipx::current_core]]
     if { $synth_file_group == ""} {
         set synth_file_group [ipx::add_file_group $synth_file_group_text [ipx::current_core]]
     }
     set_property MODEL_NAME [dsp_get_param_value_in_driver_tcl_namespace TopLevelModule] $synth_file_group
     return $synth_file_group
 }
 #
 # Get software drivers file group
 #
 proc dsp_ipp_get_softwaredrivers_file_group {} {
     set file_group_text "xilinx_softwaredriver"
     set file_group [ipx::get_file_groups -quiet $file_group_text -of [ipx::current_core]]
     if { $file_group == ""} {
         set file_group [ipx::add_file_group $file_group_text [ipx::current_core]]
     }
     return $file_group
 }
 #
 # Get datasheet file group
 #
 proc dsp_ipp_get_datasheet_file_group {} {
     set datasheet_file_group [ipx::get_file_groups -quiet xilinx_product_guide -of [ipx::current_core]]
     if { $datasheet_file_group == ""} {
         set datasheet_file_group [ipx::add_file_group  xilinx_product_guide [ipx::current_core]]
     }
     return $datasheet_file_group
 }
 #
 # Get testbench file group based on top level language
 #
 proc dsp_ipp_get_testbench_file_group {} {
     if { [dsp_hdllang_is_vhdl] } {
        set tb_file_group_text "xilinx_vhdltestbench"
     } else {
        set tb_file_group_text "xilinx_verilogtestbench"
     }
     set tb_file_group [ipx::get_file_groups -quiet $tb_file_group_text -of [ipx::current_core]]
     if { $tb_file_group == "" } {
        set tb_file_group [ipx::add_file_group $tb_file_group_text [ipx::current_core]]
     }
     return $tb_file_group 
 }

 #
 # Get simulation file group based on top level language
 #
 proc dsp_ipp_get_simulation_file_group {} {
     if { [dsp_hdllang_is_vhdl] } {
         set sim_file_group_text "xilinx_vhdlbehavioralsimulation"
     } else {
          set sim_file_group_text "xilinx_verilogbehavioralsimulation"    
     }
     set sim_file_group [ipx::get_file_groups -quiet $sim_file_group_text -of [ipx::current_core]]
     if { $sim_file_group == ""} {
         set sim_file_group [ipx::add_file_group $sim_file_group_text [ipx::current_core]]
     }
     set_property MODEL_NAME [dsp_get_param_value_in_driver_tcl_namespace TopLevelModule] $sim_file_group
     return $sim_file_group
 }

 #-----------------------------------------------------------
 # Handles the processing of Verilog files for Packaging
 #-----------------------------------------------------------
 proc dsp_ipp_handler_v { filelist } {
     set top_module [dsp_get_param_value_in_driver_tcl_namespace TopLevelModule]
     set top_module_file "$top_module.v"
     set root_hdl_dir "[dsp_ipp_get_ip_directory]/hdl"
     file mkdir "$root_hdl_dir"
     set ordered_file_list [list]
     foreach ffile $filelist {    
         set library "work"
         set opts [lrange $ffile 1 end]
         set nopts [llength $opts]
         if {$nopts > 0} {
             set ffile [lindex $ffile 0]
             for {set i 0} {$i < $nopts} {set i [expr {$i + 2}]} {
                 set key [lindex $opts $i]
                 set val [lindex $opts [expr {$i + 1}]]
                 switch -- $key {
                     "-lib" {
                         set library $val
                     }
                 }
             }
         }
         file copy -force "$ffile" "$root_hdl_dir"              
         if { [string match conv_pkg.v [file tail $ffile]] } {
             set_property -dict "LIBRARY_NAME $library IS_INCLUDE true" [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]]
             set_property -dict "LIBRARY_NAME $library IS_INCLUDE true" [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_simulation_file_group]]
         } else { 
             set_property LIBRARY_NAME $library [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]]
             set_property LIBRARY_NAME $library [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_simulation_file_group]]
         }

         lappend ordered_file_list $ffile
         if { $top_module_file == [file tail $ffile] } {
             ipx::import_top_level_hdl -verbose -include_dirs [dsp_get_sysgen_project_file_dir] -ordered_files  $ordered_file_list -top_level_hdl_file $ffile -top_module_name $top_module [ipx::current_core]
             ipx::add_model_parameters_from_hdl -include_dirs [dsp_get_sysgen_project_file_dir] -ordered_files  $ordered_file_list -top_level_hdl_file $ffile -top_module_name $top_module [ipx::current_core]
         }
     }
 }

 #-----------------------------------------------------------
 # Handles the processing of Verilog files for Packaging
 #-----------------------------------------------------------
 proc dsp_ipp_handler_vh { filelist } {
     set root_hdl_dir "[dsp_ipp_get_ip_directory]/hdl"
     file mkdir "$root_hdl_dir"
     foreach ffile $filelist { 
         set library "work"
         set opts [lrange $ffile 1 end]
         set nopts [llength $opts]
         if {$nopts > 0} {
             set ffile [lindex $ffile 0]
             for {set i 0} {$i < $nopts} {set i [expr {$i + 2}]} {
                 set key [lindex $opts $i]
                 set val [lindex $opts [expr {$i + 1}]]
                 switch -- $key {
                     "-lib" {
                         set library $val
                     }
                 }
             }
         } 
         file copy -force "$ffile" "$root_hdl_dir"              
         set_property -dict "LIBRARY_NAME $library IS_INCLUDE true" [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]]
         set_property -dict "LIBRARY_NAME $library IS_INCLUDE true" [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_simulation_file_group]]
     }
 }
 #-----------------------------------------------------------
 # Handles Processing of VHDL files for packaging
 #-----------------------------------------------------------
 proc dsp_ipp_handler_vhd { filelist } {
     set top_module [dsp_get_param_value_in_driver_tcl_namespace TopLevelModule]
     set top_module_file "$top_module.vhd"
     set root_hdl_dir "[dsp_ipp_get_ip_directory]/hdl"
     file mkdir "$root_hdl_dir"
     set ordered_file_list [list]
     foreach ffile $filelist {    
         set library "work"
         set opts [lrange $ffile 1 end]
         set nopts [llength $opts]
         if {$nopts > 0} {
             set ffile [lindex $ffile 0]
             for {set i 0} {$i < $nopts} {set i [expr {$i + 2}]} {
                 set key [lindex $opts $i]
                 set val [lindex $opts [expr {$i + 1}]]
                 switch -- $key {
                     "-lib" {
                         set library $val
                     }
                 }
             }
         }
         file copy -force "$ffile" "$root_hdl_dir"               
         set_property LIBRARY_NAME $library [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]]
         set_property LIBRARY_NAME $library [ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_simulation_file_group]]
         lappend ordered_file_list $ffile
         if { $top_module_file == [file tail $ffile] } {
             ipx::import_top_level_hdl -verbose -include_dirs [dsp_get_sysgen_project_file_dir] -ordered_files  $ordered_file_list -top_level_hdl_file $ffile -top_module_name $top_module [ipx::current_core]
             ipx::add_model_parameters_from_hdl -include_dirs [dsp_get_sysgen_project_file_dir] -ordered_files  $ordered_file_list -top_level_hdl_file $ffile -top_module_name $top_module [ipx::current_core]
         }
     }
 } 
 #
 # Handles Processing of DCP Files
 #
 proc dsp_ipp_handler_dcp { filelist } {
     set root_dcp_dir "[dsp_ipp_get_ip_directory]/dcp"
     file mkdir "$root_dcp_dir"
     foreach ffile $filelist {    
         file copy -force "$ffile" "$root_dcp_dir"
         ipx::add_file "dcp/[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]
     }
 }

 #
 # Handles Processing of XCI files for packaging
 #
 proc dsp_ipp_handler_xci { filelist } {
     set root_ip_dir "[dsp_ipp_get_ip_directory]"      
     
     foreach ffile $filelist {
#         convert_ips [get_files $ffile]   # re-enable when CoreContainers are back
         set ip_dir "$root_ip_dir/[file tail [file rootname $ffile]]"
         file mkdir "$ip_dir"       
         file copy -force "$ffile" "$ip_dir"
         puts "Adding File $ffile"
         set file_obj [ipx::add_file "[file tail $ip_dir]/[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]]
         set file_obj [ipx::add_file "[file tail $ip_dir]/[file tail $ffile]" [dsp_ipp_get_simulation_file_group]]
     }
 }  
 #
 # Handles Processing of XDC files for packaging
 #
 proc dsp_ipp_handler_xdc { filelist } {
     set root_xdc_dir "[dsp_ipp_get_ip_directory]/constrs"      
     file mkdir "$root_xdc_dir"     
     foreach ffile $filelist {
         # don't add *_clock.xdc file
         if {[string match -nocase "*_clock.xdc" $ffile] == 0} {
             file copy -force "$ffile" "$root_xdc_dir"
             puts "Adding File $ffile"
             ipx::add_file "constrs/[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]
         }
     }
 } 
 #
 # Handles Processing of COE files for packaging
 #
 proc dsp_ipp_handler_coe { filelist } {
     set root_coe_dir "[dsp_ipp_get_ip_directory]"      
     file mkdir "$root_coe_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$root_coe_dir"    
         puts "Adding File $ffile"
         ipx::add_file "[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]
         ipx::add_file "[file tail $ffile]" [dsp_ipp_get_simulation_file_group]
     }
 }

 #
 # Handles Processing of MEM files for packaging
 #
 proc dsp_ipp_handler_mem { filelist } {
     set root_mem_dir "[dsp_ipp_get_ip_directory]"      
     file mkdir "$root_mem_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$root_mem_dir"    
         puts "Adding File $ffile"
         ipx::add_file "[file tail $ffile]" [dsp_ipp_get_synthesis_file_group]
         ipx::add_file "[file tail $ffile]" [dsp_ipp_get_simulation_file_group]
     }
 }
 #
 # Handles processing of dat files for packaging - copied to the same dir as hdl files
 # needed to import HLS designs into System Generator for DSP
 #
 proc dsp_ipp_handler_dat { filelist } {
     set root_dat_dir "[dsp_ipp_get_ip_directory]/hdl"      
     file mkdir "$root_dat_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$root_dat_dir"    
         puts "Adding File $ffile"
         ipx::add_file "hdl/[file tail $ffile]" [dsp_ipp_get_simulation_file_group]
     }
 }
 #
 # Handles processing of htm files for packaging
 #
 proc dsp_ipp_handler_htm { filelist } {
     set root_dir "[dsp_ipp_get_ip_directory]"      
     file mkdir "$root_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$root_dir"    
         puts "Adding File $ffile"
         ipx::add_file "[file tail $ffile]" [dsp_ipp_get_datasheet_file_group]
     }
     set images_src_dir "[file dirname $ffile]/images"
     set images_des_dir "$root_dir"
     file copy -force "$images_src_dir" "$images_des_dir"
 }
 #
 # Handles Processing of dat files
 #
 proc dsp_ipp_handler_testbench_dat { filelist } {
     set root_testbench_dat_dir "[dsp_ipp_get_ip_directory]/testbench"      
     file mkdir "$root_testbench_dat_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$root_testbench_dat_dir"    
         puts "Adding File $ffile"
         ipx::add_file "testbench/[file tail $ffile]" [dsp_ipp_get_testbench_file_group]
     }
 }
 #
 # Handles the processing of vhd testbench
 #
 proc dsp_ipp_handler_testbench_vhd { filelist } {
     set root_testbench_dir "[dsp_ipp_get_ip_directory]/testbench"      
     file mkdir "$root_testbench_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$root_testbench_dir"    
         puts "Adding File $ffile"
         ipx::add_file "testbench/[file tail $ffile]" [dsp_ipp_get_testbench_file_group]
     }
 }

 #
 # Handles creation of logo files
 #
 proc dsp_ipp_handler_logo { filelist } {     
     set root_logo_dir "[dsp_ipp_get_ip_directory]"      
     foreach ffile $filelist {     
         file copy -force "$ffile" "$root_logo_dir"         
         ipx::create_xgui_files -logo_file [file tail $ffile] -logo_width 100 -logo_height 100 -logo_gui_page Page0 [ipx::current_core]
     }
 }
 
 #
 # Handles c driver files
 #
 proc dsp_ipp_handler_c { filelist } {     
     set driver_dir "[dsp_ipp_get_drivers_directory]"      
     set driver_src_dir "$driver_dir/src"
     file mkdir "$driver_src_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$driver_src_dir"         
         set_property type driver_src [ipx::add_file "[dsp_ipp_drivers_dir_hierarchy]/src/[file tail $ffile]" [dsp_ipp_get_softwaredrivers_file_group]]
     }
 }

 #
 # Handles h driver files
 #
 proc dsp_ipp_handler_h { filelist } {     
     set driver_dir "[dsp_ipp_get_drivers_directory]"      
     set driver_src_dir "$driver_dir/src"
     file mkdir "$driver_src_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$driver_src_dir"         
         set_property type driver_src [ipx::add_file "[dsp_ipp_drivers_dir_hierarchy]/src/[file tail $ffile]" [dsp_ipp_get_softwaredrivers_file_group]]
     }
 }
 #
 # Handles the mdd file
 #
 proc dsp_ipp_handler_mdd { filelist } {     
     set driver_dir "[dsp_ipp_get_drivers_directory]"      
     set driver_data_dir "$driver_dir/data"
     file mkdir "$driver_data_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$driver_data_dir"         
         set_property type driver_mdd [ipx::add_file "[dsp_ipp_drivers_dir_hierarchy]/data/[file tail $ffile]" [dsp_ipp_get_softwaredrivers_file_group]]
     }
 }
 #
 # Handles the mdd-tcl file
 #
 proc dsp_ipp_handler_mtcl { filelist } {     
     set driver_dir "[dsp_ipp_get_drivers_directory]"      
     set driver_data_dir "$driver_dir/data"
     file mkdir "$driver_data_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$driver_data_dir/[file rootname [file tail $ffile]].tcl"
         set_property type driver_tcl [ipx::add_file "[dsp_ipp_drivers_dir_hierarchy]/data/[file rootname [file tail $ffile]].tcl" [dsp_ipp_get_softwaredrivers_file_group]]
     }
 }
 #
 # Handles the Make file
 #
 proc dsp_ipp_handler_mak { filelist } {     
     set driver_dir "[dsp_ipp_get_drivers_directory]"      
     set driver_src_dir "$driver_dir/src"
     file mkdir "$driver_src_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$driver_src_dir/[file rootname [file tail $ffile]]"
         set_property type driver_src [ipx::add_file "[dsp_ipp_drivers_dir_hierarchy]/src/[file rootname [file tail $ffile]]" [dsp_ipp_get_softwaredrivers_file_group]]
     }
 }
 #
 # Handles the Driver Documentation file
 #
 proc dsp_ipp_handler_html { filelist } {     
     set driver_dir "[dsp_ipp_get_drivers_directory]"      
     set driver_doc_dir "$driver_dir/doc"
     file mkdir "$driver_doc_dir"     
     set driver_html_dir "$driver_doc_dir/html"
     file mkdir "$driver_html_dir"     
     set driver_api_dir "$driver_dir/doc/html/api"
     file mkdir "$driver_api_dir"     
     foreach ffile $filelist {     
         file copy -force "$ffile" "$driver_api_dir"
         ipx::add_file "[dsp_ipp_drivers_dir_hierarchy]/doc/html/api/[file tail $ffile]" [dsp_ipp_get_softwaredrivers_file_group]
     }
 }
 #
 # Returns the location of the directory in which contain the packaged 
 # IP. If the directory does not exist a directory is created
 #
 proc dsp_ipp_get_ip_directory {} {     
     set use_common_repository [dsp_get_param_value_in_driver_tcl_namespace IP_Common_Repos]
     if {$use_common_repository == 0 } {
         set netlist_dir [ dsp_get_param_value_in_driver_tcl_namespace TargetDir ]     
         return "$netlist_dir/ip"
     } else {
         set ip_dir [dsp_get_param_value_in_driver_tcl_namespace IP_Dir]             
         file mkdir $ip_dir/[dsp_ip_packager_get_top_name]_v[dsp_ip_packager_get_version_no_dot]
         return $ip_dir/[dsp_ip_packager_get_top_name]_v[dsp_ip_packager_get_version_no_dot]
     }
 }

 #
 # Returns the location of the directory in the driver files are delivered 
 # If the directory does not exist a directory is created
 #
 proc dsp_ipp_get_drivers_directory {} {
     set ip_dir [dsp_ipp_get_ip_directory] 
     file mkdir "$ip_dir"
     file mkdir "$ip_dir/drivers"
     file mkdir "$ip_dir/drivers/[dsp_ip_packager_get_top_name]_v[dsp_ip_packager_get_version_no_dot]"
     return "$ip_dir/drivers/[dsp_ip_packager_get_top_name]_v[dsp_ip_packager_get_version_no_dot]" 
 }
 proc dsp_ipp_drivers_dir_hierarchy {} {
     return "drivers/[dsp_ip_packager_get_top_name]_v[dsp_ip_packager_get_version_no_dot]"
 }

 #
 # Searches a file repository for a specific file name
 # 
 proc dsp_get_file_name { filename } {
     set filedir [dsp_get_sysgen_project_file_dir]
     set origname $filename
     set origrootname [file rootname $filename]
     set filenameraw "$filedir/$origname"
     if { [ file exists $filenameraw ] } {
        set filename [file normalize $filenameraw]
     } else {
        set filename [file normalize $origname]
     }    

     return $filename
 }

 #
 # Create IPs in the project for IP Catalog flow to enable creation of XCI files used for packaging
 # 
 proc dsp_ipp_create_ips {} {
     set projfilesexts "coe tcl"
     set retcode [ dsp_reset_project_file_list_var $projfilesexts ] 
     set_property design_mode RTL [ get_filesets sources_1]
     set filedir [ dsp_get_sysgen_project_file_dir ]
     set paramvalueProjectFiles [ dsp_get_param_value_in_driver_tcl_namespace ProjectFiles ]
     foreach p $paramvalueProjectFiles {
        set filename [dsp_get_file_name [lindex $p 0]]
        foreach curext $projfilesexts {
           if { [string match -nocase "*.$curext" $filename] } {
               set listvarname [ dsp_get_list_var_name $curext ]
               lappend $listvarname $filename
           }
        }
     }
     foreach curext $projfilesexts {
         set listvarname [ dsp_get_list_var_name $curext ]
         if { [ info exists $listvarname ] } {
             set handlername [ dsp_get_add_project_files_handler_name $curext ]
             set findproc [ info proc $handlername ]
             if { [ string length $findproc ] > 0  } {
                 eval $handlername $listvarname
             }
         }
     } 
  } 
  
  proc dsp_ipp_remove_ips {} {
      set ips [get_ips]
      set coe_dir ""
      foreach ip $ips {
         set ipfile [get_property IP_FILE $ip]
         remove_files $ipfile
         if { $coe_dir == "" } {
             set coe_dir [file dirname [file dirname $ipfile]]
         }
         file delete -force [file dirname $ipfile] 
      }
      if { $coe_dir != "" } {
          set coe_files [glob -nocomplain "$coe_dir/*.coe"]
          foreach coe_file $coe_files {
             file delete -force $coe_file 
          }
      }
  }
 

  #----------------------------------------------------------
  # Factory Method to create a IP with user setting
  #----------------------------------------------------------
  proc dsp_ipp_get_ip_core {} {
      set ip_core [ipx::create_core -quiet [dsp_ip_packager_get_vendor] [dsp_ip_packager_get_library] [dsp_ip_packager_get_top_name] [dsp_ip_packager_get_version]]        
      set_property core_revision [dsp_ip_packager_get_revision] $ip_core
      set_property display_name [dsp_ip_packager_get_top_name] $ip_core
      set_property description [dsp_ip_packager_get_description] $ip_core
      set_property company_url {} $ip_core
      set_property taxonomy [dsp_ip_packager_get_taxonomy] $ip_core
      set_property XML_FILE_NAME "[dsp_ipp_get_ip_directory]/component.xml" $ip_core
      set_property payment_required false $ip_core
      #Set the support family    
      set driverns [ dsp_get_driver_tcl_namespace_qualifiers ]
      set tmplist [list]
      lappend tmplist [dsp_required_parameter ${driverns}::DSPFamily]
      lappend tmplist [dsp_ip_packager_get_life_cycle]
      set_property supported_families $tmplist $ip_core
      return $ip_core
  }
  #----------------------------------------------------------
  # returns the instance name for the top level IP instanced in the example project
  #----------------------------------------------------------
  proc dsp_ipp_get_rtl_example_ip_name {} {
      return [dsp_ip_packager_get_top_name]_0
  }
  #---------------------------------------------------------
  # Set layered metedata for each bus interface
  #---------------------------------------------------------
  proc dsp_ipp_set_layered_meta_data_on_bifs { ip_core } {
      foreach intf $intfs {
          set intf_vlnv [get_property VLNV $intf]
          set index [string first "aximm_rtl" $intf_vlnv]
          if {$index != -1} {
              # Apply BD Automation to every AXI Lite Interface exported by SysGen
              continue 
          }
          set index [string first "aximm_rtl" $intf_vlnv]
      }
  }
  proc dsp_ipp_add_bus_parameter {bus name value {resolve_type ""}} {
      if {$resolve_type == ""} {
        set resolve_type "immediate"
      }

      set current_bus_parameter [ipx::add_bus_parameter $name $bus]
      set_property value $value $current_bus_parameter
      set_property value_resolve_type $resolve_type $current_bus_parameter

      return $current_bus_parameter
  }  
  #
  # Takes a bus interface object as an input and returns 1 if it is an
  # axi_memoery_mapped interface else return 0
  #
  proc dsp_ipp_is_aximm { bif } {
      set bif_vlnv [get_property BUS_TYPE_VLNV $bif]
      set index [string first "aximm" $bif_vlnv]      
      if { $index != "-1" } {
          return 1
      }
      return 0
  }

  #
  # Takes a bus interface object as an input and returns 1 if it is an
  # axi_streaming interface else return 0
  #
  proc dsp_ipp_is_axis { bif } {
      set bif_vlnv [get_property BUS_TYPE_VLNV $bif]
      set index [string first "axis" $bif_vlnv]      
      if { $index != "-1" } {
          return 1
      }
      return 0
  }
  #
  # Iterates through all the bif and associates LAYERED_META_DATA with bifs
  # that are axis_rtl type
  #
  proc dsp_ipp_set_axis_layered_meta_data { ip_core } {
      set top_level_port_interface [ dsp_get_param_value_in_driver_tcl_namespace TopLevelPortInterface ]   
      set bifs [ipx::get_bus_interfaces -of_objects $ip_core]
      foreach bif $bifs {
          if { [dsp_ipp_is_axis $bif] == 1 } {
              set tdata_name [get_property NAME $bif]
              append tdata_name _tdata
              if { [dict exists $top_level_port_interface $tdata_name] } {
                  set port_interface [dict get $top_level_port_interface $tdata_name]
                  set layered_meta_data_for_port ""
                  dict set layered_meta_data_for_port $iptypes::vlnv TDATA [dsp_ipp_get_data_type port_interface]
                  dsp_ipp_add_bus_parameter $bif LAYERED_METADATA $layered_meta_data_for_port generated
              }
          }
      }    
  }
  #
  # Iterates through all the ports of the IP and associates a layered meta
  # data with a port if and only if the port is not associated with any
  # AXI bus interfaces
  #
  proc dsp_ipp_package_ports_as_data_interface { ip_core } {
      set top_level_port_interface [ dsp_get_param_value_in_driver_tcl_namespace TopLevelPortInterface ]   
      set bifs [ipx::get_bus_interfaces -of_objects $ip_core]
      set interface_ports [list]
      #Create a list of all the mapped Physical ports
      foreach bif $bifs {
          set portmaps [ipx::get_port_maps -of_objects $bif]
          foreach portmap $portmaps {
              lappend interface_ports [get_property PHYSICAL_NAME $portmap]
          }
      }
      set interface_ports [lsort -ascii $interface_ports]
      foreach {port_obj} [ipx::get_ports -of $ip_core] {
          set port_name [get_property NAME $port_obj]
          set sg_interface "DATA"
          if {[dict exists $top_level_port_interface $port_name]} {
              set port_interface [dict get $top_level_port_interface $port_name]
              if {[dict exists $port_interface InterfaceString]} {
                  set sg_interface [dict get $port_interface InterfaceString]
              }
          }
          if {[string equal $sg_interface CLOCKENABLE_CLEAR]} {
              set sg_interface "DATA"
          }
          if {[lsearch -sorted $interface_ports $port_name] == -1 || [string equal $sg_interface CLOCK]} {
              set current_bus_interface {}
              if { [string equal $sg_interface CLOCK] } {
                set current_bus_interface [ipx::get_bus_interfaces $port_name]
              } 
              if { [string length $current_bus_interface] == 0 } {
                set current_bus_interface [ipx::add_bus_interface $port_name $ip_core ]
              }
              # By Default the interface is data
              switch $sg_interface {
                  DATA {
                      set_property bus_type_vlnv {xilinx.com:signal:data:1.0} $current_bus_interface
                      set_property abstraction_type_vlnv {xilinx.com:signal:data_rtl:1.0} $current_bus_interface
                      set current_port_map [ipx::add_port_map $port_name $current_bus_interface]
                      set_property logical_name {DATA} $current_port_map    
                      set_property physical_name $port_name $current_port_map
                      if {[dict exists $top_level_port_interface $port_name]} { 
                          set port_interface [dict get $top_level_port_interface $port_name]
                          if {[dict exists $port_interface Direction]} {
                              if {[dict get $port_interface Direction] == "in"} {
                                  set_property interface_mode slave $current_bus_interface
                              } else {
                                  set_property interface_mode master $current_bus_interface
                              }               
                          } 
                          set layered_meta_data_for_port ""
                          dict set layered_meta_data_for_port $iptypes::vlnv DATA [dsp_ipp_get_data_type port_interface]
                          dsp_ipp_add_bus_parameter $current_bus_interface LAYERED_METADATA $layered_meta_data_for_port immediate
                      }
                  }
                  INTERRUPT {
                      set_property bus_type_vlnv {xilinx.com:signal:interrupt:1.0} $current_bus_interface
                      set_property abstraction_type_vlnv {xilinx.com:signal:interrupt_rtl:1.0} $current_bus_interface
                      set current_port_map [ipx::add_port_map $port_name $current_bus_interface]
                      set_property logical_name {INTERRUPT} $current_port_map 
                      set_property physical_name $port_name $current_port_map
                      if {[dict exists $top_level_port_interface $port_name]} { 
                         set port_interface [dict get $top_level_port_interface $port_name]
                         if {[dict exists $port_interface Direction]} {
                             if {[dict get $port_interface Direction] == "in"} {
                                 set_property interface_mode slave $current_bus_interface
                             } else {
                                 set_property interface_mode master $current_bus_interface
                             }               
                         } 
                      }                 
                  }
                  CLOCK {
                      set_property bus_type_vlnv {xilinx.com:signal:clock:1.0} $current_bus_interface
                      set_property abstraction_type_vlnv {xilinx.com:signal:clock_rtl:1.0} $current_bus_interface              
                      set_property interface_mode {slave} $current_bus_interface 
                      set current_port_map [ipx::get_port_maps -of_objects $current_bus_interface ] 
                      if { [string length $current_port_map] == 0 } {
                        set current_port_map  [ipx::add_port_map $port_name $current_bus_interface]
                      }
                      set_property logical_name {CLK} $current_port_map
                      set_property physical_name $port_name $current_port_map
                      if {[dict exists $top_level_port_interface $port_name]} {
                          set port_interface [dict get $top_level_port_interface $port_name]
                          if {[dict exists $port_interface InterfaceString]} {
                              if {[dict get $port_interface InterfaceString] == "CLOCK"} {
                                  set associated_interfaces_string ""
                                  set sep ""
                                  if {[dict exists $port_interface AssociatedInterfaces]} {
                                      set associated_interfaces [dict get $port_interface AssociatedInterfaces]
                                      if { [llength $associated_interfaces] > 0 } {                                        
                                        foreach associated_interface $associated_interfaces {
                                          append associated_interfaces_string $sep$associated_interface
                                          set sep ":"
                                        }                                         
                                      }
                                  }
                                  #Here we add all the inferred associated Interfaces to Clock like AXI Stream, AXI Full 
                                  if {[dict exists $port_interface ClockDomain]} { 
                                      set this_clockdomain [dict get $port_interface ClockDomain]
                                      foreach candidate_bif $bifs {          
                                          set c_portmaps [ipx::get_port_maps -of_objects $candidate_bif]
                                          foreach c_portmap $c_portmaps {
                                              set c_portname [get_property PHYSICAL_NAME $c_portmap]
                                              if {[string equal $c_portname $port_name]} {
                                                  break
                                              }
                                              if {[dict exists $top_level_port_interface $c_portname]} {
                                                  set c_portinterface [dict get $top_level_port_interface $c_portname]
                                                  if {[dict exists $c_portinterface ClockDomain]} {
                                                      set c_bif_clockdomain [dict get $c_portinterface ClockDomain]
                                                      if {[string match $this_clockdomain $c_bif_clockdomain]} {
                                                          append associated_interfaces_string "$sep[get_property NAME $candidate_bif]"
                                                          set sep ":"
                                                          break
                                                      }
                                                  }
                                              }
                                          }
                                      }                                  
                                  }
                                  if {[string length $associated_interfaces_string]>0} {
                                      dsp_ipp_add_bus_parameter $current_bus_interface ASSOCIATED_BUSIF "$associated_interfaces_string" immediate                                      
                                  }
                                  if {[dict exists $port_interface AssociatedResets]} {
                                      set associated_resets [dict get $port_interface AssociatedResets]
                                      if { [llength $associated_resets] > 0 } {
                                          dsp_ipp_add_bus_parameter $current_bus_interface ASSOCIATED_RESET [lindex $associated_resets 0] immediate 
                                      }
                                  }
              
                              }
                          }
                     }
                  }
                  CLOCKENABLE {
                      set_property bus_type_vlnv {xilinx.com:signal:clockenable:1.0} $current_bus_interface
                      set_property abstraction_type_vlnv {xilinx.com:signal:clockenable_rtl:1.0} $current_bus_interface
                      set_property interface_mode {slave} $current_bus_interface
                      set current_port_map [ipx::add_port_map $port_name $current_bus_interface]
                      set_property logical_name {CE} $current_port_map
                      set_property physical_name $port_name $current_port_map
                  }
                  ARESETN {
                      set_property bus_type_vlnv {xilinx.com:signal:reset:1.0} $current_bus_interface
                      set_property abstraction_type_vlnv {xilinx.com:signal:reset_rtl:1.0} $current_bus_interface
                      set_property interface_mode {slave} $current_bus_interface
                      set current_port_map [ipx::add_port_map $port_name $current_bus_interface]
                      set_property logical_name {RST} $current_port_map
                      set_property physical_name $port_name $current_port_map
                  }
              }
          }
      }  
  }
  #---------------------------------------------------------
  # Creates bus interfaces for the IP 
  #---------------------------------------------------------
  proc dsp_ipp_infer_bus_interface { ip_core } {
      if {[dsp_ip_packager_get_Auto_Infer_flag] == "1" } {
        ipx::infer_bus_interfaces {{xilinx.com:interface:axis:1.0} {xilinx.com:interface:aximm_rtl:1.0} {xilinx.com:signal:data_rtl:1.0}} $ip_core
          dsp_ipp_package_ports_as_data_interface $ip_core      
          dsp_ipp_set_axis_layered_meta_data $ip_core
      } else {
        foreach {port_obj} [ipx::get_ports -of $ip_core] {
           set port_name [get_property name $port_obj]
           set current_bus_interface [ipx::add_bus_interface $port_name $ip_core ]
           if {[string match "clk*" $port_name]} {
              set_property bus_type_vlnv {xilinx.com:signal:clock:1.0} $current_bus_interface
              set_property abstraction_type_vlnv {xilinx.com:signal:clock_rtl:1.0} $current_bus_interface              
              set_property interface_mode {slave} $current_bus_interface
              set current_port_map [ipx::add_port_map $port_name $current_bus_interface]
              set_property logical_name {CLK} $current_port_map
           } elseif {[string match "ce" $port_name]} {
              set_property bus_type_vlnv {xilinx.com:signal:clockenable:1.0} $current_bus_interface
              set_property abstraction_type_vlnv {xilinx.com:signal:clockenable_rtl:1.0} $current_bus_interface
              set_property interface_mode {slave} $current_bus_interface
              set current_port_map [ipx::add_port_map $port_name $current_bus_interface]
              set_property logical_name {CE} $current_port_map
           } else {
              set_property bus_type_vlnv {xilinx.com:signal:data:1.0} $current_bus_interface
              set_property abstraction_type_vlnv {xilinx.com:signal:data_rtl:1.0} $current_bus_interface
              set current_port_map [ipx::add_port_map $port_name $current_bus_interface]
              set_property logical_name {DATA} $current_port_map
           }
           set_property physical_name $port_name $current_port_map
        }
     }
     set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]    
     set mem_maps [ipx::get_memory_maps -of_objects $ip_core] 
     foreach {mem_map} $mem_maps {   
       set intf_name [get_property NAME  $mem_map ] 
       set macro_prefix "C_[string toupper ${intf_name}]"  
       ipx::add_address_block_parameter OFFSET_BASE_PARAM [ipx::get_address_blocks reg0 -of_objects $mem_map]
       set_property value "${macro_prefix}_BASEADDR" [ipx::get_address_block_parameters OFFSET_BASE_PARAM -of_objects [ipx::get_address_blocks reg0 -of_objects $mem_map]]
       ipx::add_address_block_parameter OFFSET_HIGH_PARAM [ipx::get_address_blocks reg0 -of_objects $mem_map] 
       set_property value "${macro_prefix}_HIGHADDR"  [ipx::get_address_block_parameters OFFSET_HIGH_PARAM -of_objects [ipx::get_address_blocks reg0 -of_objects $mem_map]]        
     } 
  }
  #----------------------------------------------------------------
  # Returns the absolute path to the testbench module
  #----------------------------------------------------------------
  proc dsp_ipp_testbench_file_name {} {
     set test_bench_module [ dsp_get_param_value_in_driver_tcl_namespace TestBenchModule ]    
     if { [dsp_hdllang_is_vhdl] } {
         return [dsp_get_file_name "$test_bench_module.vhd"]
     } else {
         return [dsp_get_file_name "$test_bench_module.v"]
     }
  }

  proc dsp_ipp_stub_file_name {} {
     set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]    
     if { [dsp_hdllang_is_vhdl] } {
         return [dsp_get_file_name ${top_level_module}_stub.vhd]
     } else {
         return [dsp_get_file_name ${top_level_module}_stub.v]
     }
  }
  #----------------------------------------------------------------
  # Returns the absolute path to the clock.xdc file
  #----------------------------------------------------------------
  proc dsp_ipp_get_clock_xdc_file {} {
      set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]    
      return [ dsp_get_file_name ${top_level_module}_clock.xdc ]
  }
  #----------------------------------------------------------------
  # Returns the absolute path to the modified testbench module that 
  # instances IP
  #----------------------------------------------------------------
  proc dsp_ipp_modified_testbench_file_name {} {
      set test_bench_module_mod [file dirname [dsp_ipp_testbench_file_name]]/[dsp_get_param_value_in_driver_tcl_namespace TestBenchModule]_mod   
     if { [dsp_hdllang_is_vhdl] } {
         return "$test_bench_module_mod.vhd"
     } else {
         return "$test_bench_module_mod.v"
     }
  }
  #----------------------------------------------------------------
  # Returns the absolute path to the modified stub module that 
  # instances IP
  #----------------------------------------------------------------
  proc dsp_ipp_modified_stub_file_name {} {
     set stub_module_mod [file dirname [dsp_ipp_stub_file_name]]/[dsp_get_param_value_in_driver_tcl_namespace TopLevelModule]_mod   
     if { [dsp_hdllang_is_vhdl] } {
         return "$stub_module_mod.vhd"
     } else {
         return "$stub_module_mod.v"
     }
  }
  #---------------------------------------------------------------
  # Generates the testbench for IP from the tesbench created during
  # netlisting of system generator design by simply modifying the
  # dut name to the im instance name
  #---------------------------------------------------------------

  proc dsp_ipp_get_modified_testbench_file {} {
       set test_bench_file [dsp_ipp_testbench_file_name]
       set mod_test_bench_file [dsp_ipp_modified_testbench_file_name]
       set cont [dsp_read_file $test_bench_file]
       set pattern [format "component %s is" [dsp_ip_packager_get_top_name]]
       set replace [format "component %s is" [dsp_ipp_get_rtl_example_ip_name]]
       regsub -all $pattern $cont $replace cont 
       set pattern [format "sysgen_dut: %s" [dsp_ip_packager_get_top_name]]
       set replace [format "sysgen_dut: %s" [dsp_ipp_get_rtl_example_ip_name]]
       regsub -all $pattern $cont $replace cont 
       set pattern [format "sysgen_dut : entity [dsp_get_vhdllib].%s" [dsp_ip_packager_get_top_name]]
       set replace [format "sysgen_dut : entity [dsp_get_vhdllib].%s" [dsp_ip_packager_get_top_name]_bd_wrapper]
       regsub -all $pattern $cont $replace cont 
       set pattern [format "%s sysgen_dut" [dsp_ip_packager_get_top_name]]
       set replace [format "%s sysgen_dut" [dsp_ip_packager_get_top_name]_bd_wrapper]
       regsub -all $pattern $cont $replace cont 
       dsp_write_file $mod_test_bench_file $cont
       return $mod_test_bench_file
  }

  proc dsp_ipp_get_modified_stub_file {} {
       set stub_file [dsp_ipp_stub_file_name]
       set mod_stub_file [dsp_ipp_modified_stub_file_name]
       set cont [dsp_read_file $stub_file]
       set pattern [format "component %s is" [dsp_ip_packager_get_top_name]]
       set replace [format "component %s is" [dsp_ipp_get_rtl_example_ip_name]]
       regsub -all $pattern $cont $replace cont 
       set pattern [format "sysgen_dut: %s" [dsp_ip_packager_get_top_name]]
       set replace [format "sysgen_dut: %s" [dsp_ipp_get_rtl_example_ip_name]]
       regsub -all $pattern $cont $replace cont 
       set pattern [format "sysgen_dut : entity [dsp_get_vhdllib].%s" [dsp_ip_packager_get_top_name]]
       set replace [format "sysgen_dut : entity [dsp_get_vhdllib].%s" [dsp_ipp_get_rtl_example_ip_name]]
       regsub -all $pattern $cont $replace cont 
       set pattern [format "%s sysgen_dut" [dsp_ip_packager_get_top_name]]
       set replace [format "%s sysgen_dut" [dsp_ipp_get_rtl_example_ip_name]]
       regsub -all $pattern $cont $replace cont 
       dsp_write_file $mod_stub_file $cont
       return $mod_stub_file
  }

  proc dsp_ipp_translate_arithmetic_type { ArithmeticType } {
      if {$ArithmeticType == "xlSigned"} {
          set Signed true
      } else {
          set Signed false
      }
      return $Signed
  }  
  
  proc dsp_ipp_get_fixed_data_type_impl {Width ArithmeticType BinaryPoint} {
      set fixed_type [iptypes::datatype::new -type real -bitwidth $Width -bitoffset 0 -fixed -signed [dsp_ipp_translate_arithmetic_type $ArithmeticType] -fractwidth $BinaryPoint]
      return $fixed_type
  }
  
  proc dsp_ipp_get_float_data_type_impl {Width ArithmeticType BinaryPoint} {
      set float_type [iptypes::datatype::new -type real -bitwidth $Width -bitoffset 0 -float -sigwidth $BinaryPoint]
      return $float_type
  }
  
  proc dsp_ipp_get_data_type { data_type_dict_name } {
      upvar 1 $data_type_dict_name data_type_dict
      set data_type [dict get $data_type_dict ArithmeticType]
      if {$data_type == "xlFloat" } {
          return [dsp_ipp_get_float_data_type_impl [dict get  $data_type_dict Width] [dict get  $data_type_dict ArithmeticType] [dict get  $data_type_dict BinaryPoint]]
      } else {
          return [dsp_ipp_get_fixed_data_type_impl [dict get  $data_type_dict Width] [dict get  $data_type_dict ArithmeticType] [dict get  $data_type_dict BinaryPoint]]
      }
  }

  #-------------------------------------------------------
  # Ip packager script
  # If there is no IP in design, just package like like GUI performed 
  # If there are IPs in the design, it package the IP using XCI files.
  #-------------------------------------------------------
  proc dsp_package_for_vivado_ip_integrator {} {
    # This Will Work Only In the Context of Having a Xilinx IP Repo Present
    set ip_repo_root [dsp_get_xilinx_ip_repository_root]
    if { $ip_repo_root != "" } {
        #Source a utility to create the layered meta data types
        if {[catch {source $ip_repo_root/xilinx/xbip_utils_v3_0/common_tcl/iptypes.tcl}]} {
            error "Could not source iptypes.tcl to enable layered metadata for ip."
        }
        puts "IP Repository Located at : $ip_repo_root"
    } else {
        error "Could not locate Xilinx IP Repository. Please Verify that you have a correct Vivado installation."
    }   
    # At this point netlist directory already exists
    # Cleaup the ip directory where all ip files 
    # will be stored
    set root_ip_dir [dsp_ipp_get_ip_directory]
    if {[file isdirectory $root_ip_dir]} {
     file delete -force "$root_ip_dir" 
    }
    file mkdir "$root_ip_dir"
    
    set projfilesexts "xci ucf xdc xco dat coe mem mif ngc vhd vhdl v h c htm mdd mtcl mak html dcp"
    set projpath [ get_property DIRECTORY [current_project] ]
    set nam [dsp_ip_packager_get_top_name]
    ::close_project
    ::open_project $projpath/$nam.xpr
    set ip_core [dsp_ipp_get_ip_core] 
    set_property XML_FILE_NAME "[dsp_ipp_get_ip_directory]/component.xml" $ip_core
    set paramvalueProjectFiles [ dsp_get_param_value_in_driver_tcl_namespace ProjectFiles ]    
    foreach p $paramvalueProjectFiles {
        set filename [dsp_get_file_name [lindex $p 0]]
        #Update with fully qualified file name
        lset p 0 $filename
        foreach curext $projfilesexts {
            #Filter out Testbench
            if { [string match -nocase "*.$curext" $filename] } {
               if { [string match -nocase [ dsp_get_param_value_in_driver_tcl_namespace TestBenchModule ] [file tail [file rootname $filename] ] ] } {
                  set listvarname [ dsp_get_testbench_list_var_name $curext ]
                  lappend $listvarname $p
                  continue
               }    
               set listvarname [ dsp_get_list_var_name $curext ]
               lappend $listvarname $p
           }
        }
    }
    #Collect all the XCI file seperately
    set ips [get_ips]
    foreach ip $ips {
        set ipfile [get_property IP_FILE $ip] 
        set listvarname [ dsp_get_list_var_name xci ]
        lappend $listvarname $ipfile
    }    

    #Collect all the .dat tetbench files separately 
    # Do not package the testbench .dat files
    #if { [ dsp_has_testbench ] } {
    #    set datapath [ dsp_get_sysgen_project_file_search_path_list ]
    #    set listvarname [ dsp_get_testbench_list_var_name "dat" ]
    #    set $listvarname [ dsp_get_file_name_list_from_pathlist $datapath {.dat} ]
    #}
    #Handle all the source files
    foreach curext $projfilesexts {
        set listvarname [ dsp_get_list_var_name $curext ]
        if { [ info exists $listvarname ] } {
            set handlername [ dsp_ipp_get_files_handler_name $curext ]
            set findproc [ info proc $handlername ]
            if { [ string length $findproc ] > 0  } {
               eval $handlername $$listvarname
            }
         }
    }
    #Handle all the testbench files
    foreach curext $projfilesexts {
        set listvarname [ dsp_get_testbench_list_var_name $curext ]
        if { [ info exists $listvarname ] } {
            set handlername [ dsp_ipp_get_testbench_files_handler_name $curext ]
            set findproc [ info proc $handlername ]
            if { [ string length $findproc ] > 0  } {
               eval $handlername $$listvarname
            }
        }
    }
    # Handle the GUI and Logo
    dsp_ipp_handler_logo [dsp_get_sysgen_project_file_dir]/[dsp_get_param_value_in_driver_tcl_namespace IP_Logo] 
    
    # Infer Bus Interfaces
    dsp_ipp_infer_bus_interface $ip_core 
    # Handle Interface Document
    ipx::save_core [ipx::current_core]
    ipx::check_integrity [ipx::current_core]
    ipx::archive_core "[dsp_ipp_get_ip_directory]/[dsp_ip_packager_get_ip_name].zip" [ipx::current_core]
    dsp_ipp_remove_ips    
    # Add the ip path to project 
    set_property ip_repo_paths [dsp_ipp_get_ip_directory] [current_fileset]
    update_ip_catalog
    # Remove coe files references
    remove_files [get_files "*.coe" -quiet] -quiet
    # Remove mem files references
    remove_files [get_files "*.mem" -quiet] -quiet
    # Create an example RTL Design
    create_ip -vlnv [dsp_ip_packager_get_vendor]:[dsp_ip_packager_get_library]:[dsp_ip_packager_get_top_name]:[dsp_ip_packager_get_version] -module_name [dsp_ipp_get_rtl_example_ip_name]

    # Add <top_module_name>_clock.xdc to ip_catalog project
    ::import_files -fileset [ get_filesets constrs_1 ] -force -norecurse [dsp_ipp_get_clock_xdc_file]
    set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
    ::import_files -fileset [ get_filesets constrs_1 ] -force -norecurse [ dsp_get_file_name ${top_level_module}.xdc ]
    ::import_files -force -norecurse [ dsp_ipp_get_modified_stub_file ]

    # Create an example Testbench With the IP
    if { [ dsp_has_testbench] } {
        ::import_files -fileset [ get_filesets sim_1 ] -force -norecurse [ dsp_ipp_get_modified_testbench_file ]
        if { [dsp_hdllang_is_vhdl] != 1 } {
            ::import_files -fileset [ get_filesets sim_1 ] -force -norecurse [dsp_get_file_name conv_pkg.v] -quiet
            set_property -quiet FILE_TYPE {Verilog Header} [get_files -quiet conv_pkg.v]  
        }
        dsp_add_project_testbench_dat_files 
    }
    # Create an example Microblaze/Zynq based design only if the compilation target is IP Catalog
    # This is done because someone might just want to use the IP created and not the microblaze based system
    # If they want the microblaze/Zynq  based system , they can call dsp_create_vivado_ip_integrator_design 
    # separately using the custom compilation target
    if { [ dsp_is_ipxact_compilation ] } { 
        dsp_create_vivado_ip_integrator_design
    }
    #
    # This is done to ensure that the requisite files needed for compilation
    # only are picked up as the design contains both an RTL top level and 
    # IP integrator top level 
    update_compile_order -fileset sources_1
    update_compile_order -fileset sim_1
 }

  proc dsp_create_vivado_ip_integrator_design {} {
    
     set use_socketable_ip_flow [dsp_ip_packager_get_Socket_IP_Flag]
     puts $use_socketable_ip_flow
    
     if { $use_socketable_ip_flow == 1 } { 
       #Use the socketable IP Flow
       dsp_use_socketable_ip_flow 
       
     } else { 
       # This Proc should Only Be called is AXI Lite and AXI MM interfaces are detected
       set bd_design [create_bd_design -bdsource SYSGEN [dsp_ip_packager_get_top_name]_bd]
       #Instantiate IP in IPI design
       dsp_instance_ip_in_ipi_design
       
       if { [dsp_is_processor_interfaces_available_on_ip] == 1 } {
         # This Should Only be executed if there are any AXI Lite Interfaces in the design
         if {[dsp_ipp_is_zynq]} {
            dsp_apply_bd_automation_for_ps
         } else {
            dsp_apply_bd_automation_for_microblaze           
         } 
       } 
       dsp_apply_bd_automation_for_ip
     }
    
    
      save_bd_design
      # Create a Wrapper for the BD Design and Make that the top Level
      # Since we create only one block diagram it is okay to use *.bd
      # quite added to ensure that project exhits gracefully even
      # if there are issues with validation and generation
      # done because FREQ parameter was not being propagated to xternal
      # interface pins
      set top_wrapper [make_wrapper -files [get_files *.bd] -top -quiet]
      import_files -force -norecurse $top_wrapper -quiet 
      set_property top [file rootname [file tail $top_wrapper]]  [current_fileset] -quiet 
  }
  
  proc dsp_use_socketable_ip_flow {} {
    puts [dsp_ip_packager_get_Socket_IP_Flag]
    puts [dsp_ip_packager_get_Socket_IP_Project]
    
    #Copy the platform
    set vivado_project [dsp_ip_packager_get_Socket_IP_Project]
    if { [file exists $vivado_project] == 0 } {      
      error "Plug-in Vivado project file '$vivado_project' does not exist. Please provide a valid Vivado project file (.xpr) and then try again."
    }
    
    # Removed -read_only option while opening vivado project
    # until issue in IPI is fixed, CR# 936873.
    # This work-around helped generate correct platform.tcl file
    # and fixed clock constraint issus reported in CR# 936874
    if { [ catch "open_project $vivado_project" err ] } {
      error "An error occured while opening the Plug-in Vivado project '$vivado_project'. Please provide a valid Vivado project file (.xpr) and then try again. \n\n $err"              
    }
    
    set plugin_part [get_property PART [current_project ]]    
    set num_bd [ llength  [get_files -norecurse *.bd] ]
    
    if  { $num_bd != 1 } {       
      close_project  
      error "Plug-in Vivado project '$vivado_project' contains ${num_bd} Block Design(s). It has to contain only one Block Design. \
             Please create a Vivado project with a single Block Design and then try again."
    }
    set ip_repos [get_property ip_repo_paths [current_project ]]
    set board_name [get_property board_part [current_project ]]
    open_bd_design [lindex  [get_files -norecurse *.bd ] 0] 
    write_bd_tcl -force ./platform.tcl
    close_project  
    
    set curr_project_part [get_property PART [current_project ]]
    if { [string equal -nocase ${curr_project_part} ${plugin_part}] != 1 } {
       error "Plug-in Vivado project $vivado_project' part is ${plugin_part}. This does not match the part chosen for IP Catalog compilation ${curr_project_part}. \n"
    }
    set curr_ip_repos [get_property ip_repo_paths [current_project ]]
    append ip_repos { } $curr_ip_repos 
    
    set_property board_part $board_name [current_project]
    set_property  ip_repo_paths $ip_repos [current_project]
    update_ip_catalog     
    
    if { [ catch {source ./platform.tcl} err ] } {
       error "An error occured while re-creating the Plug-in Vivado project '$vivado_project'. Please ensure that validate_bd_design in the Plug-in Vivado project is successful and then try again.\n\n $err"              
    } 
    
    if { [ catch {validate_bd_design} err ] } {
       error "An error occured while validating the re-created Plug-in Vivado project '$vivado_project'. Please ensure that validate_bd_design in the Plug-in Vivado project is successful and then try again. \n\n $err"              
    }
    
    #Instantiate IP in IPI design
    dsp_instance_ip_in_ipi_design
    
    save_bd_design 
    
    dsp_find_potential_interfaces 
    dsp_find_potential_pins
    
    assign_bd_address
    save_bd_design 
    
  }
 
 #-------------------------------------------------------
 # Find out potential Sysgen Ports 
 # and then connect them up 
 #-------------------------------------------------------
 proc dsp_find_potential_pins {} { 
   set ip_inst [dsp_get_ip_instance_name] 
   set ip_pins [get_bd_pins /[dsp_get_ip_instance_name]/*]
   
   foreach ip_pin $ip_pins {
      
     set bd_ports [get_bd_ports]     
     set ip_pin_interface [get_property INTF  $ip_pin] 
     set ip_pin_name [get_property NAME   $ip_pin]
     set ip_pin_direction [get_property DIR   $ip_pin]
     #If the pin is a part of interface, ignore it because we have already handled interfaces
     if { [string equal -nocase ${ip_pin_interface} "TRUE"] } {
       continue
     }
     
     foreach bd_port $bd_ports {  
              
       #If the port is associated to the board then ignore it. 
       set is_associated [::internal::is_associated_to_board $bd_port]
       if { $is_associated == 1 } {       
          continue
       }       
       
       #Find out what the port is connected to and ensure that it is connected to something. 
       set connected_to [find_bd_objs -relation connected_to -thru_hier [get_bd_ports ${bd_port}]]           
       if { [ expr { [ string length $connected_to ] == 0 } ] } { 
         continue
       } 
       
       set bd_port_name [get_property NAME   $bd_port]
       set bd_port_direction [get_property DIR   $bd_port]
       
       #If the port names are the same and the directions are compatible, then connect the ports up. 
       if { [string equal $ip_pin_name $bd_port_name] } {
         
         if { (
                  [string equal -nocase ${bd_port_direction} "I"] &&       
                  [string equal -nocase ${ip_pin_direction} "O"]   
               ) || (
                  [string equal -nocase ${bd_port_direction} "O"] && 
                  [string equal -nocase ${ip_pin_direction} "I"]   
               )                             
         } {
           
            #Find out what the port is connected to 
            set connected_to [find_bd_objs -relation connected_to [get_bd_ports ${bd_port}]]
            #Delete the net
            set net [get_bd_nets -of_objects $bd_port] 
            delete_bd_objs $net
            delete_bd_objs $bd_port
            
            # Connect it to the IP Interface  
            connect_bd_net  $connected_to $ip_pin
            break
           
         }
       }
     }    
     
   }
   save_bd_design
 }
 
  
 #-------------------------------------------------------
 # Find out potential Sysgen Ports and Interfaces 
 #
 #-------------------------------------------------------
 proc dsp_find_potential_interfaces {} { 
   set ip_inst [dsp_get_ip_instance_name] 
   set ip_intfs [get_bd_intf_pins /[dsp_get_ip_instance_name]/*]
   foreach ip_intf $ip_intfs {
     set ip_intf_name [get_property NAME $ip_intf]
     set ip_intf_vlnv [get_property VLNV $ip_intf]
     set ip_intf_mode [get_property MODE $ip_intf]  
     set ip_intf_protocol [get_property config.protocol $ip_intf ]   
     set match_intf {}
     #Iterate over all the interfaces first
     set intfs [get_bd_intf_ports]
     foreach intf $intfs {
       if { [is_sysgen_intf $intf] == 1 } { 
         
         set name [get_property NAME  [get_bd_intf_ports $intf]]
         set vlnv [get_property VLNV  [get_bd_intf_ports $intf]]
         set mode [get_property MODE  [get_bd_intf_ports $intf]]  
         set protocol [get_property config.protocol [get_bd_intf_ports $intf ]] 
         if { [string equal $vlnv $ip_intf_vlnv] } { 
           #This is added because AXI Lite and AXI Full have the same VLNV, so we have to distinguish between them using the protocol field. 
           if { [string equal $ip_intf_protocol $protocol] } { 
           
               if { (
                        [string equal {Slave} $ip_intf_mode] &&            
                        [string equal {Master} $mode]    
                     ) || (
                         [string equal {Master} $ip_intf_mode] && 
                        [string equal {Slave} $mode]   
                     )                             
               } {
                 #Ensure that the potential candidates are connected to something.
                 set connected_to [find_bd_objs -relation connected_to -thru_hier [get_bd_intf_ports ${intf}]]
                 if { [ expr { [ string length $connected_to ] == 0 } ] } { 
                   continue
                 }
                 lappend match_intf $intf
               }  
           }
           
         }
         
       }
              
     }
     
     set match_counter [llength $match_intf] 
     
     set unique_match [lindex $match_intf  0 ]
     
     if { [expr { $match_counter > 1 == 1 } ] } {
       
       foreach potential_match $match_intf {
         
         set potential_match_name [get_property NAME  [get_bd_intf_ports $potential_match]]
         #here we are also relying on the fact that IPI does not allow same interface name with different case.  
         if { [string match -nocase $potential_match_name $ip_intf_name ] } {
           set unique_match $potential_match
           break
         }
         
       }  
       
     } elseif { $match_counter == 0 } {
       
       continue
     }
     
     
     #Find out what the interface is connected to. We do not want to do thru_hier here because we 
     # have already ensured that the intf is connected in the previous step and now we are 
     #just making the connection at the heirarchical boundary. 
     set connected_to [find_bd_objs -relation connected_to [get_bd_intf_ports ${unique_match}]]
     # If the interface is connected to multiple interfaces(in case of ILA, monitor ports etc, filter them out
     if { [llength $connected_to] != 1 } {
       foreach connected_intf $connected_to {
         set connected_intf_mode [get_property MODE $connected_intf]    
         if { [string equal -nocase $connected_intf_mode {MONITOR} ] != 1  } {
           set connected_to $connected_intf
           break
         }
       }
     }
     
     #Delete the Interface..
     set net [get_bd_intf_nets -of_objects $unique_match] 
     disconnect_bd_intf_net $net $unique_match
     delete_bd_objs $unique_match
     
     # Connect it to the IP Interface  
     connect_bd_intf_net -boundary_type upper $connected_to $ip_intf
     
     #Now connect the clocks and the resets thru hierarchy
     set connected_to [find_bd_objs -relation connected_to -thru_hier $ip_intf]
     # If the interface is connected to multiple interfaces(in case of ILA, monitor ports etc, filter them out
     if { [llength $connected_to] != 1 } {
       foreach connected_intf $connected_to {
         set connected_intf_mode [get_property MODE $connected_intf]    
         if { [string equal -nocase $connected_intf_mode {MONITOR} ] != 1  } {
           set connected_to $connected_intf
           break
         }
       }
     }
     ::bd::clkrst::connect_sg_clk_rst ${ip_intf} ${connected_to} 
               
     save_bd_design 
     
   } 
 }
  #
  # Takes a bus interface object as an input and returns 1 if it is a 
  # potential match for sysgen else return 0
  #
  proc is_sysgen_intf {
        intf
  } {
    
    #If the intf is associated to the board then skip it. 
    set is_associated [::internal::is_associated_to_board $intf] 
    if { $is_associated == 1 } { 
      return 0
    }    
    
    set connected_to [find_bd_objs -relation connected_to -thru_hier [get_bd_intf_ports ${intf}]]
    
    if { [ expr { [ string length $connected_to ] == 0 } ] } { 
      return 0
    }
    #TODO: remove the MIG condition
    #If the interface is not connected to anything or if it is connected to MIG, then continue
    if { [string match {*xilinx.com:ip:mig_7series:*} [::bd::utils::get_parent $connected_to] ] } {
      return 0
    }
    set associated_board_param [get_property board.associated_param ${connected_to}] 

    #If there is no associated board param, that means that this interface is definitely for Sysgen
    if { [ expr { [ string length $associated_board_param ] == 0 } ] } { 
      return 1
    }

    set board_connection [get_property config.${associated_board_param} [::bd::utils::get_parent $connected_to]]
    
    if { [ expr { [ string length $board_connection ] != 0 } ] } {
      return 0
    }

    #If the board connection is empty, then that means that this interface is definitely for Sysgen
    return 1
  }
 
 
 #-------------------------------------------------------
 # Returns the VLNV of the IP that packaged using System Generator 
 #
 #-------------------------------------------------------
 proc dsp_get_ip_vlnv {} {
    set ip_vlnv [dsp_ip_packager_get_vendor]:[dsp_ip_packager_get_library]:[dsp_ip_packager_get_top_name]:[dsp_ip_packager_get_version]
    return $ip_vlnv
 }
 #-------------------------------------------------------
 # Creates a functioning template ZynQ design
 #-------------------------------------------------------
 proc dsp_apply_bd_automation_for_ps {} {
    set ps_inst processing_system_1
#    set ps_version 5.4 
#    create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:$ps_version $ps_inst
    create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 $ps_inst
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1"}  [get_bd_cells /$ps_inst] 
    set_property -dict [list CONFIG.PCW_USE_M_AXI_GP0 {1}] [get_bd_cells /$ps_inst] 
  set_property -dict [list CONFIG.PCW_EN_CLK0_PORT {1}] [get_bd_cells /$ps_inst]  
 }
 #-------------------------------------------------------
 # Create a functioning template Microblaze Design
 #-------------------------------------------------------
 proc dsp_apply_bd_automation_for_microblaze {} {
    set microblaze_inst microblaze_1
    #set microblaze_version 9.5
    create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze $microblaze_inst
    apply_bd_automation -rule xilinx.com:bd_rule:microblaze -config {local_mem "8KB" ecc "None" debug_module "Debug Only" axi_periph "1" axi_intc "0" clk "New Clocking Wizard (100 MHz)" }  [get_bd_cells /$microblaze_inst]
    #Following lines have a lot of hardcoding to make the design functional and useful 
    # By default Block Automation of Microblaze instances an AXI Interconnect with two 
    # Masters So We Reconfigure it to have only One Master
    set_property -dict [list CONFIG.NUM_MI {1}] [get_bd_cells /${microblaze_inst}_axi_periph]
    # By default Block Automation of Microblaze instances a Clock Wizard with 
    # differential pins but does not make them external so we reconfigure it
    # to make both the reset and the diff pairs external
    set clk_wiz_inst clk_wiz_1
    create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN1_D
    connect_bd_intf_net [get_bd_intf_ports /CLK_IN1_D] [get_bd_intf_pins /$clk_wiz_inst/CLK_IN1_D]
    # By default Block Automation of Microblaze instances a proc_sys_reset port
    # with dangling ext_reset_in and aux_reset_in. aux_reset_in is left unconnected
    # because it gets a good default value. ext_reset_in is connected to 
    # reset_rtl port that is an external port. The reset pin of clk_wiz is
    # also connected to the same port. This reset pin is Active High
    set proc_sys_reset_inst rst_clk_wiz_1_100M
    create_bd_port -dir I reset_rtl -type rst
    set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_ports /reset_rtl]
    connect_bd_net [get_bd_ports /reset_rtl] [get_bd_pins /$proc_sys_reset_inst/ext_reset_in]
    connect_bd_net [get_bd_ports /reset_rtl] [get_bd_pins /$clk_wiz_inst/reset] 
 }

 #-------------------------------------------------------
 # Returns IP instance in IPI design
 #-------------------------------------------------------
 proc dsp_get_ip_instance_name {} {
    set ip_inst [dsp_ip_packager_get_top_name]_1
    return $ip_inst
 }
 #-------------------------------------------------------
 # Instantiate IP bd cell in IPI design
 #------------------------------------------------------
 proc dsp_instance_ip_in_ipi_design {} {
    set ip_inst [dsp_get_ip_instance_name]
    set ip_vlnv [dsp_get_ip_vlnv]
    #Create a System Generator IP instance 
    create_bd_cell -type ip -vlnv $ip_vlnv $ip_inst
 }
 
proc dsp_is_processor_interfaces_available_on_ip {} {
    set intfs [get_bd_intf_pins /[dsp_get_ip_instance_name]/*]
    if { $intfs == "" } {
        #No Interfaces Available
        return 0
    }
    foreach intf $intfs {
        set intf_vlnv [get_property VLNV $intf]
        set index [string first "aximm_rtl" $intf_vlnv]
        if {$index != -1} {
            return 1;
        }        
    }    
    return 0
 }
 #-------------------------------------------------------------------------
 # Returns 1 if ZynQ device is targetted
 #-------------------------------------------------------------------------
 proc dsp_ipp_is_zynq {} {
#    return [string match [dsp_get_param_value_in_driver_tcl_namespace DSPFamily] "zynq"]
    # using wildcards to also match QZynq (no ZynqUPlus, yet, since this is different IP)
    return [string match -nocase "*zynq" [dsp_get_param_value_in_driver_tcl_namespace DSPFamily]]
 }
 #-------------------------------------------------------
 # Performs Automation for IP Created By System Generator
 # AXI Lite Interfaces are connected to AXI Interconnect 
 # AXI Stream Interfaces are made external
 # Non-interface ports other than clock and aresetn are made external
 # Clock is connected to clocking wizard
 # Reset is connected to proc_sys_reset_1 
 #-------------------------------------------------------
 proc dsp_apply_bd_automation_for_ip {} {
    set microblaze_inst microblaze_1
    set ip_inst [dsp_get_ip_instance_name]
    set ps_inst processing_system_1    
    if { [dsp_is_processor_interfaces_available_on_ip] == 1 } {
        set intfs [get_bd_intf_pins /[dsp_get_ip_instance_name]/*]
        foreach intf $intfs {
            set intf_vlnv [get_property VLNV $intf]
            set index [string first "aximm_rtl" $intf_vlnv]
            if {$index != -1} {
                if {[dsp_ipp_is_zynq]} {
                   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config [list Master "/$ps_inst/M_AXI_GP0"] $intf 
                } else {
                   #Apply BD Automation to every AXI Lite Interface exported by SysGen
                   apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config [list Master "/$microblaze_inst (Periph)"] $intf 
                }
            }
        }
    }
    # Apply Rule Automation to all Unconnected Pins that do not belong to any interface
    set pins [get_bd_pins /$ip_inst/*]
    foreach pin $pins {
        set pin_net [get_bd_nets -quiet -of_object $pin]
        set is_intf_pin [get_property -quiet INTF $pin]
        if { $is_intf_pin == FALSE && $pin_net == "" } {
            # Make it External
            set pin_name  [file tail [get_property -quiet NAME $pin]]
            if {[get_property -quiet LEFT $pin] == ""} {
                # A boolean signal
                create_bd_port -dir [get_property -quiet DIR $pin] -type [get_property -quiet TYPE $pin] $pin_name 
            } else {
                create_bd_port -dir [get_property -quiet DIR $pin] -from [get_property -quiet LEFT $pin] -to [get_property -quiet RIGHT $pin] -type [get_property -quiet TYPE $pin] $pin_name 
            }
            connect_bd_net [get_bd_ports /$pin_name] [get_bd_pins $pin]
        }
    }
    set_msg_config -id {BD 41-759} -new_severity {INFO}
    validate_bd_design
    set_msg_config -id {BD 41-759} -new_severity {CRITICAL WARNING}
    #Apply a Rule to Make Each UnConnected Interface an External Interface
    set intfs [get_bd_intf_pins /$ip_inst/*]
    foreach intf $intfs {
        set intf_vlnv [get_property VLNV $intf]
        set index [string first "axis_rtl" $intf_vlnv]
        if { $index != -1 } {
            create_bd_intf_port -mode [get_property MODE $intf] -vlnv xilinx.com:interface:axis_rtl:1.0 [get_property NAME $intf]
            # Added to enable board Automation for ZynQ single clock systems
            if {([dsp_ipp_is_zynq] == 1) && ([dsp_is_processor_interfaces_available_on_ip] == 1)} {
                set_property CONFIG.FREQ_HZ [get_property CONFIG.FREQ_HZ [get_bd_intf_pins /$ip_inst/[get_property NAME $intf]]] [get_bd_intf_ports /[get_property NAME $intf]]
            } 
            connect_bd_intf_net [get_bd_intf_pins /$ip_inst/[get_property NAME $intf]] [get_bd_intf_ports /[get_property NAME $intf]]
            if {[get_property MODE $intf] == "Slave"} {
                set_property CONFIG.TDATA_NUM_BYTES [get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins /$ip_inst/[get_property NAME $intf]]] [get_bd_intf_ports /[get_property NAME $intf]]                
                set_property CONFIG.HAS_TLAST [get_property CONFIG.HAS_TLAST [get_bd_intf_pins /$ip_inst/[get_property NAME $intf]]] [get_bd_intf_ports /[get_property NAME $intf]]
                set_property CONFIG.LAYERED_METADATA [get_property CONFIG.LAYERED_METADATA [get_bd_intf_pins /$ip_inst/[get_property NAME $intf]]] [get_bd_intf_ports /[get_property NAME $intf]]
            } 
        }
    }
 }

   # setting project and fileset properties when compilation target is HDL Netlist or IP Catalog
   proc dsp_analysis_set_project_settings {} {
       set compilationFlowName [ dsp_get_compilation_flow_name ]
       if { [ string equal $compilationFlowName "HDL Netlist" ] || [string equal $compilationFlowName "IP Catalog"] } {
           puts "INFO: Setting More Options property of synthesis to -mode out_of_context."
           set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs synth_1]
       }


       # In case of AXILite interface, the Sysgen example design may include processor, glue logic
       # and the Sysgen design
       # For normal IP Catalog flow, <top_module>_bd_wrapper is top module in Vivado project
       # For Timing Analysis, timing paths under <top_module>_stub should only be analyzed
       # Hence, it should be top module in Vivado project
       set orig_top_module_name [ get_property top [current_fileset] ]
       if { [string equal $compilationFlowName "IP Catalog"] } {
           set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
           set stub_top_module ${top_level_module}_stub
           ### DEBUG
           # puts "INFO: Original top module: $orig_top_module_name"
           puts "INFO: To enable analysis of IP Catalog flow results the top module is set to $stub_top_module."
           set_property -name top -value $stub_top_module [current_fileset] -quiet
       }
       return [ list $orig_top_module_name ]
   }

   # reverting project and fileset property settings
   proc dsp_analysis_revert_project_settings {prefValueList} {
       set compilationFlowName [ dsp_get_compilation_flow_name ]
       if { [ string equal $compilationFlowName "HDL Netlist" ] || [string equal $compilationFlowName "IP Catalog"] } {
           puts "INFO: Setting More Options property of synthesis to empty string."
           set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {} -objects [get_runs synth_1]
       }

       set orig_top_module_name [ get_property top [current_fileset] ]
       if { [string equal $compilationFlowName "IP Catalog"] } {
           set orig_top_module [ lindex $prefValueList 0 ]
           puts "INFO: For IP Catalog flow the top module is reverted back to $orig_top_module after collecting results for analysis."
           set_property -name top -value $orig_top_module [current_fileset] -quiet
       }
   }

   proc dsp_generate_timing_report {} {
       #puts "PRINT: Entered dsp_generate_timing_report"
       ### PERF_DEBUG
       set Performance_benchmarking 0
       if {$Performance_benchmarking == 1} {
           set system_time [clock seconds]
           set formated_time [clock format $system_time -format %H:%M:%S]
           puts "INFO: TA_Performance -- Entered dsp_generate_timing_report at time : $formated_time"
       }
       ### END PERF_DEBUG

       set curr_proj [::current_project]
       set ext {.xpr}

       # get necessary params to open project
       set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
       set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
       set proj_path "${paramvalueProjectDir}/${paramvalueProject}${ext}"
       if { [ dsp_is_good_string $curr_proj ] == 0 } {
           ### DEBUG
           # puts "INFO: SG_Analyzer -- Opening Vivado project ${proj_path} "
           [::open_project ${proj_path} -quiet]
       } else {
           ### DEBUG
           # puts "INFO: SG_Analyzer -- Vivado project ${proj_path} is already open."
       }

       # set project preferences set for timing analysis flow
       set origProjectSettings [ dsp_analysis_set_project_settings ]

       set currDir [pwd]
       cd "${paramvalueProjectDir}"
       ### DEBUG
       # puts "Current Directory: ${currDir}"
       # puts "Project Directory: ${paramvalueProjectDir}"

       # During synthesis resource sharing or merging of identical resources takes place.
       # Hence, in the synthesized netlist, merged blocks information is not available. 
       # For timing data back-annotation from Vivado to Simulink model, we need to have information
       # of the merged resources.
       # Setting of following parameter enables Vivado database to preserve information of the merged/shared resources.
       # It will be saved as FILE_NAMES and LINE_NUMBERS cell properties.
       [ ::set_param netlist.enableMultipleFileLines 1 ]
       #puts "PRINT: done enableMultipleFilelines"

       set prgs [get_property progress [get_runs synth_1]]
       if { [ string equal $prgs "100%" ] } {
           puts "INFO: SG_Analyzer -- A successful synthesis run is found. Opening run synth_1 ..."
           if { [ catch {::open_run synth_1 -name "synth_1" -quiet} result ] } {
               # do nothing
           }
       } else {
           ### PERF_DEBUG
           if {$Performance_benchmarking == 1} {
               set system_time1 [clock seconds]
               set formated_time [clock format $system_time1 -format %H:%M:%S]
               puts "INFO: TA_Performance -- Starting design synthesis at time : $formated_time"
           }
           ### END PERF_DEBUG

           puts "INFO: SG_Analyzer -- Running synth_1 ..."
           [ ::launch_runs synth_1 ]
           #puts "PRINT: launched synth_1"
           [ ::wait_on_run synth_1 ]
           if { [ catch {::open_run synth_1 -name "synth_1" -quiet} result ] } {
               # do nothing
           }

           # CR: 880842: # The optimized design gives different timing results than
           # timing results from just synthesized design 
           # Commenting out opt_design run after synthesis 
           # [ ::opt_design ]

           ### PERF_DEBUG
           if {$Performance_benchmarking == 1} {
               set system_time2 [clock seconds]
               set formated_time [clock format $system_time2 -format %H:%M:%S]
               puts "INFO: TA_Performance -- Completed synthesis at time : $formated_time"
               set time_diff [ expr {$system_time2 - $system_time1} ];
               puts "INFO: TA_Performance -- Total time in seconds : $time_diff"
           }
           ### END PERF_DEBUG
       }

       # check if post-implementation timing analysis is expected
       # if AnalyzeTimingPostImplementation is not set to 1
       # then run gather Vivado timing data post-synthesis
       set atPostImpl [ dsp_get_param_value_in_driver_tcl_namespace AnalyzeTimingPostImplementation ]
       #puts "PRINT: $atPostImpl"
       ### DEBUG
       # puts "Value of analyzeTimingPostImplementation option: $atPostImpl";
       if { [ dsp_is_good_string $atPostImpl ] && [ string equal $atPostImpl "1" ] } {
           set prgs [get_property progress [get_runs impl_1]]
           if { [ string equal $prgs "100%" ] } {
               puts "INFO: SG_Analyzer -- A successful implementation run is found. Opening run impl_1 ..."
               if { [ catch {::open_run impl_1 -name "impl_1"} result ] } {
                   # do nothing
               }
           } else {
               ### PERF_DEBUG
               if {$Performance_benchmarking == 1} {
                   set system_time1 [clock seconds]
                   set formated_time [clock format $system_time1 -format %H:%M:%S]
                   puts "INFO: TA_Performance -- Starting design optimization and implementation at time : $formated_time"
               }
               ### END PERF_DEBUG

               # run design optimization
               #puts "PRINT: running opt_design"
               [ ::opt_design ]
               
               puts "INFO: SG_Analyzer -- Running impl_1 ..."
               if {[ catch { ::launch_runs impl_1} ]} {
                   #puts "PRINT: launch impl_1 fails and executing again"
                   [ ::reset_run impl_1]
                   [ ::launch_runs impl_1]
                   [ ::wait_on_run impl_1 ]

               }
               #puts "PRINT: waiting for implementation to finish"
               [ ::wait_on_run impl_1 ]
               #puts "PRINT: implementation done"
               if { [ catch {::open_run impl_1 -name "impl_1"} result ] } {
                   # do nothing
               }

               ### PERF_DEBUG
               if {$Performance_benchmarking == 1} {
                   set system_time2 [clock seconds]
                   set formated_time [clock format $system_time2 -format %H:%M:%S]
                   puts "INFO: TA_Performance -- Completed optimization and implementation at time : $formated_time"
                   set time_diff [ expr {$system_time2 - $system_time1} ];
                   puts "INFO: TA_Performance -- Total time in seconds : $time_diff"
               }
               ### END PERF_DEBUG
           }
           puts "INFO: SG_Analyzer -- Timing paths data will be collected from the post-implementation design ...";
       } else {
           puts "INFO: SG_Analyzer -- Timing paths data will be collected from the post-synthesis design ..."
       }

       ## set clock_xdc_file "./${top_level_module}.srcs/constrs_1/imports/sysgen/${top_level_module}_clock.xdc"
       # Reading <top_module>_clock.xdc file for Synthesized_Checkpoint flow
       set compilationFlowName [ dsp_get_compilation_flow_name ]
       if { [ string equal $compilationFlowName "Synthesized Checkpoint" ] } {
           set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
           set clock_xdc_file "{[get_files ${top_level_module}_clock.xdc]}"
           ::read_xdc -no_add -verbose ${clock_xdc_file}

           # clock port location, BUFGCTRL_X0Y0, is fixed for all designs
           # this is needed for accurate timing analysis - Chaitanya Dudha
           ::set_property HD.CLK_SRC BUFGCTRL_X0Y0 [get_ports clk]
       }

       ### PERF_DEBUG
       if {$Performance_benchmarking == 1} {
           set system_time1 [clock seconds]
           set formated_time [clock format $system_time1 -format %H:%M:%S]
           puts "INFO: TA_Performance -- Starting timing paths data collection at time : $formated_time"
       }
       ### END PERF_DEBUG

       ### DEBUG
       # puts "Calling dsp_extract_timing_paths"
       set status [ dsp_extract_timing_paths ]

       ### PERF_DEBUG
       if {$Performance_benchmarking == 1} {
           set system_time2 [clock seconds]
           set formated_time [clock format $system_time2 -format %H:%M:%S]
           puts "INFO: TA_Performance -- Completed timing paths data collection at time : $formated_time"
           set time_diff [ expr {$system_time2 - $system_time1} ];
           puts "INFO: TA_Performance -- Total time in timing paths collection : $time_diff seconds"
       }
       ### END PERF_DEBUG

       ### DEBUG
       # puts "Calling dsp_extract_resource_utilization_data"
       set status [ dsp_extract_resource_utilization_data ]

       ### PERF_DEBUG
       if {$Performance_benchmarking == 1} {
           set system_time3 [clock seconds]
           set formated_time [clock format $system_time3 -format %H:%M:%S]
           puts "INFO: TA_Performance -- Completed resource utilization data collection at time : $formated_time"
           set time_diff [ expr {$system_time3 - $system_time2} ];
           puts "INFO: TA_Performance -- Total time in resources data collection : $time_diff seconds"
       }
       ### END PERF_DEBUG

       ### DEBUG
       # puts "change working directory to $currDir"
       cd "$currDir"

       # revert project preferences set for timing analysis flow to their original values
       dsp_analysis_revert_project_settings $origProjectSettings
       puts "INFO: SG_Analyzer -- Collected Vivado timing paths and resource utilization information ..."

       ### PERF_DEBUG
       if {$Performance_benchmarking == 1} {
           set system_time [clock seconds]
           set formated_time [clock format $system_time -format %H:%M:%S]
           puts "INFO: TA_Performance -- Exiting dsp_generate_timing_report at time : $formated_time"
       }
       ### END PERF_DEBUG
   }
   # End of dsp_generate_timing_report


   # writes timing data into outFile if HDL file used by Vivado tools 
   # match with the HDL file generated by SysGen
   # The generated data is in AnyTable Format
   proc dsp_extract_timing_paths {} {
       set result True

       # get file name <proj_name>.at to write timing data
       set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
       set netlistDir [ dsp_get_param_value_in_driver_tcl_namespace TargetDir ]

       set timing_report_file "${netlistDir}/${paramvalueProject}.at"
       ### DEBUG
       # puts "Timing paths data will be written in file: ${timing_report_file}"

       set hdlNetlistFile "${paramvalueProject}.v"
       if { [ dsp_hdllang_is_vhdl ] } {
           set hdlNetlistFile "${paramvalueProject}.vhd"
       }
       set hdlNetlistFiles [ list $hdlNetlistFile ]
       
       set atHoldConstraints [ dsp_get_param_value_in_driver_tcl_namespace AnalyzeTimingHoldConstraints ]
       ### DEBUG
       # puts "Value of analyzeTimingHoldConstraints option: $atHoldConstraints";

       set delayTypes [ list "max" ]
       if { [ dsp_is_good_string $atHoldConstraints ] && [ string equal $atHoldConstraints "1" ] } {
           set delayTypes [ list "max" "min" ]
           ### DEBUG
           # puts "INFO: Timing_Analyzer -- Timing paths for both SETUP and HOLD constrains will be collected ...";
       } else {
           ### DEBUG
           # puts "INFO: Timing_Analyzer -- Timing paths for only SETUP constrain will be collected ...";
       }

       set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
       set crossProbeFile "${top_level_module}.v.at"
       set hdl_language "verilog"
       if { [ dsp_hdllang_is_vhdl ] } {
           set crossProbeFile "${top_level_module}.vhd.at"
           set hdl_language "vhdl"
       }

       set outFile [ open ${timing_report_file} w ]
       puts $outFile "\# Vivado timing paths data is represented in anytable format"
       puts $outFile "\# The data will be consumed by System Generator Timing Analyzer.\n"
       puts $outFile "{"

       set atPostImpl [ dsp_get_param_value_in_driver_tcl_namespace AnalyzeTimingPostImplementation ]
       puts $outFile "    'Data_Collection' => \["
       puts $outFile "        {"
       if { [ dsp_is_good_string $atPostImpl ] && [ string equal $atPostImpl "1" ] } {
           puts $outFile "            'Vivado_Stage' => 'Post Implementation',"
       } else {
           puts $outFile "            'Vivado_Stage' => 'Post Synthesis',"
       }
       puts $outFile "            'Top_Module' => '${top_level_module}',"
       puts $outFile "            'HDL_Language' => '${hdl_language}',"
       puts $outFile "            'Netlist_Crossprobe_File' => '${crossProbeFile}',"
       puts $outFile "        }"
       puts $outFile "    \],"

       set maxPaths [ dsp_get_param_value_in_driver_tcl_namespace AnalyzeTimingNumPaths ]
       foreach delayType $delayTypes {
           ### DEBUG
           # puts "Delay Type: $delayType"
        
           set viol_type "setup"
           if { $delayType eq "min" } {
               set viol_type "hold"
           }

           puts $outFile "    '$viol_type' => \["
           ### DEBUG
           # puts "TA DEBUG: Calling get_timing_paths ... "
           # set i 0

           set timing_paths [ ::get_timing_paths -delay_type $delayType -max_paths $maxPaths -nworst 1 ]
           foreach path $timing_paths {
               ### DEBUG
               # set i [expr {$i + 1}]
               # puts "TA DEBUG: Vivado Timing Path Number: $i "

               set slack [ ::get_property SLACK $path ]
               if { [ llength $slack ] == 0 } {
                  ### puts "TA DEBUG: The slack is empty string"
                  continue
               }
               set delay [ ::get_property DATAPATH_DELAY $path ]
               if { [ llength $delay ] == 0 } {
                  ### puts "TA DEBUG: The delay is empty string"
                  continue
               }
               ### puts "TA DEBUG: delay: $delay "
               set logic_delay [ ::get_property DATAPATH_LOGIC_DELAY $path ]
               if { [ llength $logic_delay ] == 0 } {
                   ### puts "TA DEBUG: The logic_delay string is empty. Assigning 0 to logic_delay."
                   set logic_delay "0.00"
               }
               set net_delay [ ::get_property DATAPATH_NET_DELAY $path ]
               if { [ llength $net_delay ] == 0 } {
                   ### puts "TA DEBUG: The net_delay string is empty. Assigning 0 to net_delay."
                   set net_delay "0.00"
               }
               ### puts "TA DEBUG: net_delay: $net_delay "
               set requirement [ ::get_property REQUIREMENT $path ]
               if { [ llength $requirement ] == 0 } {
                  ### puts "TA DEBUG: The clock period requirement is empty string"
                  continue
               }
               ### puts "TA DEBUG: requirement: $requirement "
               set logic_levels [ ::get_property LOGIC_LEVELS $path ]
               if { [ llength $logic_levels ] == 0 } {
                  ### puts "TA DEBUG: The logic_levels is empty string"
                  continue
               }
               set launch_pin [ ::get_property STARTPOINT_PIN $path ]
               if { [ llength $launch_pin ] == 0 } {
                  ### puts "TA DEBUG: The launch_pin is empty string"
                  continue
               }
               set launch_cell [ ::get_property PARENT_CELL $launch_pin ]
               if { [ llength $launch_cell ] == 0 } {
                  ### puts "TA DEBUG: The launch_cell is empty string"
                  continue
               }
               set launch_clk [ ::get_property STARTPOINT_CLOCK $path ]
               if { [ llength $launch_clk ] == 0 } {
                  ### puts "TA DEBUG: The launch_clk is empty string"
                  continue
               }
               set launch_clk_name [ ::get_property NAME $launch_clk ]
               if { [ llength $launch_clk_name ] == 0 } {
                  ### puts "TA DEBUG: The launch_clk_name is empty string"
                  continue
               }
               # Check to make sure launch clock period is non-zero
               set launch_clk_period [ ::get_property PERIOD $launch_clk ]
               if { [ llength $launch_clk_period ] == 0 } {
                  ### puts "TA DEBUG: The launch_clk_period is empty string"
                  continue
               }
               ### puts "TA DEBUG: Launch Clock Name: $launch_clk_name \t Period: $launch_clk_period"
               if { $requirement > $launch_clk_period } {
                   set ce_index  [ expr {int( [expr {$requirement / $launch_clk_period}] )} ]
                   ### puts "TA DEBUG: Launch Clock Name: $launch_clk_name, ce_$ce_index"
                   set launch_clk_name [expr {"$launch_clk_name, ce_$ce_index"}]
               }
               ### puts "TA DEBUG: Launch Clock Name: $launch_clk_name \t Period: $launch_clk_period"

               set multicycle_path ""
               # the -quiet option suppresses errors in the command
               if { [catch {set exception_info [ ::get_property -quiet EXCEPTION $path ] } result] } {
                   puts "Timing Analyzer Info: An exception is thrown while accessing EXCEPTION property of a path"
               } else {
                   if { [ llength $exception_info ] > 0 &&
                        [ string is list $exception_info ] == 1 } {
                       set val_0 [lindex $exception_info 0]
                       if { [string equal $val_0 "MultiCycle"] == 1 } {
                           set val_2 [lindex $exception_info 2]
                           if { [string equal $val_2 "Setup"] == 1 } {
                               set setup_val [lindex $exception_info 4]
                               set hold_val [expr $setup_val - 1]
                               set multicycle_path "-setup $setup_val  -hold $hold_val"
                           }
                           if { [string equal $val_2 "Hold"] == 1 } {
                               set hold_val [lindex $exception_info 4]
                               set setup_val [expr $hold_val + 1]
                               set multicycle_path "-setup $setup_val  -hold $hold_val"
                           }
                       }
                   }
               }

               ### DEBUG
               # puts "TA DEBUG: Timing Path Data"
               # puts "Slack: $slack"
               # puts "Delay: $delay"
               # puts "Logic_Delay: $logic_delay"
               # puts "Routing_Delay: $net_delay"
               # puts "Logic Levels: $logic_levels"
               # puts "Launch pin: $launch_pin"
               # puts "Launch cell: $launch_cell"
               # puts "Launch clock domain: $launch_clk"
               # puts "Launch clock name: $launch_clk_name"
               # puts "Launch clock period: $launch_clk_period"
               # puts "Requirement: $requirement"
               # puts "MultiCycle Constraint: $multicycle_path"

               # get a list containing following information of the cell instance
               # cell name, hier_name and reference_name,
               # matching hdl netlist file name,
               # and line line number in the netlist file where cell is declared
               ## initialize path_visited to empty string
               set path_visited ""

               set resList [ dsp_extract_sysgen_block_name $launch_cell $hdlNetlistFiles ]
               set listSize [ llength $resList ]
               if { $listSize == 1 } { # list contains only launch_cell
                   continue
               }

               puts $outFile "        {"
               puts $outFile "            'Cells' => \["
               # list contains launch_cell and other related data
               if { $listSize == 2 } {
                   puts "Timing Analyzer Info: Cannot find relevant block name in SysGen design for launch cell, $launch_cell ."
                   set hier_cell [ lindex $resList 0 ]
                   set ref_name  [ lindex $resList 1 ]
                   ### DEBUG
                   # puts "Timing Analyzer Info: The highest level of cell instance in Vivado database, $hier_cell ."

                   puts $outFile "                {"
                   puts $outFile "                     'HDL_File' => 'UNFOUND',"
                   puts $outFile "                     'Line_Num' => 'Line_000',"
                   puts $outFile "                     'HDL_Files' => '',"
                   puts $outFile "                     'Line_Numbers' => 'Line_000',"
                   puts $outFile "                     'Block_Path' => '',"
                   puts $outFile "                     'Hier_Name' => '$hier_cell',"
                   puts $outFile "                     'Ref_Name' => '$ref_name',"
                   puts $outFile "                },"
               } else {
                   # puts "TA DEBUG: Writing timing path data, $resList, for launch cell, $launch_cell "
                   set file_name [ lindex $resList 0 ]
                   set line_num  [ lindex $resList 1 ]
                   set cell_path [ lindex $resList 2 ]
                   set hier_name [ lindex $resList 3 ]
                   set ref_name  [ lindex $resList 4 ]
                   set file_names ""
                   set line_numbers ""

                   if { $listSize > 5 } {
                       set file_names [ lindex $resList 5 ]
                       set line_numbers [ lindex $resList 6 ]
                   }
                   # puts "TA DEBUG: ListSize = $listSize"
                   # puts "TA DEBUG: file_names = $file_names"
                   # puts "TA DEBUG: line_numbers = $line_numbers"

                   set path_visited $cell_path

                   puts $outFile "                {"
                   puts $outFile "                     'HDL_File' => '${file_name}',"
                   puts $outFile "                     'Line_Num' => '${line_num}',"
                   if { [llength $file_names] > 0 } {
                       puts $outFile "                     'HDL_Files' => '${file_names}',"
                       puts $outFile "                     'Line_Numbers' => '${line_numbers}',"
                   } else {
                       puts $outFile "                     'HDL_Files' => '',"
                       puts $outFile "                     'Line_Numbers' => '',"
                   }
                   puts $outFile "                     'Block_Path' => '$cell_path',"
                   puts $outFile "                     'Hier_Name' => '$hier_name',"
                   puts $outFile "                     'Ref_Name' => '$ref_name',"
                   puts $outFile "                },"
               }

               set capture_clk [ ::get_property ENDPOINT_CLOCK $path ]
               if { [ llength $capture_clk ] > 0 } {
                   set capture_clk_name [ ::get_property NAME $capture_clk ]
                   set capture_clk_period [ ::get_property PERIOD $capture_clk ]
                   if { $requirement > $capture_clk_period } {
                       set ce_index  [ expr {int( [expr {$requirement / $capture_clk_period}] )} ]
                       ### puts "TA DEBUG: Capture Clock Name: $capture_clk_name, ce_$ce_index"
                       set capture_clk_name [expr {"$capture_clk_name, ce_$ce_index"} ]
                   }
               }

               ### DEBUG
               # if { [::get_property IS_PROPAGATED $capture_clk] == 1} {
               #     puts "TA DEBUG: Capture Clock: $capture_clk_name is propagated."
               # } else {
               #     puts "TA DEBUG: Capture Clock: $capture_clk_name is not propagated."
               # }

               set capture_pin [ ::get_property ENDPOINT_PIN $path ]
               if { [ llength $capture_pin ] > 0 } {
                   set capture_cell [ ::get_property PARENT_CELL $capture_pin ]
               }
               # puts "TA DEBUG: Capture pin: $capture_pin"
               # puts "TA DEBUG: Capture clock domain: $capture_clk"

               set path_cells [ ::get_cells -of_objects $path ]
               set num_path_cells [ llength $path_cells ]
               if { $num_path_cells > 2 } {
                   # There are path elements between launch_cell and capture_cell
                   foreach path_cell $path_cells {
                       if { [ llength $path_cell ] == 0 } {
                           continue
                       }
                       # puts "TA DEBUG: Parent Cell: $path_cell"

                       if { [ string equal $launch_cell $path_cell ] } {
                           continue
                       }

                       if { [ string equal $capture_cell $path_cell ] } {
                           continue
                       }

                       set resList [ dsp_extract_sysgen_block_name $path_cell $hdlNetlistFiles ]
                       set listSize [ llength $resList ]
                       if {$listSize  == 1 } { # list contains only path_cell
                           continue
                       } else { # list contains path_cell and other related data
                           if { $listSize == 2 } {
                               puts "Timing Analyzer Info: Cannot find relavent block name in SysGen design for path cell: $path_cell ."
                               set hier_cell [ lindex $resList 0 ]
                               set ref_name  [ lindex $resList 1 ]
                               ### DEBUG
                               # puts "Timing Analyzer Info: The highest level of cell instance in Vivado database, $hier_cell"

                               puts $outFile "                {"
                               puts $outFile "                     'HDL_File' => 'UNFOUND',"
                               puts $outFile "                     'Line_Num' => 'Line_000',"
                               puts $outFile "                     'HDL_Files' => '',"
                               puts $outFile "                     'Line_Numbers' => 'Line_000',"
                               puts $outFile "                     'Block_Path' => '',"
                               puts $outFile "                     'Hier_Name' => '$hier_cell',"
                               puts $outFile "                     'Ref_Name' => '$ref_name',"
                               puts $outFile "                },"
                           } else {
                               # puts "TA DEBUG: Writing timing path data for path cell, $path_cell"
                               set file_name [ lindex $resList 0 ]
                               set line_num  [ lindex $resList 1 ]
                               set cell_path [ lindex $resList 2 ]
                               set hier_name [ lindex $resList 3 ]
                               set ref_name  [ lindex $resList 4 ]
                               set file_names ""
                               set line_numbers ""
                               if { $listSize > 5 } {
                                   set file_names [ lindex $resList 5 ]
                                   set line_numbers [ lindex $resList 6 ]
                               }
                               # puts "TA DEBUG: ListSize = $listSize"
                               # puts "TA DEBUG: file_names = $file_names"
                               # puts "TA DEBUG: line_numbers = $line_numbers"

                               if { [ string equal $cell_path $path_visited ] } {
                                   continue
                               }
                               set path_visited $cell_path

                               puts $outFile "                {"
                               puts $outFile "                     'HDL_File' => '${file_name}',"
                               puts $outFile "                     'Line_Num' => '${line_num}',"
                               if { [llength $file_names] > 0 } {
                                   puts $outFile "                     'HDL_Files' => '${file_names}',"
                                   puts $outFile "                     'Line_Numbers' => '${line_numbers}',"
                               } else {
                                   puts $outFile "                     'HDL_Files' => '',"
                                   puts $outFile "                     'Line_Numbers' => '',"
                               }
                               puts $outFile "                     'Block_Path' => '$cell_path',"
                               puts $outFile "                     'Hier_Name' => '$hier_name',"
                               puts $outFile "                     'Ref_Name' => '$ref_name',"
                               puts $outFile "                },"
                           }
                       }
                   }
               }

               if { [ llength $capture_cell ] > 0 } {
                   set resList [ dsp_extract_sysgen_block_name $capture_cell $hdlNetlistFiles ]
                   set listSize [ llength $resList ]
                   if { $listSize > 1 } { # list contains capture_cell and other related data
                       if { $listSize == 2 } {
                           puts "INFO: Timing_Analyzer -- Cannot find relevant block name in SysGen design for capture cell, $capture_cell ."
                           set hier_cell [ lindex $resList 0 ]
                           set ref_name  [ lindex $resList 1 ]
                           ### DEBUG
                           # puts "Timing Analyzer Info: The highest level of cell instance in Vivado database, $hier_cell ."
                           puts $outFile "                {"
                           puts $outFile "                     'HDL_File' => 'UNFOUND',"
                           puts $outFile "                     'Line_Num' => 'Line_000',"
                           puts $outFile "                     'HDL_Files' => '',"
                           puts $outFile "                     'Line_Numbers' => 'Line_000',"
                           puts $outFile "                     'Block_Path' => '',"
                           puts $outFile "                     'Hier_Name' => '$hier_cell',"
                           puts $outFile "                     'Ref_Name' => '$ref_name',"
                           puts $outFile "                },"
                       } else {
                           ### puts "TA DEBUG: "Writing timing path data for capture cell, $capture_cell"

                           set file_name [ lindex $resList 0 ]
                           set line_num  [ lindex $resList 1 ]
                           set cell_path [ lindex $resList 2 ]
                           set hier_name [ lindex $resList 3 ]
                           set ref_name  [ lindex $resList 4 ]
                           set file_names ""
                           set line_numbers ""
                           if { $listSize > 5 } {
                               set file_names [ lindex $resList 5 ]
                               set line_numbers [ lindex $resList 6 ]
                           }
                           # puts "TA DEBUG: ListSize = $listSize"
                           # puts "TA DEBUG: file_names = $file_names"
                           # puts "TA DEBUG: line_numbers = $line_numbers"

                           puts $outFile "                {"
                           puts $outFile "                     'HDL_File' => '${file_name}',"
                           puts $outFile "                     'Line_Num' => '${line_num}',"
                           if { [llength $file_names] > 0 } {
                               puts $outFile "                     'HDL_Files' => '${file_names}',"
                               puts $outFile "                     'Line_Numbers' => '${line_numbers}',"
                           } else {
                               puts $outFile "                     'HDL_Files' => '',"
                               puts $outFile "                     'Line_Numbers' => '',"
                           }
                           puts $outFile "                     'Block_Path' => '$cell_path',"
                           puts $outFile "                     'Hier_Name' => '$hier_name',"
                           puts $outFile "                     'Ref_Name' => '$ref_name',"
                           puts $outFile "                },"
                       }
                   }
               }

               # closing square bracket that matches with sequence, "'Cells' => \["
               puts $outFile "            \],"

               # slack, delay and logic_levels are either double or integer values
               puts $outFile "            'Slack' => $slack,"
               puts $outFile "            'Delay' => $delay,"
               puts $outFile "            'Logic_Delay' => $logic_delay,"
               puts $outFile "            'Routing_Delay' => $net_delay,"
               puts $outFile "            'Logic_Levels' => $logic_levels,"
               puts $outFile "            'Launch_Clk' => '$launch_clk_name',"
               puts $outFile "            'Launch_Clk_Period' => $launch_clk_period,"
               puts $outFile "            'Capture_Clk' => '$capture_clk_name',"
               puts $outFile "            'Capture_Clk_Period' => $capture_clk_period,"
               puts $outFile "            'Requirement' => $requirement,"
               if { [llength $multicycle_path] > 0 } {
                   puts $outFile "            'MultiCycle_Path' => '$multicycle_path',"
               } else {
                   puts $outFile "            'MultiCycle_Path' => '',"
               }

               # closing curly bracket to show end of data for each path
               puts $outFile "        },"
           }

           # closing square bracket that matches with sequence, 'setup' or 'hold'
           puts $outFile "    \],"
       }

       # closing curly bracket that matches with the first curly bracket in the file
       puts $outFile "}"
       ::close $outFile

       return ${result}
   }
   # End of dsp_extract_timing_paths


   # gets hdl netlist name from vivado for each hier cell instance
   # and looks for the netlist name in hdlNetlistFiles that are created by SysGen netlist writer
   # IF a match is found then returns a list containing
   # hierarchical cell instance, netlist file name and line number
   proc dsp_extract_sysgen_block_name {leafCell hdlNetlistFiles} {
       set matchedNetlistFile ""
       set parentCell ${leafCell}
       while { [ string length $parentCell ] > 0 } {
           if { [ get_property IS_PRIMITIVE $parentCell ] == 0} {
               set filePath [ ::get_property FILE_NAME $parentCell ]
               set fileName [ file tail $filePath ]
               ### DEBUG
               # puts "Vivado parent cell: $parentCell"
               # puts "Vivado netlist file path: $filePath"
               # puts "Vivado netlist file name: $fileName"

               foreach netlistFile $hdlNetlistFiles {
                   if { [ string equal $fileName $netlistFile ] } {
                       set matchedNetlistFile $fileName
                       ### DEBUG
                       # puts "Found SysGen source file: $netlistFile : $lineNum for netlist instance: $parentCell"
                       set lineNum [ ::get_property LINE_NUMBER $parentCell ]
                       set lineNumString "Line_${lineNum}"
                       set hierName [ ::get_property HIERARCHICALNAME $parentCell ]
                       set refName [ ::get_property REF_NAME $parentCell ]
                       # Look for FILE_NAMES and LINE_NUMBERS property for the leaf cell
                       # Due to resource sharing, Vivado synthesis may merge instances and keep only one instance
                       # in the synthesized netlist.
                       # For back-annotation from Vivado to Simulink, we need information of all merged instances also.
                       # New properties FILE_NAMES and LINE_NUMBERS were added in 2015.3 to provide this information.
                       list fileNames ""
                       list lineNumberStrings ""
                       set fileLines [ ::get_property LINE_NUMBERS $parentCell ]
                       if { [ llength $fileLines ] > 0 } {
                           ### DEBUG
                           # puts "fileLines : $fileLines"
                           set numLines [llength $fileLines]
                           for {set i 0} {$i < $numLines} {set i [expr {$i + 1}]} {
                               set lNum [lindex $fileLines $i]
                               ### DEBUG
                               # puts "lineNum  : $lNum"
                               lappend fileNames $matchedNetlistFile
                               set lNumStr "Line_${lNum}"
                               lappend lineNumberStrings $lNumStr
                           }
                       }
                       ### DEBUG
                       # puts "TA DEBUG: fileNames = $fileNames"
                       # puts "TA DEBUG: lineNumbers = $lineNumbers"
                       return [ list $netlistFile $lineNumString $parentCell $hierName $refName $fileNames $lineNumberStrings ]
                   }
               }
           }
           set parentCell [ ::get_property PARENT $parentCell ]
       }

       if {$matchedNetlistFile eq ""} {
           ### DEBUG
           # puts "ERROR: Timing_Analyzer -- Cannot find SysGen source file for netlist instance: $leafCell"
           set refName [ ::get_property REF_NAME $leafCell ]
           if { [ string length $refName ] > 0 } {
               return [ list $leafCell $refName ]
           } else {
               return [ list $leafCell ]
           }
       }
   }
   # End of dsp_extract_sysgen_block_name

   # Note: Call to function dsp_generate_resource_utilization_report is commented out
   # Function dsp_extract_resource_utilization_data is directly called
   # from dsp_generate_timing_report
   # Collect resource utilization data from Vivado database
   # Write the data in the anytable format
   proc dsp_generate_resource_utilization_report {} {
       ### PERF_DEBUG
       set Performance_benchmarking 0
       if {$Performance_benchmarking == 1} {
           set system_time [clock seconds]
           set formated_time [clock format $system_time -format %H:%M:%S]
           puts "INFO: RA_Performance -- Entered dsp_generate_resourfce_utilization_report at time : $formated_time"
       }
       ### END PERF_DEBUG

       set curr_proj [::current_project]
       set ext {.xpr}

       # get necessary params to open project
       set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
       set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]
       set proj_path "${paramvalueProjectDir}/${paramvalueProject}${ext}"
       if { [ dsp_is_good_string $curr_proj ] == 0 } {
           ### DEBUG
           # puts "INFO: SG_Analyzer -- Opening Vivado project ${proj_path} "
           [::open_project ${proj_path} -quiet]
       } else {
           ### DEBUG
           # puts "INFO: SG_Analyzer -- Vivado project ${proj_path} is already open."
       }

       # set project preferences set for timing analysis flow
       set origProjectSettings [ dsp_analysis_set_project_settings ]

       set currDir [pwd]
       cd "${paramvalueProjectDir}"
       ### DEBUG
       # puts "Current Directory: ${currDir}"
       # puts "Project Directory: ${paramvalueProjectDir}"

       # Setting of following parameter enables Vivado database to preserve information of the merged/shared resources.
       # It will be saved as FILE_NAMES and LINE_NUMBERS cell properties.
       [ ::set_param netlist.enableMultipleFileLines 1 ]

       set prgs [get_property progress [get_runs synth_1]]
       if { [ string equal $prgs "100%" ] } {
           puts "INFO: SG_Analyzer -- A successful synthesis run is found. Opening run synth_1 ..."
           if { [ catch {::open_run synth_1 -name "synth_1" -quiet} result ] } {
               # do nothing
           }
       } else {
           ### PERF_DEBUG
           if {$Performance_benchmarking == 1} {
               set system_time1 [clock seconds]
               set formated_time [clock format $system_time1 -format %H:%M:%S]
               puts "INFO: RA_Performance -- Starting design synthesis at time : $formated_time"
           }
           ### END PERF_DEBUG

           puts "INFO: SG_Analyzer -- Running synth_1 ..."
           [ ::launch_runs synth_1 ]
           [ ::wait_on_run synth_1 ]
           if { [ catch {::open_run synth_1 -name "synth_1" -quiet} result ] } {
               # do nothing
           }

           ### PERF_DEBUG
           if {$Performance_benchmarking == 1} {
               set system_time2 [clock seconds]
               set formated_time [clock format $system_time2 -format %H:%M:%S]
               puts "INFO: RA_Performance -- Completed synthesis at time : $formated_time"
               set time_diff [ expr {$system_time2 - $system_time1} ];
               puts "INFO: RA_Performance -- Total time in seconds: $time_diff"
           }
           ### END PERF_DEBUG
       }

       # check if post-implementation analysis is expected
       # if AnalyzeTimingPostImplementation is not set to 1 then
       # gather Vivado resource utilization data after synthesis
       set atPostImpl [ dsp_get_param_value_in_driver_tcl_namespace AnalyzeTimingPostImplementation ]
       ### DEBUG
       # puts "Value of analyzeTimingPostImplementation option: $atPostImpl";
       if { [ dsp_is_good_string $atPostImpl ] && [ string equal $atPostImpl "1" ] } {
           set prgs [get_property progress [get_runs impl_1]]
           if { [ string equal $prgs "100%" ] } {
               puts "INFO: SG_Analyzer -- A successful implementation run is found. Opening run impl_1 ..."
               if { [ catch {::open_run impl_1 -name "impl_1"} result ] } {
               # do nothing
           }
           } else {
               ### PERF_DEBUG
               if {$Performance_benchmarking == 1} {
                   set system_time1 [clock seconds]
                   set formated_time [clock format $system_time1 -format %H:%M:%S]
                   puts "INFO: RA_Performance -- Starting design optimization and implementation at time : $formated_time"
               }
               ### END PERF_DEBUG

               # run design optimization
               [ ::opt_design ]

               ### DEBUG
               # puts "INFO: SG_Analyzer -- Running impl_1 ..."

               [ ::launch_runs impl_1 ]
               [ ::wait_on_run impl_1 ]
               if { [ catch {::open_run impl_1 -name "impl_1"} result ] } {
                   # do nothing
               }

               ### PERF_DEBUG
               if {$Performance_benchmarking == 1} {
                   set system_time2 [clock seconds]
                   set formated_time [clock format $system_time2 -format %H:%M:%S]
                   puts "INFO: RA_Performance -- Completed optimization and implementation at time : $formated_time"
                   set time_diff [ expr {$system_time2 - $system_time1} ];
                   puts "INFO: RA_Performance -- Total time in seconds: $time_diff"
               }
               ### END PERF_DEBUG
           }
           puts "INFO: SG_Analyzer -- Resource utilization data will be collected from the post-implementation design ...";
       } else {
           puts "INFO: SG_Analyzer -- Resource utilization data will be collected from the post-synthesis design ..."
       }

       ### PERF_DEBUG
       if {$Performance_benchmarking == 1} {
           set system_time1 [clock seconds]
           set formated_time [clock format $system_time1 -format %H:%M:%S]
           puts "INFO: RA_Performance -- Starting resource utilization data collection at time : $formated_time"
       }
       ### END PERF_DEBUG

       ### DEBUG
       # puts "Calling dsp_extract_resource_utilization_data"
       set status [ dsp_extract_resource_utilization_data ]

       ### PERF_DEBUG
       if {$Performance_benchmarking == 1} {
           set system_time2 [clock seconds]
           set formated_time [clock format $system_time2 -format %H:%M:%S]
           puts "INFO: RA_Performance -- Completed resource utilization data collection at time : $formated_time"
           set time_diff [ expr {$system_time2 - $system_time1} ];
           puts "INFO: SG_Analyzer_Performance -- Total time in data collection : $time_diff seconds"
       }
       ### END PERF_DEBUG

       ### DEBUG
       # puts "change working directory to $currDir"
       cd "$currDir"

       # revert project preferences set for timing analysis flow to their original values
       dsp_analysis_revert_project_settings $origProjectSettings
       puts "INFO: SG_Analyzer -- Collected Vivado resource utilization data ..."

       ### PERF_DEBUG
       if {$Performance_benchmarking == 1} {
           set system_time [clock seconds]
           set formated_time [clock format $system_time -format %H:%M:%S]
           puts "INFO: SG_Analyzer_Performance -- Exiting dsp_generate_resource_utilization_report at time : $formated_time"
       }
       ### END PERF_DEBUG
   }
   # End of dsp_generate_resource_utilization_report

   # Extract resource utilization data form Vivado cells
   # Build tcl dictionary and write out in anytable format
   proc dsp_extract_resource_utilization_data {} {
       set curr_proj [ ::current_project ]
       set top_name [ get_property NAME $curr_proj ]
       set paramvalueProject [ dsp_get_param_value_in_driver_tcl_namespace Project ]

       set hdlNetlistFile "${paramvalueProject}.v"
       if { [ dsp_hdllang_is_vhdl ] } {
           set hdlNetlistFile "${paramvalueProject}.vhd"
       }

       # get file name <proj_name>_res_util.at to write timing data
       set netlistDir [ dsp_get_param_value_in_driver_tcl_namespace TargetDir ]
       set res_util_data_file "${netlistDir}/${paramvalueProject}_res_util.at"
       ### DEBUG
       # puts "INFO: SG_Analyzer -- Resource Utilization data will be written in file: ${res_util_data_file}"

       set vivado_stage "Post Synthesis"
       set atPostImpl [ dsp_get_param_value_in_driver_tcl_namespace AnalyzeTimingPostImplementation ]
       if { [ dsp_is_good_string $atPostImpl ] && [ string equal $atPostImpl "1" ] } {
           set vivado_stage "Post Implementation"
       }
       set top_level_module [ dsp_get_param_value_in_driver_tcl_namespace TopLevelModule ]
       set crossProbeFile "${top_level_module}.v.at"
       set hdl_language "verilog"
       if { [ dsp_hdllang_is_vhdl ] } {
           set crossProbeFile "${top_level_module}.vhd.at"
           set hdl_language "vhdl"
       }

       set proj_part [::get_property PART $curr_proj]
       set block_RAMs [::get_property BLOCK_RAMS $proj_part]
       set DSPs [::get_property DSP $proj_part]
       set Registers [::get_property FLIPFLOPS $proj_part]
       set LUT_Elements [::get_property LUT_ELEMENTS $proj_part]
       # Ultra RAMs are added in UltraScale+ devices
       # the ULTRA_RAMS propery will not be present for other 
       # device parts from 7/8 series/UltraScale families
       set Ultra_RAMs ""
       set uram_property "ULTRA_RAMS"
       set part_properties [list_property $proj_part]
       if { [lsearch $part_properties $uram_property] } {
          set Ultra_RAMs [::get_property ULTRA_RAMS $proj_part]
       }

       set outFile [ open ${res_util_data_file} w ]
       puts $outFile "\# Vivado resource utilization data is represented in anytable format"
       puts $outFile "\# The data will be consumed by Resource Utilization flow in SysGen.\n"
       puts $outFile "{"
       puts $outFile "   'Design_Information' => \["
       puts $outFile "     { "
       puts $outFile "        'PART' => '${proj_part}',"
       puts $outFile "        'Vivado_Stage' => '${vivado_stage}',"
       puts $outFile "        'Top_Module' => '${top_level_module}',"
       puts $outFile "        'HDL_Language' => '${hdl_language}',"
       puts $outFile "        'Netlist_Crossprobe_File' => '${crossProbeFile}',"
       puts $outFile "     },"
       puts $outFile "   \],"
       puts $outFile "   'Device_Resources' => \["
       puts $outFile "     { "
       if { $Ultra_RAMs > 0 } {
           puts $outFile "        'URAMs' => '${Ultra_RAMs}',"
       }
       puts $outFile "        'BRAMs' => '${block_RAMs}',"
       puts $outFile "        'DSPs' => '${DSPs}',"
       puts $outFile "        'Registers' => '${Registers}',"
       puts $outFile "        'LUTs' => '${LUT_Elements}',"
       puts $outFile "     },"
       puts $outFile "   \],"
       puts $outFile "   'Resource_Utilization_Data' => \["

       # Note: Due to lack of additional wrapper code
       # instance <top_name>_struct is at the top level in the final netlist
       # for HDL Netlist and Synthesized Checkpoint flows
       set design_top_instance "${top_name}_struct"
       set compilationFlowName [ dsp_get_compilation_flow_name ]
       if { [string equal $compilationFlowName "IP Catalog"] } {
           # Note: Search for <top_name>_struct instance for IP Catalog
           set expected_top_instance ${top_name}_struct
           set wrapper_top_instance "${top_name}_bd_i"
           # puts "DEBUG: IP Catalog wrapper top instance: $wrapper_top_instance"

           # Go through all subcells under "${top_name}_bd_i" to find hierarchical
           # name of ${top_name}_struct instance
           set cell_list [ get_cells $wrapper_top_instance/*]
           foreach cl $cell_list {
               set is_prim [ ::get_property IS_PRIMITIVE $cl ]
               if { $is_prim == 1 } {
                   continue
               }
               ### DEBUG
               # set cell_name [ ::get_property NAME $cl ]
               # puts "DEBUG: Cell Name: $cell_name"
               set top_struct_instance [ dsp_find_top_struct_instance $cl $hdlNetlistFile $expected_top_instance ]
               if { [llength $top_struct_instance] > 0 } {
                   set design_top_instance $top_struct_instance
                   break
               }
           }

           ### DEBUG
           # puts "DEBUG: IP Catalog flow Changing Top Instance to: $design_top_instance"
       } else {
           set paramvalueProjectDir [ dsp_get_param_value_in_driver_tcl_namespace ProjectDir ]
           if { [string equal $paramvalueProjectDir "hwcosim"] } {
               # Note: Search for <top_name>_struct instance for HwCosim flow
               set expected_top_instance ${top_name}_struct
               set wrapper_top_instance "${paramvalueProjectDir}_top_i"
               # wrapper_top_instance is "hwcosim_top_i"
               # puts "DEBUG: HWCosim wrapper top instance: $wrapper_top_instance"

               # Go through all subcells under "hwcosim_top_i" to find hierarchical
               # name of ${top_name}_struct instance
               set cell_list [ get_cells $wrapper_top_instance/*]
               foreach cl $cell_list {
                   set is_prim [ ::get_property IS_PRIMITIVE $cl ]
                   if { $is_prim == 1 } {
                       continue
                   }

                    ### DEBUG
                   set cell_name [ ::get_property NAME $cl ]
                   # puts "DEBUG: design wrapper cell name: $cell_name"
                   set top_struct_instance [ dsp_find_top_struct_instance $cl $hdlNetlistFile $expected_top_instance ]
                   if { [llength $top_struct_instance] > 0 } {
                       set design_top_instance $top_struct_instance
                       break
                   }
               }

               # After hierarchical name of ${top_name}_struct instance is found
               # find resources used by additional logic added as hwcosim wrapper
               set logic_level "design_wrapper_top"
               set design_wrapper_name "hwcosim_wrapper_logic_and_axi_lite_interface"
               set wrapper_RU_data [dict create "cell_name" $design_wrapper_name]
               set cell_list [ get_cells $wrapper_top_instance/*]
               foreach cl $cell_list {
                   set is_prim [ ::get_property IS_PRIMITIVE $cl ]
                   if { $is_prim == 1 } {
                       continue
                   }

                    ### DEBUG
                   set cell_name [ ::get_property NAME $cl ]
                   # puts "DEBUG: design wrapper cell name: $cell_name"
                   # puts "DEBUG: getting resource utilization for design wrapper cell name : $cell_name"
                   set cell_RU_data [ dsp_get_resource_utilization_data $cl $hdlNetlistFile $outFile $design_top_instance $logic_level ]
                   foreach id [ dict keys $cell_RU_data ] {
                       if { [string equal $id "cell_name"] == 0 } {
                           set val [ dict get $cell_RU_data $id ]
                           if { [dict exists $wrapper_RU_data $id] } {
                               set orig_val [ dict get $wrapper_RU_data $id ]

                               ### DEBUG
                               # puts "Existing Key-Value Pair: $id -- $orig_val"
                               # set new_val [expr {$val + $orig_val}]
                               # dict set wrapper_RU_data $id $new_val

                               dict set wrapper_RU_data $id [expr {$val + $orig_val}]

                               ### DEBUG
                               # set new_val [dict get $wrapper_RU_data $id]
                               # puts "Updated Key-Value Pair: $id -- $new_val"
                           } else {
                               dict set wrapper_RU_data $id $val
                           }
                           ### DEBUG
                           # puts "Primitive: $id Value: $val"
                       }
                   }
               }

               if { [dict size $wrapper_RU_data] > 1 } {
                   puts $outFile "     { "
                   puts $outFile "          'File_Name' => 'design_wrapper_logic',"
                   puts $outFile "          'Line_Num' => 'Line_000',"
                   puts $outFile "          'Hier_Name' => '$design_wrapper_name',"
                   set id "cell_name"
                   puts $outFile "          'Cell_Name' => '$design_wrapper_name',"
                   puts $outFile "          'Primitives' => \[ "
                   puts $outFile "               { "
                   ## Note: Print resources that is not a cell name and
                   ## do not match "Total_*" pattern
                   foreach id [ dict keys $wrapper_RU_data ] {
                       if { [string equal $id "cell_name"] == 0 &&
                            [string match "Total_*"  $id] == 0 } {
                           set val [ dict get $wrapper_RU_data $id ]
                           ### DEBUG
                           # puts "     ${id} => $val"
                           puts $outFile "                    '${id}' => $val,"
                       }
                   }
                   ## Note: Print resources that match "Total_*" pattern
                   foreach id [ dict keys $wrapper_RU_data ] {
                       if { [string match "Total_*" $id] == 1 } {
                           set val [ dict get $wrapper_RU_data $id ]
                           ### DEBUG
                           # puts "     ${id} => $val"
                           puts $outFile "                    '${id}' => $val,"
                       }
                   }
                   puts $outFile "               },"
                   puts $outFile "          \],"
                   puts $outFile "     },"
               }

               ### DEBUG
               # puts "DEBUG: HWCosim flow Changing Top Instance to: $design_top_instance"
           }
       }

       ### DEBUG
       # puts "DEBUG: Design Top Instance: $design_top_instance"
       set cell_list [get_cells ${design_top_instance}/*]
       set len [llength $cell_list]
       if {$len > 0} {
           set top_RU_data [dict create "cell_name" $top_name]
           foreach cl $cell_list {
               ### DEBUG
               # puts "INFO: SG_Analyzer -- Calling dsp_get_resource_utilization_data for cell: $cl"
               set logic_level "design_struct"
               set cell_RU_data [ dsp_get_resource_utilization_data $cl $hdlNetlistFile $outFile $design_top_instance $logic_level ]
               foreach id [ dict keys $cell_RU_data ] {
                   if { [string equal $id "cell_name"] == 0 } {
                       set val [ dict get $cell_RU_data $id ]
                       ### DEBUG
                       # puts "Valid Key : $id  Value: $val"
                       if { [dict exists $top_RU_data $id] } {
                           ## dict incr top_RU_data $id $val
                           set orig_val [ dict get $top_RU_data $id ]

                           ### DEBUG
                           # puts "Existing Key-Value Pair: $id -- $orig_val"
                           # set new_val [expr {$val + $orig_val}]
                           # dict set top_RU_data $id $new_val

                           dict set top_RU_data $id [expr {$val + $orig_val}]

                           ### DEBUG
                           # set new_val [dict get $top_RU_data $id]
                           # puts "Updated Key-Value Pair: $id -- $new_val"
                       } else {
                           dict set top_RU_data $id $val
                       }
                       ### DEBUG
                       # puts "Primitive: $id Value: $val"
                   }
               }
           }
         
           ### DEBUG
           # puts "     File_Name => $hdlNetlistFile"
           puts $outFile "     { "
           puts $outFile "          'File_Name' => '$hdlNetlistFile',"
           puts $outFile "          'Line_Num' => 'Line_000',"
           puts $outFile "          'Hier_Name' => '${top_name}',"
           set id "cell_name"
           ### DEBUG
           # puts "     Cell_Name => ${top_name}"
           puts $outFile "          'Cell_Name' => '${top_name}',"
           puts $outFile "          'Primitives' => \[ "
           puts $outFile "               { "
           ## Note: Print resources that is not a cell name and
           ## do not match "Total_*" pattern
           foreach id [ dict keys $top_RU_data ] {
               if { [string equal $id "cell_name"] == 0 &&
                    [string match "Total_*"  $id] == 0 } {
                   set val [ dict get $top_RU_data $id ]
                   ### DEBUG
                   # puts "     ${id} => $val"
                   puts $outFile "                    '${id}' => $val,"
               }
           }
           ## Note: Print resources that match "Total_*" pattern
           foreach id [ dict keys $top_RU_data ] {
               if { [string match "Total_*" $id] == 1 } {
                   set val [ dict get $top_RU_data $id ]
                   ### DEBUG
                   # puts "     ${id} => $val"
                   puts $outFile "                    '${id}' => $val,"
               }
           }
           puts $outFile "               },"
           puts $outFile "          \],"
           puts $outFile "     },"
       }

       puts $outFile "   \],"
       puts $outFile "} "
       ::close $outFile
   }

   # this process is recursively called for each cell
   proc dsp_get_resource_utilization_data {cellName hdlNetlistFile outFile designTopInstance logicLevel} {
       # set count 0
       set cell_RU_data [ dict create "cell_name" $cellName ]
       set is_prim [ ::get_property IS_PRIMITIVE $cellName ]
       if { $is_prim == 1 } {
           set ref_name [ ::get_property REF_NAME $cellName ]
           # Ground (GND), and Power Supply (VCC) type of primitives
           # are not mapped to LUTs, BRAMs, URAMs, Registers or DSPs
           if { [string equal $ref_name "GND"] == 0 &&
                [string equal $ref_name "VCC"] == 0 } {

               # CARRY4 and CARRY8 are also not mapped to the primitive types of
               # our interest but still will be printed in the output file just
               # to preserve the information
               set prim_count [ ::get_property PRIMITIVE_COUNT $cellName ]
               ### DEBUG
               # puts "Primitive Name: $ref_name, Count: $prim_count"
               dict set cell_RU_data $ref_name $prim_count
               if { [ string match "*LUT*" $ref_name ] || [ string match "SRL*" $ref_name ] } {
                   dict set cell_RU_data "Total_LUTs" $prim_count
               }
               # Primitives of type FDCE, FDPE, FDRE and FDSE and LDCE and LDPE are considered registers
               # Hence these primitivs are added under Total_Registers count
               if { [ string match "FD*" $ref_name ] ||  [ string match "LD*" $ref_name ] } {
                   dict set cell_RU_data "Total_Registers" $prim_count
               }
               if { [ string match "DSP*" $ref_name ] } {
                   dict set cell_RU_data "Total_DSPs" $prim_count
               }
               #
               # As per Vivado report utilization development team
               # RAMB18, RAMB18E1, RAMB18E2, RAMB18SDP are treated as RAMB18
               # FIFO18E1, FIFO18E2 are treated as FIFO18
               # RAMB36, RAMB36E1, RAMB36E2, RAMB36E2_TEST, RAMB36SDP, RAMB36SDP_EXT
               # and RAMB36_EXP are treated as FIFO36
               # FIFO36E1 and FIFO36E2 are treated as FIFO36
               # Following equation is used to compute total BRAM count
               # Total BRAM count = (RAMB18+FIFO18)/2 + (RAMB36+FIFO36)
               if { [ string match "RAMB18*" $ref_name ] || [string match "FIFO18*" $ref_name] } {
                   dict set cell_RU_data "Total_BRAMs" [ expr {$prim_count/2.0} ]
               }
               if { [ string match "RAMB36*" $ref_name ] || [string match "FIFO36*" $ref_name] } {
                   dict set cell_RU_data "Total_BRAMs" $prim_count
               }
               # Ultra RAMs are added for UltraScale+ device families
               # This primitive resource is reported separately from BRAMs (Block RAMS + FIFO)
               # resource in Vivado resource utilization report
               if { [ string match "URAM*" $ref_name ] } {
                   dict set cell_RU_data "Total_URAMs" $prim_count
               }
           }
       } else {
           ### DEBUG
           # puts "Looking for cell list for: $cellName"
           set cell_list [ get_cells $cellName/* ]
           set len [ llength $cell_list ]
           if { $len > 0 } {
               if { [string equal $logicLevel "design_wrapper_top"] } {
                   set subLogicLevel "design_wrapper_internal"
               } else {
                   set subLogicLevel $logicLevel
               }
               foreach cl $cell_list {
                   ### DEBUG
                   # if { [string equal $logicLevel "design_wrapper_internal"] || [string equal $logicLevel "design_wrapper_top"] } {
                   #    puts "Calling dsp_get_resource_utilization_data for cell: $cl"
                   # }

                   if { [string equal $logicLevel "design_struct"] == 0 } {
                       if { [string equal $cl $designTopInstance] } {
                           ### DEBUG
                           # puts "DEBUG: Found design_top_instance, $designTopInstance, while getting res_util data for wrapper."
                           # puts "DEBUG: Skipping the cell instance"
                           continue
                       }
                   }

                   set RU_data [ dsp_get_resource_utilization_data $cl $hdlNetlistFile $outFile $designTopInstance $subLogicLevel ]
                   foreach id [ dict keys $RU_data ] {
                       if { [string equal $id "cell_name"] == 0 } {
                           set val [ dict get $RU_data $id ]
                           ### DEBUG
                           # puts "Valid Key : $id  Value: $val"
                           set new_val $val
                           if { [dict exists $cell_RU_data $id] } {
                               ## dict incr cell_RU_data $id $val
                               set orig_val [ dict get $cell_RU_data $id ]

                               ### DEBUG
                               # puts "Existing Key-Value Pair: $id -- $orig_val"
                               # set new_val [expr {$val + $orig_val}]
                               # puts "Changing Key-Value Pair: $id -- $new_val"
                               # dict set cell_RU_data $id $new_val

                               dict set cell_RU_data $id [expr {$val + $orig_val}]

                               ### DEBUG
                               # set new_val [ dict get $cell_RU_data $id ]
                               # puts "Updated Key-Value Pair: $id -- $new_val"
                           } else {
                               dict set cell_RU_data $id $val
                           }

                           ### DEBUG
                           # puts "Primitive: $id Value: $val"
                       }
                   }
               }

               set write_output 0
               if { [string equal $logicLevel "design_wrapper_top"] } {
                   set fileName "design_wrapper_logic"
                   set lineNum "000"
                   set hierName [ ::get_property HIERARCHICALNAME $cellName ]
                   set write_output 1
               }
               if { [string equal $logicLevel "design_struct"] } {
                   set filePath [ ::get_property FILE_NAME $cellName ]
                   set fileName [ file tail $filePath ]
               
                   if { [string equal $fileName $hdlNetlistFile] } {
                       set lineNum [ ::get_property LINE_NUMBER $cellName ]
                       set hierName [ ::get_property HIERARCHICALNAME $cellName ]
                       # set ref_name [ ::get_property REF_NAME $cellName ]
                       set write_output 1
                   }
               }

               if { $write_output == 1 } {
                       puts $outFile "     {"
                       puts $outFile "          'File_Name' => '$fileName',"
                       puts $outFile "          'Line_Num' => 'Line_${lineNum}',"
                       puts $outFile "          'Hier_Name' => '$hierName',"
                       set id "cell_name"
                       set val [ dict get $cell_RU_data $id ]
                       ### DEBUG
                       # puts "     Cell_Name => $val"
                       puts $outFile "          'Cell_Name' => '$val',"
                       puts $outFile "          'Primitives' => \[ "
                       puts $outFile "               {"
                       ## Note: Print resources that is not a cell name and
                       ## do not match "Total*" pattern
                       foreach id [ dict keys $cell_RU_data ] {
                           if { [string equal $id "cell_name"] == 0 && 
                                [string match "Total_*" $id] == 0 } {
                               set val [ dict get $cell_RU_data $id ]
                               ### DEBUG
                               # puts "     ${id} => $val"
                               puts $outFile "                    '${id}' => $val,"
                           }
                       }
                       ## Note: Print resources that match "Total_*" pattern
                       foreach id [ dict keys $cell_RU_data ] {
                           ## Note: Print resources that is not a cell name and
                           ## do not match "Total*" pattern
                           if { [string match "Total_*" $id] == 1 } {
                               set val [ dict get $cell_RU_data $id ]
                               ### DEBUG
                               # puts "     ${id} => $val"
                               puts $outFile "                    '${id}' => $val,"
                           }
                       }
                       puts $outFile "               },"
                       puts $outFile "          \], "
                       puts $outFile "     },"
               }
           }
       }

       return ${cell_RU_data}
   }

   # This process is called for HwCosim and IP Catalog compilation targets
   # to find out <top_module>_struct instance under the top level wrapper
   proc dsp_find_top_struct_instance {cellName hdlNetlistFile expectedTopInstance} {
       set top_struct_instance ""
       # The expected top instance <top_module>_struct is at higher level in hierarchy
       # Hence, if the cell is a primitive then return.
       set is_prim [::get_property IS_PRIMITIVE $cellName]
       if { $is_prim == 1 } {
           return ${top_struct_instance}
       }

       set hier_name [::get_property NAME $cellName]
       set cell_name [file tail $hier_name]
       # The clock_driver related instances are not part of Simulink design.
       # Hence, return if the cell name has "clock_driver" string.
       if { [string match {*clock_driver*} $cell_name] } {
           # puts "DEBUG: cell name matches with string: clock_driver"
           return ${top_struct_instance}
       }
       # puts "DEBUG: Cell Name = $cell_name"
       set file_path [::get_property FILE_NAME $cellName]
       set file_name [file tail $file_path]
       # puts "DEBUG: File Name = $file_name"
       if { [string equal $file_name $hdlNetlistFile] == 1 &&
            [string equal $cell_name $expectedTopInstance] == 1 } {
           set top_struct_instance $cellName
           # puts "DEBUG: found top_struct_instance $top_struct_instance"
       } else {
           # puts "DEBUG: Calling get cells for $cellName"
           set cell_list [::get_cells $cellName/*]
           set len [llength $cell_list]
           if { $len > 0 } {
               foreach cl $cell_list {
                   set top_struct_instance [dsp_find_top_struct_instance $cl $hdlNetlistFile $expectedTopInstance]
                   if { [llength $top_struct_instance] > 0 } {
                       break
                   }
               }
           }
       }
       return ${top_struct_instance}
   }

}
# END namespace ::xilinx::dsp::planaheadworker


