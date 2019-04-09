set rateCeqpsk_tx_symbol_gen51200 qpsk_tx_symbol_gen_default_clock_driver/clockdriver/pipelined_ce.ce_pipeline[1].ce_reg/latency_gt_0.fd_array[1].reg_comp/fd_prim_array[0].bit_is_0.fdre_comp
set rateCellsqpsk_tx_symbol_gen51200 [get_cells -of [filter [all_fanout -flat -endpoints [get_pins $rateCeqpsk_tx_symbol_gen51200/Q]] IS_ENABLE]]
set_multicycle_path -from $rateCellsqpsk_tx_symbol_gen51200 -to $rateCellsqpsk_tx_symbol_gen51200 -setup 51200
set_multicycle_path -from $rateCellsqpsk_tx_symbol_gen51200 -to $rateCellsqpsk_tx_symbol_gen51200 -hold 51199
