# [ygdes.com/GHDL](http://ygdes.com/GHDL)

Created by [Yann Guidon](http://ygdes.com) and converted to markdown by [@1138-4EB](https://github.com/1138-4EB).
The files in this subdirectory are released in the hope that they are helpful or entertaining, no warranty yada yada...
You use a high level language so you're a grown up now.

# GHDL interfaces and extensions

I (Yann) own the copyright on these files and they are distributed under the terms of the [GNU GPLv3](./gpl-3.0.txt). They support articles that have been published to spread the knowledge and use of [GHDL](http://github.com/ghdl/ghdl) but they are not officially part of this simulator.

They provide and demonstrate interesting and useful features for interactive simulations. They also show advanced and special coding techniques that could give you other ideas to extend GHDL for your own projects.

You can download the whole directory with this archive : [`ghdl_extra.tgz`](http://ygdes.com/GHDL/ghdl_extra.tgz).

## [clk](./clk), GNU/Linux Magazine France #128

Generates a "real time clock", which helps slowing down a simulation. The clock period is given as a generic in milliseconds, though the system calls will usually round up this if you're not careful. It's quite useful if you want to synchronise a testbench at a few Hz.

## [fb](./fb), GNU/Linux Magazine France #130

Adds a simple and nicely working interface to the Linux framebuffer in 32-bit mode (RGBA). It needs to be enhanced in the future but it's powerful enough for doing nice pictures...

## [ghdl_env](./ghdl_env), GNU/Linux Magazine France #131

Adds a `getenv` function that reads the requested environment variable and returns an integer or a string.

> 2017/12/09 : look at the [t37](./ghdl_env/t37) directory for the simpler (yet more limited) version implemented in the [ghdl/ghdl#37](https://github.com/ghdl/ghdl/issues/37) since GHDLv0.33 (2015)!

## [7segments](./7segments), GNU/Linux Magazine France #HS51

Creates a 7-segment display, using the [fb](./fb) and [clk](./clk) package.

## [lfsr4](./lfsr4), OpenSilicium #1

It's a scalable 4-xor LFSR, from 5 taps to 786, very handy!

## [io_port](./io_port), GNU/Linux Magazine France #133

Read the parallel printer port's status signals and turn them into VHDL signals. A really primitive sketching application is shown as example (using [fb](./fb) and [clk](./clk)).

## [int_bool](./int_bool), GNU/Linux Magazine France #136

`int_ops.c` and `int_ops.vhdl` provide boolean/logic operations to VHDL's integer type. An intermediate type is provided by 4 packages with different properties and a microbenchmark implements the SHA1 algorithm to demonstrate the speedup that behavioural simulation can benefit from.

## [access_c](./access_c)

This shows how GHDL can access variables located in a C module, using the access type (sort of pointer).

## [direct_c](./direct_c)

This shows how a C module can access a shared variable in a VHDL package, using the extern keyword. However it is a more brittle method than the previous one.

---

More to come in the future...

# External resources

- VHDL References
  - (LRM in HTML or PDF ?)
  - http://www.vhdl.org/ (GHDL is not linked back from there, BTW)
  - comp.lang.vhdl Frequently Asked Questions And Answers
    - http://www.vhdl.org/comp.lang.vhdl/FAQ1.html  (Part 1): General
    - http://www.vhdl.org/comp.lang.vhdl/FAQ4.html  (Part 4): VHDL Glossary
- Tutorials
  - in french: http://vhdl33.free.fr/wp-content/cours/cours2007.htm
- Papers
  - Pascal Giard, communication with POSIX shared memory and CORBA: http://organact.mine.nu/dokuwiki/_media/mesetudes:mnrc08.pdf?id=mesetudes&cache=cache
  - A Methodology and Toolset to Enable SystemC and VHDL Co-simulation
    - http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=4208939
    - http://www.lsc.ic.unicamp.br/publications/maciel2007isvlsi.pdf
- Articles
  - In GNU/Linux Magazine France (in french) issues 126 (04/2010), HS47 (04-05/2010),
127 (05/2010), 130 (09/2010), 131 (10/2010), 132 (11/2010) and more...
- Source code
  - VHDL Cosimulation with GHDL (VPI, VHPI): http://www.myhdl.org/doku.php/dev:vhdl_cosim
  - Modifications to GHDL VPI Examples: http://www.myhdl.org/doku.php/dev:vhdl_cosim:ghdl_vpi1

  > "This was a quick experiment to take the cver VPI implementation, compile it and load it in GHDL. The experiment was successful but was a very limited experiment. Although the VPI was loaded successfully nothing from the VPI interface was accessed. Need to do some more experiments to test feasibility of the VPI interface."

