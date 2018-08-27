package pkg_access is
  type array_type is
    array(integer range 0 to 100) of integer;

  type array_p is access array_type;

  function get_p return array_p;
    attribute foreign of get_p :
      function is "VHPIDIRECT get_p";

  shared variable arr: array_p := get_p;
end pkg_access;

package body pkg_access is
  function get_p return array_p is
  begin
    assert false report "VHPI" severity failure;
  end get_p;
end pkg_access;
