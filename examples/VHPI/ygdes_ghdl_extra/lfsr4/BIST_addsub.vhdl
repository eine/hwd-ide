-- file : BIST_addsub.vhdl
-- version : jeu. nov.  4 00:49:28 CET 2010
-- this file implements a combinatorial unit, injects a fault and compares
-- the result with a reference unit.
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



library ieee; use ieee.std_logic_1164.all;
              use ieee.numeric_std.all;

entity BIST_addsub is
end BIST_addsub;

architecture BIST of BIST_addsub is
  signal result, clk, reset : std_ulogic;
  signal operandes : std_ulogic_vector(66 downto 1);
  signal result_dut, result_ref : std_ulogic_vector(33 downto 1);
begin

  -- the test vector generator
 lfsr : entity work.lfsr4
    generic map(size => 66)
    port map (
      clk => clk,
      reset => reset,
      lfsr => operandes);
  -- operandes(1) : add/substract
  -- operandes(2) : carry in
  -- operandes(34 downto 3) : substractend
  -- operandes(66 downto 35) : addend

  -- reference add/sub unit
  reference: process(operandes) is
    variable addend, substractend : std_ulogic_vector(34 downto 1);
    variable res : unsigned(34 downto 1);
  begin
    addend := '0' & operandes(66 downto 35) & '1';
    substractend := '0' & operandes(34 downto 2);
    -- A-B = A+(-B) = A+(not B + 1) :
    if (operandes(1) = '1') then
      substractend := not substractend;
    end if;

    -- calcule l'addition avec les retenues
    res := unsigned(addend) + unsigned(substractend);

    -- écrit la retenue sortante mais pas entrante
    result_ref <= std_ulogic_vector(res(34 downto 2));
  end process;


  -- add/sub with a fault
  faulty: process(operandes) is
    variable addend, substractend : std_ulogic_vector(34 downto 1);
    variable res : unsigned(34 downto 1);
  begin
    addend := '0' & operandes(66 downto 35) & '1';
    substractend := '0' & operandes(34 downto 2);
    if (operandes(1) = '1') then
      substractend := not substractend;
    end if;
    res := unsigned(addend) + unsigned(substractend);

    -- fault injection :
    if (operandes(34 downto 28) = "0110110") then
      res(33) := '1';
    end if;

    result_dut <= std_ulogic_vector(res(34 downto 2));
  end process;

  process
    function sulv2txt(s : std_ulogic_vector) return string is
      variable t : string(s'range);
      variable u : string(3 downto 1);
    begin
      for i in s'range loop
        u := std_ulogic'image(s(i));
        t(i) := u(2);
      end loop;
      return t;
    end sulv2txt;

    variable r : std_ulogic_vector(33 downto 1);
  begin
    clk <= '0';
    reset <= '1';
    wait for 1 ns;
    reset <= '0';

    for i in 1 to 100000 loop
      clk <= '1'; wait for 1 ns;
      clk <= '0'; wait for 1 ns;
      r := result_ref xor result_dut;
      if (r /= (33 downto 1=>'0')) then
        report integer'image(i) & " : " & sulv2txt(operandes) & " - " & sulv2txt(r);
      end if;
    end loop;

    wait;
  end process;

end BIST;

