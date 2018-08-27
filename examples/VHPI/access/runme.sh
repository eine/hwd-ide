#!/bin/sh

set -e

cd $(dirname $0)

gcc -c access_mmap.c -o access_mmap.o

ghdl -a access.vhdl test.vhdl
ghdl -e -Wl,access_mmap.o access_test

./access_test

rm *.o work-obj93.cf access_test
