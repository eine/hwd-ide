readme.txt by yann guidon
sam. juin  5 09:20:17 CEST 2010
jeu. nov.  4 00:53:45 CET 2010

The file lfsr4.vhdl is designed for helping circuit tests.
Its size can be adjusted from 5 to 786 taps with no gaps.
The most interesting property is that the circuit always
uses a 4-feedback architecture, whatever the LFSR size. 
If you want to fill a FPGA array up to the last gate,
you just need to vary the size of the LFSRs.
A data-in is provided so the register is not optimised-out
by the synthesizer.

For example, for the Actel A3P125 (with 3072 tiles),
100% device utilization is achieved with 64 LFSR of 46 taps.
Since the number of XOR operations is constant, it is easy
to find the right LFSR size.

Many other uses are possible, of course.

test_lfsr4.vhdl runs the LFSR and displays the result,
showing that the output is cyclic with the expected period.

yg
