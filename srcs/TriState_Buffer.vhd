library ieee;
use ieee.std_logic_1164.all;

entity TriState_Buffer is
	port (
	En: in std_logic;
	D: in std_logic_vector (23 downto 0);
	Y: out std_logic_vector (23 downto 0)
	);
end TriState_Buffer;
architecture Behav of TriState_Buffer is
begin
	Y <= D when En = '1' else (others => 'Z');
end Behav;
