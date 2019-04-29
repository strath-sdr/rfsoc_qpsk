#ifndef QPSK_TX_SYMBOL_GEN__H
#define QPSK_TX_SYMBOL_GEN__H
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
#include "qpsk_tx_symbol_gen_hw.h"
/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 qpsk_tx_symbol_gen_BaseAddress;
} qpsk_tx_symbol_gen_Config;
#endif
/**
* The qpsk_tx_symbol_gen driver instance data. The user is required to
* allocate a variable of this type for every qpsk_tx_symbol_gen device in the system.
* A pointer to a variable of this type is then passed to the driver
* API functions.
*/
typedef struct {
    u32 qpsk_tx_symbol_gen_BaseAddress;
    u32 IsReady;
} qpsk_tx_symbol_gen;
/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define qpsk_tx_symbol_gen_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define qpsk_tx_symbol_gen_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define qpsk_tx_symbol_gen_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define qpsk_tx_symbol_gen_ReadReg(BaseAddress, RegOffset) \
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
int qpsk_tx_symbol_gen_Initialize(qpsk_tx_symbol_gen *InstancePtr, u16 DeviceId);
qpsk_tx_symbol_gen_Config* qpsk_tx_symbol_gen_LookupConfig(u16 DeviceId);
int qpsk_tx_symbol_gen_CfgInitialize(qpsk_tx_symbol_gen *InstancePtr, qpsk_tx_symbol_gen_Config *ConfigPtr);
#else
int qpsk_tx_symbol_gen_Initialize(qpsk_tx_symbol_gen *InstancePtr, const char* InstanceName);
int qpsk_tx_symbol_gen_Release(qpsk_tx_symbol_gen *InstancePtr);
#endif
/**
* Write to transfersymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the transfersymbol instance to operate on.
* @param	Data is value to be written to gateway transfersymbol.
*
* @return	None.
*
* @note    .
*
*/
void qpsk_tx_symbol_gen_transfersymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data);
/**
* Read from transfersymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the transfersymbol instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 qpsk_tx_symbol_gen_transfersymbol_read(qpsk_tx_symbol_gen *InstancePtr);
/**
* Write to resetsymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the resetsymbol instance to operate on.
* @param	Data is value to be written to gateway resetsymbol.
*
* @return	None.
*
* @note    .
*
*/
void qpsk_tx_symbol_gen_resetsymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data);
/**
* Read from resetsymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the resetsymbol instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 qpsk_tx_symbol_gen_resetsymbol_read(qpsk_tx_symbol_gen *InstancePtr);
/**
* Write to packetsizesymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the packetsizesymbol instance to operate on.
* @param	Data is value to be written to gateway packetsizesymbol.
*
* @return	None.
*
* @note    .
*
*/
void qpsk_tx_symbol_gen_packetsizesymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data);
/**
* Read from packetsizesymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the packetsizesymbol instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 qpsk_tx_symbol_gen_packetsizesymbol_read(qpsk_tx_symbol_gen *InstancePtr);
/**
* Write to lfsr_rst gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the lfsr_rst instance to operate on.
* @param	Data is value to be written to gateway lfsr_rst.
*
* @return	None.
*
* @note    .
*
*/
void qpsk_tx_symbol_gen_lfsr_rst_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data);
/**
* Read from lfsr_rst gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the lfsr_rst instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 qpsk_tx_symbol_gen_lfsr_rst_read(qpsk_tx_symbol_gen *InstancePtr);
/**
* Write to enable gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the enable instance to operate on.
* @param	Data is value to be written to gateway enable.
*
* @return	None.
*
* @note    .
*
*/
void qpsk_tx_symbol_gen_enable_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data);
/**
* Read from enable gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the enable instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 qpsk_tx_symbol_gen_enable_read(qpsk_tx_symbol_gen *InstancePtr);
/**
* Write to autorestartsymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the autorestartsymbol instance to operate on.
* @param	Data is value to be written to gateway autorestartsymbol.
*
* @return	None.
*
* @note    .
*
*/
void qpsk_tx_symbol_gen_autorestartsymbol_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data);
/**
* Read from autorestartsymbol gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the autorestartsymbol instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 qpsk_tx_symbol_gen_autorestartsymbol_read(qpsk_tx_symbol_gen *InstancePtr);
/**
* Write to packetsizerf gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the packetsizerf instance to operate on.
* @param	Data is value to be written to gateway packetsizerf.
*
* @return	None.
*
* @note    .
*
*/
void qpsk_tx_symbol_gen_packetsizerf_write(qpsk_tx_symbol_gen *InstancePtr, u32 Data);
/**
* Read from packetsizerf gateway of qpsk_tx_symbol_gen. Assignments are LSB-justified.
*
* @param	InstancePtr is the packetsizerf instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 qpsk_tx_symbol_gen_packetsizerf_read(qpsk_tx_symbol_gen *InstancePtr);
#ifdef __cplusplus
}
#endif
#endif
