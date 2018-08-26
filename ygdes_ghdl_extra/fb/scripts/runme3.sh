#!/bin/bash
gcc -c ../fb_ghdl.c -o fb_ghdl_c.o &&
ghdl -a -Wc,-O2 ../fb_ghdl.vhdl ../lissajous.vhdl &&
ghdl -e -Wl,fb_ghdl_c.o lissajous &&
./lissajous &&
rm *.o work-obj93.cf
