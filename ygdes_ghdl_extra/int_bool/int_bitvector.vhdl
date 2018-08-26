-- int_bitvector.vhdl
-- créé sam. janv. 29 12:11:00 CET 2011 par whygee@f-cpu.org

library IEEE;
use IEEE.numeric_bit.all;

package int_bitvector is
  subtype int_1  is unsigned( 0 downto 0);
  subtype int_2  is unsigned( 1 downto 0);
  subtype int_3  is unsigned( 2 downto 0);
  subtype int_4  is unsigned( 3 downto 0);
  subtype int_5  is unsigned( 4 downto 0);
  subtype int_8  is unsigned( 7 downto 0);
  subtype int_16 is unsigned(15 downto 0);
  subtype int_32 is unsigned(31 downto 0);

  function from_int(i, j : integer) return unsigned;
  function to_int(i : unsigned) return integer;
end package int_bitvector;

package body int_bitvector is
  function from_int(i, j : integer) return unsigned is
  begin
    return unsigned(to_signed(i,j));
  end from_int;

  function to_int(i : unsigned) return integer is
  begin
    return to_integer(i);
  end to_int;
end package body int_bitvector;
