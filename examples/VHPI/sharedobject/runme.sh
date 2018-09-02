#!/bin/sh

set -e

cd $(dirname $0)
rootDir=$(pwd)

mkdir -p bin
mkdir -p obj

cd obj

echo "|> Analyze VHDL sources (screen_ghdl.vhdl, test.vhdl)"
ghdl -a -fPIC ../screen_ghdl.vhdl ../test.vhdl

echo "|> Bind simulation unit"
ghdl --bind -fPIC test_screen

echo "|> Build 'wrapper.o' for 'ghdl_mm'"
gcc -c -fPIC ../wrapper.c -o wrapper.o

echo "|> Build 'main'"
gcc ../main.c -o ../bin/main -Wl,wrapper.o -Wl,`ghdl --list-link test_screen`

echo "|> Run 'main'"
../bin/main

echo "|> Build 'wrapper.so'"
#gcc -fPIC -shared -o libwrapper.so -Wl,wrapper.o -Wl,`ghdl --list-link test_screen`

#> Workaround for ghdl/ghdl#640"
cat /opt/ghdl-llvm/lib/ghdl/grt.ver | sed -e 's#^\(.*local:\)#ghdl_mm;\n\1#g' > ghdl.ver
gcc -fPIC -shared -o libwrapper.so -Wl,wrapper.o -Wl,`ghdl --list-link test_screen | sed -e 's#/opt/ghdl-llvm/lib/ghdl/grt.ver#ghdl.ver#g'`
#<

echo "|> Build 'shared'"
gcc -L$PWD -o ../bin/shared ../shared.c -lwrapper -ldl

echo "|> Run 'shared'"
LD_LIBRARY_PATH=$PWD:/$LD_LIBRARY_PATH ../bin/shared
