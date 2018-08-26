-- file : lissajous.vhdl
-- created by Yann Guidon / ygdes.com
-- version 2010/06/05

-- lissajous.vhdl : example program for the use of the framebuffer package
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



library work;
use work.fb_ghdl.all;
library ieee;
use ieee.math_real.all;

entity lissajous is
end lissajous;

architecture courbes of lissajous is
  signal x,y : integer := 0;
begin
  process  -- generateur x
    variable accumulateur: real := 0.0;
  begin
    wait for 10000 ns;
    accumulateur := accumulateur + 0.001;
    x <= integer(real(fbx-1) * (0.5+ (0.5*sin(accumulateur))));
  end process;

  process  -- generateur y
    variable accumulateur: real := 0.0;
  begin
    wait for 4141 ns;
    accumulateur := accumulateur + 0.001;
    y <= integer(real(fby-1) * (0.5+(0.5*cos(accumulateur))));
  end process;

  -- affiche le point quand une coordonnee change
  process(x,y)
    variable couleur : integer := -1;
  begin
    pixel(y,x) := couleur;
    couleur := couleur-1;

    -- backup
    if (couleur=-3500000) then
      save_pixels("lissajous.raw24");
      assert false severity failure;
    end if;
  end process;
end courbes;
