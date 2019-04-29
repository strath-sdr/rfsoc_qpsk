#include "axi_qpsk_rx_dec.h"
#ifndef __linux__
int axi_qpsk_rx_dec_CfgInitialize(axi_qpsk_rx_dec *InstancePtr, axi_qpsk_rx_dec_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->axi_qpsk_rx_dec_BaseAddress = ConfigPtr->axi_qpsk_rx_dec_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void axi_qpsk_rx_dec_transfer_write(axi_qpsk_rx_dec *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_dec_WriteReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 16, Data);
}
u32 axi_qpsk_rx_dec_transfer_read(axi_qpsk_rx_dec *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_dec_ReadReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 16);
    return Data;
}
void axi_qpsk_rx_dec_auto_restart_write(axi_qpsk_rx_dec *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_dec_WriteReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 12, Data);
}
u32 axi_qpsk_rx_dec_auto_restart_read(axi_qpsk_rx_dec *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_dec_ReadReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 12);
    return Data;
}
void axi_qpsk_rx_dec_rxreset_write(axi_qpsk_rx_dec *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_dec_WriteReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 0, Data);
}
u32 axi_qpsk_rx_dec_rxreset_read(axi_qpsk_rx_dec *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_dec_ReadReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 0);
    return Data;
}
void axi_qpsk_rx_dec_packetsizerf_write(axi_qpsk_rx_dec *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_dec_WriteReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 4, Data);
}
u32 axi_qpsk_rx_dec_packetsizerf_read(axi_qpsk_rx_dec *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_dec_ReadReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 4);
    return Data;
}
void axi_qpsk_rx_dec_enable_write(axi_qpsk_rx_dec *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_dec_WriteReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 8, Data);
}
u32 axi_qpsk_rx_dec_enable_read(axi_qpsk_rx_dec *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_dec_ReadReg(InstancePtr->axi_qpsk_rx_dec_BaseAddress, 8);
    return Data;
}
