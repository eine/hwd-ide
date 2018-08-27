library work;
use work.screen_ghdl.all;

entity test_screen is
  generic ( g_x, g_y: integer:=0 );
end test_screen;

architecture test of test_screen is
begin
  process
    variable i,j:integer;
  begin
    for j in 0 to g_y-1 loop
      for i in 0 to g_x-1 loop
        pixel(j,i) := 16#FFFF00#;
      end loop;
    end loop;

    for j in (g_y/2)-200 to (g_y/2) loop
      for i in (g_x/2)-200 to (g_x/2) loop
        pixel(j,i) := 16#00FFFF#;
      end loop;
    end loop;

    save_pixels;
    wait;
  end process;
end test;
