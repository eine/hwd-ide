library work;
use work.pkg_access.all;

entity access_test is
end access_test;

architecture test of access_test is
begin
  process
  begin
    for x in 0 to 4 loop
      report "integer=" &  integer'image(arr(x));
    end loop;
    wait;
  end process;
end test;
