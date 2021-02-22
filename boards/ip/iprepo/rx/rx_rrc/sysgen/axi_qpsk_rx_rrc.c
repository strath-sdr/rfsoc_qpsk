#include "axi_qpsk_rx_rrc.h"
#ifndef __linux__
int axi_qpsk_rx_rrc_CfgInitialize(axi_qpsk_rx_rrc *InstancePtr, axi_qpsk_rx_rrc_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->axi_qpsk_rx_rrc_BaseAddress = ConfigPtr->axi_qpsk_rx_rrc_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void axi_qpsk_rx_rrc_transfer_write(axi_qpsk_rx_rrc *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_rrc_WriteReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 16, Data);
}
u32 axi_qpsk_rx_rrc_transfer_read(axi_qpsk_rx_rrc *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_rrc_ReadReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 16);
    return Data;
}
void axi_qpsk_rx_rrc_auto_restart_write(axi_qpsk_rx_rrc *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_rrc_WriteReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 12, Data);
}
u32 axi_qpsk_rx_rrc_auto_restart_read(axi_qpsk_rx_rrc *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_rrc_ReadReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 12);
    return Data;
}
void axi_qpsk_rx_rrc_rxreset_write(axi_qpsk_rx_rrc *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_rrc_WriteReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 0, Data);
}
u32 axi_qpsk_rx_rrc_rxreset_read(axi_qpsk_rx_rrc *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_rrc_ReadReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 0);
    return Data;
}
void axi_qpsk_rx_rrc_packetsizerf_write(axi_qpsk_rx_rrc *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_rrc_WriteReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 4, Data);
}
u32 axi_qpsk_rx_rrc_packetsizerf_read(axi_qpsk_rx_rrc *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_rrc_ReadReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 4);
    return Data;
}
void axi_qpsk_rx_rrc_enable_write(axi_qpsk_rx_rrc *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_rrc_WriteReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 8, Data);
}
u32 axi_qpsk_rx_rrc_enable_read(axi_qpsk_rx_rrc *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_rrc_ReadReg(InstancePtr->axi_qpsk_rx_rrc_BaseAddress, 8);
    return Data;
}
