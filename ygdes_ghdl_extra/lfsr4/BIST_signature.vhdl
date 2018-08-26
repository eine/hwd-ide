-- file : BIST_signature.vhdl
-- version : jeu. nov.  4 00:49:28 CET 2010
-- This file shows a LFSR+MISR architecture with (simulated) decimated output.
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
library std;  use std.textio.all;

entity BIST_signature is
end BIST_signature;

architecture BIST of BIST_signature is
  signal result, clk, reset : std_ulogic;
  signal operandes : std_ulogic_vector(66 downto 1);
  signal result_dut, result_ref,
         sign_dut, sign_ref : std_ulogic_vector(33 downto 1);
begin
  -- the test vector generator
 lfsr : entity work.lfsr4
    generic map(size => 66)
    port map (
      clk => clk,
      reset => reset,
      lfsr => operandes);

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

 signref : process(result_ref, reset, clk)
  begin
    -- reflected polynomial : 33 32 29 27 => 1 2 5 7
    if reset = '1' then
      sign_ref <= (1=>'1', others=>'0');
    else
      if rising_edge(clk) then
        sign_ref <= result_ref
           xor ((sign_ref(1) xor sign_ref(2)
             xor sign_ref(5) xor sign_ref(7))
               & sign_ref(33 downto 2));
      end if;
    end if;
  end process;

 signdut : process(result_dut, reset, clk)
  begin
    if reset = '1' then
      sign_dut <= (1=>'1', others=>'0');
    else
      if rising_edge(clk) then
        sign_dut <= result_dut
           xor ((sign_dut(1) xor sign_dut(2)
             xor sign_dut(5) xor sign_dut(7))
               & sign_dut(33 downto 2));
      end if;
    end if;
  end process;

  process
    variable r : std_ulogic;
    variable u : string(3 downto 1);
    variable l : line;
  begin
    clk <= '0';
    reset <= '1';
    wait for 1 ns;
    reset <= '0';

    for i in 1 to 100 loop
      for j in 1 to 70 loop
        clk <= '1'; wait for 1 ns;
        clk <= '0'; wait for 1 ns;
        r :=  sign_dut(1) xor
             sign_ref(1);
        u := std_ulogic'image(r);
        write(l,u(2));
      end loop;
      writeline(output,l);
    end loop;

    wait;
  end process;

end BIST;
