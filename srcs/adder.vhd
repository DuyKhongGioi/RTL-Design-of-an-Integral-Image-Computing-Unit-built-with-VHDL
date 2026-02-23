library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adder is
	port (
	input: in std_logic_vector (8 downto 0);
	output: out std_logic_vector (8 downto 0)
	);
end adder;
architecture dataflow of adder is
begin
	output <= input + 1;
end dataflow;
	

