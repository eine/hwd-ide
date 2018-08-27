package mmap_ghdl is
  type dummy_type is record
    d: bit;
  end record;

  type dummy_p is access dummy_type;

  function get_s(f : integer) return dummy_p;
    attribute foreign of get_s :
      function is "VHPIDIRECT get_p";

--

  function get_p(f : integer) return integer;
    attribute foreign of get_p :
      function is "VHPIDIRECT get_p";

  constant sx: integer := get_p(1);
  constant sy: integer := get_p(2);

  type screen_type is
    array(integer range 0 to sy-1,
          integer range 0 to sx-1) of integer;

  type screen_p is access screen_type;

  function get_mp(f : integer) return screen_p;
    attribute foreign of get_mp :
      function is "VHPIDIRECT get_p";

  shared variable pixel: screen_p := get_mp(0);

  procedure save_pixels;
    attribute foreign of save_pixels :
      procedure is "VHPIDIRECT save_pixels";
end mmap_ghdl;

package body mmap_ghdl is
  function get_s(f : integer) return dummy_p is begin
    assert false report "VHPI" severity failure;
  end get_s;

---

  function get_p(f : integer) return integer is begin
    assert false report "VHPI" severity failure;
  end get_p;
  function get_mp(f : integer) return screen_p is begin
    assert false report "VHPI" severity failure;
  end get_mp;
  procedure save_pixels is begin
    assert false report "VHPI" severity failure;
  end save_pixels;
end mmap_ghdl;
