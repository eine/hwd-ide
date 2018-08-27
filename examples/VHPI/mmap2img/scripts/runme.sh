#!/bin/sh

set -e

cd $(dirname $0)

gcc -c ../mmap_ghdl.c -o mmap_ghdl_c.o

ghdl -a ../mmap_ghdl.vhdl ../test.vhdl
ghdl -e -Wl,mmap_ghdl_c.o test_mmap

./test_mmap

rm *.o work-obj93.cf
