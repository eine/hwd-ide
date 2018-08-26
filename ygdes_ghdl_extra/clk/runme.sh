#!/bin/bash
# file runme.sh
# created by Yann Guidon / ygdes.com
# version 2010/06/05
gcc -c rt_functions.c &&
ghdl -a rt_clk.vhdl clk_exemple.vhdl &&
ghdl -e -Wl,rt_functions.o clk_exemple &&
./clk_exemple --stop-time=40ns &&
rm work-obj93.cf *.o
