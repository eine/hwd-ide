#!/bin/sh
gcc -c boutons8.c -o boutons8_c.o &&
ghdl -a boutons8.vhdl &&
ghdl -e -Wl,boutons8_c.o test_boutons8 &&
./passport $PWD/test_boutons8
