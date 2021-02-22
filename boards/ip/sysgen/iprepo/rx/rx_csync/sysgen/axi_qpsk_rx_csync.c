#include "axi_qpsk_rx_csync.h"
#ifndef __linux__
int axi_qpsk_rx_csync_CfgInitialize(axi_qpsk_rx_csync *InstancePtr, axi_qpsk_rx_csync_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->axi_qpsk_rx_csync_BaseAddress = ConfigPtr->axi_qpsk_rx_csync_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void axi_qpsk_rx_csync_transfer_write(axi_qpsk_rx_csync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_csync_WriteReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 16, Data);
}
u32 axi_qpsk_rx_csync_transfer_read(axi_qpsk_rx_csync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_csync_ReadReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 16);
    return Data;
}
void axi_qpsk_rx_csync_auto_restart_write(axi_qpsk_rx_csync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_csync_WriteReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 12, Data);
}
u32 axi_qpsk_rx_csync_auto_restart_read(axi_qpsk_rx_csync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_csync_ReadReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 12);
    return Data;
}
void axi_qpsk_rx_csync_rxreset_write(axi_qpsk_rx_csync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_csync_WriteReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 0, Data);
}
u32 axi_qpsk_rx_csync_rxreset_read(axi_qpsk_rx_csync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_csync_ReadReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 0);
    return Data;
}
void axi_qpsk_rx_csync_packetsizerf_write(axi_qpsk_rx_csync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_csync_WriteReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 4, Data);
}
u32 axi_qpsk_rx_csync_packetsizerf_read(axi_qpsk_rx_csync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_csync_ReadReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 4);
    return Data;
}
void axi_qpsk_rx_csync_enable_write(axi_qpsk_rx_csync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_csync_WriteReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 8, Data);
}
u32 axi_qpsk_rx_csync_enable_read(axi_qpsk_rx_csync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_csync_ReadReg(InstancePtr->axi_qpsk_rx_csync_BaseAddress, 8);
    return Data;
}
