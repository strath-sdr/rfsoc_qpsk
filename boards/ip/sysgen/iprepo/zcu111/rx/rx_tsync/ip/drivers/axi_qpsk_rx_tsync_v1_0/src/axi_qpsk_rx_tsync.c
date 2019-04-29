#include "axi_qpsk_rx_tsync.h"
#ifndef __linux__
int axi_qpsk_rx_tsync_CfgInitialize(axi_qpsk_rx_tsync *InstancePtr, axi_qpsk_rx_tsync_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->axi_qpsk_rx_tsync_BaseAddress = ConfigPtr->axi_qpsk_rx_tsync_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void axi_qpsk_rx_tsync_transfer_write(axi_qpsk_rx_tsync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_tsync_WriteReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 16, Data);
}
u32 axi_qpsk_rx_tsync_transfer_read(axi_qpsk_rx_tsync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_tsync_ReadReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 16);
    return Data;
}
void axi_qpsk_rx_tsync_syncreset_write(axi_qpsk_rx_tsync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_tsync_WriteReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 20, Data);
}
u32 axi_qpsk_rx_tsync_syncreset_read(axi_qpsk_rx_tsync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_tsync_ReadReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 20);
    return Data;
}
void axi_qpsk_rx_tsync_auto_restart_write(axi_qpsk_rx_tsync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_tsync_WriteReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 12, Data);
}
u32 axi_qpsk_rx_tsync_auto_restart_read(axi_qpsk_rx_tsync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_tsync_ReadReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 12);
    return Data;
}
void axi_qpsk_rx_tsync_rxreset_write(axi_qpsk_rx_tsync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_tsync_WriteReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 0, Data);
}
u32 axi_qpsk_rx_tsync_rxreset_read(axi_qpsk_rx_tsync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_tsync_ReadReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 0);
    return Data;
}
void axi_qpsk_rx_tsync_packetsizerf_write(axi_qpsk_rx_tsync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_tsync_WriteReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 4, Data);
}
u32 axi_qpsk_rx_tsync_packetsizerf_read(axi_qpsk_rx_tsync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_tsync_ReadReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 4);
    return Data;
}
void axi_qpsk_rx_tsync_enable_write(axi_qpsk_rx_tsync *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_tsync_WriteReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 8, Data);
}
u32 axi_qpsk_rx_tsync_enable_read(axi_qpsk_rx_tsync *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_tsync_ReadReg(InstancePtr->axi_qpsk_rx_tsync_BaseAddress, 8);
    return Data;
}
