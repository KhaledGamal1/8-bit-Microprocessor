library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--This mux will choose the value of the data to be added together

entity mux1 is
    port (
        a : in STD_LOGIC_VECTOR (7 downto 0);        --default data
        b : in STD_LOGIC_VECTOR (7 downto 0);        --constant data (address of destination reg that will be extended using sign extend component)
        sel : in std_logic;
        y : out STD_LOGIC_VECTOR (7 downto 0)        --output data (value of B which is either reg2 value or constant data)
    );
end entity mux1;


architecture behavioral of mux1 is
    
begin
    process (sel , a , b)
    begin
        if (sel = '0') then    --default operations (opcode = 00 or 01 or 10)
            y <= a;
        else
            y <= b;            --when opcode = 11
        end if;
    end process;
end architecture behavioral;