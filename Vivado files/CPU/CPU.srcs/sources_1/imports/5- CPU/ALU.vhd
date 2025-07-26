library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;        --applying all the variables to be unsigned so we can do addition and subtraction

entity ALU is
    port (
        op : in std_logic_vector(1 downto 0);
        rs , rt : in std_logic_vector(7 downto 0);
        rd : out std_logic_vector(7 downto 0)
    );
end entity ALU;

architecture rtl of ALU is
    signal result : std_logic_vector(7 downto 0);
begin

process (op , rs , rt)
    begin
        --first 3 operations are the default operations (result is saved in dest reg) but the last one the output should be saved inside register2 (can be done by control unit)
        if (op = "00") then      --AND operation
            result <= rs and rt;
        elsif (op = "01") then   --Addition operation
            result <= rs + rt ;
        elsif (op = "10") then   --Subtraciont operation
            result <= rs - rt ;
        elsif (op = "11") then   --Addition operation 2 and this operation is done using the control unit
            result <= rs + rt ;      -- Adding A with the address of the destination register (8-bit + 2-bit) and the result will be saved in register2
        end if;
    end process;
    
    --Assigning the result to the output
    rd <= result;

end architecture;