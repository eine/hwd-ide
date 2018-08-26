-- fichier ghdl_direct.vhdl
-- created by Yann Guidon / ygdes.com
-- version jeu. avril 10 01:03:13 CEST 2014

-- Copyright (C) 2014 Yann GUIDON
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

package ghdl_direct is
  procedure change_int(f : integer);
    attribute foreign of change_int :
      procedure is "VHPIDIRECT change_int";

  shared variable my_var : integer := 43;
end ghdl_direct;

package body ghdl_direct is
  procedure change_int(f : integer) is
  begin
    assert false report "VHPI" severity failure;
  end change_int;
end ghdl_direct;
