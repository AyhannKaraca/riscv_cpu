    .section .text
    .globl _start

_start:
    li   x1, 0x80002000    # x1 = base address of array in DMEM

    li   x5, 7
    sw   x5, 0(x1)         # mem[0] = 7
    li   x5, 3
    sw   x5, 4(x1)         # mem[1] = 3
    li   x5, 9
    sw   x5, 8(x1)         # mem[2] = 9
    li   x5, 1
    sw   x5, 12(x1)        # mem[3] = 1
    li   x5, 5
    sw   x5, 16(x1)        # mem[4] = 5

    ################################################
    # Bubble sort using the array at x1
    # x2 = n (number of elements)
    # x3 = inner counter (n-1 ...)
    # x4 = pointer to current element
    # x5, x6 used as temporaries for loads
    ################################################
    li   x2, 5             # n = 5

outer_loop:
    addi x3, x2, -1        # x3 = n - 1
    addi x4, x1, 0         # x4 = pointer to start of array

inner_loop:
    lw   x5, 0(x4)         # x5 = array[i]
    lw   x6, 4(x4)         # x6 = array[i+1]

    blt  x5, x6, no_swap   # if array[i] < array[i+1], skip swap

    # swap array[i] and array[i+1]
    sw   x6, 0(x4)
    sw   x5, 4(x4)

no_swap:
    addi x4, x4, 4         # pointer += 4 (next element)
    addi x3, x3, -1        # inner counter--
    bnez x3, inner_loop    # if x3 != 0 goto inner_loop

    addi x2, x2, -1        # outer counter--
    li   x7, 1
    bgt  x2, x7, outer_loop
    jal exit

    ################################################
    # Align exit to 0x80001000 (if .text starts at 0x80000000
    # and assembler/linker places code accordingly)
    ################################################
    .align 12
exit:
    nop
