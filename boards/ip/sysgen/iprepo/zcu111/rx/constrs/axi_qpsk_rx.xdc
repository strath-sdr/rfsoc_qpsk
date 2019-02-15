set rateCeaxi_qpsk_rx40 axi_qpsk_rx_default_clock_driver/clockdriver_x4/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx40 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx40/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx80 axi_qpsk_rx_default_clock_driver/clockdriver_x2/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx80 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx80/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx1600 axi_qpsk_rx_default_clock_driver/clockdriver_x0/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx1600 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx1600/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx3200 axi_qpsk_rx_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx3200 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx3200/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx6400 axi_qpsk_rx_default_clock_driver/clockdriver_x1/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx6400 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx6400/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx12800 axi_qpsk_rx_default_clock_driver/clockdriver_x3/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx12800 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx12800/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx25600 axi_qpsk_rx_default_clock_driver/clockdriver_x5/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx25600 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx25600/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx80 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx80 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx1600 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx1600 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx3200 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx3200 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx6400 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx6400 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx12800 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx12800 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx25600 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx40 -to $rateCellsaxi_qpsk_rx25600 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx1600 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx1600 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx3200 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx3200 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx6400 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx6400 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx12800 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx12800 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx25600 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx80 -to $rateCellsaxi_qpsk_rx25600 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx3200 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx3200 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx6400 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx6400 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx12800 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx12800 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx25600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx1600 -to $rateCellsaxi_qpsk_rx25600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx6400 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx6400 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx12800 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx12800 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx25600 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx3200 -to $rateCellsaxi_qpsk_rx25600 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx12800 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx12800 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx25600 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx6400 -to $rateCellsaxi_qpsk_rx25600 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx12800 -setup 12800
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx12800 -hold 12799
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx25600 -setup 12800
set_multicycle_path -from $rateCellsaxi_qpsk_rx12800 -to $rateCellsaxi_qpsk_rx25600 -hold 12799
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx12800 -setup 12800
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx12800 -hold 12799
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx25600 -setup 25600
set_multicycle_path -from $rateCellsaxi_qpsk_rx25600 -to $rateCellsaxi_qpsk_rx25600 -hold 25599
