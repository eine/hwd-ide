-- fichier ghdl_access.vhdl
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

package ghdl_access is
  -- Définit un pointeur vers un entier :
  type int_access is access integer;

  -- déclaration des fonctions en C
  function get_ptr return int_access;
    attribute foreign of get_ptr :
      function is "VHPIDIRECT get_ptr";

  procedure change_int(f : integer);
    attribute foreign of change_int :
      procedure is "VHPIDIRECT change_int";

  -- crée une variable aliasée vers la variable en C  
  shared variable my_data : int_access := get_ptr;
end ghdl_access;

package body ghdl_access is
  function get_ptr return int_access is
  begin
    assert false report "VHPI" severity failure;
  end get_ptr;
  procedure change_int(f : integer) is
  begin
    assert false report "VHPI" severity failure;
  end change_int;
end ghdl_access;
