library ieee;
use ieee.std_logic_1164.all;

entity line_buffer is
	port (
	clock: in std_logic;
	Reset: in std_logic;
	EnAdr: in std_logic;
	Lre: in std_logic;
	Lwe: in std_logic;
	selAdr: in std_logic;
	--selIn: in std_logic;
	input: in std_logic_vector (23 downto 0);
	line_out: out std_logic_vector (23 downto 0)
	--adrline: out std_logic_vector (8 downto 0)
	);
end line_buffer;
architecture structural of line_buffer is
component buffer_mem
	port (
	clock: in std_logic;
	rst: in std_logic;
	Mre: in std_logic;
	Mwe: in std_logic;
	address: in std_logic_vector (8 downto 0);
	data_in: in std_logic_vector (23 downto 0);
	data_out: out std_logic_vector (23 downto 0)
	);
end component;
component reg9 is
	port (
	clock: in std_logic;
	D: in std_logic_vector (8 downto 0);
	En: in std_logic;
	Reset: in std_logic;
	Q: out std_logic_vector (8 downto 0)
	);
end component;
component mux2to1_9bit
	port (
	Sel: in std_logic;
	I0: in std_logic_vector (8 downto 0);
	I1: in std_logic_vector (8 downto 0);
	O: out std_logic_vector (8 downto 0)
	);
end component;
component adder
	port (
	input: in std_logic_vector (8 downto 0);
	output: out std_logic_vector (8 downto 0)
	);
end component;
signal Adreg_in, Adreg_out: std_logic_vector (8 downto 0);
signal Adrmux1: std_logic_vector (8 downto 0);
begin
	Address_register: reg9 port map (
	clock => clock,
	D => Adreg_in,
	En => EnAdr,
	Reset => Reset,
	Q => Adreg_out
	);
	AdrAdder: adder port map (
	input => Adreg_out,
	output => Adrmux1
	);
	MuxAdr: mux2to1_9bit port map (
	Sel => selAdr,
	I0 => "000000000",
	I1 => Adrmux1,
	O => Adreg_in
	);
	line_mem: buffer_mem port map (
	clock => clock,
	rst => Reset,
	Mre => Lre,
	Mwe => Lwe,
	address => Adreg_out,
	data_in => input,
	data_out => line_out
	);
	--adrline <= Adreg_out;
end structural;
	

