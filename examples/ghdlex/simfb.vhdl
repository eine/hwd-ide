--
-- Simulator<->netpp server communication example
-- (c) 2011 Martin Strubel <hackfin@section5.ch>
--
-- This example connects to the netpp remote display and shows a UYUV color
-- pattern. It is kinda slow, so deal with framerates < 1fps.
--
-- Usage: Fire up display server on the local machine, then start this
-- simulation.
-- If it crashes, try using the --stack-size=10000 option

-- There are two ways of doing it: Either dumping a memory buffer
-- via setfb() or setting pixels by setpixel().


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Unsigned

library work;
use work.ghpi_netpp.all;
use work.txt_util.all;

use std.textio.all;

entity simfb is
	generic (
		ServerPort : string := "TCP:localhost:2008"
	);
end simfb;

architecture behaviour of simfb is

	signal clk : std_ulogic := '0';
	signal count : unsigned(15 downto 0) := x"0000";
	signal data : unsigned(7 downto 0);
	signal sigterm : std_logic := '0';

	signal ypos : unsigned(15 downto 0) := x"0000";
	signal xpos : unsigned(15 downto 0) := x"0000";

	constant WIDTH  : integer := 256;
	constant HEIGHT : integer := 256;

	type rambuf is array(0 to WIDTH*HEIGHT-1) of pixel_t;

	shared variable device : netpphandle_t;
	shared variable g_fb   : framebuffer_t;
	shared variable g_ram  : rambuf; -- pixarray_t;

begin

	process
		variable err : integer;
		variable hdl : handle_t;
	begin
		-- Open device. When failing to connect, function will bail out.
		device := device_open(ServerPort);
		-- get_ptr(device, hdl);
		-- get_ptr(device, hdl);
		print(output, "Got device handle: " & str(device));
		g_fb := initfb(device, WIDTH, HEIGHT, VIDEOMODE_UYVY);
		if g_fb < 0 then
			assert false report "Failed to init framebuffer" severity failure;
		end if;
		clkloop : loop
			wait for 100 us;
			clk <= not clk;
			if sigterm = '1' then
				exit;
			end if;
		end loop clkloop;

		print(output, " -- TERMINATED --");
		releasefb(g_fb);
		-- Close connection to netpp device
		device_close(device);
		wait;

	end process;

----------------------------------------------------------------------------

	process (clk)
		variable ret : integer;
		variable offset : natural;
		variable val : unsigned(15 downto 0);
		variable uyselect : std_logic := '0';
	begin
		if rising_edge(clk) then
			-- Set integer value on device to counter value:
			uyselect := not uyselect;
			if xpos = WIDTH - 1 then
				xpos <= (others => '0');
				if ypos = HEIGHT - 1 then
					ypos <= (others => '0');
					-- Update frame buffer
					setfb(g_fb, pixarray_t(g_ram));
					updatefb(g_fb);
					count <= count + 1;
				else
					ypos <= ypos + 1;
				end if;
			else
				xpos <= xpos + 1;
			end if;

			if uyselect = '0' then
				val := count + xpos(7 downto 0);
				val := x"70" & val(7 downto 0);
				-- val := "0" & xpos(6 downto 0) & x"c0";
			else
				val := count + ypos(7 downto 0);
				val := x"70" & val(7 downto 0);
				-- val := "0" & ypos(6 downto 0) & x"c0";
			end if;
			offset := to_integer(ypos) * WIDTH + to_integer(xpos);
			g_ram(offset) := val;
			-- setpixel(g_fb, to_integer(xpos), to_integer(ypos), val);
		end if;
	end process;

end;
