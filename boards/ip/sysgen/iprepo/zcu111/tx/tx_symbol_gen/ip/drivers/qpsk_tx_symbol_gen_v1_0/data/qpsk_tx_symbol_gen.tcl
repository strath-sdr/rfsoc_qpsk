proc generate {drv_handle} {
    xdefine_include_file $drv_handle "xparameters.h" "qpsk_tx_symbol_gen" "NUM_INSTANCES" "DEVICE_ID" "C_QPSK_TX_SYMBOL_GEN_S_AXI_BASEADDR" "C_QPSK_TX_SYMBOL_GEN_S_AXI_HIGHADDR" 
    xdefine_config_file $drv_handle "qpsk_tx_symbol_gen_g.c" "qpsk_tx_symbol_gen" "DEVICE_ID" "C_QPSK_TX_SYMBOL_GEN_S_AXI_BASEADDR" 
    xdefine_canonical_xpars $drv_handle "xparameters.h" "qpsk_tx_symbol_gen" "DEVICE_ID" "C_QPSK_TX_SYMBOL_GEN_S_AXI_BASEADDR" "C_QPSK_TX_SYMBOL_GEN_S_AXI_HIGHADDR" 

}