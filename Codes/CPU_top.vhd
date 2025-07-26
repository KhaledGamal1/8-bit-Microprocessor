library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CPU_top is
    port (
        clk : in std_logic;
        value : out std_logic_vector(7 downto 0)
    );
end entity CPU_top;

architecture rtl of CPU_top is

--Components declaration
    component Program_counter is
        port (
            clk   : in std_logic;
            next_instruction : out STD_LOGIC_VECTOR(2 downto 0)        
            
        );
    end component Program_counter;


    component Instruction_memory is
        port (
            instr_addr : in std_logic_vector(2 downto 0);      
            op : out std_logic_vector(1 downto 0);            
            rs_addr : out std_logic_vector(1 downto 0);      
            rt_addr : out std_logic_vector(1 downto 0);      
            rd_addr : out std_logic_vector(1 downto 0)        
        );
    end component Instruction_memory;


    component Registers_file is
        port (
            clk   : in std_logic;                             
            rs_addr : in std_logic_vector(1 downto 0);
            rt_addr : in std_logic_vector(1 downto 0);
            rd_addr : in std_logic_vector(1 downto 0);
            wr_data : in std_logic_vector(7 downto 0);       
            rs : out std_logic_vector(7 downto 0);            
            rt : out std_logic_vector(7 downto 0)
        );
    end component Registers_file;


    component ALU is
        port (
            op : in std_logic_vector(1 downto 0);
            rs , rt : in std_logic_vector(7 downto 0);
            rd : out std_logic_vector(7 downto 0)
        );
    end component ALU;


    component Control_unit is
        port (
            instr : in STD_LOGIC_VECTOR (1 downto 0);     
            alu_op : out STD_LOGIC_VECTOR (1 downto 0);   
            alu_src : out std_logic;                      
            reg_dst : out std_logic                      
        );
    end component Control_unit;


    component mux0 is
        port (
            a : in STD_LOGIC_VECTOR (1 downto 0);       
            b : in STD_LOGIC_VECTOR (1 downto 0);       
            sel : in std_logic;
            y : out STD_LOGIC_VECTOR (1 downto 0)      
        );
    end component mux0;


    component mux1 is
        port (
            a : in STD_LOGIC_VECTOR (7 downto 0);        
            b : in STD_LOGIC_VECTOR (7 downto 0);        
            sel : in std_logic;
            y : out STD_LOGIC_VECTOR (7 downto 0)      
        );
    end component mux1;


    component sign_extend is
        port (
            data_in : in STD_LOGIC_VECTOR (1 downto 0);
            data_out : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component sign_extend;


--Signals declaration
    signal opcode_sig : std_logic_vector(1 downto 0);                                                                                                           --wire0
    signal rs_sig , rt_sig : std_logic_vector(7 downto 0);                                                                                                      --wire1 , wire2
    signal instr_sig : std_logic_vector(1 downto 0);                                                                                                            --wire3
    signal alu_dst_sig, alu_src_sig : STD_LOGIC;      --selections lines of muxs                                                                                --wire5 , wire8              
    signal rt_addr_sig , rd_addr_sig : std_logic_vector(1 downto 0);                                                                                            --wire18 , wire19
    signal rt_val , sign_ext_out: std_logic_vector(7 downto 0);                                                                                                 --9 , 10
    signal mux0_out , rs_addr_sig : std_logic_vector(1 downto 0);                                                                                               --12 , 13
    signal instr_addr_sig : std_logic_vector(2 downto 0);                                                                                                       --14
    signal out_val : std_logic_vector(7 downto 0);                                                                                                              --15

begin

    value <= out_val;

--Components instantiation
    ALU_inst: 
    ALU port map(
        op => opcode_sig,
        rs => rs_sig,
        rt => rt_sig,
        rd => out_val
    );


    Control_unit_inst: Control_unit
    port map(
        instr => instr_sig,
        alu_op => opcode_sig,
        alu_src => alu_src_sig,
        reg_dst => alu_dst_sig
    );

    Instruction_memory_inst: Instruction_memory
    port map(
        instr_addr => instr_addr_sig,
        op => instr_sig,
        rs_addr => rs_addr_sig,
        rt_addr => rt_addr_sig,
        rd_addr => rd_addr_sig
    );

    mux0_inst: mux0
    port map(
        a => rt_addr_sig,
        b => rd_addr_sig,
        sel => alu_dst_sig,
        y => mux0_out
    );

    mux1_inst: mux1
    port map(
        a => rt_val,
        b => sign_ext_out,
        sel => alu_src_sig,
        y => rt_sig
    );

    Program_counter_inst: Program_counter
    port map(
        clk => clk,
        next_instruction => instr_addr_sig
    );

    Registers_file_inst: Registers_file
    port map(
        clk => clk,
        rs_addr => rs_addr_sig,
        rt_addr => rt_addr_sig,
        rd_addr => mux0_out,
        wr_data => out_val,
        rs => rs_sig,
        rt => rt_val
    );

    sign_extend_inst: sign_extend
    port map(
        data_in => rd_addr_sig,
        data_out => sign_ext_out
    );
end architecture;