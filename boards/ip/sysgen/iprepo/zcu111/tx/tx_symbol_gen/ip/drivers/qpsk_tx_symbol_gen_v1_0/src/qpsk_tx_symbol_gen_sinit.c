/**
* @file qpsk_tx_symbol_gen_sinit.c
*
* The implementation of the qpsk_tx_symbol_gen driver's static initialzation
* functionality.
*
* @note
*
* None
*
*/
#ifndef __linux__
#include "xstatus.h"
#include "xparameters.h"
#include "qpsk_tx_symbol_gen.h"
extern qpsk_tx_symbol_gen_Config qpsk_tx_symbol_gen_ConfigTable[];
/**
* Lookup the device configuration based on the unique device ID.  The table
* ConfigTable contains the configuration info for each device in the system.
*
* @param DeviceId is the device identifier to lookup.
*
* @return
*     - A pointer of data type qpsk_tx_symbol_gen_Config which
*    points to the device configuration if DeviceID is found.
*    - NULL if DeviceID is not found.
*
* @note    None.
*
*/
qpsk_tx_symbol_gen_Config *qpsk_tx_symbol_gen_LookupConfig(u16 DeviceId) {
    qpsk_tx_symbol_gen_Config *ConfigPtr = NULL;
    int Index;
    for (Index = 0; Index < XPAR_QPSK_TX_SYMBOL_GEN_NUM_INSTANCES; Index++) {
        if (qpsk_tx_symbol_gen_ConfigTable[Index].DeviceId == DeviceId) {
            ConfigPtr = &qpsk_tx_symbol_gen_ConfigTable[Index];
            break;
        }
    }
    return ConfigPtr;
}
int qpsk_tx_symbol_gen_Initialize(qpsk_tx_symbol_gen *InstancePtr, u16 DeviceId) {
    qpsk_tx_symbol_gen_Config *ConfigPtr;
    Xil_AssertNonvoid(InstancePtr != NULL);
    ConfigPtr = qpsk_tx_symbol_gen_LookupConfig(DeviceId);
    if (ConfigPtr == NULL) {
        InstancePtr->IsReady = 0;
        return (XST_DEVICE_NOT_FOUND);
    }
    return qpsk_tx_symbol_gen_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif
