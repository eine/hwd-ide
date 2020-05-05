-- int_integer_range.vhdl
-- créé sam. janv. 29 12:11:00 CET 2011 par whygee@f-cpu.org
use work.int_ops.all;

package int_integer_range is
  subtype int_1  is integer range 0 to 1;
  subtype int_2  is integer range 0 to 3;
  subtype int_3  is integer range 0 to 7;
  subtype int_4  is integer range 0 to 15;
  subtype int_5  is integer range 0 to 31;
  subtype int_8  is integer range 0 to 255;
  subtype int_16 is integer range 0 to 65535;
  subtype int_32 is integer;

  function from_int(i, j : integer) return integer;
  function to_int(i : integer) return integer;
end package int_integer_range;

package body int_integer_range is
  function from_int(i, j : integer) return integer is
  begin
    if (i < 32) then
      assert i < (1 sll j)
        report "out of range integer : " & integer'image(i)
        severity error;
    end if;
    return i;
  end from_int;

  function to_int(i : integer) return integer is
  begin
    return i;
  end to_int;
end package body int_integer_range;

