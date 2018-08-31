#!/bin/sh

ghdl -a screen_ghdl.vhdl ../test.vhdl
ghdl --bind test_screen

gcc wrapper.c -Wl,`ghdl --list-link test_screen` -o ./test_screen

./test_screen

rm -rf *.o *.lst work-obj93.cf test_screen
