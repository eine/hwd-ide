package math is
  function sin (v : real) return real;
  attribute foreign of sin : function is "VHPIDIRECT sin";
end math;

package body math is
  function sin (v : real) return real is
  begin
    assert false severity failure;
  end sin;
end math;

entity math_tb is
end math_tb;

use work.math.all;
use std.textio.all;

architecture behav of math_tb is
begin
   process
     variable r : real;
     variable l : line;
   begin
     r := 0.0;
     for i in 0 to 10 loop
       write (l, string'("sin ("));
       write (l, r);
       write (l, string'(") = "));
       write (l, sin (r));
       writeline (output, l);
       r := r + 0.1;
     end loop;
     wait;
   end process;
end behav;
