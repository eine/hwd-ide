#!/bin/bash
# fichier : telecran.sh
gcc -c rt_functions.c &&
gcc -c boutons.c -o boutons_c.o &&
gcc -c fb_ghdl.c -o fb_ghdl_c.o &&
ghdl -a fb_ghdl.vhdl rt_clk.vhdl boutons.vhdl telecran.vhdl &&
ghdl -e -Wl,fb_ghdl_c.o -Wl,rt_functions.o -Wl,boutons_c.o telecran
# && ./passport $PWD/telecran
