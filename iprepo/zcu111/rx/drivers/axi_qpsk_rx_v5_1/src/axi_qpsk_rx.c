#include "axi_qpsk_rx.h"
#ifndef __linux__
int axi_qpsk_rx_CfgInitialize(axi_qpsk_rx *InstancePtr, axi_qpsk_rx_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->axi_qpsk_rx_BaseAddress = ConfigPtr->axi_qpsk_rx_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void axi_qpsk_rx_transfer_sync_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 76, Data);
}
u32 axi_qpsk_rx_transfer_sync_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 76);
    return Data;
}
void axi_qpsk_rx_transfer_rrc_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 64, Data);
}
u32 axi_qpsk_rx_transfer_rrc_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 64);
    return Data;
}
void axi_qpsk_rx_transfer_dec_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 52, Data);
}
u32 axi_qpsk_rx_transfer_dec_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 52);
    return Data;
}
void axi_qpsk_rx_transfer_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 40, Data);
}
u32 axi_qpsk_rx_transfer_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 40);
    return Data;
}
void axi_qpsk_rx_auto_restart_sync_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 72, Data);
}
u32 axi_qpsk_rx_auto_restart_sync_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 72);
    return Data;
}
void axi_qpsk_rx_auto_restart_rrc_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 60, Data);
}
u32 axi_qpsk_rx_auto_restart_rrc_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 60);
    return Data;
}
void axi_qpsk_rx_auto_restart_dec_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 48, Data);
}
u32 axi_qpsk_rx_auto_restart_dec_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 48);
    return Data;
}
void axi_qpsk_rx_auto_restart_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 36, Data);
}
u32 axi_qpsk_rx_auto_restart_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 36);
    return Data;
}
void axi_qpsk_rx_rxreset_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 28, Data);
}
u32 axi_qpsk_rx_rxreset_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 28);
    return Data;
}
void axi_qpsk_rx_packetsize_sync_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 68, Data);
}
u32 axi_qpsk_rx_packetsize_sync_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 68);
    return Data;
}
void axi_qpsk_rx_packetsize_rrc_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 56, Data);
}
u32 axi_qpsk_rx_packetsize_rrc_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 56);
    return Data;
}
void axi_qpsk_rx_packetsize_dec_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 44, Data);
}
u32 axi_qpsk_rx_packetsize_dec_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 44);
    return Data;
}
void axi_qpsk_rx_packetsizerf_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 20, Data);
}
u32 axi_qpsk_rx_packetsizerf_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 20);
    return Data;
}
void axi_qpsk_rx_enable_write(axi_qpsk_rx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_rx_WriteReg(InstancePtr->axi_qpsk_rx_BaseAddress, 32, Data);
}
u32 axi_qpsk_rx_enable_read(axi_qpsk_rx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_rx_ReadReg(InstancePtr->axi_qpsk_rx_BaseAddress, 32);
    return Data;
}
