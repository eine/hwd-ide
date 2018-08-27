GHDL=ghdl
CC=gcc

all: math_tb random_tb timeit showtime

# Import of 'sin' function from the math library.
math_tb: libmath.o
	$(GHDL) -e -Wl,-lm math_tb

libmath.o: libmath.vhdl
	$(GHDL) -a $<

# Import of random function from the C library.
random_tb: random.o
	$(GHDL) -e random_tb

random.o: random.vhdl
	$(GHDL) -a $<

# Same as random_tb but in C.
random_ref: random_ref.o
	$(CC) -o $@ $<

# Start GHDL simulation from a C program.
timeit: timeit.o time_tb.o
	$(GHDL) -e -Wl,timeit.o time_tb

time_tb.o: time_tb.vhdl
	$(GHDL) -a $<

# Start GHDL simulation from an Ada program
showtime: time_tb.o e~time_tb.lst
	gnatmake showtime -largs `$(GHDL) --list-link time_tb`

e~time_tb.lst: time_tb.vhdl
	$(GHDL) -a $<
	$(GHDL) --bind time_tb

clean:
	$(RM) math_tb random_tb showtime random_ref time_tb
	$(RM) *~ e~* *.ali *.o work-obj93.cf

