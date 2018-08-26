-- int_integer.vhdl
-- créé sam. janv. 29 12:11:00 CET 2011 par whygee@f-cpu.org

package int_integer is
  subtype int_1  is integer;
  subtype int_2  is integer;
  subtype int_3  is integer;
  subtype int_4  is integer;
  subtype int_5  is integer;
  subtype int_8  is integer;
  subtype int_16 is integer;
  subtype int_32 is integer;

  function from_int(i, j : integer) return integer;
  function to_int(i : integer) return integer;
end package int_integer;

package body int_integer is
  function from_int(i, j : integer) return integer is
  begin
    return i;
  end from_int;

  function to_int(i : integer) return integer is
  begin
    return i;
  end to_int;
end package body int_integer;
