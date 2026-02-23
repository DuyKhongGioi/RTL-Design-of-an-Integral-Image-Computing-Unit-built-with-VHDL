library ieee;
use ieee.std_logic_1164.all;

entity tb_microprocessor is
end tb_microprocessor;

architecture behavior of tb_microprocessor is

    -- Component declaration
    component microprocessor
        port (
            clock : in std_logic;
            Start : in std_logic;
            Reset : in std_logic;
	    outp: out std_logic_vector (23 downto 0);
	r, c: out std_logic_vector (8 downto 0);
            done  : out std_logic
        );
    end component;

    -- Signals
    signal clock : std_logic := '0';
    signal Start : std_logic := '0';
    signal Reset : std_logic := '0';
	signal r, c: std_logic_vector (8 downto 0);
	signal outp:  std_logic_vector (23 downto 0);
    signal done  : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate DUT (Device Under Test)
    uut: microprocessor
        port map (
            clock => clock,
            Start => Start,
            Reset => Reset,
	outp => outp,r=>r, c=>c,
            done  => done
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clock <= '0';
            wait for clk_period / 2;
            clock <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Reset the system
        Reset <= '1';
        wait for clk_period * 2;
        Reset <= '0';
        wait for clk_period * 2;

        -- Start signal
        Start <= '1';
        wait for clk_period;
        Start <= '0';

        -- Wait for done
        wait until done = '1';

        -- Wait a few cycles then stop
        wait for clk_period * 10;

        assert false report "Simulation finished." severity failure;
    end process;

end behavior;

