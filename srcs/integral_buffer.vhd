library ieee;
use ieee.std_logic_1164.all;

entity integral_buffer is
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
end integral_buffer;
architecture structural of integral_buffer is
component reg24 is
	port (
	clock: in std_logic;
	D: in std_logic_vector (23 downto 0);
	En: in std_logic;
	Reset: in std_logic;
	Q: out std_logic_vector (23 downto 0)
	);
end component;

signal IP1_inter: std_logic_vector (23 downto 0);

begin
	IntegralPixel2: reg24 port map (
	clock => clock,
	D => IPixel_in2,
	En => loadI2,
	Reset => Reset,
	Q => IPixel_out2
	);
	IntegralPixel1: reg24 port map (
	clock => clock,
	D => IPixel_in1,
	En => loadI1,
	Reset => Reset,
	Q => IP1_inter
	);
	IntegralPixel0: reg24 port map (
	clock => clock,
	D => IP1_inter,
	En => loadI0,
	Reset => Reset,
	Q => IPixel_out0
	);
	IPixel_out1 <= IP1_inter;
end structural;
