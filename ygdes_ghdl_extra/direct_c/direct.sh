#!/bin/bash
# direct.sh
gcc -c ghdl_direct.c -o ghdl_direct_c.o &&
ghdl -a ghdl_direct.vhdl direct_test.vhdl &&
ghdl -e -Wl,ghdl_direct_c.o test_direct &&
./test_direct &&
rm *.o work-obj93.cf test_direct