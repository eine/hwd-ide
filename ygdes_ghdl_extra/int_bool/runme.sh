#!/bin/bash
# runme.sh : compile and execute the example program
gcc -O2 -c int_ops.c -o int_ops_c.o &&
ghdl -a -Wc,-O2 int_ops.vhdl test_bool.vhdl &&
ghdl -e -Wl,int_ops_c.o test_bool &&
./test_bool &&
rm *.o work-obj93.cf
