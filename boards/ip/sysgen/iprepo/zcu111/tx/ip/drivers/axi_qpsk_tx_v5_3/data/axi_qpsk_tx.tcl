proc generate {drv_handle} {
    xdefine_include_file $drv_handle "xparameters.h" "axi_qpsk_tx" "NUM_INSTANCES" "DEVICE_ID" "C_AXI_QPSK_TX_S_AXI_BASEADDR" "C_AXI_QPSK_TX_S_AXI_HIGHADDR" 
    xdefine_config_file $drv_handle "axi_qpsk_tx_g.c" "axi_qpsk_tx" "DEVICE_ID" "C_AXI_QPSK_TX_S_AXI_BASEADDR" 
    xdefine_canonical_xpars $drv_handle "xparameters.h" "axi_qpsk_tx" "DEVICE_ID" "C_AXI_QPSK_TX_S_AXI_BASEADDR" "C_AXI_QPSK_TX_S_AXI_HIGHADDR" 

}