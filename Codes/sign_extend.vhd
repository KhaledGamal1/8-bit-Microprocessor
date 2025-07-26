library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
    port (
        data_in : in STD_LOGIC_VECTOR (1 downto 0);
        data_out : out STD_LOGIC_VECTOR (7 downto 0)
    );
end entity sign_extend;

architecture rtl of sign_extend is
begin
    data_out <= "000000" & data_in;
end architecture rtl;