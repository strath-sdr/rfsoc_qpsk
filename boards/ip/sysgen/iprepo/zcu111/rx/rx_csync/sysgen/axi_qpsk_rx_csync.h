#ifndef AXI_QPSK_RX_CSYNC__H
#define AXI_QPSK_RX_CSYNC__H
#ifdef __cplusplus
extern "C" {
#endif
/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "axi_qpsk_rx_csync_hw.h"
/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 axi_qpsk_rx_csync_BaseAddress;
} axi_qpsk_rx_csync_Config;
#endif
/**
* The axi_qpsk_rx_csync driver instance data. The user is required to
* allocate a variable of this type for every axi_qpsk_rx_csync device in the system.
* A pointer to a variable of this type is then passed to the driver
* API functions.
*/
typedef struct {
    u32 axi_qpsk_rx_csync_BaseAddress;
    u32 IsReady;
} axi_qpsk_rx_csync;
/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define axi_qpsk_rx_csync_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define axi_qpsk_rx_csync_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define axi_qpsk_rx_csync_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define axi_qpsk_rx_csync_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif
/************************** Function Prototypes *****************************/
#ifndef __linux__
int axi_qpsk_rx_csync_Initialize(axi_qpsk_rx_csync *InstancePtr, u16 DeviceId);
axi_qpsk_rx_csync_Config* axi_qpsk_rx_csync_LookupConfig(u16 DeviceId);
int axi_qpsk_rx_csync_CfgInitialize(axi_qpsk_rx_csync *InstancePtr, axi_qpsk_rx_csync_Config *ConfigPtr);
#else
int axi_qpsk_rx_csync_Initialize(axi_qpsk_rx_csync *InstancePtr, const char* InstanceName);
int axi_qpsk_rx_csync_Release(axi_qpsk_rx_csync *InstancePtr);
#endif
/**
* Write to transfer gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the transfer instance to operate on.
* @param	Data is value to be written to gateway transfer.
*
* @return	None.
*
* @note    .
*
*/
void axi_qpsk_rx_csync_transfer_write(axi_qpsk_rx_csync *InstancePtr, u32 Data);
/**
* Read from transfer gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the transfer instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 axi_qpsk_rx_csync_transfer_read(axi_qpsk_rx_csync *InstancePtr);
/**
* Write to auto_restart gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the auto_restart instance to operate on.
* @param	Data is value to be written to gateway auto_restart.
*
* @return	None.
*
* @note    .
*
*/
void axi_qpsk_rx_csync_auto_restart_write(axi_qpsk_rx_csync *InstancePtr, u32 Data);
/**
* Read from auto_restart gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the auto_restart instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 axi_qpsk_rx_csync_auto_restart_read(axi_qpsk_rx_csync *InstancePtr);
/**
* Write to rxreset gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the rxreset instance to operate on.
* @param	Data is value to be written to gateway rxreset.
*
* @return	None.
*
* @note    .
*
*/
void axi_qpsk_rx_csync_rxreset_write(axi_qpsk_rx_csync *InstancePtr, u32 Data);
/**
* Read from rxreset gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the rxreset instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 axi_qpsk_rx_csync_rxreset_read(axi_qpsk_rx_csync *InstancePtr);
/**
* Write to packetsizerf gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the packetsizerf instance to operate on.
* @param	Data is value to be written to gateway packetsizerf.
*
* @return	None.
*
* @note    .
*
*/
void axi_qpsk_rx_csync_packetsizerf_write(axi_qpsk_rx_csync *InstancePtr, u32 Data);
/**
* Read from packetsizerf gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the packetsizerf instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 axi_qpsk_rx_csync_packetsizerf_read(axi_qpsk_rx_csync *InstancePtr);
/**
* Write to enable gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the enable instance to operate on.
* @param	Data is value to be written to gateway enable.
*
* @return	None.
*
* @note    .
*
*/
void axi_qpsk_rx_csync_enable_write(axi_qpsk_rx_csync *InstancePtr, u32 Data);
/**
* Read from enable gateway of axi_qpsk_rx_csync. Assignments are LSB-justified.
*
* @param	InstancePtr is the enable instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 axi_qpsk_rx_csync_enable_read(axi_qpsk_rx_csync *InstancePtr);
#ifdef __cplusplus
}
#endif
#endif
