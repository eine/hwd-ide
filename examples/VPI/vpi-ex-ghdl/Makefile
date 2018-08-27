CC=gcc
CFLAGS=-Wall -g -I.

all: run-vpi1 run-vpi2

vpi1.o: vpi1.c
	$(CC) -c -fPIC $(CFLAGS) vpi1.c

vpi1.vpi: vpi1.o
	$(CC) --shared -o vpi1.vpi vpi1.o

vpi2.o: vpi2.c
	$(CC) -c -fPIC $(CFLAGS) vpi2.c

vpi2.vpi: vpi2.o
	$(CC) --shared -o vpi2.vpi vpi2.o

disptree: disptree.vhdl
	ghdl -a disptree.vhdl
	ghdl -e -Wl,-Wl,-E disptree

run-vpi1: vpi1.vpi disptree
	./disptree --vpi=./vpi1.vpi

run-vpi2: vpi2.vpi disptree
	./disptree --vpi=./vpi2.vpi

clean:
	rm -f vpi1.vpi vpi2.vpi disptree
	rm -f *.o

tar:
	tar cvf vpi-ex-ghdl.tar vpi1.c vpi2.c disptree.vhdl Makefile vpi_user.h
