package screen_ghdl is
-->
  type dummy_type is record
    d: bit;
  end record;

  type dummy_p is access dummy_type;

  function get_s(f : integer) return dummy_p;
    attribute foreign of get_s :
      function is "VHPIDIRECT get_p";
---<

  function get_p(f : integer) return integer;
    attribute foreign of get_p :
      function is "VHPIDIRECT get_p";

  constant x: integer := get_p(1);
  type screen_type is array(integer range 0 to x) of integer;
  type screen_p is access screen_type;

  function get_m(f : integer) return screen_p;
    attribute foreign of get_m :
      function is "VHPIDIRECT get_p";

  shared variable pixel: screen_p := get_m(0);
end screen_ghdl;

package body screen_ghdl is
--->
  function get_s(f : integer) return dummy_p is begin
    assert false report "VHPI" severity failure;
  end get_s;
---<

function get_p(f : integer) return integer is begin
    assert false report "VHPI" severity failure;
  end get_p;
  function get_m(f : integer) return screen_p is begin
    assert false report "VHPI" severity failure;
  end get_m;
end screen_ghdl;
