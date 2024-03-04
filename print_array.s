.data
A: .word 11, 22, 33, 44, 55
space: .asciiz " "
newline: .asciiz "\n"

.text
main:

    # passing the two arguments to a0 and a1
    la a0, A
    addi a1, x0, 5

    # jump to the print_array procedure
    jal print_array

    # exit gracefully
    addi a0, x0, 10
    addi a1, x0, 0
    ecall # Terminate ecall

print_array:
    addi sp, sp, -4
    sw ra, 0(sp) # save ra register on to the stack
    addi t0, x0, 0 # i = 0
loop:
    bge t0, a1, loop_exit # exit loop if i >= size
    slli t1, t0, 2 # i = i * 4
    add t1, a0, t1 # t1 = &A[0] + i*4
    lw t1, 0(t1) # t1 = A[i]

    # save a0 and a1 on to the stack
    addi sp, sp, -8
    sw a0, 4(sp)
    sw a1, 0(sp)

    # printf("%d ", A[i])
    addi a0, x0, 1
    mv a1, t1
    ecall
    addi a0, x0, 4
    la a1, space
    ecall

    # restore a0 and a1 from the stack
    lw a0, 4(sp)
    lw a1, 0(sp)
    addi sp, sp, 8

    addi t0, t0, 1 # i++
    j loop # goto loop
loop_exit:
    addi a0, x0, 4
    la a1, newline
    ecall

    # restore ra and return
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra