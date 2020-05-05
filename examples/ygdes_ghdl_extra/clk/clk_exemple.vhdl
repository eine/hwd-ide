-- Fichier : clk_exemple.vhdl
-- created by Yann Guidon / ygdes.com
-- jeu. avril 15 15:28:24 CEST 2010
-- jeu. avril 15 21:05:36 CEST 2010

-- clk_exemple.vhdl : just an example for the use of the synchronised clock generator
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


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.rt_utils.all;

entity clk_exemple is
  -- rien
end entity;

architecture exemple of clk_exemple is
  -- ne pas oublier d'initialiser clk
  -- sinon l'horloge ne peut pas osciller
  -- aussi, stop doit etre maintenu à '0'
  signal clk, stop: std_ulogic:='0';

begin
  -- instanciation de l'horloge :
  horloge : entity work.rt_clk
    generic map(ms => 500)
    port map(clk => clk, stop => stop);

  process(clk) is
    variable compteur: integer := 0;
  begin
    if rising_edge(clk) then
      compteur := compteur + 1;
      if compteur > 10 then
        stop <= '1';
      end if;
    end if;
  end process;

  observe_std_ulogic("clk",clk);

end exemple;


