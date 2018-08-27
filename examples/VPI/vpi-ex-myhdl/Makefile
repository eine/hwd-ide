CC=gcc
CFLAGS=-Wall -g -I.

all: run-vpi

myhdl_vpi.o: myhdl_vpi.c
	$(CC) -c -fPIC $(CFLAGS) myhdl_vpi.c

myhdl.vpi: myhdl_vpi.o
	$(CC) --shared -o myhdl.vpi myhdl_vpi.o

disptree: 
	ghdl -a disptree.vhdl
	ghdl -e -Wl,-Wl,-E disptree

run-vpi: myhdl.vpi disptree
	./disptree --vpi=./myhdl.vpi


clean:
	rm -f myhdl_vpi.vpi
	rm -f *.o

tar:
	tar cvf vpi-ex-ghdl.tar myhdl_vpi.c Makefile vpi_user.h
