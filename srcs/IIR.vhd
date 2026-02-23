library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity IIR is
	port (
	Reset: in std_logic;
	IIRinc: in std_logic;
	Q: out std_logic_vector (17 downto 0)
	);
end IIR;
architecture behav of IIR is
signal tmp_IIR: std_logic_vector (17 downto 0);
begin
	process (Reset, IIRinc)
	begin
		if Reset = '1' then
			tmp_IIR <= "000000000000000000";
		elsif IIRinc'event and IIRinc = '1' then
			tmp_IIR <= tmp_IIR + 1;
		end if;
	end process;
	Q <= tmp_IIR;
end behav;
