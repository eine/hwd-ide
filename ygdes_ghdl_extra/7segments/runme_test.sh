#!/bin/bash
gcc -c fb_ghdl.c -o fb_ghdl_c.o &&
gcc -c rt_functions.c &&
ghdl -a fb_ghdl.vhdl rt_clk.vhdl segment.vhdl test_7seg.vhdl &&
ghdl -e -Wl,fb_ghdl_c.o -Wl,rt_functions.o test_7seg &&
./test_7seg
rm *.o work-obj93.cf

