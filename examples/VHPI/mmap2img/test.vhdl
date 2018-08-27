library work;
use work.mmap_ghdl.all;

entity test_mmap is
end test_mmap;

architecture test of test_mmap is
begin
  process
    variable i,j:integer;
  begin
    for j in 0 to sy-1 loop
      for i in 0 to sx-1 loop
        pixel(j,i) := 16#FFFF00#;
      end loop;
    end loop;

    for j in (sy/2)-200 to (sy/2) loop
      for i in (sx/2)-200 to (sx/2) loop
        pixel(j,i) := 16#00FFFF#;
      end loop;
    end loop;

    save_pixels;
    wait;
  end process;
end test;
