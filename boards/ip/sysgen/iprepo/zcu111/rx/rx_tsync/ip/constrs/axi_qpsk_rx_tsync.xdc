set rateCeaxi_qpsk_rx_tsync1600 axi_qpsk_rx_tsync_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_tsync1600 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_tsync1600/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsaxi_qpsk_rx_tsync1600 -to $rateCellsaxi_qpsk_rx_tsync1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx_tsync1600 -to $rateCellsaxi_qpsk_rx_tsync1600 -hold 1599
