-- fichier testenv.vhdl (C) Yann Guidon 2010
-- version jeu. sept.  2 06:38:43 CEST 2010
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

use work.ghdl_env.all;

entity testEnv is
  generic(
    environnement: string := "GHDL";
    -- exemple d'initialisation très anticipée :
    Test_nr : integer := getenv("TEST_NR", 1);
    -- définition de la taille d'un tableau :
    table_size : integer := getenv("TABLESIZE",24)
  );
end testEnv;

architecture test of testEnv is
  type int_table is
    array (integer range 0 to table_size) of integer;
  signal table : int_table;
begin
  process
    variable a, i: integer;
  begin
    -- exemple de lecture explicite :
    a := getenv(environnement, 5);
    for i in 1 to a loop
      report "La variable " & environnement
         & " est égale à " & integer'image(a);
    end loop;
    report "$PATH=" & getenv("PATH");
    report "$PIKA=" & getenv("PIKA");
    wait;
  end process;

  Test1: if Test_nr=1 generate
    assert false report "test par défaut" severity note;
  end generate;

  Test2: if Test_nr=2 generate
    assert false report "test n°2 lancé !" severity note;
  end generate;
end test;
