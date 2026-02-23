library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port(
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
	isValid_Integral: out std_logic;
	compute: in std_logic;
	loadI2: in std_logic;
	loadI1: in std_logic;
	loadI0: in std_logic;
	in_pixel: in std_logic_vector (23 downto 0); -- Current input pixel
	EnAdrLine: in std_logic;
	Lre: in std_logic;
	Lwe: in std_logic;
	out_pixel: out std_logic_vector (23 downto 0);
	--win2, win1, win0, line_o: out std_logic_vector (23 downto 0);
	--
	--row_i, col_i, adrline : out std_logic_vector (8 downto 0);
	enOutReg: in std_logic
	);
end datapath;

architecture structural of datapath is

component pixel_counter is
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
	--row_i, col_i: out std_logic_vector (8 downto 0)
	);
end component;
component integral_buffer is
	port (
	clock: in std_logic;
	Reset: in std_logic;
	--selI2: in std_logic;
	loadI2: in std_logic;
	loadI1: in std_logic;
	loadI0: in std_logic;
	IPixel_in1: in std_logic_vector (23 downto 0);
	IPixel_in2: in std_logic_vector (23 downto 0);
	IPixel_out0: out std_logic_vector (23 downto 0);
	IPixel_out1: out std_logic_vector (23 downto 0);
	IPixel_out2: out std_logic_vector (23 downto 0)
	);
end component;
component line_buffer is
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
end component;
component integral_compute is
	port (
	En: in std_logic;
	IPixel0: in std_logic_vector (23 downto 0);
	IPixel1: in std_logic_vector (23 downto 0);
	IPixel2: in std_logic_vector (23 downto 0);
	IPixel3: in std_logic_vector (23 downto 0);
	IPixel_out: out std_logic_vector (23 downto 0)
	);
end component;
component mux2to1 is
	port (
	Sel: in std_logic;
	I0: in std_logic_vector (23 downto 0);
	I1: in std_logic_vector (23 downto 0);
	O: out std_logic_vector (23 downto 0)
	);
end component;
component reg24 is
	port (
	clock: in std_logic;
	D: in std_logic_vector (23 downto 0);
	En: in std_logic;
	Reset: in std_logic;
	Q: out std_logic_vector (23 downto 0)
	);
end component;

signal isValid_out: std_logic;
signal linePixel: std_logic_vector (23 downto 0);
signal IPixel_temp0, IPixel_temp1, IPixel_temp2: std_logic_vector (23 downto 0);
signal IPixel_out_temp: std_logic_vector (23 downto 0);
signal out_pixel_temp: std_logic_vector (23 downto 0);
begin
	--Component: Pixel Counter Block
	PCB: pixel_counter port map (
	clock => clock,
	enRow => enRow,
	enCol => enCol,
	enCheckIntegral => enCheckIntegral,
	Reset => Reset,
	row_size => row_size,
	enRowSize => enRowSize,
	col_size => col_size,
	enColSize => enColSize,
	sel_row => sel_row,
	sel_col => sel_col,
	isValid_Row => isValid_Row,
	isValid_Col => isValid_Col,
	isValid_Integral => isValid_out
	---row_i => row_i,
	--col_i => col_i
	);
	--Component: Integral Buffer Block
	IBB: integral_buffer port map (
	clock => clock,
	Reset => Reset,
	loadI2 => loadI2,
	loadI1 => loadI1,
	loadI0 => loadI0,
	IPixel_in1 => linePixel,
	IPixel_in2 => out_pixel_temp,
	IPixel_out0 => IPixel_temp0,
	IPixel_out1 => IPixel_temp1,
	IPixel_out2 => IPixel_temp2
	);
	--Component: Line Buffer Block
	LBB: line_buffer port map (
	clock => clock,
	Reset => Reset,
	EnAdr => EnAdrLine,
	Lre => Lre,
	Lwe => Lwe,
	selAdr => sel_col,
	input => out_pixel_temp,
	line_out => linePixel
	--adrline => adrline
	);
	--Component: Integral Compute Block
	ICB: integral_compute port map (
	En => compute,
	IPixel0 => IPixel_temp0,
	IPixel1 => IPixel_temp1,
	IPixel2 => IPixel_temp2,
	IPixel3 => in_pixel,
	IPixel_out => IPixel_out_temp
	);
	--Component: MUX Padding or Valid
	MPV: mux2to1 port map (
	Sel => compute,
	I0 => x"000000",
	I1 => IPixel_out_temp,
	O => out_pixel_temp
	);
	--Component: Output Register Block
	ORB:  reg24 port map (
	clock => clock,
	D => out_pixel_temp,
	En => enOutReg,
	Reset => Reset,
	Q => out_pixel
	);
	
	isValid_Integral <= isValid_out;	
	--win2 <= IPixel_temp2;
	--win1 <= IPixel_temp1;
	--win0 <= IPixel_temp0;
	--line_o <= linePixel;
	
end structural;
