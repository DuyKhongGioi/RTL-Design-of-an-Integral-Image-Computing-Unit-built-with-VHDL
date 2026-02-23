library ieee;
use ieee.std_logic_1164.all;

entity microprocessor is
	port (
	clock: in std_logic;
	Start: in std_logic;
	Reset: in std_logic;
	inp: out std_logic_vector (23 downto 0);
	outp: out std_logic_vector (23 downto 0);	
	done: out std_logic
	);
end microprocessor;
architecture structural of microprocessor is

component datapath is
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
	enOutReg: in std_logic
	);
end component;
component control_unit is
	port (
	Start: in std_logic;
	clock: in std_logic;
	Reset: in std_logic;
	Mre: out std_logic;
	Mwe: out std_logic;
	enRow: out std_logic;
	enRowSize: out std_logic;
	enColSize: out std_logic;
	enCol: out std_logic;
	enCheckIntegral: out std_logic;
	sel_row: out std_logic;
	sel_col: out std_logic;
	loadI2: out std_logic;
	loadI1: out std_logic;
	loadI0: out std_logic;	
	EnAdrLine: out std_logic;
	Lre: out std_logic;
	Lwe: out std_logic;
	compute: out std_logic;
	enRegOut: out std_logic;
	isValid_Row: in std_logic;
	isValid_Col: in std_logic;
	isValid_Integral: in std_logic;
	done: out std_logic;
	address_out: out std_logic_vector (17 downto 0)
	);
end component;
component memory is
	port (
	clock: in std_logic;
	rst: in std_logic;
	Mre: in std_logic;
	Mwe: in std_logic;
	address: in std_logic_vector (17 downto 0);
	data_in: in std_logic_vector (23 downto 0);
	data_out: out std_logic_vector (23 downto 0)
	);
end component;

signal Mre_cpu, Mwe_cpu, enRow_cpu, enRowSize_cpu, enColSize_cpu,
enCol_cpu, enCheckIntegral_cpu, sel_row_cpu, sel_col_cpu, loadI2_cpu,
loadI1_cpu, loadI0_cpu, EnAdrLine_cpu, Lre_cpu, Lwe_cpu, compute_cpu, 
enRegOut_cpu, isValid_Row_cpu, isValid_Col_cpu, isValid_Integral_cpu : std_logic;
signal address_out_cpu: std_logic_vector (17 downto 0);
signal row_size_cpu, col_size_cpu: std_logic_vector (8 downto 0);
signal in_pixel_cpu, out_pixel_cpu: std_logic_vector (23 downto 0);

begin

	--DATAPATH
	DATAPATH_BLOCK:  datapath port map (
	clock => clock,
	enRow => enRow_cpu,
	enCol => enCol_cpu,
	enCheckIntegral => enCheckIntegral_cpu,
	Reset => Reset,
	row_size => in_pixel_cpu(8 downto 0),	
	enRowSize => enRowSize_cpu,
	col_size => in_pixel_cpu(8 downto 0),
	enColSize => enColSize_cpu,
	sel_row => sel_row_cpu,
	sel_col => sel_col_cpu,
	isValid_Row => isValid_Row_cpu,
	isValid_Col => isValid_Col_cpu,
	isValid_Integral => isValid_Integral_cpu,
	compute => compute_cpu,
	loadI2 => loadI2_cpu,
	loadI1 => loadI1_cpu,
	loadI0 => loadI0_cpu,
	in_pixel => in_pixel_cpu,-- Current input pixel
	EnAdrLine => EnAdrLine_cpu,
	Lre => Lre_cpu,
	Lwe => Lwe_cpu,
	out_pixel => out_pixel_cpu,
	enOutReg => enRegOut_cpu
	);
	--Controller Unit
	CONTROLLER: control_unit port map (
	Start => Start,
	clock => clock,
	Reset => Reset,
	Mre => Mre_cpu,
	Mwe => Mwe_cpu,
	enRow => enRow_cpu,
	enRowSize => enRowSize_cpu,
	enColSize => enColSize_cpu,
	enCol => enCol_cpu,
	enCheckIntegral => enCheckIntegral_cpu,
	sel_row => sel_row_cpu,
	sel_col => sel_col_cpu,
	loadI2 => loadI2_cpu,
	loadI1 => loadI1_cpu,
	loadI0 => loadI0_cpu,
	EnAdrLine => EnAdrLine_cpu,
	Lre => Lre_cpu,
	Lwe => Lwe_cpu,
	compute => compute_cpu,
	enRegOut => enRegOut_cpu,
	isValid_Row => isValid_Row_cpu,
	isValid_Col => isValid_Col_cpu,
	isValid_Integral => isValid_Integral_cpu,
	done => done,
	address_out => address_out_cpu
	);
	--MEMORY
	MEMORY_BLOCK: memory port map (
	clock => clock,
	rst => Reset, 
	Mre => Mre_cpu,
	Mwe => Mwe_cpu,
	address => address_out_cpu,
	data_in => out_pixel_cpu,
	data_out => in_pixel_cpu
	);
	outp <= out_pixel_cpu;
	inp <= in_pixel_cpu;
end structural;
