main:
    addi x10, x0, 5     
    jal x1, fact        # Return address saved
    addi x11, x10, 0    # 3. Save result in x11 to keep it safe for printing
    addi a7, x0, 1      # System call code for print_int
    addi a0, x11, 0     # Move result into a0 (x10) 
    ecall

    # 5. Program Exit (System Call 10 = Exit)
    addi a7, x0, 10
    ecall
fact:
    addi sp , sp , -8 # adjust stack for 2 items
    sw x1 , 4(sp) # save return address
    sw x10 , 0(sp) # save argument n

    addi x5 , x10 , -1 # x5 = n - 1
    bge x5 , x0 , L1 # if (n - 1) >= 0, go to L1

    addi x10 , x0 , 1 # return 1
    addi sp , sp , 8 # pop stack
    jalr x0 , 0(x1) # return

L1:
    addi x10 , x10 , -1 # argument = n - 1
    jal x1 , fact # recursive call

    addi x6 , x10 , 0 # save result of fact(n -1)
    lw x10 , 0(sp) # restore original n
    lw x1 , 4(sp) # restore return address
    addi sp , sp , 8 # pop stack

    mul x10 , x10 , x6 # n * fact(n -1)
    jalr x0 , 0(x1) # return