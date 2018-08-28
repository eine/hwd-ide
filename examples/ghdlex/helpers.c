/** \file helpers.c
 *
 * GHDL simulator interface auxiliaries
 *
 * (c) 2009-2011 Martin Strubel <hackfin@section5.ch>
 *
 */

#include <stdio.h>
#include "ghpi.h"

/** Dump buffer */

void hexdump(char *buf, unsigned long n)
{
	int i = 0;
	int c = 0;

	while (i < n) {
		// Testing: Bitreverse display:
		// printf("%02x ", reverse32(buf[2 * i]) >> 24);
		printf("%02x ", (unsigned char) buf[i]);
		c++;
		if (c == 16) { c = 0; printf("\r\n"); }
		i++;
	}
	if (c)
		printf("\r\n");
}

void dump_bits(unsigned char c)
{
	char *s = "UX01Z???";

	c &= 7;

	putchar(s[c]);
}

int logic_to_uint(const char *l, int nbits, uint32_t *val)
{
	uint32_t v = 0;
	while (nbits--) {
		v <<= 1;
		switch (*l) {
			case HIGH: v |= 1; break;
			case LOW: break;
			default: return -1;
		}
		l++;
	}
	*val = v;
	return 0;
}

void uint_to_logic(char *l, int nbits, uint32_t val)
{
	uint32_t pos;
	
	while (nbits--) {
		pos = 1 << nbits;
		if (val & pos) {
			*l = HIGH;
		} else {
			*l = LOW;
		}
		l++;
	}
}

void logic_to_bytes(char *l, int n, unsigned char *b)
{
	uint32_t v;

	while (n--) {
		logic_to_uint(l, 8, &v);
		*b++ = v; l += 8;
	}
}

void bytes_to_logic(char *l, int n, const unsigned char *b)
{
	while (n--) {
		uint_to_logic(l, 8, *b++);
		l += 8;
	}
}

void fill_slv(char *l, int nbits, unsigned char val)
{
	while (nbits--) {
		*l++ = val;
	}
}

// TESTING
	
void sim_set_ptr(handle_t_ghdl p)
{
	printf("Got ptr: %lx\n", p);
}

handle_t_ghdl sim_get_ptr(netpphandle_t_ghdl i)
{
	printf("Got int: %x\n", i);
	return (void *) 0xdeadbeef;
}
