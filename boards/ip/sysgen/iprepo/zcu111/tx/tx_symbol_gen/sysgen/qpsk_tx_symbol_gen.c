#include "qpsk_tx_symbol_gen.h"
#ifndef __linux__
int qpsk_tx_symbol_gen_CfgInitialize(qpsk_tx_symbol_gen *InstancePtr, qpsk_tx_symbol_gen_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->qpsk_tx_symbol_gen_BaseAddress = ConfigPtr->qpsk_tx_symbol_gen_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void qpsk_tx_symbol_gen_transfersymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    qpsk_tx_symbol_gen_WriteReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 0, Data);
}
u32 qpsk_tx_symbol_gen_transfersymbol_read(qpsk_tx_symbol_gen *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = qpsk_tx_symbol_gen_ReadReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 0);
    return Data;
}
void qpsk_tx_symbol_gen_resetsymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    qpsk_tx_symbol_gen_WriteReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 8, Data);
}
u32 qpsk_tx_symbol_gen_resetsymbol_read(qpsk_tx_symbol_gen *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = qpsk_tx_symbol_gen_ReadReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 8);
    return Data;
}
void qpsk_tx_symbol_gen_packetsizesymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    qpsk_tx_symbol_gen_WriteReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 16, Data);
}
u32 qpsk_tx_symbol_gen_packetsizesymbol_read(qpsk_tx_symbol_gen *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = qpsk_tx_symbol_gen_ReadReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 16);
    return Data;
}
void qpsk_tx_symbol_gen_lfsr_rst_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    qpsk_tx_symbol_gen_WriteReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 28, Data);
}
u32 qpsk_tx_symbol_gen_lfsr_rst_read(qpsk_tx_symbol_gen *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = qpsk_tx_symbol_gen_ReadReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 28);
    return Data;
}
void qpsk_tx_symbol_gen_enable_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    qpsk_tx_symbol_gen_WriteReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 32, Data);
}
u32 qpsk_tx_symbol_gen_enable_read(qpsk_tx_symbol_gen *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = qpsk_tx_symbol_gen_ReadReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 32);
    return Data;
}
void qpsk_tx_symbol_gen_autorestartsymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    qpsk_tx_symbol_gen_WriteReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 36, Data);
}
u32 qpsk_tx_symbol_gen_autorestartsymbol_read(qpsk_tx_symbol_gen *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = qpsk_tx_symbol_gen_ReadReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 36);
    return Data;
}
void qpsk_tx_symbol_gen_packetsizerf_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    qpsk_tx_symbol_gen_WriteReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 20, Data);
}
u32 qpsk_tx_symbol_gen_packetsizerf_read(qpsk_tx_symbol_gen *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = qpsk_tx_symbol_gen_ReadReg(InstancePtr->qpsk_tx_symbol_gen_BaseAddress, 20);
    return Data;
}
