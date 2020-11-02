#include "axi_qpsk_tx.h"
#ifndef __linux__
int axi_qpsk_tx_CfgInitialize(axi_qpsk_tx *InstancePtr, axi_qpsk_tx_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->axi_qpsk_tx_BaseAddress = ConfigPtr->axi_qpsk_tx_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void axi_qpsk_tx_transfertime_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 60, Data);
}
u32 axi_qpsk_tx_transfertime_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 60);
    return Data;
}
void axi_qpsk_tx_transfersymbol_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 0, Data);
}
u32 axi_qpsk_tx_transfersymbol_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 0);
    return Data;
}
void axi_qpsk_tx_transferfft_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 4, Data);
}
u32 axi_qpsk_tx_transferfft_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 4);
    return Data;
}
void axi_qpsk_tx_simulateinterface_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 64, Data);
}
u32 axi_qpsk_tx_simulateinterface_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 64);
    return Data;
}
void axi_qpsk_tx_resettime_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 48, Data);
}
u32 axi_qpsk_tx_resettime_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 48);
    return Data;
}
void axi_qpsk_tx_resetsymbol_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 8, Data);
}
u32 axi_qpsk_tx_resetsymbol_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 8);
    return Data;
}
void axi_qpsk_tx_resetfft_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 12, Data);
}
u32 axi_qpsk_tx_resetfft_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 12);
    return Data;
}
void axi_qpsk_tx_packetsizetime_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 52, Data);
}
u32 axi_qpsk_tx_packetsizetime_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 52);
    return Data;
}
void axi_qpsk_tx_packetsizesymbol_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 16, Data);
}
u32 axi_qpsk_tx_packetsizesymbol_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 16);
    return Data;
}
void axi_qpsk_tx_packetsizerf_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 20, Data);
}
u32 axi_qpsk_tx_packetsizerf_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 20);
    return Data;
}
void axi_qpsk_tx_packetsizefft_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 24, Data);
}
u32 axi_qpsk_tx_packetsizefft_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 24);
    return Data;
}
void axi_qpsk_tx_outputgain_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 44, Data);
}
u32 axi_qpsk_tx_outputgain_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 44);
    return Data;
}
void axi_qpsk_tx_lfsr_rst_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 28, Data);
}
u32 axi_qpsk_tx_lfsr_rst_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 28);
    return Data;
}
void axi_qpsk_tx_enable_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 32, Data);
}
u32 axi_qpsk_tx_enable_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 32);
    return Data;
}
void axi_qpsk_tx_bypassgain_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 68, Data);
}
u32 axi_qpsk_tx_bypassgain_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 68);
    return Data;
}
void axi_qpsk_tx_autorestarttime_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 56, Data);
}
u32 axi_qpsk_tx_autorestarttime_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 56);
    return Data;
}
void axi_qpsk_tx_autorestartsymbol_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 36, Data);
}
u32 axi_qpsk_tx_autorestartsymbol_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 36);
    return Data;
}
void axi_qpsk_tx_autorestartfft_write(axi_qpsk_tx *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    axi_qpsk_tx_WriteReg(InstancePtr->axi_qpsk_tx_BaseAddress, 40, Data);
}
u32 axi_qpsk_tx_autorestartfft_read(axi_qpsk_tx *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = axi_qpsk_tx_ReadReg(InstancePtr->axi_qpsk_tx_BaseAddress, 40);
    return Data;
}
