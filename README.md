# RISC-V CPU Verification

SystemVerilog verification project for an open-source RV32I single-cycle CPU.

## Current Progress

- Open-source RV32I CPU used as DUT
- Custom SystemVerilog testbench
- Clock/reset generation
- Instruction memory model
- Directed ADD test
- Self-checking PASS/FAIL mechanism

## Current Test

```asm
addi x1, x0, 5
addi x2, x0, 7
add  x3, x1, x2
Expected result:
x3 = 12
Current simulation result:
[PASS] ADD test passed: x3 = 12
DUT
The DUT is based on the open-source riscv-simple-sv project by tilk.
The DUT source code retains its original BSD-3-Clause license and copyright notices.
The verification environment under dv/ is developed for this project.