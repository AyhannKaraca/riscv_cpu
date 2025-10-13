    .section .text
    .globl _start

_start:

    ############################################################
    # Configurations
    ############################################################
    li      x1, 2        # RUNS (outer repetition count)
    li      x2, 10000         # PH1_LOOP (big loop)
    li      x3, 3             # PH2_LOOP (small loop)
    li      x4, 256           # PH3_OUTER
    li      x5, 64            # PH3_INNER
    li      x6, 1             # LFSR seed
    li      x7, 5000          # PH4_LOOP (random)
    li      x8, 10000         # PH5_LOOP (biased)
    li      x9, 10000         # PH6_LOOP (alternating)

    li      x10, 0            # outer run counter
    li      x11, 0
    li      x12, 0
    li      x13, 0
    li      x14, 0
    li      x15, 0

############################################################
# Outer Loop
############################################################
outer_runs:
    addi    x10, x10, 1
    blt     x10, x1, phases_start
    j       all_done

phases_start:

############################################################
# PHASE 1: Large backward loop
############################################################
    mv      x11, x2
ph1_loop_top:
    addi    x11, x11, -1
    addi    x12, x12, 1
    bnez    x11, ph1_loop_top

############################################################
# PHASE 2: Small loop repeated
############################################################
    li      x13, 1000
ph2_repeat:
    addi    x13, x13, -1
    mv      x11, x3
ph2_loop_top:
    addi    x11, x11, -1
    addi    x12, x12, 2
    bnez    x11, ph2_loop_top
    bnez    x13, ph2_repeat

############################################################
# PHASE 3: Nested loops
############################################################
    mv      x14, x4
ph3_outer:
    addi    x14, x14, -1
    mv      x11, x5
ph3_inner:
    addi    x11, x11, -1
    add     x12, x12, x11
    bnez    x11, ph3_inner
    bnez    x14, ph3_outer

############################################################
# PHASE 4: Pseudo-random 50% taken (software LFSR)
############################################################
    mv      x11, x7
ph4_loop:
    addi    x11, x11, -1
    # xorshift-like pseudo-random (x6)
    slli    x12, x6, 13
    xor     x6, x6, x12
    srli    x12, x6, 17
    xor     x6, x6, x12
    slli    x12, x6, 5
    xor     x6, x6, x12

    andi    x12, x6, 1
    beq     x12, x0, ph4_not_taken
    addi    x13, x13, 1
    j       ph4_continue
ph4_not_taken:
    addi    x13, x13, 2
ph4_continue:
    bnez    x11, ph4_loop

############################################################
# PHASE 5: High bias (~90% taken)
# every 10th branch not taken, modulo implemented manually
############################################################
    mv      x11, x8
    li      x14, 0
ph5_loop:
    addi    x11, x11, -1
    addi    x14, x14, 1
    li      x15, 10
    blt     x14, x15, ph5_taken_check
    li      x14, 0
ph5_taken_check:
    beq     x14, x0, ph5_not_taken
    addi    x13, x13, 1
    j       ph5_continue
ph5_not_taken:
    addi    x13, x13, 2
ph5_continue:
    bnez    x11, ph5_loop

############################################################
# PHASE 6: Alternating taken / not taken
############################################################
    mv      x11, x9
    li      x14, 0
ph6_loop:
    addi    x11, x11, -1
    addi    x14, x14, 1
    andi    x12, x14, 1
    beq     x12, x0, ph6_not_taken
    addi    x13, x13, 1
    j       ph6_cont
ph6_not_taken:
    addi    x13, x13, 2
ph6_cont:
    bnez    x11, ph6_loop

    j       outer_runs

############################################################
# Program End
############################################################
all_done:
    jal     exit
    .align 4

exit:
    nop
