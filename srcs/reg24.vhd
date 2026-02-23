library ieee;
use ieee.std_logic_1164.all;

entity reg24 is
	port (
	clock: in std_logic;
	D: in std_logic_vector (23 downto 0);
	En: in std_logic;
	Reset: in std_logic;
	Q: out std_logic_vector (23 downto 0)
	);
end reg24;
architecture behavioral of reg24 is
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
end behavioral;

