# Batch wrapper: turn Tcl/IP/build failures into a nonzero process exit.
proc ci_main {} {
    global argv
    lassign $argv stage design_name reports
    set project ./block_design/block_design.xpr
    set bd ./block_design/block_design.srcs/sources_1/bd/${design_name}/${design_name}.bd
    switch -- $stage {
        recreate {
            set result [uplevel #0 {source ./make_block_design.tcl}]
            if {[string is integer -strict $result] && $result != 0} {
                error "Block design script returned failure: $result"
            }
            if {[llength [get_bd_designs -quiet $design_name]] != 1 ||
                [llength [get_bd_cells -quiet]] == 0} {
                error "Block design recreation did not produce $design_name"
            }
            validate_bd_design
            save_bd_design
            report_ip_status -file $reports/recreate-ip-status.rpt
        }
        migrate {
            open_project $project
            open_bd_design $bd
            report_ip_status -file $reports/before-upgrade-ip-status.rpt
            set locked [get_ips -quiet -filter {IS_LOCKED == true}]
            if {[llength $locked]} {
                upgrade_ip $locked -log $reports/ip-upgrade.log
            }
            validate_bd_design
            save_bd_design
            report_ip_status -file $reports/after-upgrade-ip-status.rpt
            if {[llength [get_ips -quiet -filter {IS_LOCKED == true}]]} {
                error "Locked IP remains after migration; inspect IP status"
            }
            write_bd_tcl -force ./${design_name}.tcl
        }
        build {
            # Retain each board's existing wrapper, constraints and build choices.
            uplevel #0 {source ./make_bitstream.tcl}
            foreach run_name {synth_1 impl_1} {
                set run [get_runs $run_name]
                if {[get_property PROGRESS $run] ne "100%" ||
                    [string match -nocase *error* [get_property STATUS $run]]} {
                    error "$run_name did not complete: [get_property STATUS $run]"
                }
            }
            open_run impl_1
            report_timing_summary -delay_type min_max -report_unconstrained -file $reports/timing.rpt
            report_drc -file $reports/drc.rpt
            report_utilization -file $reports/utilization.rpt
            report_ip_status -file $reports/final-ip-status.rpt
            # Check setup, hold and pulse width on the implemented run.
            foreach metric {STATS.WNS STATS.WHS STATS.TPWS} {
                set slack [get_property $metric [get_runs impl_1]]
                if {![string is double -strict $slack] || $slack < 0} {
                    error "Timing check failed: $metric = $slack"
                }
            }
            if {[llength [get_drc_violations -quiet -filter {SEVERITY == "Error" || SEVERITY == "Critical Warning"}]]} {
                error "DRC errors or critical warnings remain; inspect drc.rpt"
            }
            if {[llength [get_ips -quiet -filter {IS_LOCKED == true}]]} {
                error "Locked IP remains in final design"
            }
        }
        default { error "Unknown stage: $stage" }
    }
    close_project
}

if {[catch {ci_main} message options]} {
    puts stderr "CI FAILED: $message"
    puts stderr [dict get $options -errorinfo]
    exit 1
}
exit 0
