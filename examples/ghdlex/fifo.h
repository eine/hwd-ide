/** \file fifo.h
 *
 * Software FIFO internal functions
 *
 * (c) 2009-2011 Martin Strubel <hackfin@section5.ch>
 *
 * Modified for ghdl extension.
 * See LICENSE.txt in this distribution for usage terms.
 *
 */

/** \defgroup FIFO     Internal software FIFO
 *
 * This module implements a software FIFO in first fall through mode
 * usable by several concurrent threads.
 *
 * Its behaviour is close to the typical FIFO chips like
 * Cypress FX2, FT2232 variants, etc.
 *
 */

/** \addtogroup FIFO
 * \{
 */

#define RXE      0  ///< RX empty, low active
#define TXF      1  ///< TX full, low active
#define RXAE     2  ///< RX data in buffer
#define TXAF     3  ///< TX data can be written
#define OVR      4  ///< Overrun bit, high active
#define UNR      5  ///< Underrun bit, high active

#define TO_SIM   0  ///< FIFO C -> Simulator
#define FROM_SIM 1  ///< FIFO Simulator -> C

#define FIFO_READ  FROM_SIM ///< Select FIFO_READ queue
#define FIFO_WRITE TO_SIM   ///< Select FIFO_WRITE queue

/* The software FIFO descriptor structure */
struct fifo_t {
	unsigned char *buf;
	unsigned short size;
	unsigned short head;
	unsigned short tail;
	unsigned short fill;
	unsigned char  ovr;   // Overrun (wrote when full)
	unsigned char  unr;   // Underrun (read when empty)
	pthread_mutex_t mutex; // FIFO locking for concurrent threads
};

/** Fifo structure, anonymous */
typedef struct fifo_t Fifo;

/** Initialize a FIFO with given size */

int fifo_init(Fifo *f, unsigned short size);

/** Release FIFO resources */

void fifo_exit(Fifo *f);

/** Read from FIFO
 * \param buf    Buffer to copy to from FIFO
 * \param n      Number of bytes to read
 *
 * \return       Number of bytes read
 *
 */

int fifo_read(Fifo *f, unsigned char *buf, unsigned short n);

/** Write to FIFO
 * \param buf    Buffer to copy from to FIFO
 * \param n      Number of bytes to read
 *
 * \return       Number of bytes read
 *
 */

int fifo_write(Fifo *f, const unsigned char *buf, unsigned short n);

/** Returns FIFO status depending on the 'which' argument:
 * #FIFO_WRITE: Check if bytes can be written
 * #FIFO_READ:  Check if bytes available from FIFO
 *
 * \param which Either #FIFO_WRITE or #FIFO_READ, see above
 * \param width Data output width of FIFO (normally 1 for 8 bit, 2 for 16 bit)
 * \param flags Pointer to array of flags changed by this function
 *
 * \return      1: FIFO ready, 0: Full/empty
 */

int fifo_status(Fifo *f, char which, int width, char *flags);

/** Return FIFO fill state (number of bytes) */
int fifo_fill(Fifo *f);

/** \} */
