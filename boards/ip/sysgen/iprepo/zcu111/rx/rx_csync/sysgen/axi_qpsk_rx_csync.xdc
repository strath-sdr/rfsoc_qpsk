set rateCeaxi_qpsk_rx_csync6400 axi_qpsk_rx_csync_default_clock_driver/clockdriver_x0/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_csync6400 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_csync6400/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx_csync25600 axi_qpsk_rx_csync_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_csync25600 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_csync25600/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync6400 -to $rateCellsaxi_qpsk_rx_csync6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync6400 -to $rateCellsaxi_qpsk_rx_csync6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync6400 -to $rateCellsaxi_qpsk_rx_csync25600 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync6400 -to $rateCellsaxi_qpsk_rx_csync25600 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync25600 -to $rateCellsaxi_qpsk_rx_csync6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync25600 -to $rateCellsaxi_qpsk_rx_csync6400 -hold 6399
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync25600 -to $rateCellsaxi_qpsk_rx_csync25600 -setup 25600
set_multicycle_path -from $rateCellsaxi_qpsk_rx_csync25600 -to $rateCellsaxi_qpsk_rx_csync25600 -hold 25599
