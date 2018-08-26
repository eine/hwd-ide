-- fichier fb_ghdl.vhdl
-- version ven. juil.  9 10:05:20 CEST 2010 : added get_color_depth()

-- fb_ghdl.vhdl : Framebuffer wrapper for graphic display on the host computer
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


package fb_ghdl is
  -- déclaration de la fonction en C
  function get_fb(f : integer) return integer;
    attribute foreign of get_fb :
      function is "VHPIDIRECT get_fb";
  function get_color_depth(expected_depth : integer) return integer;

  -- initialise les constantes
  constant fbx      : integer := get_fb(1);
  constant fbx1     : integer := fbx-1;
  constant fby      : integer := get_fb(2);
  constant fby1     : integer := fby-1;
  constant fbxv     : integer := get_fb(3);
  constant fbxv1    : integer := fbxv-1;
  constant fbyv     : integer := get_fb(4);
  constant fbdepth  : integer := get_color_depth(32);
  constant fbsize   : integer := get_fb(6);

  -- crée un tableau de pixels
  type screen_type is
    array(integer range 0 to fby1,
          integer range 0 to fbxv1) of integer;

  -- Définit un pointeur vers ce type :
  type screen_p is access screen_type; 

  -- alias permettant de retourner ce type :
  function get_fbp(f : integer) return screen_p;
    attribute foreign of get_fbp :
      function is "VHPIDIRECT get_fb";

  -- initialise l'adresse de l'écran
  shared variable pixel : screen_p := get_fbp(0);

  procedure save_pixels(n: string);

  -- Active le clignotement du curseur
  constant esc_cursor_on  : string := ESC & "[?c";
  -- Eteint le curseur
  constant esc_cursor_off : string := ESC & "[?17c";

end fb_ghdl;

package body fb_ghdl is
  function get_fb(f : integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end get_fb;
  function get_fbp(f : integer) return screen_p is
  begin
    assert false report "VHPI" severity failure;
  end get_fbp;

  function get_color_depth(expected_depth : integer) return integer is
    variable t : integer;
  begin
    t := get_fb(5);
    assert t = expected_depth
      report "framebuffer pixel depth is not " & integer'image(expected_depth)
      severity failure;
    return t;
  end get_color_depth;

  procedure save_pixels(n: string) is
    type screen_line is array(0 to (3*fbx)-1) of character;
    variable buff : screen_line;
    type screen_file is file of screen_line;
    file pixout : screen_file open write_mode is n;
    variable i,j,k,l: integer;
  begin
    for j in 0 to fby1 loop
      l:=0;
      -- collecte les composantes
      for i in 0 to fbx1 loop
        k:=pixel(j,i);
        buff(l  ):= character'val((k/65536) mod 256);
        buff(l+1):= character'val((k/256)   mod 256);
        buff(l+2):= character'val( k        mod 256);
        l:=l+3;
      end loop;
      -- écriture du tampon
      write(pixout,buff);
    end loop;
  end save_pixels;
end fb_ghdl;
