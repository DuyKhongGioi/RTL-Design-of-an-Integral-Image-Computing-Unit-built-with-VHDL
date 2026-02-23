library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity muxAddress is
	port (
	Sel: in std_logic;
	I0: in std_logic_vector (17 downto 0);
	I1: in std_logic_vector (17 downto 0);
	O: out std_logic_vector (17 downto 0)
	);
end muxAddress;

architecture behav of muxAddress is 
begin					 
	process (Sel, I0, I1)
	begin
		case Sel is
			when '0' =>
			O <= I0;
			when '1' =>
			O <= I1;
			when others => null;
		end case;
	end process;
end behav;

