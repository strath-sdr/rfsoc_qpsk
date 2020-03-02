set rateCeaxi_qpsk_rx_dec40 axi_qpsk_rx_dec_default_clock_driver/clockdriver_x2/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_dec40 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_dec40/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx_dec80 axi_qpsk_rx_dec_default_clock_driver/clockdriver_x1/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_dec80 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_dec80/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx_dec3200 axi_qpsk_rx_dec_default_clock_driver/clockdriver_x0/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_dec3200 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_dec3200/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx_dec6400 axi_qpsk_rx_dec_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_dec6400 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_dec6400/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec80 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec80 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec3200 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec3200 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec6400 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec40 -to $rateCellsaxi_qpsk_rx_dec6400 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec3200 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec3200 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec6400 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec80 -to $rateCellsaxi_qpsk_rx_dec6400 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec6400 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec3200 -to $rateCellsaxi_qpsk_rx_dec6400 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec40 -setup 40
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec40 -hold 39
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec80 -setup 80
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec80 -hold 79
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx_dec6400 -to $rateCellsaxi_qpsk_rx_dec6400 -hold 6399
