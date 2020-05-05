-- file    : boutons8.vhdl
-- created : sam. oct. 30 18:56:10 CEST 2010 par whygee@f-cpu.org
-- version : Fri Mar 16 16:45:22 CET 2012 : version with 8 inputs
-- compile with :
--   $ gcc -c boutons8.c -o boutons8_c.o 
--   $ ghdl -a boutons8.vhdl
--   $ ghdl -e -Wl,boutons8_c.o test_boutons8 
-- run with :
--   $ ./passport $PWD/test_boutons8

library ieee; use ieee.std_logic_1164.all; 

package boutons8 is
  procedure lecture_boutons8 (bouton1, bouton2, bouton3, bouton4,
                     bouton5, bouton6, bouton7, bouton8: out std_ulogic);
    attribute foreign of lecture_boutons8 :
      procedure is "VHPIDIRECT lecture_boutons8";
end boutons8;

package body boutons8 is
  procedure lecture_boutons8 (bouton1, bouton2, bouton3, bouton4,
                     bouton5, bouton6, bouton7, bouton8: out std_ulogic) is
  begin
    assert false report "VHPI" severity failure;
  end lecture_boutons8;
end boutons8;

--------------------------------------------------------------------

library work; use work.boutons8.all;
library ieee; use ieee.std_logic_1164.all;

entity test_boutons8 is
end test_boutons8;

architecture test of test_boutons8 is
begin
  process
    variable b1, b2, b3, b4, b5, b6, b7, b8 : std_ulogic;
  begin
    -- affiche et modifie les variables :
    lecture_boutons8(b1, b2, b3, b4, b5, b6, b7, b8);
    -- affiche les variables modifiees :
    report "b1:" & std_ulogic'image(b1)
        & " b2:" & std_ulogic'image(b2)
        & " b3:" & std_ulogic'image(b3)
        & " b4:" & std_ulogic'image(b4)
        & " b5:" & std_ulogic'image(b5)
        & " b6:" & std_ulogic'image(b6)
        & " b7:" & std_ulogic'image(b7)
        & " b8:" & std_ulogic'image(b8);
    wait for 1 ns;
  end process;
end test;
