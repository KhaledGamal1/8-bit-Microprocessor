library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity CPU_tb is
end entity CPU_tb;

architecture rtl of CPU_tb is
    component CPU_top is
        port (
            clk : in std_logic;
            value : out std_logic_vector(7 downto 0)
        );
    end component CPU_top;

    signal clk_tb : STD_LOGIC := '0';
    signal value_tb : std_logic_vector(7 downto 0) := "00000000";

begin

    dut:CPU_top
    port map(
        clk => clk_tb,
        value => value_tb
    );

    clk_generation: process
    begin
        while true loop
            wait for 5 ns;
            clk_tb <= not clk_tb;
        end loop;
    end process clk_generation;
    

    stim_proc: process
    begin
        wait for 200 ns;
        wait;
    end process stim_proc;
end architecture;