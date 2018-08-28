/** \file fifo.c
 *
 * Stupid software FIFO for test purposes.
 *
 * (c) 2009 Martin Strubel <hackfin@section5.ch>
 *
 * Changes:
 *  09/2011 Martin Strubel <hackfin@section5.ch>
 *     Implemented a first-fall-through FIFO for the GHDL simulator
 *     interface.
 *
 * The first version of this FIFO exhibited a pitfall: When burst
 * reading, the FIFO empty condition can not be handled in time.
 * Therefore, another flag RXAE is introduced. This flag goes
 * low when there is only one byte left to read from the FIFO.
 * Likewise, there is a TXAF flag. A sane VHDL implementation should
 * really check for both flags (we don't, in the provided example).
 * Things can go wrong if there is only ONE byte written to an empty FIFO.
 *
 */

#include <pthread.h>
#include <unistd.h> // usleep()
#include <stdio.h>
#include <stdlib.h>
#include "fifo.h"
#include "ghpi.h"

extern Fifo g_fifos[2];

int fifo_init(Fifo *f, unsigned short size)
{
	int error;
	f->size = size;
	error = pthread_mutex_init(&f->mutex, NULL);
	if (error < 0) return error;
	f->buf = (unsigned char*) malloc(size);
	if (!f->buf) return -1;
	f->head = 0;
	f->tail = 0;
	f->fill = 0;
	f->ovr = LOW;
	f->unr = LOW;
	return 0;
}

void fifo_exit(Fifo *f)
{
	pthread_mutex_destroy(&f->mutex);
	free(f->buf);
}

int fifo_getbyte(Fifo *f, unsigned char *byte)
{
	if (f->fill == 0) {
		return 0;
	}
	*byte = f->buf[f->tail];
	return 1;
}

static
int fifo_get(Fifo *f, unsigned char *dst, int n)
{
	unsigned short p;

	int ret = f->fill;

	p = f->tail;
	do {
		*dst++ = f->buf[p++];
		p %= f->size;
		n--;
	} while (p != f->head && n > 0);


	return ret;
}

int fifo_advance(Fifo *f, int n)
{
	int ret = 0;

	pthread_mutex_lock(&f->mutex);

	if (f->fill == 0) {
		f->unr = HIGH;
		fprintf(stderr, "Error: FIFO underrun (advance)\n");
	} else {
		f->tail += n; f->tail %= f->size;
		f->fill -= n;
		ret = 1;
	}

	pthread_mutex_unlock(&f->mutex);

	return ret;
}

int fifo_read(Fifo *f, unsigned char *byte, unsigned short n)
{
	int i = 0;
	if (n == 0) return 0;

	pthread_mutex_lock(&f->mutex);

	if (f->fill == 0) {
		f->unr = HIGH;
		fprintf(stderr, "Error: FIFO underrun (read)\n");
		i = 0;
	} else {
		do {
			*byte++ = f->buf[f->tail++];
			f->tail %= f->size;
			n--; i++;
		} while (f->tail != f->head && n > 0);
		f->fill -= i;
	}

	pthread_mutex_unlock(&f->mutex);

	return i;
}

int fifo_fill(Fifo *f)
{
	unsigned short fill;
	pthread_mutex_lock(&f->mutex);
	fill = f->fill;
	pthread_mutex_unlock(&f->mutex);
	return fill;
}

int fifo_status(Fifo *f, char which, int width, char *flags)
{
	pthread_mutex_lock(&f->mutex);

	if (which == FIFO_WRITE) {
		if (f->fill == f->size) {
			flags[TXF] = LOW; flags[TXAF] = LOW;
		}
		if (f->fill == f->size - width) {
			flags[TXF] = HIGH; flags[TXAF] = LOW;
		}
		else {
			flags[TXF] = HIGH; flags[TXAF] = HIGH;
		}
	} else {
		if (f->fill == 0) {
			flags[RXE] = LOW; flags[RXAE] = LOW;
		} else
		if (f->fill == width) {
			flags[RXE] = HIGH; flags[RXAE] = LOW;
		}
		else {
			flags[RXE] = HIGH; flags[RXAE] = HIGH;
		}
	}
	pthread_mutex_unlock(&f->mutex);
	return 1;
}

void fifo_reset(Fifo *f)
{
	f->unr = LOW;
	f->ovr = LOW;
}


int fifo_write(Fifo *f, const unsigned char *byte, unsigned short n)
{
	int i = 0;

	if (n == 0) return 0;

	pthread_mutex_lock(&f->mutex);

	if (f->fill == f->size) {
		f->ovr = HIGH;
		fprintf(stderr, "Error: FIFO overrun\n");
		i = 0;
	} else {
		do {
			f->buf[f->head++] = *byte++;
			f->head %= f->size;
			n--; i++;
		} while (f->tail != f->head && n > 0);

		f->fill += i;
	}

	pthread_mutex_unlock(&f->mutex);

	return i;
}

/** This is the FIFO filler/emptier
 * 
 * ..for the FALLTHROUGH FIFO type.
 *
 * \param flag   0: read (set out), 1: write (get in)
 *
 *
 */

void sim_fifo_io(struct fat_pointer *data, char *flag)
{
// 	printf("in: %p, out: %p, flag: %x\n", in, out, flag);
	unsigned char valuebytes[32];
	unsigned char rx, tx;
	short n;
	short nbits = data->bounds->len;
	short nbytes = (nbits + 7) >> 3;

	// Guard maximum chunk size:
	if (nbytes > sizeof(valuebytes)) {
		nbytes = sizeof(valuebytes);
		fprintf(stderr, "Warning: FIFO request size truncated\n");
	}


	// Buffer action flags:
	rx = flag[RXE] == HIGH ? 1 : 0;
	tx = flag[TXF] == HIGH ? 1 : 0;

	// Check W1C error flags:
	if (flag[OVR] == HIGH) g_fifos[TO_SIM].ovr = LOW;
	if (flag[UNR] == HIGH) g_fifos[FROM_SIM].unr = LOW;
	
	// Do we write?
	if (tx) {
		logic_to_bytes(data->base, nbytes, valuebytes);
		fifo_write(&g_fifos[FROM_SIM], valuebytes, nbytes);
		// printf("S -> H fill: %d\n", g_fifos[FROM_SIM].fill);
	}

	// Did we read advance?
	if (rx) {
		// printf("S <- H fill: %d\n", g_fifos[TO_SIM].fill);
		fifo_advance(&g_fifos[TO_SIM], nbytes);
	}

	
	// Query status and set flags
	fifo_status(&g_fifos[FROM_SIM], FIFO_WRITE, nbytes, flag);
	fifo_status(&g_fifos[TO_SIM], FIFO_READ, nbytes, flag);

	if (flag[RXE] == HIGH) { // We do at least have 'nbytes' bytes in the FIFO
		n = fifo_get(&g_fifos[TO_SIM], valuebytes, nbytes);
		bytes_to_logic(data->base, nbytes, valuebytes);
		// printf("n: %d: %02x %02x\n", n, valuebytes[0], valuebytes[1]);
	} else {
		fill_slv(data->base, nbits, UNDEFINED);
		// usleep(10000); // Save some cycles on the GHDL side
		// This could be potentially dangerous, because it may
		// block a fifo_write event for too long.
	}
	

	// Return OVR/UNR flags
	flag[OVR] = g_fifos[FROM_SIM].ovr;
	flag[UNR] = g_fifos[TO_SIM].unr;
}

// not first fall through
// Unused and unmaintained.
#if 0
void sim_fifo_io_ex(char *data, char *flag)
{
	uint32_t v;
	unsigned char b;


	// Check W1C error flags:
	if (flag[OVR] == HIGH) g_fifos[TO_SIM].unr = LOW;
	if (flag[UNR] == HIGH) g_fifos[FROM_SIM].ovr = LOW;

	// Are we serious to operate?
	if (flag[RXE] == HIGH) {
		if (fifo_read(&g_fifos[TO_SIM], &b, 1) == 1) {
			uint_to_logic(data, 8, b);
		}
	}

	if (flag[TXF] == HIGH) {
		logic_to_uint(data, 8, &v);
		b = v;
		fifo_write(&g_fifos[FROM_SIM], &b, 1);
	}

	// Query status and set flags
	fifo_status(&g_fifos[TO_SIM], FIFO_READ, flag);
	fifo_status(&g_fifos[FROM_SIM], FIFO_WRITE, flag);

	// Return OVR/UNR flags
	flag[OVR] = g_fifos[FROM_SIM].ovr;
	flag[UNR] = g_fifos[TO_SIM].unr;
}

#endif
