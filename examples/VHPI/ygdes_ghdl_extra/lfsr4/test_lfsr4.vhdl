-- file : test_lfsr4.vhdl
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
library std;
use std.textio.all;

entity test_lfsr4 is
end test_lfsr4;

architecture test of test_lfsr4 is
  constant c : integer := 8;
  signal result, clk, reset : std_ulogic;
begin
 dut : entity work.lfsr4
    generic map(size => c)
    port map (
      clk => clk,
      reset => reset,
      din => '0',
      s => result);

  process
    procedure clock is
    begin
      clk <= '1'; wait for 1 ns;
      clk <= '0'; wait for 1 ns;
    end procedure;
    variable i, j, n0, n1 : integer;
    variable l: line;
    variable s: string(3 downto 1);
  begin
    clk <= '0';
    reset <= '1';
    wait for 1 ns;
    reset <= '0';
    wait for 1 ns;

    for j in 1 to 3 loop
      n0 := 0;
      n1 := 0;
      for i in 2 to 2**c loop
        clock;
        if result = '1' then
          n1 := n1 + 1;
        else
          n0 := n0 + 1;
        end if;
        s:=std_ulogic'image(result);
        write(l,s(2));
      end loop;
      writeline(output,l);
      write(l,"0:"&integer'image(n0)&", 1:"&integer'image(n1));
      writeline(output,l);
    end loop;

    wait;
  end process;

end test;

