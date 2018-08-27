-- Without integer boolean operations, the generated code is very ugly
-- (see test_opt.s for the resulting assembly code)

entity test_opt is end test_opt;

architecture test of test_opt is
begin
  process
    variable a, b, c, d, e, f : integer := 1;

    function decalage_droit(a,i : integer) return integer is
    begin
      return a / (2**i);
    end decalage_droit;

    function decalage_gauche(a,i : integer) return integer is
    begin
      return a * (2**i);
    end decalage_gauche;

    function lsb(a,i : integer) return integer is
    begin
      return a mod (2**i);
    end lsb;

  begin
    a := b * (2**6);
    c := d mod 2;
    e := f / (2**7);
    report "ok !";
    wait;
  end process;
end test;
