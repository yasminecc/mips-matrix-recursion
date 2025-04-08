.data
firstMatrix: .word 1, 2, 6, 4    
secondMatrix: .word 3, 2, 1, 8   
resultMatrix: .space 16  # Allocate space for 2x2 matrix 

newline: .asciiz "\n"  # Newline character for printing
space: .asciiz " "     # Space charcter for printing 


.text
.globl main

main:
    # Initialize base addresses of matrices
    la   $a0, firstMatrix   # Load address of firstMatrix into $a0
    la   $a1, secondMatrix  # Load address of secondMatrix into $a1
    la   $t0, resultMatrix  # Load address of resultMatrix into $t0

    addi $sp, $sp, -8   # Allocate space on the stack
    sw   $ra, 0($sp)    # Save return address on the stack

    li   $t1, 0   # initialize i to 0
    li   $t2, 2   # matrix size is 2

loop1:
    bge  $t1, $t2, end1   # if i >= size, end loop1
    li   $t3, 0           # j = 0, initialize j to 0

loop2:
    bge  $t3, $t2, end2   # if j >= size, end loop2

    mul  $t4, $t1, 2     # rowOffset = i * 2
    add  $t5, $t4, $t3   # index = i * 2 + j
    sll  $t6, $t5, 2     # byteOffset = (i * 2 + j) * 4
    add  $t7, $t0, $t6   # elementAddr = &resultMatrix[i][j]
    ori  $t8, $zero, 0   # temp = 0
    sw   $t8, 0($t7)     # resultMatrix[i][j] = 0

    li   $t9, 0  #initialize k to 0

loop3:
    bge  $t9, $t2, end3  # if k >= size, exit loop3

    # Load firstMatrix[i][k]
    mul  $t4, $t1, 2      # rowOffset = i * 2
    add  $t5, $t4, $t9    # index = i * 2 + k
    sll  $t6, $t5, 2      # byteOffset = (i * 2 + k) * 4
    add  $t7, $a0, $t6    # # elementAddr = &resultMatrix[i][j]
    lw   $s0, 0($t7)      # temp1 = firstMatrix[i][k]

    # Load secondMatrix[k][j]
    mul  $t4, $t9, 2     # rowOffset1 = k * 2
    add  $t5, $t4, $t3   # index = k * 2 + j
    sll  $t6, $t5, 2     # byteOffset = (k * 2 + j) * 4
    add  $t7, $a1, $t6   # elementAddr = &secondMatrix[k][j]
    lw   $s1, 0($t7)     # temp2 = secondMatrix[k][j]

    # Multiply temp1 and temp2 and assign it to temp3
    mul  $s2, $s0, $s1   

    # Load resultMatrix[i][j]
    mul  $t4, $t1, 2    # rowOffse = i * 2
    add  $t5, $t4, $t3  # index = i * 2 + j
    sll  $t6, $t5, 2    # byteOffset= (i * 2 + j) * 4
    add  $t7, $t0, $t6  # elementAddr = &resultMatrix[i][j]
    lw   $s3, 0($t7)    # temp4 = resultMatrix[i][j]

    add  $s3, $s3, $s2  # $s3 = resultMatrix[i][j] + (firstMatrix[i][k] * secondMatrix[k][j])

   
    sw   $s3, 0($t7)  # Store new resultMatrix[i][j] back to memory

    addi $t9, $t9, 1   # k++
    j loop3            # Jump back to loop3

end3:
    addi $t3, $t3, 1    # j++
    j loop2             # Jump back to loop2

end2:
    addi $t1, $t1, 1  # i++
    j loop1           # Jump back to loop1

end1:
    # printing the result matrix
    li   $t1, 0   # initialize i to 0

print_loop1:
    bge  $t1, $t2, end4  # if i >= size, exit loop1
    li   $t3, 0          # initialize j to 0

print_loop2:
    bge  $t3, $t2, newlineRow  # if j >= size, exit loop2

    # Load resultMatrix[i][j]
    mul  $t4, $t1, 2    # rowOffset = i * 2
    add  $t5, $t4, $t3  # index = i * 2 + j
    sll  $t6, $t5, 2    # byteOffset = (i * 2 + j) * 4
    add  $t7, $t0, $t6  # elementAddr = &resultMatrix[i][j]
    lw   $s0, 0($t7)    # Load the value into $s0

    # Print the value in $s0
    li   $v0, 1    # Print integer syscall
    move $a0, $s0  # Move the value to $a0 for printing
    syscall

    # Print a space after each number
    li   $v0, 4  # Print string syscall
    la   $a0, space   
    syscall

    addi $t3, $t3, 1   # j++
    j print_loop2      # Jump back to print_loop2

newlineRow:
    # Print newline after each row
    li   $v0, 4         # Print string syscall
    la   $a0, newline   # Load newline address
    syscall

    addi $t1, $t1, 1   # i++
    j print_loop1      # Jump back to print_loop1

end4:
    lw   $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 8   # Clean up the stack

    # Exit program
    li   $v0, 10  
    syscall