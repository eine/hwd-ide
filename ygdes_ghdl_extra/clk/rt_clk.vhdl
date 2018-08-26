-- Fichier : rt_clk.vhdl
-- created by Yann Guidon / ygdes.com
-- jeu. avril 15 20:13:20 CEST 2010
-- version lun. juin 21 14:30:07 CEST 2010 : timing modified

-- rt_clk.vhdl : clock generator that is synchronised with the host computer
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

package rt_utils is
  procedure observe_std_ulogic
    (name: string; s:std_ulogic);

  procedure realtime_init(ms : integer);
    attribute foreign of realtime_init :
      procedure is "VHPIDIRECT realtime_init";

  impure function realtime_delay return integer;
    attribute foreign of realtime_delay :
      function is "VHPIDIRECT realtime_delay";

  procedure realtime_exit;
    attribute foreign of realtime_exit :
      procedure is "VHPIDIRECT realtime_exit";
end rt_utils;

package body rt_utils is

  procedure observe_std_ulogic
    (name: string; s:std_ulogic) is
  begin
    report name & "=" & std_ulogic'image(s);
  end procedure;

-- fonctions vides, dont le code est en C :

  procedure realtime_init(ms : integer) is
  begin
    assert false report "VHPI" severity failure;
  end realtime_init;

  impure function realtime_delay return integer is
  begin
    assert false report "VHPI" severity failure;
  end realtime_delay;

  procedure realtime_exit is
  begin
    assert false report "VHPI" severity failure;
  end realtime_exit;

end rt_utils;

-----------------------------------------------------------
------------------    the clock    ------------------------
-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.rt_utils.all;

entity rt_clk is
  generic(
    ms: integer:=500 -- default : 2*500ms=1s=1Hz
  );
  port(
    clk : inout std_ulogic:='0';
    -- clk est en mode "inout" pour qu'on puisse relire
    -- sa derniere valeur afin de la modifier.
    -- La valeur est initialisee a '0' car sinon
    -- elle est a 'U' par defaut, valeur qui donne
    -- elle-meme lorsqu'on effectue l'operation "not".

    stop: in  std_ulogic:='0'
    -- mettre a '1' pour arreter la simulation
  );
end entity;

architecture simple of rt_clk is
begin
  process is
  begin
    realtime_init(ms);
--    report "setting real time interval to "
--         & integer'image(ms) & "ms";

    while stop='0' loop
      wait for ms * 1000 us;
      while realtime_delay=0 loop
        wait for 0 ns;  -- tourne un peu a vide
      end loop;
      clk <= not clk;
    end loop;

    realtime_exit;
    wait;
  end process;
end simple;
