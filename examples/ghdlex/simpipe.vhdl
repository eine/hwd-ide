--
-- Simulator <-> C interfacing example via linux pipes
-- (c) 2011 Martin Strubel <hackfin@section5.ch>
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Unsigned

library work;
use work.ghpi_pipe.all;
use work.txt_util.all;

use std.textio.all;

entity simpipe is end simpipe;

architecture behaviour of simpipe is
	signal clk : std_ulogic := '0';
	signal count : unsigned(7 downto 0) := x"05";
	signal data : unsigned(7 downto 0);
	signal sigterm : std_logic := '0';
	signal data_valid : std_logic := '0';
	signal pipe_flags : pipeflag_t;
	-- Pipe handles:
	shared variable inpipe : pipehandle_t;
	shared variable outpipe : pipehandle_t;

begin
	process
		variable err : integer;
	begin
		inpipe := openpipe("/tmp/sim_fromuser");
		if inpipe < 0 then
			assert false report "Failed to create IN pipe" severity failure;
		end if;
		outpipe := openpipe("/tmp/sim_touser");
		if outpipe < 0 then
			assert false report "Failed to create OUT pipe" severity failure;
		end if;
		clkloop : loop
			wait for 1 us;
			clk <= not clk;
			if sigterm = '1' then
				exit;
			end if;
		end loop clkloop;

		print(output, " -- TERMINATED --");
		closepipe(inpipe);
		closepipe(outpipe);
		wait;

	end process;

	process (clk)
		variable val : unsigned(7 downto 0);
		variable inflags : pipeflag_t := "0000";
		variable outflags : pipeflag_t := "0000";
	begin
		if rising_edge(clk) then

			inflags := pipe_flags;

			pipe_in(inpipe, val, inflags);
			-- Did we get a byte?
			if pipe_flags(RX) = '1' then
				-- Terminate when we get Ctrl-E:
				if val = x"05" then
					sigterm <= '1';
				end if;

				print(output, "SIM> " & hstr(val(8-1 downto 0)));
				-- Loop it back to the sim_touser FIFO:
				-- FIXME: We don't check for overruns.
				outflags(TX) := '1';
				pipe_out(outpipe, val, outflags);
			end if;

			-- Save flags for next time
			pipe_flags <= inflags;

		end if;
	end process;

end;
