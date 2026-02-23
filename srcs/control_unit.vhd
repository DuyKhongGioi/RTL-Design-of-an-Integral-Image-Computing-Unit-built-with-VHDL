library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
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
end control_unit;
architecture structural of control_unit is
component controller is
	port (
	Start: in std_logic;
	clock: in std_logic;
	Reset: in std_logic;
	IIRinc: out std_logic;
	OIRinc: out std_logic;
	SelIO: out std_logic;
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
	done: out std_logic;
	isValid_Row: in std_logic;
	isValid_Col: in std_logic;
	isValid_Integral: in std_logic
	);
end component;
component IIR is
	port (
	Reset: in std_logic;
	IIRinc: in std_logic;
	Q: out std_logic_vector (17 downto 0)
	);
end component;
component OIR is
	port (
	Reset: in std_logic;
	OIRinc: in std_logic;
	Q: out std_logic_vector (17 downto 0)
	);
end component;
component muxAddress is
	port (
	Sel: in std_logic;
	I0: in std_logic_vector (17 downto 0);
	I1: in std_logic_vector (17 downto 0);
	O: out std_logic_vector (17 downto 0)
	);
end component;

signal SelIO_temp, IIRinc_temp, OIRinc_temp: std_logic;
signal Iadr, Oadr: std_logic_vector (17 downto 0);
begin
	--Controller Block
	CB: controller port map (
	Start => Start,
	clock => clock,
	Reset => Reset,
	IIRinc => IIRinc_temp,
	OIRinc => OIRinc_temp,
	SelIO => SelIO_temp,
	Mre => Mre,
	Mwe => Mwe,
	enRow => enRow,
	enRowSize => enRowSize,
	enColSize => enColSize,
	enCol => enCol,
	enCheckIntegral => enCheckIntegral,
	sel_row => sel_row,
	sel_col => sel_col,
	loadI2 => loadI2,
	loadI1 => loadI1,
	loadI0 => loadI0,	
	EnAdrLine => EnAdrLine,
	Lre => Lre,
	Lwe => Lwe,
	compute => compute,
	enRegOut => enRegOut,
	done => done,
	isValid_Row => isValid_Row,
	isValid_Col => isValid_Col,
	isValid_Integral => isValid_Integral
	);
	-- Input Image Register Block
	IIRB: IIR port map (
	Reset => Reset,
	IIRinc => IIRinc_temp,
	Q => Iadr
	);
	-- Output Image Register Block
	OIRB: OIR port map (
	Reset => Reset,
	OIRinc => OIRinc_temp,
	Q => Oadr
	);
	-- Mux Image Address Block
	MIAB: muxAddress port map (
	Sel => SelIO_temp,
	I0 => Iadr,
	I1 => Oadr, 
	O => address_out
	);
end structural;
