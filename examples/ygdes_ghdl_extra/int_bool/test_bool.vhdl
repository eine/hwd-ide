-- test_bool.vhdl
use work.int_ops.all;

entity test_bool is end test_bool;

architecture test of test_bool is
begin
  process
    variable a, b, c : integer;
  begin
    b := 5;  c := 12;
    a := b nand c;  report "nand: " & integer'image(a);
    a := b  and c;  report " and: " & integer'image(a);
    a := b nor  c;  report " nor: " & integer'image(a);
    a := b  or  c;  report " or : " & integer'image(a);
    a := b xor  c;  report " xor: " & integer'image(a);
    a := b  sll c;  report " sll: " & integer'image(a);
    a := b  srl c;  report " srl: " & integer'image(a);
    a := b  sra c;  report " sra: " & integer'image(a);
    wait;
  end process;
end test;
