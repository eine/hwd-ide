-- fichier ghdl_env.vhdl (C) Yann Guidon 2010
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


package ghdl_env is
  function getenv(s : string; d : integer) return integer;
  function getenvC2(s : string; d : integer) return integer;
    attribute foreign of getenvC2 :
        function is "VHPIDIRECT ghdl_envC2";
  function getenv(s : string) return string;
  function getenvS2(s : string) return string;
    attribute foreign of getenvS2 :
        function is "VHPIDIRECT ghdl_env_string";
end ghdl_env;

package body ghdl_env is
  -- fonction relais :
  function getenv(s : string; d : integer)
    return integer is
  begin  -- ajoute le 0 terminal :
    return getenvC2(s & NUL, d);
  end getenv;

  function getenvC2(s : string; d : integer)
    return integer is
  begin
    assert false report "VHPI" severity failure;
  end getenvC2;

  -- fonction relais :
  function getenv(s : string) return string is
  begin  -- ajoute le 0 terminal :
    return getenvS2(s & NUL);
  end getenv;

  function getenvS2(s : string) return string is
  begin
    assert false report "VHPI" severity failure;
  end getenvS2;
end ghdl_env;
