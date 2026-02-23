library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity OIR is
	port (
	Reset: in std_logic;
	OIRinc: in std_logic;
	Q: out std_logic_vector (17 downto 0)
	);
end OIR;
architecture behav of OIR is
signal tmp_OIR: std_logic_vector (17 downto 0);
begin
	process (Reset, OIRinc)
	begin
		if Reset = '1' then
			tmp_OIR <= "010000000000000000";
		elsif OIRinc'event and OIRinc = '1' then
			tmp_OIR <= tmp_OIR + 1;
		end if;
	end process;
	Q <= tmp_OIR;
end behav;
