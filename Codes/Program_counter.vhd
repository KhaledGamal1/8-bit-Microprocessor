library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Program_counter is
    port (
        clk   : in std_logic;
        next_instruction : out STD_LOGIC_VECTOR(2 downto 0)        --The output will be the address of the current instruction to be excuted (3 bits because we have 8 instructions)
        
    );
end entity Program_counter;

architecture rtl of Program_counter is

    --Storing the value to be displayed in the output
    signal current_signal : std_logic_vector(2 downto 0) := "000";

begin
    process (clk)
    begin
        if falling_edge(clk) then
            current_signal <= STD_LOGIC_VECTOR(unsigned(current_signal) + TO_UNSIGNED(1,3));
        end if;
    end process;

    next_instruction <= current_signal;   --assigning the signal to the output
end architecture;