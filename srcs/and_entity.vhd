library ieee;
use ieee.std_logic_1164.all;

entity and_entity is
	port (
	En: in std_logic;
	In1: in std_logic;
	In2: in std_logic;
	and_out: out std_logic
	);
end and_entity;
architecture behav of and_entity is
begin
	process (En, In1, In2) 
	begin
		if En = '1' then
			and_out <= In1 and In2;
		else 
			and_out <= '0';
		end if;
	end process;
end behav;
