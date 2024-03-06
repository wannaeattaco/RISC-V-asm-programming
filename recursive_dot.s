.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .asciiz "The dot product is: "

.text
main:
    la a0, a
    la a1, b
    addi a2, x0, 5
    jal dot_product_recursive 
    j exit

dot_product_recursive:
    addi sp, sp, -16 # Prepare Stack Pointer
    sw ra, 0(sp) 
    sw a0, 4(sp) 
    sw a1, 8(sp) 
    sw a2, 12(sp) 
    addi t0, x0, 1 # t0 = temporary 1
    beq a2, t0, base_case
    
    addi a0, a0, 4 # a + 1
    addi a1, a1, 4 # b + 1
    addi a2, a2, -1 # size - 1
    jal dot_product_recursive
    lw ra, 0(sp) 
    lw t0, 4(sp) 
    lw t1, 8(sp) 
    lw t2, 12(sp) 
    addi sp, sp, 16 # Reset stack pointer
    lw t3, 0(t0) 
    lw t4, 0(t1)
    mul t5, t3, t4 
    add a0, a0, t5 
    jr ra
    
base_case:
    # Base Case
    addi sp, sp, 16 # Reset stack pointer
    lw t1, 0(a0) # a[0]
    lw t2, 0(a1) # b[0]
    mul a0, t1, t2 # a[0]*b[0]
    jr ra
    
exit:
    mv t0, a0
    
    # print a newline character; use print_string
    addi a0, x0, 4
    la a1, newline
    ecall
    
    # print_int; sop
    mv a1, t0
    addi a0, x0, 1
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall