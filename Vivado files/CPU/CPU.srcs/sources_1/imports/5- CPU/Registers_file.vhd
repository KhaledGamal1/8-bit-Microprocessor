library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Takes the address of A , B , distenation registers, and write data (output value of the operation) that is saved inside the destination register

entity Registers_file is
    port (
        clk   : in std_logic;                             --After each cycle the value is saved in destination register
        rs_addr : in std_logic_vector(1 downto 0);
        rt_addr : in std_logic_vector(1 downto 0);
        rd_addr : in std_logic_vector(1 downto 0);
        wr_data : in std_logic_vector(7 downto 0);        --ALU output is saved inside the destination register
        rs : out std_logic_vector(7 downto 0);            --The outputs are the value of A and B
        rt : out std_logic_vector(7 downto 0)
    );
end entity Registers_file;

architecture rtl of Registers_file is
    --Array of the 4 registers each is 8-bit long
    type registerfile is array (0 to 3) of std_logic_vector(7 downto 0);
        signal reg : registerfile := (     --Defined as signals because the vlaue inside the registers is changing with each cycle
            "11000010",
            "11010101",
            "11101011",
            "01000111"
        );
begin

--After each cycle (with falling edge) the value of "write data" is saved inside the destination register
process (clk)
begin
    if falling_edge(clk) then
        reg (to_integer(unsigned(rd_addr))) <= wr_data;
    end if;
end process;


--Assigning the values inside the registers to the outputs
rs <= reg(TO_INTEGER(UNSIGNED(rs_addr)));    
rt <= reg(TO_INTEGER(UNSIGNED(rt_addr)));

end architecture;