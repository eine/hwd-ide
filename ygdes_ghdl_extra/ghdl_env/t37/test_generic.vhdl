-- test_generic.vhdl
-- created ven. déc.  8 15:55:14 CET 2017 by whygee@f-cpu.org
-- just to test https://sourceforge.net/p/ghdl-updates/tickets/37/
-- 
-- Tristan Gingold - 2015-03-07
-- 
-- Hello,
-- the enhancement is now implemented (at least for string generic):
-- it is possible to override a top entity generic using -gNAME=VALUE switch:
-- 
-- ghdl -r dispgen -gstr=Hello
-- 
-- I have added a test in ticket37
-- 
-- > The -g flag seems only supported by the --elab-run command and not by the -e command.
-- This is expected. The -g switch is handled by -r.
--
--
-- [yg@localhost t37]$ ghdl -e test_generic
-- [yg@localhost t37]$ ghdl -e test_generic
-- [yg@localhost t37]$ ./test_generic 
-- test_generic.vhdl:34:5:@0ms:(report note): default message
-- [yg@localhost t37]$ ./test_generic "-gmessage=Hello World"
-- test_generic.vhdl:34:5:@0ms:(report note): Hello World
--

entity test_generic is
  generic (
    message: string := "default message"
  );
end test_generic;

architecture test of test_generic is
begin

  test: process
  begin
    report message;
    wait;
  end process;

end test;




