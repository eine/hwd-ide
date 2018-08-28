/** \file pipe.c
 *
 * Simple named pipe reader/writer for GHDL simulation interface
 *
 * (c) 2011 Martin Strubel <hackfin@section5.ch>
 *
 */

#include "ghpi.h"
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <unistd.h>
#include <poll.h>
#include <string.h>

#define RXE      0  ///< RX empty, low active
#define TXF      1  ///< TX full, low active
#define OUR      2  ///< Over/Underrun bit
#define ERR      3  ///< Generic error bit

#define TIMEOUT 1

int sim_openpipe(struct ghdl_string *name)
{
	int l;
	char fname[32];

	l = name->bounds->len;
	if (l >= 32) return -ENOMEM;
	strncpy(fname, name->base, l);
	fname[l] = '\0';
	return open(fname, O_RDWR | O_NONBLOCK);
}

void sim_closepipe(int fd)
{
	close(fd);
}

void sim_pipe_in(int fd, char *data, char *flag)
{
	unsigned char buf[2];
	int stat;
	struct pollfd fds;
	fds.fd = fd;
	fds.events = POLLIN | POLLERR;

	if (flag[RXE] == HIGH) { // we issue a read
		stat = read(fd, buf, 1);
		if (stat == 1) {
			bytes_to_logic(data, 1, buf);
		} else {
			flag[OUR] = HIGH;
		}
	}
	stat = poll(&fds, 1, TIMEOUT);
	if (stat < 0) flag[ERR] = HIGH; // Mark error
	else if (stat > 0) {
		flag[RXE] = HIGH;
	} else {
		flag[RXE] = LOW;
	}
}

void sim_pipe_out(int fd, char *data, char *flag)
{
	unsigned char buf[2];
	int stat;
	struct pollfd fds;
	fds.fd = fd;
	fds.events = POLLOUT | POLLERR;

	if (flag[TXF] == HIGH) { // we issue a write
		logic_to_bytes(data, 1, buf);
		stat = write(fd, buf, 1);
		if (stat != 1) flag[OUR] = HIGH;
	}
	stat = poll(&fds, 1, TIMEOUT);
	if (stat < 0) flag[ERR] = HIGH; // Mark error
	else if (stat > 0) {
		flag[TXF] = HIGH;
	} else {
		flag[TXF] = LOW;
	}
}

