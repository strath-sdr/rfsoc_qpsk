set rateCeaxi_qpsk_tx3200 axi_qpsk_tx_default_clock_driver/clockdriver_x2/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_tx3200 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_tx3200/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_tx6400 axi_qpsk_tx_default_clock_driver/clockdriver_x1/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_tx6400 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_tx6400/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_tx12800 axi_qpsk_tx_default_clock_driver/clockdriver_x0/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_tx12800 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_tx12800/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_tx51200 axi_qpsk_tx_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_tx51200 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_tx51200/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx6400 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx6400 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx12800 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx12800 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx51200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_tx3200 -to $rateCellsaxi_qpsk_tx51200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx12800 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx12800 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx51200 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_tx6400 -to $rateCellsaxi_qpsk_tx51200 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx12800 -setup 12800
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx12800 -hold 12799
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx51200 -setup 12800
set_multicycle_path -from $rateCellsaxi_qpsk_tx12800 -to $rateCellsaxi_qpsk_tx51200 -hold 12799
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx12800 -setup 12800
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx12800 -hold 12799
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx51200 -setup 51200
set_multicycle_path -from $rateCellsaxi_qpsk_tx51200 -to $rateCellsaxi_qpsk_tx51200 -hold 51199
