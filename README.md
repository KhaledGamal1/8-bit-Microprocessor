# 8-bit Microprocessor in VHDL

This project implements a simple 8-bit microprocessor using VHDL. It is fully synthesizable and designed for simulation purposes, composed of key modules including a program counter, instruction memory, register file, ALU, control unit, sign extender, and multiplexers.

## 🧠 Architecture Overview

The processor follows a basic single-cycle architecture. Each instruction is 8 bits wide and split into four fields:
- **op** (2 bits): ALU operation code
- **rs_addr** (2 bits): source register address
- **rt_addr** (2 bits): second source or target register address
- **rd_addr** (2 bits): destination register address or immediate operand (depending on instruction)

### Data Path Components

- **Program Counter (PC)**:  
  Increments on every falling edge of the clock and provides the current instruction address (3 bits for 8 instructions).

- **Instruction Memory**:  
  A small ROM that outputs an instruction based on the address from the PC.

- **Registers File**:  
  Contains 4 registers, each 8 bits wide. Allows reading from two registers and writing to one register on the falling edge of the clock.

- **ALU**:  
  Performs arithmetic or logical operations depending on the `op` code.  
  - `00`: AND  
  - `01`: ADD  
  - `10`: SUB  
  - `11`: ADD (used with immediate values)

- **Control Unit**:  
  Interprets the `op` code and generates control signals:
  - `alu_op`: operation for the ALU
  - `alu_src`: selects between register or immediate as second ALU operand
  - `reg_dst`: selects the destination register

- **Multiplexers (mux0 & mux1)**:  
  - `mux0`: Chooses between `rt_addr` and `rd_addr` for register write-back  
  - `mux1`: Chooses between register value and sign-extended immediate as ALU input

- **Sign Extender**:  
  Converts the 2-bit `rd_addr` field into an 8-bit immediate value by padding leading zeros.

## 📁 File Descriptions

| File Name              | Description                                      |
|------------------------|--------------------------------------------------|
| `CPU_top.vhd`          | Top-level design connecting all components       |
| `Program_counter.vhd`  | Increments instruction address on each clock     |
| `Instruction_memory.vhd` | ROM containing hardcoded instructions         |
| `Registers_file.vhd`   | Register bank with read/write logic              |
| `ALU.vhd`              | Performs arithmetic and logic operations         |
| `Control_unit.vhd`     | Generates control signals based on instruction   |
| `mux0.vhd`, `mux1.vhd` | Multiplexers for operand and destination select  |
| `sign_extend.vhd`      | Extends 2-bit values to 8-bit values             |

## ▶️ Simulation

You can simulate the CPU using **Vivado** or any VHDL simulator of your choice.

### Sample Output Signal
The `value` port from `CPU_top` represents the result of the ALU operations and can be used for waveform observation or LED output.

## 🛠️ Future Improvements
- Add branching and jump logic
- Support more instructions (load/store)
- Extend PC to handle larger instruction sets
- Integrate with RAM or external memory interface

## 📜 License
This project is open-source and available under the MIT License.

---

