#!/bin/bash
gcc -c ghdl_env.c -o ghdl_env_c.o &&
ghdl -a ghdl_env.vhdl testenv.vhdl &&
ghdl -e -Wl,ghdl_env_c.o testenv &&
./testenv &&
rm *.o work-obj93.cf testenv
