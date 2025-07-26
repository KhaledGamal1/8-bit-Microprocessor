library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--it's used to implement the following function
--value of reg1 + constat data = register2
--The constant data => is the address of the destination register

--The control unit will use multiplexers to implement this function
--multiplexer1 : to change destination from default destination to register2 (to choose which operations should be excuted is it the defaults or the last one)
--multiplexer2 : to choose between the value of reg2 or the constant data  (so we can add either the value of reg2 or the constant data to A)
--sign extend : convert address of destination register to value can be added to register1 (extend the bits of the address of dest reg from 2 bits to 8 bits)

--The control unit will determine the selection lines of the muxs and choose which operation should be excuted.IEEE.numeric_std.all

entity Control_unit is
    port (
        instr : in STD_LOGIC_VECTOR (1 downto 0);      --input to choose which operation
        alu_op : out STD_LOGIC_VECTOR (1 downto 0);    --same opcode will be output here but the difference is in the muxs
        alu_src : out std_logic;                       --selection line of mux1
        reg_dst : out std_logic                        --selection line of mux0
    );
end entity Control_unit;

architecture rtl of Control_unit is
    
begin
    --assinging the output to be the same as the input which will be the to ALU opcode
    with instr select
        alu_op  <=  "00" when "00",       --AND
                    "01" when "01",       --Add
                    "10" when "10",       --Sub
                    "11" when others;     --Addi
    
    
    
    --Controlling the mux0 selection line
    with instr select 
        reg_dst <=  '1' when "11",       --Addi
                    '0' when others;


    --Controlling the mux1 selection line
    with instr select 
        alu_src <=  '1' when "11",       --Addi 
                    '0' when others;

end architecture rtl;