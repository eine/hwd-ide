
/**************************************************************************
 *
 * This file was generated by dclib/netpp. Modifications to this file will
 * be lost.
 * Stylesheet: proplist.xsl     (c) 2005-2011 section5
 *
 * Version: 0.0
 *
 **************************************************************************/

#include "property_types.h"

#include "example.h"

#define DECLARE_PROTO_GETTER(func)  int func(DEVICE d, DCValue *out);
#define DECLARE_PROTO_SETTER(func)  int func(DEVICE d, DCValue *in);

////////////////////////////////////////////////////////////////////////////
// LIBRARY VERSION CONTROL

char g_vendor[]   = "section5";

int g_version[2] = { 0, 1 };

char g_build[]   = "develop";

////////////////////////////////////////////////////////////////////////////
// DIRECT PROPERTY ACCESS



////////////////////////////////////////////////////////////////////////////
// PROTOTYPES


DECLARE_PROTO_GETTER(get_fifo)

DECLARE_PROTO_SETTER(set_fifo)
					
////////////////////////////////////////////////////////////////////////////
// DEVICE DECLARATIONS


enum {
	g_index_ghdlsim,
	
	N_DEVICES
};


////////////////////////////////////////////////////////////////////////////
// DEVICE: GHDLSimInterface, ID: ghdlsim
////////////////////////////////////////////////////////////////////////////


// PROPERTY KEYS
enum {
	ghdlsim, // Device Root node
	// Properties, Structs, Arrays:
	id335227,
	id335291,
	id335245,
	id335274,
	id335261,
	
	// Items:
	
	// Limits
	
	// Sizes
	
	// Events
	
	MAXPROP_ghdlsim // = Number of Properties
};

////////////////////////////////////////////////////////////////////////////
// Struct lists:


////////////////////////////////////////////////////////////////////////////
// Array lists:


////////////////////////////////////////////////////////////////////////////
// Children lists:


////////////////////////////////////////////////////////////////////////////
// Register defines


/*********************************************************
 * Address segment 'FPGA_Registermap'
 *********************************************************/
		
#define FPGA_Registermap_Offset 0
#define Reg_MagicId                                  (FPGA_Registermap_Offset + 0x00)
#define Reg_Control                                  (FPGA_Registermap_Offset + 0x02)

////////////////////////////////////////////////////////////////////////////
// Feature tables

// ROOT LIST (Top level nodes)

static
PROPINDEX
g_root_ghdlsim[] = {
	id335227,
	id335291,
	id335245,
	id335274,
	id335261,
	INVALID_INDEX
};

static
PropertyDesc
g_props_ghdlsim[] = {

/* ROOT NODE (always on top of the list!) */

	{ "GHDLSimInterface", DC_ROOT,
		F_RO ,
		DC_STATIC, { .base = 0 } , g_root_ghdlsim },

/* Properties */
	
	{ "Enable" /* id335227 */,  DC_BOOL, 
		F_RW | F_BIG,
		DC_ADDR, { .reg = { Reg_Control, 0, 0, 1 } },
			0 /* no children */ },
	
	{ "Fifo" /* id335291 */,  DC_BUFFER, 
		F_RW,
		DC_HANDLER, { .func = { get_fifo, set_fifo } },
			0 },
	
	{ "Reset" /* id335245 */,  DC_BOOL, 
		F_RW | F_BIG,
		DC_ADDR, { .reg = { Reg_Control, 7, 7, 1 } },
			0 /* no children */ },
	
	{ "Throttle" /* id335274 */,  DC_BOOL, 
		F_RW | F_BIG,
		DC_ADDR, { .reg = { Reg_Control, 1, 1, 1 } },
			0 /* no children */ },
	
	{ "Timeout" /* id335261 */,  DC_INT, 
		F_RW,
		DC_VAR, { .varp_int = &g_timeout },
			0 /* no children */ },
	
/* Items */
	
/* Limits */
	
/* Size variables */
	
/* Event descriptors */
	
	{ 0 }
};



// Global token pointers


////////////////////////////////////////////////////////////////////////////
// SUPPORTED DEVICES


DeviceDesc g_devices[] = {
	{ g_props_ghdlsim, 0, 0,  MAXPROP_ghdlsim },
	
};

int g_ndevices = N_DEVICES;

////////////////////////////////////////////////////////////////////////////


