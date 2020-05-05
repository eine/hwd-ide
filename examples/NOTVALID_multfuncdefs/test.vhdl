library work;
use work.screen_ghdl.all;

entity test_screen is
end test_screen;

architecture test of test_screen is
begin
  process
    variable i,j:integer;
  begin
    for j in 0 to x-1 loop
      pixel(x) := 16#FFFF00#;
    end loop;
    wait;
  end process;
end test;
