#!/bin/bash
# access.sh
gcc -c ghdl_access.c -o ghdl_access_c.o &&
ghdl -a ghdl_access.vhdl access_test.vhdl &&
ghdl -e -Wl,ghdl_access_c.o test_access &&
./test_access &&
rm *.o work-obj93.cf test_access