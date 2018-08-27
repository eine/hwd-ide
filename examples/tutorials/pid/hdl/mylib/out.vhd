library ieee;
context ieee.ieee_std_context;

entity o is
  port ( CLK, RST, EN: in std_logic;
         I: in std_logic_vector(7 downto 0);
		 O: out std_logic_vector(7 downto 0)
	   );
end entity;

architecture arch of o is

begin

O <= I;

end arch;