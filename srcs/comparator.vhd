library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity comparator is
	port (
	X: in std_logic_vector (8 downto 0);
	Y: in std_logic_vector (8 downto 0);
	G: out std_logic
	);
end comparator;

architecture dataflow of comparator is
begin
	G <= '1' when (X > Y) else '0';
end dataflow;
	
