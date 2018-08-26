-- file : test_fb.vhdl
-- created by Yann Guidon / ygdes.com
-- version 2010/06/05

library work;
use work.fb_ghdl.all;

entity test_fb is
end test_fb;

architecture test of test_fb is
begin
  process
  begin
    report " x=" & integer'image(fbx);
    report " y=" & integer'image(fby);
    report "xv=" & integer'image(fbxv);
    report "yv=" & integer'image(fbyv);

    -- Warning : fbp was available in a previous
    -- version of the code, it is now useless

    -- affiche un pixel vert+bleu
    -- fbp.all := 65535;
    wait;
  end process;
end test;
