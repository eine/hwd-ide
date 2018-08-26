-- fichier : segment.vhdl
-- créé : lun. juin 21 14:58:36 CEST 2010
-- version ven. sept. 17 04:24:05 CEST 2010
-- version sam. sept. 18 08:36:49 CEST 2010
-- version mar. sept. 28 15:41:27 CEST 2010

--    segment.vhdl : package and architecture for 7-segment display
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
use work.fb_ghdl.all;

package segment is
  type sulv2int_array is array (std_ulogic) of integer;

  constant sul2int : sulv2int_array := (
    'U' =>    16#ff9400#, -- orange
    '0' =>    16#003000#, -- vert foncé
    '1' =>    16#4fff4f#, -- vert clair
    others => 16#8b8b8b#  -- gris foncé
  );

  constant oblique_haut : integer := -1;
  constant oblique_bas  : integer :=  1;

  procedure segment_point     (x,y,  h:     integer; v: std_ulogic);
  procedure segment_horizontal(x,y,w,h:     integer; v: std_ulogic);
  procedure segment_vertical  (x,y,w,h:     integer; v: std_ulogic);
  procedure segment_oblique   (x,y,w,h,dir: integer; v: std_ulogic);
end segment;

package body segment is

  procedure segment_point(x,y,h: integer; v: std_ulogic) is
    variable i,j, c: integer;
  begin
    c := sul2int(v);
    -- carré :
    for j in y to y+h loop
      for i in x to x+h loop
        pixel(j,i) := c;
      end loop;
    end loop;
  end segment_point;

  procedure segment_horizontal(x,y,w,h: integer; v: std_ulogic) is
    variable i,j,t, c: integer;
  begin
    c := sul2int(v);
    -- la ligne centrale, affichée une seule fois
    for i in x to x+h loop
      pixel(y,i) := c;
    end loop; 

    for j in 1 to w loop
      -- boucle sur la ligne du dessus
      t := y-j;
      for i in (x+j) to (x+h-j) loop
        pixel(t,i) := c;
      end loop;
      -- boucle sur la ligne du dessous
      t := y+j;
      for i in (x+j) to (x+h-j) loop
        pixel(t,i) := c;
      end loop;
    end loop;
  end segment_horizontal;

  procedure segment_vertical(x,y,w,h: integer; v: std_ulogic) is
    variable i,j, c: integer;
  begin
    c := sul2int(v);

    for j in 0 to w loop
      -- triangle supérieur
      for i in (x-j) to (x+j) loop
        pixel(y+j,i) := c;
      end loop;
      -- triangle inférieur
      for i in (x-j) to (x+j) loop
        pixel(y+h-j,i) := c;
      end loop;
    end loop;

    -- rectangle
    for j in y+w to y+h-w loop
      for i in x-w to x+w loop
        pixel(j,i) := c;
      end loop;
    end loop;

  end segment_vertical;

  procedure segment_oblique(x,y,w,h,dir: integer; v: std_ulogic) is
    variable i, j, a, b, c, y2: integer;
  begin
    a := 0;
    b := w;
    c := sul2int(v);
    y2:=y;

    for j in 0 to h loop
      -- affiche une ligne horizontale
      for i in a+x to b+x loop
        pixel(y2,i) := c;
      end loop;

      -- passe à la ligne du dessous
      y2 := y2+dir;
      -- avance le début :
      if j>w then a := a+1; end if;
      -- avance la fin :
      if b<h then b := b+1; end if;
    end loop;
  end segment_oblique;

end segment;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.segment.all;
use work.fb_ghdl.all;

entity seg7 is
  generic(
    x : integer;       -- \ coordinates of left-top corner - minus girth
    y : integer;       -- /
    s : integer := 70; -- length of the segments
    g : integer := 7;  -- girth/width of the segments
    l : integer := 3   -- spacing between segments
  );
  port(seg : in std_ulogic_vector(6 downto 0));
begin
  process is
  begin
    -- 1 < g < s
    assert 1 < g             report "segment trop fin"   severity failure;
    assert g < s             report "segment trop épais" severity failure;
    -- 0 < l < s
    assert 0 < l             report "espacement trop faible" severity failure;
    assert l < s             report "espacement trop grand"  severity failure;
    -- 3 < s < fby
    assert 3 < s             report "segment trop long"  severity failure;
    assert s < fby           report "segment trop court" severity failure;
    -- l < x < fbx1-(s+l)
    assert l < x             report "abscisse trop à gauche" severity failure;
    assert x < fbx1-(s+l)    report "abscisse trop à droite" severity failure;
    -- l < y < fby1-(s+l+l+s+l)
    assert l < y                report "ordonnée trop haute" severity failure;
    assert y < fby1-(s+l+l+s+l) report "ordonnée trop basse" severity failure;

    wait;
  end process;
end seg7;

architecture observe of seg7 is
begin
  segment_horizontal(x+l    ,y            ,g,s, seg(0));
  segment_vertical  (x+l+s+l,y+l          ,g,s, seg(1));
  segment_vertical  (x+l+s+l,y+l+s+l+l    ,g,s, seg(2));
  segment_horizontal(x+l    ,y+l+s+l+l+s+l,g,s, seg(3));
  segment_vertical  (x      ,y+l+s+l+l    ,g,s, seg(4));
  segment_vertical  (x      ,y+l          ,g,s, seg(5));
  segment_horizontal(x+l    ,y+l+s+l      ,g,s, seg(6));
end observe;
