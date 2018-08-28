--
-- FIFO Simulator <-> C interfacing example
-- (c) 2011 Martin Strubel <hackfin@section5.ch>
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Unsigned

library work;
use work.ghpi_fifo.all;
use work.txt_util.all;

use std.textio.all;

entity simfifo is end simfifo;

architecture behaviour of simfifo is
	signal clk : std_ulogic := '0';
	signal reset : std_ulogic := '0';
	signal count : unsigned(7 downto 0) := x"05";
	signal data : unsigned(7 downto 0);
	signal sigterm : std_logic := '0';
	signal data_valid : std_logic := '0';
	signal fifo_flags : fifoflag_t := "000000";

begin

	process
		variable err : integer;
	begin
		err := thread_init("");
		if err < 0 then
			assert false report "Failed to launch thread" severity failure;
		end if;
		clkloop : loop
			wait for 1 us;
			clk <= not clk;
			if sigterm = '1' then
				exit;
			end if;
		end loop clkloop;

		print(output, " -- TERMINATED --");
		thread_exit;
		wait;

	end process;

	process (clk)
		variable val : unsigned(7 downto 0);
		variable flags : fifoflag_t := "000000";
	begin
		if rising_edge(clk) then
			-- We first probe the fifo state.
			-- We could get by with one call to fifo_io, but that would
			-- make the code harder to read.
			flags := "000000";
			fifo_io(val, flags);
			data_valid <= flags(RXE);
			data <= val;

			if data_valid = '1' then -- Data available?
				count <= count + 1;
				if val = x"ff" then
					sigterm <= '1';
				end if;
				print(output, "SIM> " & hstr(val(8-1 downto 0)));

				-- We should check flags(TX_READY) whether we can write to the
				-- FIFO. We just assume we are.
				flags(RX) := '1'; -- RX queue advance
				flags(TX) := '1'; -- And TX advance
				fifo_io(val, flags);
			end if;
			
			-- store current FIFO state
			fifo_flags <= flags;

		end if;
	end process;

end;
