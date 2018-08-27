entity disptree is
  port (o : out bit);
end disptree;

entity sub_dp is
  port (sub_o : out bit;
        sub_i : in bit);
end sub_dp;

architecture sub_behav of sub_dp is
begin
   sub_o <= sub_i;
end sub_behav;

configuration sub_conf of sub_dp is
  for sub_behav
  end for;
end sub_conf;

architecture behav of disptree is
  signal i1 : bit;
  signal i2, i3, i4, i5 : bit;
  procedure check is
  begin
    null;
  end check;
  constant bt : boolean := true;
  constant bf : boolean := true;
  component comp
    port (sub_o : out bit;
          sub_i : in bit);
  end component;
  for inst4 : comp use entity work.sub_dp;
begin
  check;
  pc1 : check;

  gc1: if bt generate
    gc1_proc: process
    begin
      wait;
    end process;
  end generate;

  gc2: if bf generate
    gc2_proc: process
    begin
      wait;
    end process;
  end generate;

  bl1: block
    port (p1 : bit);
    port map (p1 => i1);
  begin
    bl1_pc1: check;
    bl1_proc2 : process
    begin
      wait;
    end process;
  end block bl1;

  inst1 : entity work.sub_dp port map (sub_o => i2, sub_i => i1);
  inst2 : entity work.sub_dp (sub_behav) port map (sub_o => i3, sub_i => i2);
  inst3 : configuration work.sub_conf  port map (sub_o => i4, sub_i => i3);
  inst4 : comp port map (sub_o => i5, sub_i => i4);
end behav;
