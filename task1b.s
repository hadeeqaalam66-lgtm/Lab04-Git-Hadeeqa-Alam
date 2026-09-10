main:
    
    addi x10, x0, 5     # 1. Pass argument n = 5 in x10
    jal  x1, fact       # 2. Call the iterative factorial function 
    addi a7, x0, 1      # 3. Print the result stored in x10 
    ecall  #Print Integer
    #Exit
    addi a7, x0, 10     # Syscall 10: Exit
    ecall

fact:
    addi x5, x0, 1        # acc = 1

loop:
    bge  x0, x10, done    # Check if (0 >= n)

    mul  x5, x5, x10      # acc = acc * n
    addi x10, x10, -1     # n = n - 1
    j    loop             # repeat loop

done:
    addi x10, x5, 0       # move result (acc) into return register x10
    jalr x0, 0(x1)        # return to main