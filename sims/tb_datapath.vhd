library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity tb_datapath is
end tb_datapath;

architecture behavior of tb_datapath is

    -- Component under test
    component datapath
        port (
            clock: in std_logic;
            enRow: in std_logic;
            enCol: in std_logic;
            enCheckIntegral: in std_logic;
            Reset: in std_logic;
            row_size: in std_logic_vector(8 downto 0);   
	    enRowSize: in std_logic; 
            col_size: in std_logic_vector(8 downto 0);
	    enColSize: in std_logic;
            sel_row: in std_logic;
            sel_col: in std_logic;
            isValid_Col: out std_logic;
            isValid_Integral: out std_logic;
            loadI2: in std_logic;
            loadI1: in std_logic;
            loadI0: in std_logic;
            in_pixel: in std_logic_vector (23 downto 0);
            EnAdrLine: in std_logic;
            Lre: in std_logic;
            Lwe: in std_logic;
            out_pixel: out std_logic_vector (23 downto 0);
            --done: out std_logic;
           -- ready: out std_logic;
	--win2, win1, win0, line_o: out std_logic_vector (23 downto 0);
	--row_i, col_i, adrline: out std_logic_vector (8 downto 0);
	enOutReg: in std_logic;
	compute: std_logic
        );
    end component;

    -- Signals to drive datapath
    signal clock, enRow, enCol, enCheckIntegral, Reset: std_logic := '0';
    signal sel_row, sel_col: std_logic := '0';
    signal loadI2, loadI1, loadI0: std_logic := '0';
    signal EnAdrLine, Lre, Lwe: std_logic := '0';
    signal row_size ,col_size: std_logic_vector(8 downto 0) := (others => '0');
    signal in_pixel: std_logic_vector(23 downto 0) := (others => '0');
    signal out_pixel: std_logic_vector(23 downto 0);
    signal isValid_Col, isValid_Integral, done, ready: std_logic;
	--signal row_i, col_i, adrline: std_logic_vector (8 downto 0) := (others => '0');
	signal enOutReg :std_logic := '0';
	signal compute: std_logic := '0';
	signal enRowSize,enColSize: std_logic := '0';
begin

    -- DUT instantiation
    uut: datapath
        port map (
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
            isValid_Col => isValid_Col,
            isValid_Integral => isValid_Integral,
            loadI2 => loadI2,
            loadI1 => loadI1,
            loadI0 => loadI0,
            in_pixel => in_pixel,
            EnAdrLine => EnAdrLine,
            Lre => Lre,
            Lwe => Lwe,
            out_pixel => out_pixel,
           -- done => done,
            --ready => ready,
	--win2 => win2, win1 => win1, win0 => win0, line_o => line_o,
	--row_i => row_i,
	--col_i =>col_i,
	enOutReg => enOutReg,
	--adrline => adrline,
	compute => compute
        );

    -- Clock generation
    clock_process : process
    begin
        while true loop
            clock <= '0';
            wait for 5 ns;
            clock <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset system
        Reset <= '1';
        wait for 10 ns;
        Reset <= '0';

        -- Setup input size
        row_size <= conv_std_logic_vector(2, 9);
        col_size <= conv_std_logic_vector(2, 9);
	enColSize <= '1';
	enRowSize <= '1';
	wait for 10 ns;
	enColSize <= '1';
	enRowSize <= '1';
	wait for 10 ns;

       --00
	enRow <= '1';
        enCol <= '1';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '1';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '1';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '1';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '1';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '1';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '1';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '1';
	enOutReg <= '1';
	compute <= '0';
	wait for 10 ns;
	--01
	enRow <= '1';
        enCol <= '1';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '1';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '1';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '1';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '1';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '1';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '1';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '1';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '1';
	enOutReg <= '1';
	compute <= '0';
	wait for 10 ns;
	--02
	enRow <= '1';
        enCol <= '1';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '1';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '1';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '1';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '1';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '1';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '1';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '1';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '1';
	enOutReg <= '1';
	compute <= '0';
	wait for 10 ns;
	--10
	enRow <= '1';
        enCol <= '1';
        enCheckIntegral <= '0';
        sel_row <= '1';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '1';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '1';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '1';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '1';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '1';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '1';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '1';
	enOutReg <= '1';
	compute <= '0';
	wait for 10 ns;
	
	--11
	enRow <= '0';
        enCol <= '1';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '1';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= x"000011";
        EnAdrLine <= '1';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '1';
        in_pixel <= x"000011";
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= x"000011";
        EnAdrLine <= '0';
        Lre <= '1';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '1';
        loadI0 <= '0';
        in_pixel <= x"000011";
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '1';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '1';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= x"000011";
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '1';
	enOutReg <= '1';
	compute <= '1';
	wait for 10 ns;
	--21
	enRow <= '0';
        enCol <= '1';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '1';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= x"000017";
        EnAdrLine <= '1';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '1';
        in_pixel <= x"000017";
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= x"000017";
        EnAdrLine <= '0';
        Lre <= '1';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '0';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '0';
        loadI1 <= '1';
        loadI0 <= '0';
        in_pixel <= (others => '0');
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '0';
	enOutReg <= '0';
	compute <= '0';
	wait for 10 ns;
	enRow <= '0';
        enCol <= '0';
        enCheckIntegral <= '1';
        sel_row <= '0';
        sel_col <= '0';
        loadI2 <= '1';
        loadI1 <= '0';
        loadI0 <= '0';
        in_pixel <= x"000017";
        EnAdrLine <= '0';
        Lre <= '0';
        Lwe <= '1';
	enOutReg <= '1';
	compute <= '1';
	wait for 10 ns;
	--Eighth pixel: 23
	
	--Ninth pixel: 5
	
        -- Observe results
        wait for 50 ns;

        -- End test
        wait;
    end process;

end behavior;

