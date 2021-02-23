set rateCeaxi_qpsk_rx_rrc1600 axi_qpsk_rx_rrc_default_clock_driver/clockdriver_x1/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_rrc1600 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_rrc1600/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx_rrc3200 axi_qpsk_rx_rrc_default_clock_driver/clockdriver_x0/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_rrc3200 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_rrc3200/Q]] IS_ENABLE]]
set rateCeaxi_qpsk_rx_rrc6400 axi_qpsk_rx_rrc_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsaxi_qpsk_rx_rrc6400 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeaxi_qpsk_rx_rrc6400/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc1600 -to $rateCellsaxi_qpsk_rx_rrc1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc1600 -to $rateCellsaxi_qpsk_rx_rrc1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc1600 -to $rateCellsaxi_qpsk_rx_rrc3200 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc1600 -to $rateCellsaxi_qpsk_rx_rrc3200 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc1600 -to $rateCellsaxi_qpsk_rx_rrc6400 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc1600 -to $rateCellsaxi_qpsk_rx_rrc6400 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc3200 -to $rateCellsaxi_qpsk_rx_rrc1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc3200 -to $rateCellsaxi_qpsk_rx_rrc1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc3200 -to $rateCellsaxi_qpsk_rx_rrc3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc3200 -to $rateCellsaxi_qpsk_rx_rrc3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc3200 -to $rateCellsaxi_qpsk_rx_rrc6400 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc3200 -to $rateCellsaxi_qpsk_rx_rrc6400 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc6400 -to $rateCellsaxi_qpsk_rx_rrc1600 -setup 1600
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc6400 -to $rateCellsaxi_qpsk_rx_rrc1600 -hold 1599
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc6400 -to $rateCellsaxi_qpsk_rx_rrc3200 -setup 3200
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc6400 -to $rateCellsaxi_qpsk_rx_rrc3200 -hold 3199
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc6400 -to $rateCellsaxi_qpsk_rx_rrc6400 -setup 6400
set_multicycle_path -from $rateCellsaxi_qpsk_rx_rrc6400 -to $rateCellsaxi_qpsk_rx_rrc6400 -hold 6399
