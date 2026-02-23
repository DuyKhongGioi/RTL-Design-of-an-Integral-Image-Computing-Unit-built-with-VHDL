library ieee;
use ieee.std_logic_1164.all;

entity controller is
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
end controller;
architecture fsm of controller is
type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16);
signal state: state_type;
begin
	--States transition process
	FSM: process (Reset, clock)
	begin
		if Reset = '1' then
			state <= S0;
		elsif clock'event and clock = '1' then
			case state is
				when S0 => 
					if Start = '1' then
						state <= S1;
					else 
						state <= S0;
					end if;
				when S1 =>
					state <= S2;
				when S2 => 	
					state <= S3;
				when S3 => 
					state <= S4;
				when S4 =>
					state <= S5;
				when S5 =>
					state <= S6;
				when S6 =>
					state <= S7;
				when S7 =>
					if isValid_Integral = '1' then
						state <= S8;
					else 
						state <= S10;
					end if;
				when S8 =>
					state <= S9;
				when S9 =>
					state <= S11;
				when S10 =>
					state <= S11;
				when S11 =>
					state <= S12;
				when S12 =>
					state <= S13;
				when S13 => 
					if isValid_Col = '1' then
						state <= S4;
					else 
						state <= S14;
					end if;
				when S14 =>
					state <= S15;
				when S15 =>
					if isValid_Row = '1' then
						state <= S4;
					else 
						state <= S16;
					end if;
				when S16 =>
					state <= S0;
			end case;
		end if;
	end process;
	
	--Combinational logic for output
	IIRinc <= '1' when state = S2 or state = S8 else '0';
	OIRinc <=  '1' when state = S12 else '0';
	SelIO <=  '1' when state = S11 else '0';
	Mre <=  '1' when state = S1 or state = S2 or state = S8 else '0';
	Mwe <=  '1' when state = S11 else '0';
	enRow <=  '1' when state = S3 or state = S14 else '0';
	enRowSize <=  '1' when  state = S2 else '0';
	enColSize <=  '1' when state = S3 else '0';
	enCol <=  '1' when state = S3 or state = S12 or state = S14 else '0'; --S12
	enCheckIntegral <=  '1' when state = S7 else '0';
	sel_row <=  '1' when state = S14 else '0';
	sel_col <=  '1' when state = S12 else '0'; --S12
	loadI2 <=  '1' when state = S9 or state = S10 else '0';
	loadI1 <=  '1' when state = S6 else '0';
	loadI0 <=  '1' when state = S4 else '0';	
	EnAdrLine <=  '1' when state = S3 or state = S12 or state = S14 else '0'; --S12
	Lre <=  '1' when state = S5 else '0';
	Lwe <=  '1' when state = S9 or state = S10 else '0';
	compute <=  '1' when state = S9 else '0';
	enRegOut <=  '1' when state = S9 or state = S10 else '0';
	done <=  '1' when state = S16 else '0';
end fsm;
	
