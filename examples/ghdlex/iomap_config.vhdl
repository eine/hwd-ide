library ieee;
use ieee.numeric_std.all;

package iomap_config is
	subtype regaddr_t is unsigned(7 downto 0);
	subtype BYTESLICE is integer range 7 downto 0;

end iomap_config;
