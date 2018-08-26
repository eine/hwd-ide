-- file : test_fb2.vhdl
-- created by Yann Guidon / ygdes.com
-- version 2010/06/05

library work;
use work.fb_ghdl.all;

entity test_fb2 is
end test_fb2;

architecture test of test_fb2 is
begin
  process
    variable i,j:integer;
  begin
    -- affiche un carre cyan
    for j in (fby/2)-100 to (fby/2)+100 loop
      for i in (fbx/2)-100 to (fbx/2)+100 loop
        pixel(j,i) := 16#FFFF#;
      end loop;
    end loop;
    wait;
  end process;
end test;
