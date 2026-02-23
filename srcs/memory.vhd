library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity memory is
	port (
	clock: in std_logic;
	rst: in std_logic;
	Mre: in std_logic;
	Mwe: in std_logic;
	address: in std_logic_vector (17 downto 0);
	data_in: in std_logic_vector (23 downto 0);
	data_out: out std_logic_vector (23 downto 0)
	);
end memory;

architecture behav of memory is
type mem_type is array (0 to 262143) of std_logic_vector (23 downto 0);
signal tmp_mem: mem_type;
begin
	write_process: process (clock, rst, Mre, address, data_in)
	begin
		if rst = '1' then
			tmp_mem <= (------------------------------------------------
			--Initial image data
			0 => x"000006", 1 => x"000006",
			2 => x"000011", 3 => x"000018", 4 => x"000001", 5 => x"000008", 6 => x"00000F",
			7 => x"000017", 8 => x"000005", 9 => x"000007", 10 => x"00000E", 11 => x"000010",
			12 => x"000004", 13 => x"000006", 14 => x"00000D", 15 => x"000014", 16 => x"000016",
			17 => x"00000A", 18 => x"00000C", 19 => x"000013", 20 => x"000015", 21 => x"000003",
			22 => x"00000B", 23 => x"000012", 24 => x"000019", 25 => x"000002", 26 => x"000009",
	
			others => x"000000");
		else
			if clock'event and clock = '1' then
				if Mwe = '1' and Mre = '0' then
					tmp_mem(conv_integer(address)) <= data_in;
				end if;
			end if;
		end if;
	end process;
	
	read_process: process (clock, rst, Mwe, address)
	begin
		if rst = '1' then 
			data_out <= (others =>'Z');
		else 
			if clock'event and clock = '1' then
				if Mre = '1' and Mwe = '0' then
					data_out <= tmp_mem(conv_integer(address));
				end if;
			end if;
		end if;
	end process;
end behav;

