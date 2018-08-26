#!/bin/bash
# sha-1.sh : compile and execute the SHA1 microbenchmark
gcc -O2 -c int_ops.c -o int_ops_c.o &&
ghdl -a -Wc,-O2 int_ops.vhdl int_bitvector.vhdl int_integer_range.vhdl int_integer.vhdl int_sulv.vhdl sha-1.vhdl &&
ghdl -e -Wl,int_ops_c.o sha1 &&
rm *.o work-obj93.cf &&
/usr/bin/time ./sha1
