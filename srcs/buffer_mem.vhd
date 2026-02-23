library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity buffer_mem is
	port (
	clock: in std_logic;
	rst: in std_logic;
	Mre: in std_logic;
	Mwe: in std_logic;
	address: in std_logic_vector (8 downto 0);
	data_in: in std_logic_vector (23 downto 0);
	data_out: out std_logic_vector (23 downto 0)
	);
end buffer_mem;

architecture behav of buffer_mem is
type buffer_type is array (0 to 511) of std_logic_vector (23 downto 0);
signal tmp_buffer: buffer_type;
begin
	write_process: process (clock, rst, Mre, address, data_in)
	begin
		if rst = '1' then
			tmp_buffer <= (------------------------------------------------
			--Initial first element for update window purpose
			0 => x"000001",
			others => x"000001");
		else
			if clock'event and clock = '1' then
				if Mwe = '1' and Mre = '0' then
					tmp_buffer(conv_integer(address)) <= data_in;
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
					data_out <= tmp_buffer(conv_integer(address));
				end if;
			end if;
		end if;
	end process;
end behav;

