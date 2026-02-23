library ieee;
use ieee.std_logic_1164.all;

entity reg9 is
	port (
	clock: in std_logic;
	D: in std_logic_vector (8 downto 0);
	En: in std_logic;
	Reset: in std_logic;
	Q: out std_logic_vector (8 downto 0)
	);
end reg9;
architecture behav of reg9 is
begin
	process (clock)
	begin
		if clock'event and clock = '1' then
			if Reset = '1' then
				Q <= (others => '0');
			elsif En = '1' then
				Q <= D;
			end if;
		end if;
	end process;
end behav;

