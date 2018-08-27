#!/bin/sh

scriptdir="$(cd `dirname $0`; pwd)"

ghdl -a "$scriptdir"/hdl/*.vhd

printf "[TEST] ghdl -r --vcd\n"
ghdl -r adder_tb --vcd=adder.vcd

printf "[TEST] ghdl -r --disp-tree=none\n"
ghdl -r adder_tb --disp-tree=none > disp-tree_none.txt

printf "[TEST] ghdl -r --disp-tree=inst\n"
ghdl -r adder_tb --disp-tree=inst > disp-tree_inst.txt

printf "[TEST] ghdl -r --disp-tree=proc\n"
ghdl -r adder_tb --disp-tree=proc > disp-tree_proc.txt

printf "[TEST] ghdl -r --disp-tree=port\n"
ghdl -r adder_tb --disp-tree=port > disp-tree_port.txt

printf "[TEST] ghdl -r --disp-tree\n"
ghdl -r adder_tb --disp-tree > disp-tree.txt

printf "[TEST] ghdl --pp-html\n"
ghdl --pp-html "$scriptdir"/hdl/*.vhd > adder.html

printf "[TEST] ghdl --file-to-xml\n"
ghdl --file-to-xml "$scriptdir"/hdl/*.vhd > adder.xml

#gtkwave adder.vcd