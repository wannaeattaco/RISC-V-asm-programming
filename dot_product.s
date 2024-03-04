.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .string "The dot product is: "

.text
main:
    li x7, 5 # 5
    addi x8, x0, 0 # i = 0
    addi x9, x0, 0 # sop = 0
    la x10, a # loading the address of a --> x8 (32 bits register)
    la x11, b # loading the address of a --> x9 (32 bits register)

loop:
    bge x8, x7, exit # i >= 5 --> exit
    # i
    slli x18, x8, 2 # set x18 to i*4
    
    add x19, x18, x10 # add i*4 to the base address of a and put it to x19
    lw x22, 0(x19)
    
    add x20, x18, x11 # add i*4 to the base address of b and put it to x20
    lw x23, 0(x20)
    
    mul x21, x22, x23  # a[i] * b[i]
    add x9, x9, x21  # sop += a[i] * b[i]
    
    addi x8, x8, 1 # i++
    j loop
    
exit:
    # print a newline character; use print_string
    addi a0, x0, 4
    la a1, newline
    ecall
    
    # print_int; sop
    addi a0, x0, 1
    add a1, x0, x9
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall