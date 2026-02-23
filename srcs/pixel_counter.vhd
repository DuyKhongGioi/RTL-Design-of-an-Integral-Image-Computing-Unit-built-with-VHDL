library ieee;
use ieee.std_logic_1164.all;

entity pixel_counter is
	port (
	clock: in std_logic;
	enRow: in std_logic;
	enCol: in std_logic;
	enCheckIntegral: in std_logic;
	Reset: in std_logic;
	row_size: in std_logic_vector (8 downto 0);
	enRowSize: in std_logic;
	col_size: in std_logic_vector (8 downto 0);
	enColSize: in std_logic;
	sel_row: in std_logic;
	sel_col: in std_logic;
	isValid_Row: out std_logic;
	isValid_Col: out std_logic;
	isValid_Integral: out std_logic
	--
	--row_i, col_i: out std_logic_vector (8 downto 0)
	);
end pixel_counter;
architecture structural of pixel_counter is
component adder is
	port (
	input: in std_logic_vector (8 downto 0);
	output: out std_logic_vector (8 downto 0)
	);
end component;
component mux2to1_9bit is
	port (
	Sel: in std_logic;
	I0: in std_logic_vector (8 downto 0);
	I1: in std_logic_vector (8 downto 0);
	O: out std_logic_vector (8 downto 0)
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
component comparator is
	port (
	X: in std_logic_vector (8 downto 0);
	Y: in std_logic_vector (8 downto 0);
	G: out std_logic
	);
end component;
component and_entity is
	port (
	En: in std_logic;
	In1: in std_logic;
	In2: in std_logic;
	and_out: out std_logic
	);
end component;

signal regRow_in, regCol_in: std_logic_vector (8 downto 0);
signal regRow_out, regCol_out: std_logic_vector (8 downto 0);
signal regRow_1, regCol_1: std_logic_vector (8 downto 0);
signal isValid_Integral_1, isValid_Integral_2: std_logic;
signal rowSize, colSize: std_logic_vector (8 downto 0);

begin
	rowCounter: adder port map (
	input => regRow_out,
	output => regRow_1
	);
	mux_row: mux2to1_9bit port map (
	Sel => sel_row,
	I0 => "000000000",
	I1 => regRow_1,
	O => regRow_in
	);
	rowReg: reg9 port map (
	clock => clock,
	D => regRow_in,
	En => enRow,
	Reset => Reset,
	Q => regRow_out
	);
	rowSizeReg: reg9 port map (
	clock => clock,
	D => row_size,
	En => enRowSize,
	Reset => Reset,
	Q => rowSize
	);
	Row_comparator: comparator port map (
	X => rowSize,
	Y => regRow_out,
	G => isValid_Row
	);
	Integral_comparator1: comparator port map (
	X => regRow_out,
	Y => "000000000",
	G => isValid_Integral_1
	);
	colCounter: adder port map (
	input => regCol_out,
	output => regCol_1
	);
	mux_col: mux2to1_9bit port map (
	Sel => sel_col,
	I0 => "000000000",
	I1 => regCol_1,
	O => regCol_in
	);
	colReg: reg9 port map (
	clock => clock,
	D => regCol_in,
	En => enCol,
	Reset => Reset,
	Q => regCol_out
	);
	colSizeReg: reg9 port map (
	clock => clock,
	D => col_size,
	En => enColSize,
	Reset => Reset,
	Q => colSize
	);
	Col_comparator: comparator port map (
	X => colSize,
	Y => regCol_out,
	G => isValid_Col
	);
	Integral_comparator2: comparator port map (
	X => regCol_out,
	Y => "000000000",
	G => isValid_Integral_2
	);
	Integral_check: and_entity port map (
	En => enCheckIntegral,
	In1 => isValid_Integral_1,
	In2 => isValid_Integral_2,
	and_out => isValid_Integral
	);
	--row_i <= regRow_out;
	--col_i <= regCol_out;
end structural;
