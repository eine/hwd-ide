-- test_a3p125.vhd
-- just a file that fills a whole FPGA with LFSRs
-- Copyright (C) 2010 Yann GUIDON
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.


library ieee;
use ieee.std_logic_1164.all;

entity test_a3p125 is
generic ( size : integer := 64);
port ( clk, reset, sig_in : in std_ulogic;
    sig_out : inout std_ulogic_vector(size downto 1));
end test_a3p125;

architecture test of test_a3p125 is
  signal sigtmp : std_ulogic_vector(size downto 1);
begin

 lab: for iterateur in 1 to size generate
     dut : entity work.lfsr4
    generic map(size => 46)
      -- 46+6=48, 48*64=3072tiles => A3P125
    port map (
      clk => clk,
      reset => reset,
      din => sigtmp(iterateur),
      s => sig_out(iterateur),
      lfsr => open);
  end generate lab;

  sigtmp <= sig_out(size-1 downto 1) & sig_in;
end test;