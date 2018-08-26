-- sha-1.vhdl : microbenchmark pour simulation comportementale
-- création : 2011/02/01 par whygee@f-cpu.org
-- code dérivé du pseudo-code disponible à http://en.wikipedia.org/wiki/SHA-1

library work;
-- Décommenter l'une de ces 4 possibilités :

-- version integer simple :
--use work.int_ops.all;
--use work.int_integer.all;

-- version integer avec détection des dépassements :
--use work.int_ops.all;
--use work.int_integer_range.all;

-- version à base de bit_vector :
use work.int_bitvector.all;
library IEEE; use IEEE.numeric_bit.all;

-- version à base de std_ulogic_vector :
--use work.int_sulv.all;
--library IEEE; use IEEE.numeric_std.all;

entity sha1 is end sha1;

architecture comportement of sha1 is
begin
  process
    constant k1 : int_32 := from_int( 1518500249,32); -- sqrt( 2)*2^30
    constant k2 : int_32 := from_int( 1859775393,32); -- sqrt( 3)*2^30
    constant k3 : int_32 := from_int( -253476060,32); -- sqrt( 5)*2^30
    constant k4 : int_32 := from_int(-1247986134,32); -- sqrt(10)*2^30

    variable i, j: integer; -- compteurs de boucles
    variable h0 : int_32 := from_int(   19088743,32); -- 0x01234567
    variable h1 : int_32 := from_int(-1985229329,32); -- 0x89ABCDEF
    variable h2 : int_32 := from_int(  -19088744,32); -- 0xFEDCBA98
    variable h3 : int_32 := from_int( 1985229328,32); -- 0x76543210
    variable h4 : int_32 := from_int( -253635901,32); -- 0xF0E1D2C3
    variable A, B, C, D, E, F, k, t : int_32;

    type type_array80 is array(0 to 79) of int_32;
    variable w : type_array80;
  begin
    -- boucle principale (à faire varier pour prendre plus de temps) :
    for j in 0 to 200 loop
      -- expansion des 16 premiers mots :
      for i in 16 to 79 loop
        w(i) := (w(i-3) xor w(i-8) xor w(i-14) xor w(i-16)) rol 1;
      end loop;
      -- initialisation des variables :
      A:=h0; B:=h1; C:=h2; D:=h3; E:=h4;

      for i in 0 to 79 loop
        if i < 40 then
          if i < 20 then
            F := (B and C) or ((not B) and D);
            k := k1;
          else
            F := B xor C xor D;
            k := k2;
          end if;
        else
          if i < 60 then
            F := (B and C) or (B and D) or (C and D);
            k := k3;
          else
            F := B xor C xor D;
            k := k4;
          end if;
        end if;

        t := (A rol 5) + F + E + k + w(i);
        E := D;  D := C;
        C := B rol 30;
        B := A;  A := t;
      end loop;

      -- recombinaison des résultats :
      h0 := h0 + A;  h1 := h1 + B;
      h2 := h2 + C;  h3 := h3 + D;
      h4 := h4 + E;
    end loop;
    wait;
  end process;
end comportement;
