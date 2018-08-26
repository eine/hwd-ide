#!/bin/sh
rm -f work-obj93.cf *.o test_generic
ghdl -a test_generic.vhdl &&
ghdl -e test_generic      &&
./test_generic &&
./test_generic "-gmessage=Hello World" | grep "Hello World" &&
echo "t37 : OK !" &&
rm -f work-obj93.cf *.o test_generic
