/**
* @file axi_qpsk_tx_sinit.c
*
* The implementation of the axi_qpsk_tx driver's static initialzation
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
#include "axi_qpsk_tx.h"
extern axi_qpsk_tx_Config axi_qpsk_tx_ConfigTable[];
/**
* Lookup the device configuration based on the unique device ID.  The table
* ConfigTable contains the configuration info for each device in the system.
*
* @param DeviceId is the device identifier to lookup.
*
* @return
*     - A pointer of data type axi_qpsk_tx_Config which
*    points to the device configuration if DeviceID is found.
*    - NULL if DeviceID is not found.
*
* @note    None.
*
*/
axi_qpsk_tx_Config *axi_qpsk_tx_LookupConfig(u16 DeviceId) {
    axi_qpsk_tx_Config *ConfigPtr = NULL;
    int Index;
    for (Index = 0; Index < XPAR_AXI_QPSK_TX_NUM_INSTANCES; Index++) {
        if (axi_qpsk_tx_ConfigTable[Index].DeviceId == DeviceId) {
            ConfigPtr = &axi_qpsk_tx_ConfigTable[Index];
            break;
        }
    }
    return ConfigPtr;
}
int axi_qpsk_tx_Initialize(axi_qpsk_tx *InstancePtr, u16 DeviceId) {
    axi_qpsk_tx_Config *ConfigPtr;
    Xil_AssertNonvoid(InstancePtr != NULL);
    ConfigPtr = axi_qpsk_tx_LookupConfig(DeviceId);
    if (ConfigPtr == NULL) {
        InstancePtr->IsReady = 0;
        return (XST_DEVICE_NOT_FOUND);
    }
    return axi_qpsk_tx_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif
