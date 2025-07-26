library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Memory that takes the output of the program counter as an input and its output is 8 bit which defines which operation should be excuted
-- the 8 bit memory is divided into 4 segments each segment is 2 bits long (because we have 4 registers) each 2 bits is responsible for specific operation


entity Instruction_memory is
    port (
        instr_addr : in std_logic_vector(2 downto 0);      --The output of the program counter
        op : out std_logic_vector(1 downto 0);            --The most significant 2 bits which defines the operation code between the 2 variables (A , B)
        rs_addr : out std_logic_vector(1 downto 0);       --Address of sorce register that holds the value of the first variable (A)
        rt_addr : out std_logic_vector(1 downto 0);       --Address of target register that holds the value of the second variable (B)
        rd_addr : out std_logic_vector(1 downto 0)        --Address of destination register that holds the operation output value
    );
end entity Instruction_memory;

architecture rtl of Instruction_memory is

    --Construction of the memory which is 8-bit long and each row is 8-bit wide
    type instruction_set is array (0 to 7) of std_logic_vector(7 downto 0);
        --Instructions that will be saved inside the memory (constant instructions that wont change)
        constant instr : instruction_set := (
            "01000010",
            "11010101",
            "11101011",
            "01000111",
            "10101100",
            "00000000",
            "00000000",
            "00000000"
        );
begin
    --assigning the address of each output register
    --first 2 bits on the left defines the operation code register address
    --second 2 bits from the left defines rs_addr
    --Third 2 bits from the left defines rt_addr
    --Last 2 bits from the left defines rd_addr

    op <= instr (to_integer(unsigned(instr_addr))) (7 downto 6);      --converted to integer to choose which location in the "instr" constant
    rs_addr <= instr (to_integer(unsigned(instr_addr))) (5 downto 4);
    rt_addr <= instr (to_integer(unsigned(instr_addr))) (3 downto 2);
    rd_addr <= instr (to_integer(unsigned(instr_addr))) (1 downto 0);

end architecture;