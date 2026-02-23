library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity integral_compute is
	port (
	En: in std_logic;
	IPixel0: in std_logic_vector (23 downto 0);
	IPixel1: in std_logic_vector (23 downto 0);
	IPixel2: in std_logic_vector (23 downto 0);
	IPixel3: in std_logic_vector (23 downto 0);
	IPixel_out: out std_logic_vector (23 downto 0)
	);
end integral_compute;
architecture dataflow of integral_compute is
component TriState_Buffer is
	port (
	En: in std_logic;
	D: in std_logic_vector (23 downto 0);
	Y: out std_logic_vector (23 downto 0)
	);
end component;
signal temp1, temp2: std_logic_vector (23 downto 0);
signal temp3: std_logic_vector (23 downto 0);
begin
	temp1 <= IPixel3 + IPixel2;
	temp2 <= IPixel1 - IPixel0;
	temp3 <= temp1 + temp2;
	U1: TriState_Buffer port map (
	En => En,
	D =>temp3,
	Y => IPixel_out
	);
end dataflow;



	
