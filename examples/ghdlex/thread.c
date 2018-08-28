/** \file thread.c
 *
 * Thread demo for GHDL C simulator interface
 * (c) 2011, Martin Strubel <hackfin@section5.ch>
 *
 * Compile with -DUSE_NETPP if you want to use the netpp server
 * interface.
 *
 */

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

#include "ghpi.h"
#include "fifo.h"

#ifdef USE_NETPP
#include "example.h"
#include "slave.h"
#include "netpp.h"
#else
#define DCERR_COMM_TIMEOUT -1
#endif

#define FIFO_SIZE   512

int fifo_blocking_read(Fifo *f, unsigned char *buf, unsigned int n)
{
	int i;
	int retry = 5;

	while (n > 0) {
		while (!fifo_fill(f)) {
#ifdef USE_NETPP
			usleep(g_timeout);
#endif
			retry--;
			if (retry == 0) return DCERR_COMM_TIMEOUT;
		}
		i = fifo_read(f, buf, n);
		buf += i; n -= i;
		// printf("Read %d from FIFO (%d left)\n", i, n);
	}
	return n;
}

int fifo_blocking_write(Fifo *f, unsigned char *buf, unsigned int n)
{
	int i;
	int retry = 5;

	while (n) {
		while (fifo_fill(f) == f->size ) {
#ifdef USE_NETPP
			usleep(g_timeout);
#endif
			retry--;
			if (retry == 0) return DCERR_COMM_TIMEOUT;
		}

		i = fifo_write(f, buf, n);
		// printf("Wrote %d to FIFO\n", i);
		buf += i; n -= i;
	}
	return n;
}

#ifdef USE_NETPP

int init_backend(void)
{
	register_proplist(g_devices, g_ndevices);
	init_registermap();
	return 0;
}


void *fifo_thread(void *arg)
{
	int error;
	char *argv[] = {
		"", (char *) arg
	};
	error = init_backend();
	if (error < 0) return 0;
	error = start_server(1, argv);
	if (error < 0) return 0;
	return (void *) 1;
}

#else

void *fifo_thread(void *arg)
{
	int n;
	int error;

	static
	unsigned char buf[FIFO_SIZE];

	char flags[6];

	static
	unsigned char seq[] = "Don't you wanna know what's cool?";

	int i = 3;

	Fifo *fifos = (Fifo *) arg;

	while (i--) {
		usleep(1000);
		fifo_status(&fifos[TO_SIM], FIFO_WRITE, 1, flags);

		if (flags[TXF] == HIGH) {
			n = fifo_write(&fifos[TO_SIM], seq, sizeof(seq));
			if (n > 0) {
				error = fifo_blocking_read(&fifos[FROM_SIM], buf, n);
				if (error < 0) {
					printf("Timed out\n");
				} else {
					printf("Return %d bytes from Simulator:\n", n);
					printf("%s\n", buf);
					hexdump((char *) buf, n);
				}
			}
		} else {
			printf("FIFO to Sim not ready. Skipping.\n");
		}
#ifdef USE_NETPP
		usleep(g_timeout);
#endif
	}
	// Send TERMINATE command:
	// This is a bit dirty. We have to send two bytes, because we're
	// polling the RXAE (almost empty) flag from the VHDL code.
	// If just one byte resides in the FIFO, only the RXE flag is high.
	n = fifo_write(&fifos[TO_SIM], (unsigned char *) "\377\000", 2);

	return 0;
}


#endif

pthread_t g_thread;
Fifo g_fifos[2];

int sim_thread_init(struct ghdl_string *str)
{
	int error;

	error = fifo_init(&g_fifos[TO_SIM], FIFO_SIZE);
	if (error < 0) return error;
	error = fifo_init(&g_fifos[FROM_SIM], FIFO_SIZE);
	if (error < 0) return error;

#ifdef USE_NETPP
	error = pthread_create(&g_thread, NULL, &fifo_thread, NULL);
#else
	error = pthread_create(&g_thread, NULL, &fifo_thread, g_fifos);
#endif
	if (error < 0) return error;
	return 0;
}


void thread_exit()
{
	int error;
	error = pthread_cancel(g_thread);
	fifo_exit(&g_fifos[0]);
	fifo_exit(&g_fifos[1]);
}
