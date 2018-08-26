-- file    : boutons.vhdl
-- created : sam. oct. 30 18:56:10 CEST 2010 par whygee@f-cpu.org
-- This package wraps a single C function that reads the parallel
-- printer port's status lines (pins 10 to 13 of the DB25 connector)
--
-- compile with :
--   $ gcc -c boutons.c -o boutons_c.o 
--   $ ghdl -a boutons.vhdl
--   $ ghdl -e -Wl,boutons_c.o boutons 
-- run with :
--   $ ./passport $PWD/boutons
--
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

package boutons is
  procedure lecture_boutons (bouton1, bouton2, bouton3, bouton4: out std_ulogic);
    attribute foreign of lecture_boutons :
      procedure is "VHPIDIRECT lecture_boutons";
end boutons;

package body boutons is
  procedure lecture_boutons (bouton1, bouton2, bouton3, bouton4: out std_ulogic) is
  begin
    assert false report "VHPI" severity failure;
  end lecture_boutons;
end boutons;

--------------------------------------------------------------------

library work; use work.boutons.all;
library ieee; use ieee.std_logic_1164.all;

entity test_boutons is
end test_boutons;

architecture test of test_boutons is
begin
  process
    variable b1, b2, b3, b4 : std_ulogic;
  begin
    -- affiche et modifie les variables :
    lecture_boutons(b1, b2, b3, b4);
    -- affiche les variables modifiées :
    report "b1:" & std_ulogic'image(b1)
        & " b2:" & std_ulogic'image(b2)
        & " b3:" & std_ulogic'image(b3)
        & " b4:" & std_ulogic'image(b4);
    wait;
  end process;
end test;
