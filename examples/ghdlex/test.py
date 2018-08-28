#!/bin/env/python

# Simple test access of netpp simulation server

NETPP = "/home/strubi/src/netpp"

import sys
sys.path.append(NETPP + "/Debug")
sys.path.append(NETPP + "/python")

import time
import netpp

dev = netpp.connect("localhost")

r = dev.sync()

TMS_SEQ    =  0x80
CLK_BYTES  =  0x84
CLK_BITS   =  0xa4
MSB                  = 0x08
PLAY_TMS             = 0x01
READ                 = 0x02
NOEXIT               = 0x10
SET_TMS    =  0xc0

NOP        =  0x00
FLUSH      =  0x01
RESET      =  0x1f

def seq2buf(seq):
	b = ""
	for i in seq:
		b += chr(i)
	
	return buffer(b)

def dump(seq):
	c = 0
	for i in seq:
		print "%02x" % (ord(i)),
		if c == 16:
			c = 0
			print
	print

fifo = r.Fifo
enable = r.Enable

seq = [
		SET_TMS | 3, 0x03,
        NOP, # HACK. fx2_usb loses first byte...
		TMS_SEQ, 5, 0x1f,
		TMS_SEQ, 3, 0x03,
		CLK_BITS | PLAY_TMS, 3, 0x01,
		CLK_BYTES | MSB | READ | PLAY_TMS, 3, 0x00, 0x00, 0x00, 0x00,
        FLUSH
]

buf = seq2buf(seq)

r.Throttle.set(0) # No slow down
fifo.set(buf)
time.sleep(0.1)
enable.set(1)

time.sleep(0.5)
a = fifo.get()
dump(a)
r.Throttle.set(1) # Slow down simulation when FIFO is idle
