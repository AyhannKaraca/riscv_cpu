_start:
    li x1, 0x80000000
    li x31, 0x80001000
    
    addi x2, x0, 1
    addi x3, x2, 2
    addi x4, x3, 4
    addi x5, x4, 8
    addi x6, x5, 16
    addi x7, x6, 32
    addi x8, x7, 64
    addi x9, x8, 128
    addi x10, x9, 256
    
    addi x11, x10, -256
    addi x12, x11, -128
    addi x13, x12, -64
    addi x14, x13, -32
    addi x15, x14, -16
    
    slti x16, x0, 1
    slti x17, x0, 0
    slti x18, x0, -1
    sltiu x19, x0, 1
    sltiu x20, x0, 0
    
    slti x21, x15, 16
    slti x22, x15, 15
    slti x23, x15, 14
    sltiu x24, x15, 16
    sltiu x25, x15, 15
    
    xori x26, x15, 0xFF
    xori x27, x26, 0xAA
    xori x28, x27, 0x55
    xori x29, x28, 0xF0
    xori x30, x29, 0x0F
    
    ori x2, x0, 0x0001
    ori x3, x2, 0x0002
    ori x4, x3, 0x0004
    ori x5, x4, 0x0008
    ori x6, x5, 0x0010
    ori x7, x6, 0x0020
    ori x8, x7, 0x0040
    ori x9, x8, 0x0080
    
    andi x10, x9, 0x00F0
    andi x11, x10, 0x0055
    andi x12, x11, 0x00AA
    andi x13, x12, 0x0033
    andi x14, x13, 0x00CC
    
    add x15, x2, x3
    add x16, x15, x4
    add x17, x16, x5
    add x18, x17, x6
    add x19, x18, x7
    add x20, x19, x8
    
    sub x21, x20, x9
    sub x22, x21, x10
    sub x23, x22, x11
    sub x24, x23, x12
    sub x25, x24, x13
    sub x26, x25, x14
    
    add x27, x15, x21
    sub x28, x16, x22
    add x29, x27, x28
    sub x30, x29, x17
    
    slli x2, x15, 1
    slli x3, x2, 2
    slli x4, x3, 3
    slli x5, x4, 4
    slli x6, x5, 5
    
    srli x7, x6, 1
    srli x8, x7, 2
    srli x9, x8, 3
    srli x10, x9, 4
    srli x11, x10, 5
    
    srai x12, x6, 1
    srai x13, x12, 2
    srai x14, x13, 3
    srai x15, x14, 4
    srai x16, x15, 5
    
    addi x17, x0, 1
    addi x18, x0, 2
    addi x19, x0, 3
    
    sll x20, x16, x17
    sll x21, x20, x18
    sll x22, x21, x19
    
    srl x23, x22, x17
    srl x24, x23, x18
    srl x25, x24, x19
    
    sra x26, x22, x17
    sra x27, x26, x18
    sra x28, x27, x19
    
    slt x29, x25, x28
    slt x30, x28, x25
    slt x2, x29, x30
    
    sltu x3, x25, x28
    sltu x4, x28, x25
    sltu x5, x3, x4
    
    xor x6, x25, x28
    xor x7, x6, x29
    xor x8, x7, x30
    xor x9, x8, x2
    
    or x10, x6, x7
    or x11, x8, x9
    or x12, x10, x11
    
    and x13, x6, x7
    and x14, x8, x9
    and x15, x13, x14
    
    lui x16, 0x12345
    lui x17, 0xABCDE
    lui x18, 0x55555
    lui x19, 0xAAAAA
    
    auipc x20, 0x1000
    auipc x21, 0x2000
    auipc x22, 0x3000
    auipc x23, 0x4000
    
    add x24, x16, x17
    add x25, x18, x19
    add x26, x20, x21
    add x27, x22, x23
    
    sw x16, 0(x1)
    sw x17, 4(x1)
    sw x18, 8(x1)
    sw x19, 12(x1)
    sw x20, 16(x1)
    sw x21, 20(x1)
    sw x22, 24(x1)
    sw x23, 28(x1)
    
    sh x24, 32(x1)
    sh x25, 34(x1)
    sh x26, 36(x1)
    sh x27, 38(x1)
    
    sb x24, 40(x1)
    sb x25, 41(x1)
    sb x26, 42(x1)
    sb x27, 43(x1)
    
    lw x28, 0(x1)
    lw x29, 4(x1)
    lw x30, 8(x1)
    lw x2, 12(x1)
    
    add x5, x2, x30
    add x3, x28, x29
    add x4, x30, x2
    sub x5, x3, x4
    
    lh x6, 32(x1)
    lhu x7, 32(x1)
    lh x8, 34(x1)
    lhu x9, 34(x1)
    
    addi x13, x9, 199
    add x10, x6, x7
    add x11, x8, x9
    sub x12, x10, x11
    
    lb x13, 40(x1)
    lbu x14, 40(x1)
    lb x15, 41(x1)
    lbu x16, 41(x1)
    
    add x17, x13, x14
    add x18, x15, x16
    sub x19, x17, x18
    
    addi x23, x0, 0x123
    xori x24, x23, 0x456
    slli x25, x24, 4
    srli x26, x25, 2
    andi x27, x26, 0x7FF
    ori x28, x27, 0x80
    
    add x29, x23, x24
    sub x30, x25, x26
    xor x2, x27, x28
    or x3, x29, x30
    and x4, x2, x3
    
    slt x5, x4, x29
    sltu x6, x3, x30
    add x7, x5, x6
    sub x8, x7, x4
    
    sw x2, 300(x1)
    sw x3, 304(x1)
    sw x4, 308(x1)
    sw x5, 312(x1)
    sw x6, 316(x1)
    sw x7, 320(x1)
    sw x8, 324(x1)
    sw x9, 328(x1)
    sw x10, 332(x1)
    sw x11, 336(x1)
    sw x12, 340(x1)
    sw x13, 344(x1)
    sw x14, 348(x1)
    sw x15, 352(x1)
    sw x16, 356(x1)
    sw x17, 360(x1)
    sw x18, 364(x1)
    sw x19, 368(x1)
    sw x20, 372(x1)
    sw x21, 376(x1)
    sw x22, 380(x1)
    sw x23, 384(x1)
    sw x24, 388(x1)
    sw x25, 392(x1)
    sw x26, 396(x1)
    sw x27, 400(x1)
    sw x28, 404(x1)
    sw x29, 408(x1)
    sw x30, 412(x1)

    # Test 1: BEQ - Branch if Equal (True case)
    addi x3, x0, 5
    addi x4, x0, 5
    beq x3, x4, beq_true_1
    addi x2, x2, 100       # Hata - buraya gelmemeli
beq_true_1:
    addi x2, x2, 1         # Test 1 başarılı
    
    # Test 2: BEQ - Branch if Equal (False case)
    addi x3, x0, 5
    addi x4, x0, 7
    beq x3, x4, beq_false_1
    addi x2, x2, 1         # Test 2 başarılı
    j beq_continue_1
beq_false_1:
    addi x2, x2, 100       # Hata
beq_continue_1:
    
    # Test 3: BNE - Branch if Not Equal (True case)
    addi x3, x0, 5
    addi x4, x0, 7
    bne x3, x4, bne_true_1
    addi x2, x2, 100       # Hata
bne_true_1:
    addi x2, x2, 1         # Test 3 başarılı
    
    # Test 4: BNE - Branch if Not Equal (False case)
    addi x3, x0, 5
    addi x4, x0, 5
    bne x3, x4, bne_false_1
    addi x2, x2, 1         # Test 4 başarılı
    j bne_continue_1
bne_false_1:
    addi x2, x2, 100       # Hata
bne_continue_1:
    
    # Test 5: BLT - Branch if Less Than (True case - pozitif sayılar)
    addi x3, x0, 3
    addi x4, x0, 8
    blt x3, x4, blt_true_1
    addi x2, x2, 100       # Hata
blt_true_1:
    addi x2, x2, 1         # Test 5 başarılı
    
    # Test 6: BLT - Branch if Less Than (False case)
    addi x3, x0, 8
    addi x4, x0, 3
    blt x3, x4, blt_false_1
    addi x2, x2, 1         # Test 6 başarılı
    j blt_continue_1
blt_false_1:
    addi x2, x2, 100       # Hata
blt_continue_1:
    
    # Test 7: BLT - Branch if Less Than (negatif sayılarla)
    addi x3, x0, -5
    addi x4, x0, 2
    blt x3, x4, blt_true_2
    addi x2, x2, 100       # Hata
blt_true_2:
    addi x2, x2, 1         # Test 7 başarılı
    
    # Test 8: BGE - Branch if Greater or Equal (True case - eşit)
    addi x3, x0, 5
    addi x4, x0, 5
    bge x3, x4, bge_true_1
    addi x2, x2, 100       # Hata
bge_true_1:
    addi x2, x2, 1         # Test 8 başarılı
    
    # Test 9: BGE - Branch if Greater or Equal (True case - büyük)
    addi x3, x0, 10
    addi x4, x0, 5
    bge x3, x4, bge_true_2
    addi x2, x2, 100       # Hata
bge_true_2:
    addi x2, x2, 1         # Test 9 başarılı
    
    # Test 10: BGE - Branch if Greater or Equal (False case)
    addi x3, x0, 3
    addi x4, x0, 8
    bge x3, x4, bge_false_1
    addi x2, x2, 1         # Test 10 başarılı
    j bge_continue_1
bge_false_1:
    addi x2, x2, 100       # Hata
bge_continue_1:
    
    # Test 11: BLTU - Branch if Less Than Unsigned (True case)
    li x3, 0xFFFFFFFF      # -1 as signed, max as unsigned
    addi x4, x0, 5
    bltu x4, x3, bltu_true_1
    addi x2, x2, 100       # Hata
bltu_true_1:
    addi x2, x2, 1         # Test 11 başarılı
    
    # Test 12: BLTU - Branch if Less Than Unsigned (False case)
    li x3, 0xFFFFFFFF
    addi x4, x0, 5
    bltu x3, x4, bltu_false_1
    addi x2, x2, 1         # Test 12 başarılı
    j bltu_continue_1
bltu_false_1:
    addi x2, x2, 100       # Hata
bltu_continue_1:
    
    # Test 13: BGEU - Branch if Greater or Equal Unsigned (True case)
    li x3, 0xFFFFFFFF
    addi x4, x0, 5
    bgeu x3, x4, bgeu_true_1
    addi x2, x2, 100       # Hata
bgeu_true_1:
    addi x2, x2, 1         # Test 13 başarılı
    
    # Test 14: BGEU - Branch if Greater or Equal Unsigned (False case)
    addi x3, x0, 5
    li x4, 0xFFFFFFFF
    bgeu x3, x4, bgeu_false_1
    addi x2, x2, 1         # Test 14 başarılı
    j bgeu_continue_1
bgeu_false_1:
    addi x2, x2, 100       # Hata
bgeu_continue_1:
    
    # Test 15: BGEU - Branch if Greater or Equal Unsigned (eşit durum)
    addi x3, x0, 10
    addi x4, x0, 10
    bgeu x3, x4, bgeu_true_2
    addi x2, x2, 100       # Hata
bgeu_true_2:
    addi x2, x2, 1         # Test 15 başarılı
    
    # Uzun mesafe branch testi (12-bit immediate limit)
    addi x3, x0, 1
    addi x4, x0, 1
    beq x3, x4, long_branch_target
    addi x2, x2, 100       # Hata

long_branch_target:
    addi x2, x2, 1         # Test 16 başarılı (uzun mesafe branch)
    
    # Test sonuçlarını belleğe yaz
    sw x2, 0(x1)           # Test sayacı (16 olmalı)
    
    # Bireysel test sonuçlarını da kaydet
    addi x5, x0, 16        # Beklenen test sayısı
    sub x6, x2, x5         # Fark (0 olmalı)
    sw x5, 4(x1)           # Beklenen değer
    sw x6, 8(x1)           # Hata sayısı

    # ========== CLZ (Count Leading Zeros) Testleri ==========
    
    # Test 1: CLZ - 0x00000001 (31 leading zeros)
    li x3, 0x00000001
    clz x4, x3
    addi x5, x0, 31        # Beklenen sonuç
    beq x4, x5, clz_test1_pass
    addi x2, x2, 100       # Hata
clz_test1_pass:
    addi x2, x2, 1         # Test 1 başarılı
    sw x3, 0(x1)           # Test değeri
    sw x4, 4(x1)           # Sonuç
    sw x5, 8(x1)           # Beklenen
    
    # Test 2: CLZ - 0x80000000 (0 leading zeros)
    li x3, 0x80000000
    clz x4, x3
    addi x5, x0, 0         # Beklenen sonuç
    beq x4, x5, clz_test2_pass
    addi x2, x2, 100       # Hata
clz_test2_pass:
    addi x2, x2, 1         # Test 2 başarılı
    sw x3, 12(x1)
    sw x4, 16(x1)
    sw x5, 20(x1)
    
    # Test 3: CLZ - 0x00000000 (32 leading zeros - özel durum)
    li x3, 0x00000000
    clz x4, x3
    addi x5, x0, 32        # Beklenen sonuç
    beq x4, x5, clz_test3_pass
    addi x2, x2, 100       # Hata
clz_test3_pass:
    addi x2, x2, 1         # Test 3 başarılı
    sw x3, 24(x1)
    sw x4, 28(x1)
    sw x5, 32(x1)
    
    # Test 4: CLZ - 0x0000FF00 (16 leading zeros)
    li x3, 0x0000FF00
    clz x4, x3
    addi x5, x0, 16        # Beklenen sonuç
    beq x4, x5, clz_test4_pass
    addi x2, x2, 100       # Hata
clz_test4_pass:
    addi x2, x2, 1         # Test 4 başarılı
    sw x3, 36(x1)
    sw x4, 40(x1)
    sw x5, 44(x1)
    
    # ========== CTZ (Count Trailing Zeros) Testleri ==========
    
    # Test 5: CTZ - 0x80000000 (31 trailing zeros)
    li x3, 0x80000000
    ctz x4, x3
    addi x5, x0, 31        # Beklenen sonuç
    beq x4, x5, ctz_test1_pass
    addi x2, x2, 100       # Hata
ctz_test1_pass:
    addi x2, x2, 1         # Test 5 başarılı
    sw x3, 48(x1)
    sw x4, 52(x1)
    sw x5, 56(x1)
    
    # Test 6: CTZ - 0x00000001 (0 trailing zeros)
    li x3, 0x00000001
    ctz x4, x3
    addi x5, x0, 0         # Beklenen sonuç
    beq x4, x5, ctz_test2_pass
    addi x2, x2, 100       # Hata
ctz_test2_pass:
    addi x2, x2, 1         # Test 6 başarılı
    sw x3, 60(x1)
    sw x4, 64(x1)
    sw x5, 68(x1)
    
    # Test 7: CTZ - 0x00000000 (32 trailing zeros - özel durum)
    li x3, 0x00000000
    ctz x4, x3
    addi x5, x0, 32        # Beklenen sonuç
    beq x4, x5, ctz_test3_pass
    addi x2, x2, 100       # Hata
ctz_test3_pass:
    addi x2, x2, 1         # Test 7 başarılı
    sw x3, 72(x1)
    sw x4, 76(x1)
    sw x5, 80(x1)
    
    # Test 8: CTZ - 0x00FF0000 (16 trailing zeros)
    li x3, 0x00FF0000
    ctz x4, x3
    addi x5, x0, 16        # Beklenen sonuç
    beq x4, x5, ctz_test4_pass
    addi x2, x2, 100       # Hata
ctz_test4_pass:
    addi x2, x2, 1         # Test 8 başarılı
    sw x3, 84(x1)
    sw x4, 88(x1)
    sw x5, 92(x1)
    
    # ========== CPOP (Count Population / Popcount) Testleri ==========
    
    # Test 9: CPOP - 0x00000000 (0 bits set)
    li x3, 0x00000000
    cpop x4, x3
    addi x5, x0, 0         # Beklenen sonuç
    beq x4, x5, cpop_test1_pass
    addi x2, x2, 100       # Hata
cpop_test1_pass:
    addi x2, x2, 1         # Test 9 başarılı
    sw x3, 96(x1)
    sw x4, 100(x1)
    sw x5, 104(x1)
    
    # Test 10: CPOP - 0xFFFFFFFF (32 bits set)
    li x3, 0xFFFFFFFF
    cpop x4, x3
    addi x5, x0, 32        # Beklenen sonuç
    beq x4, x5, cpop_test2_pass
    addi x2, x2, 100       # Hata
cpop_test2_pass:
    addi x2, x2, 1         # Test 10 başarılı
    sw x3, 108(x1)
    sw x4, 112(x1)
    sw x5, 116(x1)
    
    # Test 11: CPOP - 0x0000000F (4 bits set)
    li x3, 0x0000000F
    cpop x4, x3
    addi x5, x0, 4         # Beklenen sonuç
    beq x4, x5, cpop_test3_pass
    addi x2, x2, 100       # Hata
cpop_test3_pass:
    addi x2, x2, 1         # Test 11 başarılı
    sw x3, 120(x1)
    sw x4, 124(x1)
    sw x5, 128(x1)
    
    # Test 12: CPOP - 0xAAAAAAAA (16 bits set - alternating pattern)
    li x3, 0xAAAAAAAA
    cpop x4, x3
    addi x5, x0, 16        # Beklenen sonuç
    beq x4, x5, cpop_test4_pass
    addi x2, x2, 100       # Hata
cpop_test4_pass:
    addi x2, x2, 1         # Test 12 başarılı
    sw x3, 132(x1)
    sw x4, 136(x1)
    sw x5, 140(x1)
    
    # Test 13: CPOP - 0x55555555 (16 bits set - alternating pattern)
    li x3, 0x55555555
    cpop x4, x3
    addi x5, x0, 16        # Beklenen sonuç
    beq x4, x5, cpop_test5_pass
    addi x2, x2, 100       # Hata
cpop_test5_pass:
    addi x2, x2, 1         # Test 13 başarılı
    sw x3, 144(x1)
    sw x4, 148(x1)
    sw x5, 152(x1)
    
    # ========== Kombine Testler ==========
    
    # Test 14: Aynı değer üzerinde tüm operasyonlar
    li x3, 0x12345678
    clz x6, x3             # Leading zeros
    ctz x7, x3             # Trailing zeros
    cpop x8, x3            # Population count
    
    # 0x12345678 için beklenen değerler:
    # CLZ: 3 (001...) - ilk 3 bit 0
    # CTZ: 3 (...000) - son 3 bit 0
    # CPOP: 13 (bit sayısı)
    
    addi x9, x0, 3         # CLZ beklenen
    addi x10, x0, 3        # CTZ beklenen
    addi x11, x0, 13       # CPOP beklenen
    
    beq x6, x9, test14_clz_ok
    addi x2, x2, 100
test14_clz_ok:
    beq x7, x10, test14_ctz_ok
    addi x2, x2, 100
test14_ctz_ok:
    beq x8, x11, test14_cpop_ok
    addi x2, x2, 100
test14_cpop_ok:
    addi x2, x2, 1         # Test 14 başarılı
    
    sw x3, 156(x1)         # Test değeri
    sw x6, 160(x1)         # CLZ sonucu
    sw x7, 164(x1)         # CTZ sonucu
    sw x8, 168(x1)         # CPOP sonucu
    sw x9, 172(x1)         # CLZ beklenen
    sw x10, 176(x1)        # CTZ beklenen
    sw x11, 180(x1)        # CPOP beklenen
    
    # ========== Sonuç ==========
    
    # Test sayacını kaydet (14 olmalı tüm testler başarılıysa)
    li x12, 0x80000200     # Sonuç adresi
    sw x2, 0(x12)          # Test sayacı
    
    addi x13, x0, 14       # Beklenen test sayısı
    sw x13, 4(x12)         # Beklenen değer
    
    sub x14, x2, x13       # Fark (0 olmalı)
    sw x14, 8(x12)         # Hata sayısı
    
    li a0, 0
    j exit

.align 12
exit:
    j exit
    


