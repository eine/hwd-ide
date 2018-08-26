-- Fichier : telecran.vhdl
-- création : dim. oct. 31 13:00:03 CET 2010
-- An example program using the "buttons" package
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


library work; use work.boutons.all;  -- boutons
              use work.fb_ghdl.all;  -- framebuffer
              use work.rt_utils.all; -- horloge
library ieee; use ieee.std_logic_1164.all;

entity telecran is end telecran;
architecture tele of telecran is
  signal clk, stop : std_ulogic := '0';
begin
  -- instanciation de l'horloge :
  horloge : entity work.rt_clk
    generic map(ms => 10)
    port map(clk => clk, stop => stop);

  process(clk)
    variable couleur : integer := -1; -- couleur initiale : blanc
    variable l : integer := 10; -- longueur des côtés du carré
    -- coordonnées d'origine : au centre de l'écran
    variable x : integer := fbx/2;
    variable y : integer := fby/2;

    procedure dessine_carre is
      variable i,j : integer;
    begin
      for i in 0 to l-1 loop
        for j in 0 to l-1 loop
          pixel(y+i,x+j) := couleur;
        end loop;
      end loop;
      couleur := couleur - 1; -- change lentement la couleur;
    end procedure;

    variable b1, b2, b3, b4 : std_ulogic;
  begin
    lecture_boutons(b1, b2, b3, b4);

    if b1='1' then  -- aller à gauche : décrémenter x
      if x > 0 then
        x := x-1;
      end if;
    else
      if b2='1' then  -- aller à droite : incrémenter x
        if x < (fbx1-l) then
          x := x+1;
        end if;
      else
        if b3='1' then  -- aller en haut : décrémenter y
          if y > 0 then
            y := y-1;
          end if;
        else
          if b4='1' then  -- aller en bas : incrémenter y
            if y < (fby1-l) then
              y := y+1;
            end if;
          end if;
        end if;
      end if;
    end if;

    -- affiche en continu le carré :
    dessine_carre;

  end process;
end tele;

