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
