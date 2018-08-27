package random is
  function rand return integer;
  attribute foreign of rand : function is "VHPIDIRECT rand";
end random;

package body random is
  function rand return integer is
  begin
    assert false severity failure;
  end rand;
end random;

entity random_tb is
end random_tb;

use work.random.rand;
use std.textio.all;

architecture behav of random_tb is
begin
  process
    variable v : integer;
    variable l : line;
  begin
    for i in 1 to 10 loop
      v := rand;
      write (l, v);
      writeline (output, l);
    end loop;
    wait;
  end process;
end behav;
