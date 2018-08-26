#!/bin/bash
gcc -c ../fb_ghdl.c -o fb_ghdl_c.o &&
ghdl -a ../fb_ghdl.vhdl ../test_fb2.vhdl &&
ghdl -e -Wl,fb_ghdl_c.o test_fb2 &&
./test_fb2 &&
rm *.o work-obj93.cf
