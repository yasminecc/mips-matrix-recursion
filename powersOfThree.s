.data
promptInt: .asciiz "input an integer: "
newline:   .asciiz "\n"

.text

main:
    # prompt user to input integer
    la   $a0, promptInt    # Load address of prompt string into $a0
    li   $v0, 4            # System call for printing a string
    syscall                # Print the prompt

    # Get integer input from user
    li   $v0, 5     # System call for reading an integer
    syscall               
    move $a0, $v0   # Move input n to register $a0 

    # Call the powerOfThree function
    jal  powerOfThree   # Jump and link to powerOfThree function

    # Print the result (storedS in $v0)
    move $a0, $v0    # Move result to $a0 for printing
    li   $v0, 1      # System call for printing an integer
    syscall          # Print the result

    # Print a newline after the result
    la   $a0, newline   # Load address of newline string
    li   $v0, 4         # System call for printing a string
    syscall             # Print the newline

    # Exit program
    li   $v0, 10   # System call for exit
    syscall                 

# Recursive function to calculate 3^n
powerOfThree:
    # Save registers $ra and $a0 on stack
    addi $sp, $sp, -8   # Make space on stack
    sw   $ra, 4($sp)    # Save return address
    sw   $a0, 0($sp)    # Save argument $a0

    # Base case: if n == 0, return 1 
    beq  $a0, $zero, baseCase

    # Recursion
    addi $a0, $a0, -1   # Decrement n by 1
    jal  powerOfThree   # Recursive call

    # Multiply result by 3
    li   $t0, 3          # Load 3 into $t0
    mul  $v0, $v0, $t0   # Multiply $v0 by 3 (v0 contains the result of powerOfThree(n-1))

    # Restore registers and return
    lw   $ra, 4($sp)    # Restore return address
    lw   $a0, 0($sp)    # Restore argument $a0
    addi $sp, $sp, 8    # Clean up stack
    jr   $ra            # Return to caller

baseCase:
    li   $v0, 1         # If n == 0, return 1
    lw   $ra, 4($sp)    # Restore return address
    lw   $a0, 0($sp)    # Restore argument $a0
    addi $sp, $sp, 8    # Clean up stack
    jr   $ra            # Return to caller