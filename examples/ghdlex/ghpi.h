/** \file ghpi.h
 * GHDL vhpi C interface specifics
 *
 * (c) 2011, Martin Strubel <hackfin@section5.ch>
 *
 * Important: Note that a std_logic_vector array is passed in the
 * char * pointers, regardless of the bit order
 * (LSB to MSB) or (MSB downto LSB).
 *
 * Thus, for a MSB downto LSB array, you have to reverse the indexing!
 *
 */

#include <stdint.h>

/** char value definitions of std_logic_vector array:
 */

#define UNDEFINED 0 ///< Undefined; VHDL: 'U'
#define INVALID_X 1 ///< Invalid;   VHDL: 'X'
#define LOW       2 ///< Low;       VHDL: '0'
#define HIGH      3 ///< High;      VHDL: '1'
#define TRISTATE  4 ///< High Z;    VHDL: 'Z'

// Used for string passing. Stolen from Yanns helpful example.

/** Structure to describe array boundarys. Used by a fat_pointer */
struct int_bounds
{
	int left;
	int right;
	char dir;
	unsigned int len;
};

/** GHDL fat pointer. Fat pointers are enhanced descriptors for
 * unconstrained VHDL arrays. In this extension library, they are exclusively
 * used for strings and unconstrained SLVs.
 */
struct fat_pointer
{
	void              *base;
	struct int_bounds *bounds;
};

#define ghdl_string fat_pointer

// Generate function prototypes:
#define RUN_CHEAD
#include "apidef.h"
#undef RUN_CHEAD

////////////////////////////////////////////////////////////////////////////
// Functions

/** \defgroup Auxiliary    Auxiliary functions for conversion, etc.
 *
 * These are internal functions to convert between GDHL data and C data
 * structures.
 *
 */

/** \addtogroup Auxiliary
 * \{ */

/** Convert std_logic_vector to unsigned short */
int logic_to_uint(const char *l, int nbits, uint32_t *val);
/** Convert std_logic_vector to unsigned short */
void uint_to_logic(char *l, int nbits, uint32_t val);
/** Convert logic to byte sequence. Matches the bit order of the
 * std_logic_vector
 */
void logic_to_bytes(char *l, int n, unsigned char *b);
/** Convert byte sequence to logic. */
void bytes_to_logic(char *l, int n, const unsigned char *b);
/** Set all std_logic members of a std_logic_vector to 'val' */
void fill_slv(char *l, int nbits, unsigned char val);

/** \} */

/** Debugging */

void dump_bits(unsigned char c);
void hexdump(char *buf, unsigned long n);

/*!
 * \mainpage GHDLex documentation
 * \version 0.03develop
 * \author Martin Strubel
 * \date 10/2011
 *
 * \section Intro     Introduction
 *
 * This code collection is an attempt to gather a few useful routines
 * into a pool of reusable functionality. It is FAR from being a real
 * library, but technically, we treat it as one.
 *
 * The main purpose is to enable GHDL to communicate easily with external
 * applications in both directions, for example, to read in real data samples
 * or output processing results to a existing and proven software driver.
 * 
 * This 'library' makes heavy use again of the netpp library. The reason is
 * that netpp already provides an efficient framework for test benching via
 * scripts as well as many I/O features spread across the network.
 * So you can easily realize a distributed processing and simulation solution
 * without having to move hardware around or even restructure your entire
 * lab. So for example, you could grab the current measurement samples from
 * the LHC lab, the SETI project and the CERN and run it through your VHDL RTL
 * description :-)
 *
 * Also, it offers a certain level of abstraction which makes it easy
 * to swap software components or VHDL entities.
 *
 * \section GHDLIntf   GHDL interfacing
 *
 * As mentioned, there is no official 'API' for GHDL. There are implementations
 * that seem to conform to the public VHPI specifications, this library
 * is not yet making use of the VHPI interface. Instead, it is using
 * potentially dangerous methods to access the GHDL internal structures
 * directly.
 *
 * So, even if there is no official "clean" way to do it, we should at least
 * keep the potential changes in one place and automate wrapping and data
 * type exchange as far as possible. Therefore you are encouraged to use
 * meta types so that you will not have to change your test bench simulation
 * code all over if the API changes.
 *
 * For a short comparison between C and VHDL/Ada (the latter being the
 * actual heart of GHDL), we can definitely reassert that there are many
 * more data type variants in VHDL than in C. This can make the interfacing
 * complex. So far, we have only covered a few data types:
 *
 * - unsigned/std_logic_vector (constrained and unconstrained)
 * - string (unconstrained)
 * - integer
 * - Some specific handles for interfacing with external units
 *
 * All currently covered types are found in the typedef section of the
 * \ref GHPIfuncs module.
 *
 * The following modules provide the API for the GHPI extension:
 * - \subpage GHPIfuncs    
 * - \subpage GHDL_Fifo
 * - \subpage GHDL_Pipe  
 *
 * From the C API side:
 * - \subpage Auxiliary
 * - \subpage FIFO
 *
 * \section Extending Autowrapping
 *
 * Because a lot of manual coding needs to be done in order to wrap
 * a C routine by a VHDL call, some highly experimental tricks to abuse
 * the C preprocessor are used. Basically, a .chdl file will be turned into
 * a .vhdl file. See Makefile for specific rules.
 * This allows to resolve #define and #include statements and makes
 * the API definition somewhat easier, since all can be generated from one
 * header file.
 *
 * The important files:
 * - apidef.h: The API definition
 * - h2vhdl.c: The vhdl package generator
 *
 * Files for hackers - please only extend, don't change:
 *
 * - apimacros.h: The dirty stuff under the hood
 *
 * \section Functionality
 *
 * \subsection FuncSlave      Generic data I/O with external applications
 *
 * In this case, a GHDL simulation acts as slave (or server).
 * For data I/O with external programs, there are two examples:
 *
 * - simpipe.vhdl : Simple file based I/O using named Unix pipes
 * - simfifo.vhdl : A thread based software FIFO implementation, that
 *                  can be compiled to accept data over the network from
 *                  a netpp client (virtual driver)
 *
 * \subsection FuncMaster     Data output to various devices
 *
 * In the following examples, GHDL is used as a master (or client),
 * talking to external devices.
 *
 * - simnetpp.vhdl: A simple example for setting a register value on a
 *                  remote device.
 * - simfb.vhdl:    Demonstrates a YUV format display output to a remote
 *                  framebuffer (the netpp display server)
 *
 * These examples can easily be modified to write directly to local devices
 * instead of going through remote handlers.
 *
 */
