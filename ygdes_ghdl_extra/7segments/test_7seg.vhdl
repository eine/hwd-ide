-- fichier : test_seg.vhdl
-- créé dim. juin 20 10:35:28 2010 (whygee@f-cpu.org)
-- version jeu. sept. 30 22:23:00 CEST 2010

--    segment.vhdl : example of a 4-digit 7-segment display
--    Copyright (C) 2010 Yann GUIDON
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.



library ieee;
use ieee.std_logic_1164.all;
library work;
use work.rt_utils.all; -- l'horloge temps réel
use work.segment.all;  -- l'afficheur à 7 segments
use work.fb_ghdl.all;

entity test_7seg is
  -- pas d'entrées-sorties
end test_7seg;

architecture test of test_7seg is
  -- contrôle de l'horloge temps réel
  signal clk_rt, stop_rt: std_ulogic:='0';
  -- les fils à afficher :
  signal segs : std_ulogic_vector(28 downto 0);
begin

 -- horloge temps réel pour ralentire la simulation
 horloge : entity work.rt_clk
  generic map(ms => 20) -- 25 Hz
  port map(clk => clk_rt, stop => stop_rt);

  rt: process
    variable i, j : integer;
  begin
    -- initialisation
    segs <= (0=>'1', others=>'0');

    -- fait clignoter les segments
    for i in 0 to 400 loop
      wait until rising_edge(clk_rt);

      -- LFSR à 29 bits, le polynôme provient de 
      -- http://www.physics.otago.ac.nz/px/research/
      --   electronics/papers/technical-reports/lfsr_table.pdf
      segs <= segs(27 downto 0) & (segs(28) xor segs(27) xor segs(26) xor segs(24));
    end loop;

    stop_rt <= '1'; -- arrête l'horloge pour terminer la simulation
    wait;
  end process;

  -- l'affichage :
  display1: entity work.seg7
    generic map(x=>50, y=>50)
    port map(seg => segs(6 downto 0));
  display2: entity work.seg7
    generic map(x=>170, y=>50)
    port map(seg => segs(13 downto 7));
  segment_point(275,85, 15, segs(14));
  segment_point(275,155,15, segs(14));
  display3: entity work.seg7
    generic map(x=>320, y=>50)
    port map(seg => segs(21 downto 15));
  display4: entity work.seg7
    generic map(x=>440, y=>50)
    port map(seg => segs(28 downto 22));
end test;
