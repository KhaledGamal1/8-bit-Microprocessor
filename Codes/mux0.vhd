library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--This mux chooses the address of which register the data will be saved inside
entity mux0 is
    port (
        a : in STD_LOGIC_VECTOR (1 downto 0);        --address of reg2
        b : in STD_LOGIC_VECTOR (1 downto 0);        --default destination address
        sel : in std_logic;
        y : out STD_LOGIC_VECTOR (1 downto 0)        --destination address
    );
end entity mux0;


architecture behavioral of mux0 is
    
begin
    process (sel , a , b)
    begin
        if (sel = '1') then    --This operation is done in case of opcode = 11 
            y <= a;
        else
            y <= b;            --here the default operations will be done while opcode = 00 or 01 or 10
        end if;
    end process;
end architecture behavioral;