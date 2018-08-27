#!/bin/sh

set -e

cd $(dirname $0)

gcc -c ../xvga.c

ghdl -a ../screen_ghdl.vhdl ../test.vhdl
ghdl -e -Wl,-lX11 -Wl,xvga.o test_screen

./test_screen -x 1366 -y 768

rm *.o work-obj93.cf
