# MIPS Assembly Lab – Matrix Multiplication & Recursion

This project contains two MIPS assembly programs that implement:

1. **Matrix multiplication** for two 2×2 matrices
2. **Recursive computation of powers of three**

These programs were developed using iterative refinement from C to MIPS, and run on the SPIM simulator.

---

## Overview

### 1. `matrixMultiply.s`
- Implements multiplication of a 2×2 matrix using nested loops (converted to `goto` and then to MIPS).
- Stores and prints the resulting matrix using SPIM syscalls.
- Result verified against manual calculation.

### 2. `powersOfThree.s`
- Implements a recursive function to calculate `3^n`.
- Uses base case (n=0) to return 1.
- Recursive case returns `3 * powerOfThree(n-1)`.
- Prompts user for input and displays result.

---

## How to Run (on SPIM)

1. Open [PCSpim](https://sourceforge.net/projects/spimsimulator/) or QtSpim.
2. Load `matrixMultiply.s` or `powersOfThree.s`.
3. Run the program and view the printed output in the terminal.

---

## Files

| File               | Description                              |
|--------------------|------------------------------------------|
| `matrixMultiply.s` | MIPS implementation of 2x2 matrix product |
| `powersOfThree.s`  | Recursive function to compute 3^n         |
| `LabReport.pdf`    | Detailed explanation of translation steps |

---

## Author

**Yasmine Elsisi**  
Computer Engineering @ NYU Abu Dhabi  
[GitHub](https://github.com/YasmineElsisi)
