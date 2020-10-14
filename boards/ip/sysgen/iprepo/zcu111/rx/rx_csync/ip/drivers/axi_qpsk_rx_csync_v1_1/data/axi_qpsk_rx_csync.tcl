proc generate {drv_handle} {
    xdefine_include_file $drv_handle "xparameters.h" "axi_qpsk_rx_csync" "NUM_INSTANCES" "DEVICE_ID" "C_AXI_QPSK_RX_CSYNC_S_AXI_BASEADDR" "C_AXI_QPSK_RX_CSYNC_S_AXI_HIGHADDR" 
    xdefine_config_file $drv_handle "axi_qpsk_rx_csync_g.c" "axi_qpsk_rx_csync" "DEVICE_ID" "C_AXI_QPSK_RX_CSYNC_S_AXI_BASEADDR" 
    xdefine_canonical_xpars $drv_handle "xparameters.h" "axi_qpsk_rx_csync" "DEVICE_ID" "C_AXI_QPSK_RX_CSYNC_S_AXI_BASEADDR" "C_AXI_QPSK_RX_CSYNC_S_AXI_HIGHADDR" 

}