.section .text
.globl _start

_start:

addi x2, x0, 0
addi x3, x0, 0
addi x4, x0, 0

li x2, -1             # x2 = 0xFFFFFFFF
li x13, 1
sll x14, x13, x2      # shift by 31

addi       x0 ,x5  ,-825
addi       x0 ,x6  ,-492
addi       x0 ,x7  ,257
addi       x0 ,x8  ,-131
addi       x0 ,x9  ,-802
addi       x0 ,x10 ,-516
addi       x0 ,x11 ,-223
addi       x0 ,x12 ,-732
addi       x0 ,x13 ,-302
addi       x0 ,x14 ,999
addi       x0 ,x15 ,-986
addi       x0 ,x16 ,455
addi       x0 ,x17 ,649
addi       x0 ,x18 ,-653
addi       x0 ,x19 ,-210
addi       x0 ,x20 ,-29
addi       x0 ,x21 ,170
addi       x0 ,x22 ,529
addi       x0 ,x23 ,943
addi       x0 ,x24 ,571
addi       x0 ,x25 ,-237
addi       x0 ,x26 ,-531
addi       x0 ,x27 ,757
addi       x0 ,x28 ,-182
addi       x0 ,x29 ,670
addi       x0 ,x30 ,196
addi       x0 ,x31 ,-376

#-------------add instruction-------------------
#---Target register in rs1---
add       x11, x31, x28
addi      x15, x11, -33
#-------------------------
add       x31, x24, x16
xor       x14, x31, x17
andi      x24, x31, 32 
#-------------------------
add       x21, x26, x9 
xor       x22, x21, x28
add       x13, x21, x15
sub       x6 , x21, x6 
#-------------------------
add       x28, x13, x14
or        x31, x28, x30
xori      x8 , x28, 38 
ori       x18, x28, 1  
sub       x25, x28, x9 
#-------------------------
add       x6 , x8 , x14
add       x9 , x6 , x22
ori       x27, x6 , 36 
add       x22, x6 , x28
and       x28, x6 , x6 
and       x16, x6 , x7 
#-------------------------
#---Target register in rs2---
add       x17, x11, x10
sub       x21, x10, x17
#-------------------------
add       x21, x31, x14
xor       x6 , x24, x21
xor       x5 , x24, x21
#-------------------------
add       x19, x25, x29
sub       x16, x30, x19
add       x30, x30, x19
and       x22, x30, x19
#-------------------------
add       x5 , x23, x8 
add       x25, x8 , x5 
add       x15, x8 , x5 
or        x21, x21, x5 
and       x7 , x19, x5 
#-------------------------
add       x19, x27, x29
or        x10, x5 , x19
or        x30, x5 , x19
or        x31, x20, x19
and       x31, x20, x19
sub       x8 , x20, x19
#-------------------------
#-------------sub instruction-------------------
#---Target register in rs1---
sub       x26, x18, x20
xor       x12, x26, x10
#-------------------------
sub       x12, x19, x10
and       x8 , x12, x16
xori      x28, x12, 30 
#-------------------------
sub       x28, x7 , x14
add       x28, x28, x12
xor       x7 , x28, x12
addi      x11, x28, 22 
#-------------------------
sub       x8 , x7 , x27
ori       x7 , x8 , -40
xori      x28, x8 , -27
add       x28, x8 , x16
or        x23, x8 , x18
#-------------------------
sub       x12, x6 , x9 
xor       x27, x12, x6 
xor       x15, x12, x20
sub       x12, x12, x26
addi      x21, x12, 9  
ori       x23, x12, -7 
#-------------------------
#---Target register in rs2---
sub       x5 , x19, x15
add       x12, x16, x5 
#-------------------------
sub       x16, x27, x28
or        x29, x28, x16
or        x23, x18, x16
#-------------------------
sub       x10, x21, x16
and       x26, x16, x10
xor       x22, x5 , x10
xor       x24, x26, x10
#-------------------------
sub       x16, x14, x8 
or        x16, x8 , x16
sub       x31, x7 , x16
or        x17, x17, x16
sub       x6 , x17, x16
#-------------------------
sub       x24, x8 , x20
and       x9 , x20, x24
xor       x27, x20, x24
add       x9 , x28, x24
sub       x23, x12, x24
xor       x10, x12, x24
#-------------------------

#-------------xor instruction-------------------
#---Target register in rs1---
xor       x28, x6 , x20
xor       x28, x28, x5 
#-------------------------
xor       x16, x14, x26
add       x18, x16, x18
andi      x21, x16, 1  
#-------------------------
xor       x26, x17, x16
xor       x16, x26, x28
or        x12, x26, x28
sub       x24, x26, x31
#-------------------------
xor       x6 , x7 , x15
add       x13, x6 , x6 
ori       x14, x6 , -17
andi      x6 , x6 , 38 
addi      x17, x6 , -13
#-------------------------
xor       x25, x19, x11
sub       x14, x25, x11
ori       x26, x25, 3  
ori       x18, x25, -40
add       x8 , x25, x22
sub       x5 , x25, x30
#-------------------------
#---Target register in rs2---
xor       x5 , x16, x19
xor       x25, x19, x5 
#-------------------------
xor       x27, x28, x5 
and       x7 , x5 , x27
xor       x29, x31, x27
#-------------------------
xor       x6 , x10, x11
add       x12, x27, x6 
xor       x31, x8 , x6 
add       x15, x10, x6 
#-------------------------
xor       x12, x8 , x22
and       x27, x22, x12
sub       x16, x22, x12
sub       x26, x20, x12
sub       x23, x30, x12
#-------------------------
xor       x26, x29, x30
add       x24, x17, x26
and       x25, x16, x26
xor       x14, x16, x26
sub       x6 , x16, x26
xor       x8 , x26, x26
#-------------------------

#-------------or instruction-------------------
#---Target register in rs1---
or        x12, x15, x19
or        x25, x12, x5 
#-------------------------
or        x7 , x19, x26
addi      x13, x7 , -24
andi      x13, x7 , 31 
#-------------------------
or        x27, x11, x22
and       x20, x27, x15
sub       x14, x27, x20
addi      x23, x27, -33
#-------------------------
or        x14, x27, x20
add       x22, x14, x27
xori      x7 , x14, 26 
andi      x24, x14, 39 
addi      x17, x14, -12
#-------------------------
or        x25, x13, x12
xori      x7 , x25, -37
sub       x17, x25, x15
addi      x31, x25, -17
add       x14, x25, x29
ori       x22, x25, -27
#-------------------------
#---Target register in rs2---
or        x13, x28, x5 
add       x17, x9 , x13
#-------------------------
or        x7 , x8 , x9 
sub       x31, x12, x7 
or        x12, x12, x7 
#-------------------------
or        x15, x17, x18
add       x5 , x12, x15
add       x25, x12, x15
or        x12, x19, x15
#-------------------------
or        x20, x27, x10
add       x9 , x13, x20
sub       x14, x13, x20
add       x9 , x21, x20
and       x6 , x21, x20
#-------------------------
or        x23, x5 , x8 
add       x17, x8 , x23
or        x20, x19, x23
add       x10, x13, x23
and       x20, x13, x23
or        x22, x16, x23
#-------------------------

#-------------and instruction-------------------
#---Target register in rs1---
and       x7 , x18, x26
and       x26, x7 , x25
#-------------------------
and       x22, x21, x27
andi      x21, x22, -9 
or        x27, x22, x20
#-------------------------
and       x6 , x28, x31
andi      x9 , x6 , -35
and       x31, x6 , x5 
or        x14, x6 , x11
#-------------------------
and       x15, x14, x26
andi      x9 , x15, 30 
sub       x12, x15, x24
addi      x6 , x15, 17 
sub       x25, x15, x28
#-------------------------
and       x11, x24, x12
addi      x27, x11, 0  
or        x17, x11, x8 
add       x10, x11, x8 
and       x8 , x11, x11
add       x29, x11, x14
#-------------------------
#---Target register in rs2---
and       x19, x30, x18
or        x28, x5 , x19
#-------------------------
and       x11, x29, x18
or        x30, x20, x11
add       x27, x20, x11
#-------------------------
and       x25, x30, x19
and       x28, x19, x25
and       x12, x23, x25
or        x11, x18, x25
#-------------------------
and       x7 , x12, x31
add       x29, x21, x7 
or        x29, x7 , x7 
and       x21, x7 , x7 
and       x9 , x13, x7 
#-------------------------
and       x17, x13, x6 
add       x10, x6 , x17
or        x17, x19, x17
or        x15, x19, x17
sub       x8 , x19, x17
add       x17, x19, x17
#-------------------------

#-------------addi instruction-------------------
#---Target register in rs1---
addi      x15, x12, -4 
or        x15, x15, x21
#-------------------------
addi      x30, x11, -5 
addi      x15, x30, 2  
or        x13, x30, x24
#-------------------------
addi      x30, x23, 35 
xori      x25, x30, -9 
ori       x19, x30, -34
ori       x27, x30, 12 
#-------------------------
addi      x11, x31, 6  
addi      x23, x11, -20
andi      x31, x11, -33
ori       x21, x11, -27
ori       x17, x11, -36
#-------------------------
addi      x13, x5 , -14
andi      x22, x13, -7 
and       x17, x13, x25
or        x9 , x13, x19
or        x9 , x13, x29
xori      x13, x13, -13
#-------------------------

#-------------xori instruction-------------------
#---Target register in rs1---
xori      x26, x22, -17
addi      x31, x26, -24
#-------------------------
xori      x27, x28, 12 
and       x17, x27, x15
add       x17, x27, x5 
#-------------------------
xori      x27, x13, -19
xori      x28, x27, -32
or        x12, x27, x8 
andi      x16, x27, -6 
#-------------------------
xori      x5 , x14, -11
sub       x23, x5 , x30
and       x7 , x5 , x18
andi      x23, x5 , -4 
andi      x16, x5 , -5 
#-------------------------
xori      x5 , x20, -4 
sub       x16, x5 , x15
ori       x16, x5 , 14 
ori       x12, x5 , 18 
sub       x30, x5 , x15
andi      x5 , x5 , -25
#-------------------------

#-------------ori instruction-------------------
#---Target register in rs1---
ori       x15, x5 , -14
add       x8 , x15, x16
#-------------------------
ori       x22, x17, 19 
add       x24, x22, x18
addi      x24, x22, -22
#-------------------------
ori       x23, x20, -10
addi      x13, x23, 24 
sub       x16, x23, x15
add       x29, x23, x12
#-------------------------
ori       x7 , x5 , -37
xor       x31, x7 , x20
xor       x5 , x7 , x10
xor       x9 , x7 , x18
or        x16, x7 , x21
#-------------------------
ori       x19, x11, -1 
sub       x22, x19, x30
andi      x26, x19, 8  
add       x16, x19, x13
xori      x9 , x19, -29
xor       x7 , x19, x23
#-------------------------

#-------------andi instruction-------------------
#---Target register in rs1---
andi      x5 , x10, -24
or        x15, x5 , x21
#-------------------------
andi      x28, x6 , 5  
xor       x21, x28, x18
add       x31, x28, x9 
#-------------------------
andi      x7 , x10, 36 
xor       x19, x7 , x23
ori       x31, x7 , -15
ori       x8 , x7 , 18 
#-------------------------
andi      x16, x25, 26 
xor       x17, x16, x31
or        x27, x16, x21
ori       x14, x16, 8  
xori      x20, x16, 11 
#-------------------------
andi      x28, x26, 29 
addi      x29, x28, 31 
add       x13, x28, x17
xori      x28, x28, 16 
xor       x16, x28, x11
addi      x18, x28, -40
#-------------------------

#-------------add instruction-------------------
#---Target register in rs1---
add       x6 , x24, x15
sub       x31, x6 , x23
#-------------------------
add       x20, x13, x8 
addi      x11, x20, 32 
add       x13, x20, x8 
#-------------------------
add       x13, x7 , x16
or        x22, x13, x7 
xori      x9 , x13, -13
ori       x23, x13, 38 
#-------------------------
add       x21, x25, x31
xor       x21, x21, x5 
xori      x19, x21, 27 
and       x27, x21, x30
sub       x14, x21, x11
#-------------------------
add       x11, x16, x5 
xor       x12, x11, x8 
or        x17, x11, x9 
xor       x9 , x11, x26
ori       x24, x11, 32 
addi      x11, x11, 34 
#-------------------------
#---Target register in rs2---
add       x29, x23, x25
and       x11, x19, x29
#-------------------------
add       x10, x15, x22
and       x9 , x5 , x10
or        x12, x28, x10
#-------------------------
add       x22, x21, x31
and       x25, x31, x22
sub       x30, x31, x22
xor       x19, x19, x22
#-------------------------
add       x31, x20, x27
xor       x25, x27, x31
add       x24, x27, x31
and       x21, x10, x31
or        x10, x16, x31
#-------------------------
add       x30, x15, x27
xor       x16, x27, x30
or        x23, x7 , x30
and       x29, x25, x30
xor       x21, x10, x30
xor       x17, x18, x30
#-------------------------

#-------------sub instruction-------------------
#---Target register in rs1---
sub       x9 , x7 , x22
xori      x11, x9 , -22
#-------------------------
sub       x7 , x14, x19
add       x12, x7 , x16
xori      x24, x7 , -40
#-------------------------
sub       x29, x16, x23
add       x10, x29, x16
or        x8 , x29, x16
and       x25, x29, x7 
#-------------------------
sub       x20, x25, x13
ori       x12, x20, 33 
or        x18, x20, x12
addi      x6 , x20, 22 
sub       x16, x20, x18
#-------------------------
sub       x29, x10, x23
sub       x10, x29, x22
xori      x6 , x29, -15
add       x7 , x29, x20
xor       x27, x29, x17
andi      x7 , x29, -12
#-------------------------
#---Target register in rs2---
sub       x21, x5 , x19
add       x27, x19, x21
#-------------------------
sub       x21, x19, x6 
xor       x22, x14, x21
xor       x30, x14, x21
#-------------------------
sub       x18, x30, x14
or        x10, x13, x18
add       x18, x13, x18
add       x22, x8 , x18
#-------------------------
sub       x23, x15, x27
sub       x30, x27, x23
sub       x21, x8 , x23
add       x6 , x31, x23
or        x24, x28, x23
#-------------------------
sub       x16, x31, x6 
xor       x22, x14, x16
and       x25, x14, x16
xor       x30, x12, x16
xor       x22, x7 , x16
add       x10, x7 , x16
#-------------------------

#-------------xor instruction-------------------
#---Target register in rs1---
xor       x12, x9 , x17
add       x15, x12, x13
#-------------------------
xor       x31, x11, x28
xori      x26, x31, -13
and       x25, x31, x10
#-------------------------
xor       x20, x28, x9 
add       x6 , x20, x27
sub       x15, x20, x7 
and       x11, x20, x14
#-------------------------
xor       x8 , x23, x15
xori      x27, x8 , -28
ori       x18, x8 , 6  
sub       x19, x8 , x11
add       x9 , x8 , x26
#-------------------------
xor       x23, x21, x12
addi      x24, x23, -31
sub       x17, x23, x23
xori      x9 , x23, 24 
xor       x27, x23, x15
ori       x27, x23, -13
#-------------------------
#---Target register in rs2---
xor       x7 , x24, x17
and       x9 , x11, x7 
#-------------------------
xor       x31, x26, x23
xor       x14, x7 , x31
add       x9 , x29, x31
#-------------------------
xor       x6 , x13, x9 
and       x10, x7 , x6 
and       x10, x7 , x6 
xor       x29, x7 , x6 
#-------------------------
xor       x17, x13, x22
sub       x19, x30, x17
xor       x5 , x19, x17
xor       x8 , x7 , x17
xor       x28, x25, x17
#-------------------------
xor       x27, x16, x25
xor       x18, x25, x27
add       x10, x25, x27
add       x16, x24, x27
xor       x25, x29, x27
sub       x29, x18, x27
#-------------------------

#-------------or instruction-------------------
#---Target register in rs1---
or        x10, x31, x22
sub       x22, x10, x20
#-------------------------
or        x14, x9 , x12
sub       x6 , x14, x9 
or        x18, x14, x31
#-------------------------
or        x21, x26, x16
andi      x6 , x21, 7  
addi      x31, x21, 7  
addi      x8 , x21, -8 
#-------------------------
or        x24, x14, x11
xor       x28, x24, x10
sub       x14, x24, x23
add       x22, x24, x5 
xor       x29, x24, x12
#-------------------------
or        x30, x19, x15
addi      x5 , x30, 27 
and       x21, x30, x16
sub       x18, x30, x15
xori      x14, x30, 2  
xor       x9 , x30, x20
#-------------------------
#---Target register in rs2---
or        x18, x12, x20
xor       x22, x5 , x18
#-------------------------
or        x26, x28, x12
sub       x15, x12, x26
sub       x28, x28, x26
#-------------------------
or        x20, x28, x25
or        x11, x25, x20
add       x20, x22, x20
and       x26, x22, x20
#-------------------------
or        x18, x19, x24
xor       x13, x19, x18
and       x7 , x7 , x18
sub       x9 , x7 , x18
and       x31, x7 , x18
#-------------------------
or        x12, x29, x26
add       x19, x8 , x12
or        x27, x21, x12
xor       x26, x10, x12
and       x31, x26, x12
add       x8 , x26, x12
#-------------------------

#-------------and instruction-------------------
#---Target register in rs1---
and       x15, x29, x18
ori       x11, x15, 23 
#-------------------------
and       x21, x13, x6 
addi      x31, x21, 29 
or        x24, x21, x26
#-------------------------
and       x17, x5 , x24
or        x30, x17, x30
andi      x14, x17, 27 
addi      x19, x17, -31
#-------------------------
and       x25, x9 , x23
addi      x10, x25, -14
xor       x28, x25, x23
andi      x6 , x25, -17
and       x9 , x25, x13
#-------------------------
and       x29, x18, x14
xor       x24, x29, x25
xor       x20, x29, x6 
and       x10, x29, x7 
and       x8 , x29, x14
xor       x11, x29, x11
#-------------------------
#---Target register in rs2---
and       x6 , x5 , x21
and       x30, x24, x6 
#-------------------------
and       x7 , x29, x22
xor       x12, x22, x7 
sub       x20, x23, x7 
#-------------------------
and       x28, x31, x11
and       x30, x5 , x28
add       x6 , x28, x28
add       x21, x20, x28
#-------------------------
and       x21, x31, x17
sub       x11, x9 , x21
xor       x25, x9 , x21
xor       x20, x12, x21
and       x8 , x29, x21
#-------------------------
and       x18, x25, x16
add       x13, x16, x18
xor       x6 , x16, x18
or        x16, x16, x18
and       x28, x12, x18
add       x5 , x26, x18
#-------------------------

#-------------addi instruction-------------------
#---Target register in rs1---
addi      x18, x27, -11
sub       x13, x18, x18
#-------------------------
addi      x17, x6 , -30
xori      x14, x17, 40 
addi      x21, x17, -26
#-------------------------
addi      x27, x29, -37
add       x22, x27, x13
and       x18, x27, x31
xor       x18, x27, x23
#-------------------------
addi      x23, x25, 15 
xor       x12, x23, x25
sub       x13, x23, x10
or        x14, x23, x25
sub       x29, x23, x11
#-------------------------
addi      x19, x20, 5  
xori      x8 , x19, -23
andi      x30, x19, -3 
addi      x15, x19, 8  
xor       x26, x19, x7 
or        x16, x19, x22
#-------------------------

#-------------xori instruction-------------------
#---Target register in rs1---
xori      x27, x13, -34
xori      x27, x27, 8  
#-------------------------
xori      x8 , x28, 27 
xori      x10, x8 , 7  
andi      x19, x8 , 30 
#-------------------------
xori      x10, x24, 39 
xori      x12, x10, 12 
add       x26, x10, x27
sub       x13, x10, x16
#-------------------------
xori      x21, x28, 37 
xori      x25, x21, 8  
xor       x21, x21, x29
andi      x22, x21, -36
sub       x10, x21, x20
#-------------------------
xori      x10, x11, 38 
xori      x27, x10, 4  
sub       x16, x10, x10
addi      x10, x10, 32 
andi      x9 , x10, -33
xori      x8 , x10, -16
#-------------------------

#-------------ori instruction-------------------
#---Target register in rs1---
ori       x5 , x12, -36
ori       x10, x5 , 14 
#-------------------------
ori       x30, x29, 22 
and       x29, x30, x11
sub       x30, x30, x5 
#-------------------------
ori       x7 , x24, -9 
sub       x21, x7 , x25
sub       x28, x7 , x13
xori      x18, x7 , -1 
#-------------------------
ori       x18, x22, 12 
addi      x6 , x18, -7 
or        x8 , x18, x27
addi      x31, x18, -25
addi      x24, x18, -40
#-------------------------
ori       x12, x16, -18
addi      x8 , x12, -2 
xori      x10, x12, -24
and       x26, x12, x5 
xor       x30, x12, x15
add       x18, x12, x10
#-------------------------

#-------------andi instruction-------------------
#---Target register in rs1---
andi      x14, x9 , -13
xori      x18, x14, 26 
#-------------------------
andi      x27, x21, -13
sub       x5 , x27, x13
andi      x27, x27, 40 
#-------------------------
andi      x10, x31, -38
add       x21, x10, x28
sub       x27, x10, x8 
addi      x14, x10, 23 
#-------------------------
andi      x7 , x11, -9 
add       x11, x7 , x13
sub       x28, x7 , x10
and       x28, x7 , x15
and       x25, x7 , x25
#-------------------------
andi      x8 , x20, 34 
xor       x11, x8 , x26
xori      x29, x8 , 22 
andi      x23, x8 , -32
addi      x16, x8 , -35
sub       x22, x8 , x12
#-------------------------
addi      x0 , x5 , -689
addi      x0 , x6 , -224
addi      x0 , x7 , 701
addi      x0 , x8 , -164
addi      x0 , x9 , 490
addi      x0 , x10, 769
addi      x0 , x11, 95
addi      x0 , x12, -404
addi      x0 , x13, -789
addi      x0 , x14, 561
addi      x0 , x15, 833
addi      x0 , x16, 222
addi      x0 , x17, -665
addi      x0 , x18, 512
addi      x0 , x19, -339
addi      x0 , x20, 596
addi      x0 , x21, 119
addi      x0 , x22, 488
addi      x0 , x23, -2
addi      x0 , x24, -492
addi      x0 , x25, 473
addi      x0 , x26, -823
addi      x0 , x27, 772
addi      x0 , x28, 770
addi      x0 , x29, 359
addi      x0 , x30, -563
addi      x0 , x31, -685

#-------------add instruction-------------------
#---Target register in rs1---
add       x30, x7 , x26
addi      x30, x30, -6 
#-------------------------
add       x20, x15, x29
ori       x13, x20, -22
ori       x23, x20, -18
#-------------------------
add       x26, x11, x22
sub       x27, x26, x23
or        x30, x26, x27
add       x12, x26, x16
#-------------------------
add       x24, x29, x15
xori      x31, x24, -18
andi      x15, x24, 31 
add       x18, x24, x5 
addi      x21, x24, -12
#-------------------------
add       x18, x30, x14
add       x21, x18, x21
xor       x15, x18, x10
andi      x6 , x18, 21 
xori      x12, x18, 15 
xori      x12, x18, -5 
#-------------------------
#---Target register in rs2---
add       x19, x11, x14
add       x29, x12, x19
#-------------------------
add       x29, x18, x31
add       x26, x10, x29
or        x7 , x10, x29
#-------------------------
add       x29, x10, x15
xor       x8 , x21, x29
sub       x22, x21, x29
and       x24, x21, x29
#-------------------------
add       x23, x10, x25
or        x21, x29, x23
or        x10, x21, x23
add       x15, x21, x23
sub       x30, x21, x23
#-------------------------
add       x22, x14, x30
and       x18, x25, x22
or        x10, x25, x22
sub       x17, x25, x22
xor       x24, x25, x22
xor       x26, x25, x22
#-------------------------

#-------------sub instruction-------------------
#---Target register in rs1---
sub       x17, x19, x16
xori      x14, x17, -8 
#-------------------------
sub       x26, x13, x30
xor       x29, x26, x19
or        x28, x26, x16
#-------------------------
sub       x26, x23, x22
andi      x7 , x26, 28 
sub       x30, x26, x6 
add       x12, x26, x17
#-------------------------
sub       x15, x28, x29
addi      x14, x15, 23 
addi      x13, x15, -4 
ori       x21, x15, -16
sub       x10, x15, x13
#-------------------------
sub       x12, x22, x5 
add       x16, x12, x8 
sub       x29, x12, x22
and       x20, x12, x18
xori      x15, x12, 14 
sub       x24, x12, x20
#-------------------------
#---Target register in rs2---
sub       x10, x5 , x8 
xor       x13, x8 , x10
#-------------------------
sub       x25, x27, x11
add       x11, x11, x25
and       x17, x22, x25
#-------------------------
sub       x14, x31, x20
add       x8 , x14, x14
or        x11, x14, x14
sub       x13, x14, x14
#-------------------------
sub       x16, x7 , x11
or        x13, x25, x16
xor       x30, x25, x16
xor       x13, x25, x16
or        x5 , x25, x16
#-------------------------
sub       x31, x20, x6 
sub       x11, x25, x31
or        x31, x17, x31
add       x19, x17, x31
xor       x31, x21, x31
add       x13, x21, x31
#-------------------------

#-------------xor instruction-------------------
#---Target register in rs1---
xor       x27, x10, x9 
ori       x6 , x27, 24 
#-------------------------
xor       x13, x18, x5 
xori      x12, x13, -32
andi      x20, x13, 40 
#-------------------------
xor       x23, x6 , x7 
sub       x28, x23, x11
sub       x24, x23, x9 
ori       x23, x23, 23 
#-------------------------
xor       x14, x6 , x17
add       x20, x14, x5 
add       x17, x14, x9 
xor       x22, x14, x17
or        x22, x14, x29
#-------------------------
xor       x28, x20, x5 
addi      x17, x28, -36
ori       x8 , x28, -17
addi      x10, x28, 7  
andi      x19, x28, -19
ori       x26, x28, 25 
#-------------------------
#---Target register in rs2---
xor       x7 , x5 , x18
sub       x22, x18, x7 
#-------------------------
xor       x23, x20, x10
xor       x19, x30, x23
xor       x9 , x19, x23
#-------------------------
xor       x8 , x23, x29
and       x20, x29, x8 
or        x31, x19, x8 
add       x18, x19, x8 
#-------------------------
xor       x14, x27, x5 
and       x18, x28, x14
add       x7 , x13, x14
and       x14, x16, x14
or        x7 , x15, x14
#-------------------------
xor       x8 , x21, x9 
add       x7 , x9 , x8 
and       x20, x9 , x8 
or        x25, x9 , x8 
sub       x9 , x9 , x8 
add       x10, x9 , x8 
#-------------------------

#-------------or instruction-------------------
#---Target register in rs1---
or        x12, x13, x15
xori      x11, x12, 15 
#-------------------------
or        x27, x14, x26
xor       x22, x27, x5 
add       x23, x27, x22
#-------------------------
or        x29, x5 , x26
xori      x11, x29, 14 
xori      x19, x29, -5 
addi      x10, x29, 38 
#-------------------------
or        x25, x8 , x6 
and       x12, x25, x25
and       x17, x25, x16
andi      x23, x25, -10
xori      x19, x25, 14 
#-------------------------
or        x23, x8 , x6 
addi      x24, x23, 21 
addi      x27, x23, 15 
xor       x13, x23, x19
xor       x24, x23, x14
and       x14, x23, x12
#-------------------------
#---Target register in rs2---
or        x17, x23, x27
or        x14, x14, x17
#-------------------------
or        x20, x18, x11
or        x21, x11, x20
and       x20, x11, x20
#-------------------------
or        x16, x20, x28
add       x27, x28, x16
xor       x28, x14, x16
add       x23, x14, x16
#-------------------------
or        x30, x18, x22
sub       x13, x31, x30
add       x26, x18, x30
sub       x11, x29, x30
xor       x11, x22, x30
#-------------------------
or        x30, x8 , x18
xor       x14, x18, x30
sub       x10, x7 , x30
and       x9 , x20, x30
sub       x29, x6 , x30
sub       x29, x6 , x30
#-------------------------

#-------------and instruction-------------------
#---Target register in rs1---
and       x8 , x31, x12
xor       x28, x8 , x26
#-------------------------
and       x28, x24, x8 
and       x28, x28, x19
andi      x13, x28, 38 
#-------------------------
and       x18, x28, x25
add       x18, x18, x19
add       x25, x18, x19
add       x15, x18, x16
#-------------------------
and       x13, x9 , x26
xor       x21, x13, x24
addi      x21, x13, -33
ori       x15, x13, -3 
xor       x16, x13, x29
#-------------------------
and       x31, x25, x17
add       x9 , x31, x27
andi      x10, x31, 24 
andi      x14, x31, 15 
or        x31, x31, x14
ori       x20, x31, 34 
#-------------------------
#---Target register in rs2---
and       x25, x22, x27
add       x16, x26, x25
#-------------------------
and       x24, x18, x17
or        x25, x17, x24
or        x17, x20, x24
#-------------------------
and       x30, x12, x7 
add       x31, x10, x30
sub       x22, x18, x30
or        x12, x18, x30
#-------------------------
and       x23, x27, x12
add       x25, x21, x23
add       x14, x18, x23
add       x10, x27, x23
sub       x17, x27, x23
#-------------------------
and       x24, x23, x26
or        x13, x26, x24
or        x6 , x26, x24
and       x13, x26, x24
or        x9 , x21, x24
and       x5 , x21, x24
#-------------------------

#-------------addi instruction-------------------
#---Target register in rs1---
addi      x10, x27, -17
or        x10, x10, x6 
#-------------------------
addi      x15, x8 , 7  
andi      x9 , x15, 17 
addi      x21, x15, -32
#-------------------------
addi      x5 , x17, -11
addi      x30, x5 , 9  
andi      x29, x5 , -28
addi      x15, x5 , 24 
#-------------------------
addi      x16, x24, 24 
ori       x29, x16, 15 
add       x27, x16, x23
addi      x22, x16, -18
or        x17, x16, x7 
#-------------------------
addi      x23, x30, -31
add       x14, x23, x7 
or        x18, x23, x29
sub       x19, x23, x5 
sub       x10, x23, x11
xor       x22, x23, x24
#-------------------------

#-------------xori instruction-------------------
#---Target register in rs1---
xori      x17, x22, 35 
addi      x27, x17, 34 
#-------------------------
xori      x9 , x14, -27
ori       x10, x9 , -34
ori       x26, x9 , -25
#-------------------------
xori      x9 , x15, -23
sub       x31, x9 , x10
xor       x30, x9 , x26
ori       x9 , x9 , 21 
#-------------------------
xori      x22, x12, -7 
or        x27, x22, x7 
andi      x27, x22, -27
xor       x10, x22, x14
sub       x11, x22, x20
#-------------------------
xori      x10, x11, -17
andi      x15, x10, -4 
add       x12, x10, x6 
add       x14, x10, x22
andi      x24, x10, 23 
xori      x5 , x10, 20 
#-------------------------

#-------------ori instruction-------------------
#---Target register in rs1---
ori       x25, x22, -31
and       x15, x25, x14
#-------------------------
ori       x24, x23, -13
add       x9 , x24, x10
ori       x26, x24, -7 
#-------------------------
ori       x16, x29, 4  
xori      x10, x16, -9 
or        x27, x16, x8 
xor       x20, x16, x23
#-------------------------
ori       x21, x20, -3 
and       x17, x21, x8 
ori       x21, x21, 18 
andi      x11, x21, -30
addi      x22, x21, 24 
#-------------------------
ori       x14, x12, -14
sub       x8 , x14, x21
or        x21, x14, x20
xor       x9 , x14, x6 
xori      x5 , x14, 30 
add       x22, x14, x26
#-------------------------

#-------------andi instruction-------------------
#---Target register in rs1---
andi      x11, x18, 1  
xori      x26, x11, 9  
#-------------------------
andi      x19, x7 , 38 
andi      x31, x19, 2  
and       x26, x19, x11
#-------------------------
andi      x8 , x11, -5 
ori       x23, x8 , -13
and       x31, x8 , x6 
add       x30, x8 , x10
#-------------------------
andi      x6 , x23, 1  
andi      x23, x6 , -27
or        x30, x6 , x31
add       x25, x6 , x16
andi      x12, x6 , 29 
#-------------------------
andi      x13, x28, 37 
xor       x24, x13, x21
xori      x23, x13, -33
xori      x20, x13, 38 
and       x5 , x13, x9 
sub       x24, x13, x8 
#-------------------------

#-------------add instruction-------------------
#---Target register in rs1---
add       x19, x27, x24
andi      x26, x19, 12 
#-------------------------
add       x22, x6 , x28
xor       x10, x22, x31
and       x8 , x22, x25
#-------------------------
add       x24, x9 , x29
andi      x18, x24, 14 
addi      x16, x24, -22
add       x21, x24, x10
#-------------------------
add       x18, x8 , x6 
ori       x19, x18, -15
or        x26, x18, x11
and       x18, x18, x28
andi      x6 , x18, -12
#-------------------------
add       x12, x26, x29
xori      x17, x12, -4 
addi      x16, x12, 18 
sub       x26, x12, x10
xor       x27, x12, x20
sub       x16, x12, x18
#-------------------------
#---Target register in rs2---
add       x12, x26, x6 
sub       x10, x30, x12
#-------------------------
add       x24, x15, x25
and       x15, x25, x24
sub       x23, x21, x24
#-------------------------
add       x23, x14, x8 
and       x14, x8 , x23
add       x21, x8 , x23
and       x17, x8 , x23
#-------------------------
add       x30, x8 , x7 
xor       x6 , x8 , x30
or        x12, x8 , x30
sub       x14, x8 , x30
xor       x24, x14, x30
#-------------------------
add       x22, x27, x14
or        x23, x14, x22
and       x9 , x14, x22
sub       x13, x14, x22
sub       x7 , x14, x22
sub       x11, x13, x22
#-------------------------

#-------------sub instruction-------------------
#---Target register in rs1---
sub       x20, x13, x21
xor       x13, x20, x14
#-------------------------
sub       x11, x17, x25
ori       x21, x11, -34
sub       x9 , x11, x23
#-------------------------
sub       x19, x10, x29
or        x10, x19, x24
or        x10, x19, x17
addi      x30, x19, 38 
#-------------------------
sub       x10, x17, x25
and       x8 , x10, x30
xor       x7 , x10, x7 
and       x23, x10, x18
ori       x22, x10, -23
#-------------------------
sub       x20, x28, x25
ori       x17, x20, 39 
add       x26, x20, x6 
and       x30, x20, x7 
addi      x20, x20, -26
xori      x19, x20, 5  
#-------------------------
#---Target register in rs2---
sub       x22, x26, x30
add       x10, x9 , x22
#-------------------------
sub       x15, x5 , x22
sub       x18, x22, x15
add       x17, x22, x15
#-------------------------
sub       x21, x19, x28
xor       x23, x28, x21
xor       x14, x28, x21
add       x20, x19, x21
#-------------------------
sub       x25, x12, x16
sub       x25, x31, x25
add       x29, x17, x25
sub       x11, x17, x25
add       x5 , x12, x25
#-------------------------
sub       x26, x22, x17
and       x19, x28, x26
sub       x8 , x5 , x26
sub       x29, x19, x26
and       x20, x13, x26
or        x7 , x23, x26
#-------------------------

#-------------xor instruction-------------------
#---Target register in rs1---
xor       x26, x21, x6 
xori      x10, x26, 16 
#-------------------------
xor       x26, x24, x7 
or        x18, x26, x19
xor       x20, x26, x5 
#-------------------------
xor       x31, x14, x16
add       x18, x31, x30
ori       x20, x31, 8  
or        x24, x31, x24
#-------------------------
xor       x9 , x21, x7 
xor       x12, x9 , x20
ori       x19, x9 , 15 
xor       x6 , x9 , x5 
add       x16, x9 , x11
#-------------------------
xor       x9 , x24, x17
xor       x28, x9 , x17
or        x16, x9 , x16
sub       x11, x9 , x7 
add       x27, x9 , x14
addi      x9 , x9 , -6 
#-------------------------
#---Target register in rs2---
xor       x22, x23, x10
add       x29, x10, x22
#-------------------------
xor       x19, x29, x13
or        x18, x13, x19
xor       x14, x13, x19
#-------------------------
xor       x10, x20, x18
or        x10, x9 , x10
sub       x30, x9 , x10
add       x7 , x9 , x10
#-------------------------
xor       x22, x30, x28
add       x21, x12, x22
add       x10, x31, x22
xor       x18, x31, x22
or        x5 , x7 , x22
#-------------------------
xor       x6 , x7 , x14
add       x22, x31, x6 
sub       x24, x31, x6 
and       x18, x16, x6 
xor       x11, x17, x6 
xor       x23, x17, x6 
#-------------------------

#-------------or instruction-------------------
#---Target register in rs1---
or        x11, x10, x24
andi      x19, x11, 27 
#-------------------------
or        x24, x5 , x7 
ori       x18, x24, 19 
addi      x20, x24, 12 
#-------------------------
or        x14, x26, x16
ori       x12, x14, 22 
xor       x12, x14, x26
xori      x9 , x14, -9 
#-------------------------
or        x10, x16, x22
add       x26, x10, x30
or        x23, x10, x26
and       x6 , x10, x27
xor       x13, x10, x17
#-------------------------
or        x18, x16, x8 
or        x8 , x18, x25
xori      x21, x18, 37 
ori       x31, x18, -27
and       x10, x18, x15
ori       x25, x18, 37 
#-------------------------
#---Target register in rs2---
or        x20, x25, x10
sub       x21, x15, x20
#-------------------------
or        x17, x26, x30
or        x19, x30, x17
add       x25, x20, x17
#-------------------------
or        x14, x31, x20
add       x13, x30, x14
or        x28, x30, x14
xor       x5 , x26, x14
#-------------------------
or        x17, x7 , x5 
sub       x14, x5 , x17
xor       x12, x5 , x17
add       x12, x20, x17
xor       x14, x6 , x17
#-------------------------
or        x11, x6 , x21
add       x20, x23, x11
add       x5 , x27, x11
sub       x11, x28, x11
add       x30, x21, x11
xor       x17, x21, x11
#-------------------------

#-------------and instruction-------------------
#---Target register in rs1---
and       x27, x11, x28
sub       x23, x27, x15
#-------------------------
and       x21, x18, x25
or        x16, x21, x27
ori       x31, x21, 11 
#-------------------------
and       x23, x25, x12
andi      x22, x23, -14
ori       x9 , x23, -26
xori      x30, x23, -16
#-------------------------
and       x5 , x10, x19
and       x13, x5 , x26
addi      x25, x5 , -25
or        x6 , x5 , x6 
ori       x26, x5 , 36 
#-------------------------
and       x12, x17, x28
add       x16, x12, x17
ori       x30, x12, 40 
addi      x13, x12, 3  
or        x17, x12, x17
add       x10, x12, x20
#-------------------------
#---Target register in rs2---
and       x7 , x13, x31
and       x18, x31, x7 
#-------------------------
and       x5 , x7 , x23
or        x27, x13, x5 
sub       x17, x13, x5 
#-------------------------
and       x20, x8 , x24
and       x20, x23, x20
and       x20, x12, x20
and       x25, x12, x20
#-------------------------
and       x10, x27, x17
xor       x12, x17, x10
add       x21, x30, x10
and       x17, x22, x10
xor       x13, x22, x10
#-------------------------
and       x26, x20, x31
sub       x9 , x26, x26
or        x30, x29, x26
and       x15, x29, x26
and       x6 , x9 , x26
or        x18, x6 , x26
#-------------------------

#-------------addi instruction-------------------
#---Target register in rs1---
addi      x20, x18, -39
and       x9 , x20, x23
#-------------------------
addi      x20, x23, 28 
ori       x29, x20, 0  
andi      x8 , x20, -9 
#-------------------------
addi      x14, x24, -19
addi      x11, x14, 34 
or        x7 , x14, x27
ori       x26, x14, -24
#-------------------------
addi      x27, x11, 9  
xori      x16, x27, -29
andi      x16, x27, -12
ori       x14, x27, 39 
add       x29, x27, x19
#-------------------------
addi      x19, x14, 34 
and       x13, x19, x5 
sub       x30, x19, x19
add       x6 , x19, x25
or        x12, x19, x21
ori       x13, x19, 14 
#-------------------------

#-------------xori instruction-------------------
#---Target register in rs1---
xori      x24, x17, -11
ori       x6 , x24, -32
#-------------------------
xori      x13, x10, 0  
sub       x15, x13, x22
or        x31, x13, x12
#-------------------------
xori      x16, x23, 13 
add       x22, x16, x9 
addi      x29, x16, 2  
andi      x24, x16, 36 
#-------------------------
xori      x31, x18, 13 
add       x24, x31, x20
xori      x30, x31, 0  
sub       x21, x31, x8 
and       x5 , x31, x7 
#-------------------------
xori      x26, x20, -11
xori      x7 , x26, -11
and       x17, x26, x13
andi      x11, x26, -8 
sub       x22, x26, x14
andi      x17, x26, 12 
#-------------------------

#-------------ori instruction-------------------
#---Target register in rs1---
ori       x30, x22, 1  
or        x11, x30, x25
#-------------------------
ori       x27, x18, 33 
and       x30, x27, x19
andi      x26, x27, -26
#-------------------------
ori       x18, x28, -24
addi      x7 , x18, 23 
xori      x26, x18, -22
addi      x8 , x18, -37
#-------------------------
ori       x20, x12, -37
xor       x22, x20, x19
xor       x10, x20, x26
xori      x19, x20, 37 
andi      x20, x20, 15 
#-------------------------
ori       x25, x11, -23
addi      x11, x25, 29 
xor       x17, x25, x27
and       x10, x25, x22
or        x14, x25, x10
ori       x24, x25, 10 
#-------------------------

#-------------andi instruction-------------------
#---Target register in rs1---
andi      x21, x24, 5  
xori      x11, x21, -28
#-------------------------
andi      x7 , x31, 17 
sub       x31, x7 , x26
add       x18, x7 , x27
#-------------------------
andi      x25, x15, -1 
or        x5 , x25, x22
add       x18, x25, x27
ori       x18, x25, 33 
#-------------------------
andi      x30, x31, 3  
sub       x16, x30, x6 
sub       x8 , x30, x29
xori      x14, x30, -33
addi      x10, x30, -23
#-------------------------
andi      x13, x8 , -17
or        x28, x13, x12
and       x25, x13, x26
ori       x20, x13, 19 
or        x31, x13, x27
andi      x22, x13, -27
#-------------------------
addi      x0 , x5 , 974
addi      x0 , x6 , 914
addi      x0 , x7 , 200
addi      x0 , x8 , 77
addi      x0 , x9 , 107
addi      x0 , x10, -386
addi      x0 , x11, -491
addi      x0 , x12, -39
addi      x0 , x13, 636
addi      x0 , x14, 29
addi      x0 , x15, 47
addi      x0 , x16, -769
addi      x0 , x17, 402
addi      x0 , x18, 3
addi      x0 , x19, 935
addi      x0 , x20, 609
addi      x0 , x21, -569
addi      x0 , x22, -699
addi      x0 , x23, 715
addi      x0 , x24, 147
addi      x0 , x25, 897
addi      x0 , x26, 908
addi      x0 , x27, -518
addi      x0 , x28, -874
addi      x0 , x29, 487
addi      x0 , x30, 963
addi      x0 , x31, 347

#-------------add instruction-------------------
#---Target register in rs1---
add       x15, x26, x10
and       x11, x15, x17
#-------------------------
add       x15, x9 , x25
ori       x24, x15, -27
and       x23, x15, x24
#-------------------------
add       x19, x7 , x6 
xor       x22, x19, x31
addi      x9 , x19, 29 
sub       x7 , x19, x6 
#-------------------------
add       x20, x25, x22
xori      x5 , x20, -16
or        x14, x20, x27
addi      x20, x20, 29 
xori      x20, x20, 30 
#-------------------------
add       x7 , x15, x31
ori       x7 , x7 , -11
sub       x11, x7 , x23
sub       x24, x7 , x30
xori      x7 , x7 , -14
andi      x14, x7 , 29 
#-------------------------
#---Target register in rs2---
add       x13, x18, x23
add       x30, x23, x13
#-------------------------
add       x27, x11, x28
and       x16, x14, x27
add       x31, x6 , x27
#-------------------------
add       x13, x25, x30
sub       x14, x30, x13
and       x7 , x8 , x13
and       x8 , x8 , x13
#-------------------------
add       x29, x27, x7 
or        x8 , x31, x29
and       x16, x31, x29
and       x25, x16, x29
sub       x31, x16, x29
#-------------------------
add       x13, x29, x22
add       x8 , x29, x13
xor       x6 , x31, x13
xor       x16, x31, x13
xor       x21, x31, x13
add       x15, x31, x13
#-------------------------

#-------------sub instruction-------------------
#---Target register in rs1---
sub       x8 , x6 , x27
sub       x27, x8 , x16
#-------------------------
sub       x15, x24, x17
and       x26, x15, x20
and       x13, x15, x21
#-------------------------
sub       x23, x15, x9 
andi      x17, x23, 8  
xor       x27, x23, x27
add       x12, x23, x17
#-------------------------
sub       x29, x6 , x25
andi      x28, x29, -14
xori      x11, x29, -15
addi      x26, x29, -21
add       x19, x29, x27
#-------------------------
sub       x28, x25, x22
and       x20, x28, x17
andi      x18, x28, 8  
sub       x18, x28, x30
sub       x25, x28, x6 
andi      x16, x28, 10 
#-------------------------
#---Target register in rs2---
sub       x5 , x15, x30
sub       x12, x30, x5 
#-------------------------
sub       x22, x29, x8 
xor       x31, x21, x22
xor       x29, x21, x22
#-------------------------
sub       x10, x16, x29
and       x25, x10, x10
add       x17, x28, x10
or        x13, x16, x10
#-------------------------
sub       x23, x13, x6 
xor       x28, x16, x23
or        x31, x16, x23
xor       x5 , x19, x23
add       x27, x19, x23
#-------------------------
sub       x15, x24, x17
and       x12, x22, x15
add       x27, x22, x15
xor       x15, x22, x15
sub       x19, x22, x15
or        x29, x22, x15
#-------------------------

#-------------xor instruction-------------------
#---Target register in rs1---
xor       x14, x30, x9 
add       x17, x14, x30
#-------------------------
xor       x30, x17, x7 
sub       x25, x30, x9 
or        x16, x30, x17
#-------------------------
xor       x6 , x13, x19
addi      x24, x6 , -30
xor       x22, x6 , x7 
xori      x19, x6 , 16 
#-------------------------
xor       x21, x15, x24
or        x5 , x21, x30
or        x26, x21, x23
andi      x21, x21, 35 
addi      x20, x21, 23 
#-------------------------
xor       x30, x19, x6 
xor       x30, x30, x20
addi      x22, x30, 22 
sub       x19, x30, x14
and       x6 , x30, x19
sub       x26, x30, x10
#-------------------------
#---Target register in rs2---
xor       x28, x25, x14
xor       x9 , x14, x28
#-------------------------
xor       x6 , x26, x27
add       x10, x7 , x6 
add       x26, x24, x6 
#-------------------------
xor       x14, x20, x26
xor       x15, x30, x14
or        x5 , x30, x14
sub       x9 , x30, x14
#-------------------------
xor       x27, x24, x11
and       x18, x7 , x27
add       x10, x17, x27
and       x21, x6 , x27
add       x10, x6 , x27
#-------------------------
xor       x21, x26, x12
xor       x15, x12, x21
and       x10, x24, x21
add       x24, x8 , x21
xor       x22, x8 , x21
and       x25, x11, x21
#-------------------------

#-------------or instruction-------------------
#---Target register in rs1---
or        x5 , x29, x19
addi      x22, x5 , -34
#-------------------------
or        x20, x18, x10
add       x17, x20, x18
sub       x29, x20, x19
#-------------------------
or        x14, x18, x23
andi      x15, x14, 1  
andi      x16, x14, -32
sub       x9 , x14, x5 
#-------------------------
or        x12, x18, x9 
or        x31, x12, x14
add       x14, x12, x24
sub       x28, x12, x21
and       x5 , x12, x12
#-------------------------
or        x10, x29, x6 
sub       x8 , x10, x23
ori       x21, x10, -12
xor       x8 , x10, x20
ori       x6 , x10, 40 
ori       x23, x10, 9  
#-------------------------
#---Target register in rs2---
or        x21, x30, x19
or        x17, x5 , x21
#-------------------------
or        x6 , x8 , x12
and       x5 , x27, x6 
sub       x10, x20, x6 
#-------------------------
or        x23, x9 , x27
xor       x14, x11, x23
xor       x6 , x7 , x23
sub       x11, x7 , x23
#-------------------------
or        x17, x13, x28
add       x23, x17, x17
xor       x8 , x24, x17
xor       x7 , x31, x17
or        x17, x19, x17
#-------------------------
or        x26, x15, x29
add       x21, x29, x26
sub       x22, x9 , x26
and       x16, x11, x26
or        x10, x9 , x26
add       x18, x29, x26
#-------------------------

#-------------and instruction-------------------
#---Target register in rs1---
and       x16, x31, x9 
and       x5 , x16, x13
#-------------------------
and       x29, x27, x12
addi      x15, x29, 30 
addi      x8 , x29, -6 
#-------------------------
and       x29, x16, x31
xori      x10, x29, -11
xori      x13, x29, -33
xori      x24, x29, -18
#-------------------------
and       x6 , x20, x14
or        x26, x6 , x23
ori       x29, x6 , -7 
xor       x17, x6 , x24
add       x13, x6 , x17
#-------------------------
and       x26, x19, x7 
or        x24, x26, x13
ori       x25, x26, -40
xori      x9 , x26, 39 
andi      x22, x26, -35
xori      x22, x26, 32 
#-------------------------
#---Target register in rs2---
and       x15, x20, x23
or        x20, x22, x15
#-------------------------
and       x14, x10, x29
or        x25, x29, x14
and       x26, x29, x14
#-------------------------
and       x23, x27, x14
sub       x28, x9 , x23
xor       x31, x30, x23
sub       x21, x25, x23
#-------------------------
and       x11, x7 , x19
sub       x11, x5 , x11
add       x7 , x5 , x11
sub       x11, x10, x11
xor       x27, x10, x11
#-------------------------
and       x19, x24, x15
xor       x16, x15, x19
add       x18, x11, x19
or        x23, x11, x19
and       x21, x11, x19
sub       x10, x11, x19
#-------------------------

#-------------addi instruction-------------------
#---Target register in rs1---
addi      x18, x29, 37 
ori       x7 , x18, 20 
#-------------------------
addi      x7 , x19, 39 
sub       x13, x7 , x27
ori       x16, x7 , -28
#-------------------------
addi      x7 , x31, 22 
addi      x16, x7 , 29 
xor       x8 , x7 , x13
andi      x21, x7 , -23
#-------------------------
addi      x25, x10, 35 
xori      x21, x25, -38
and       x6 , x25, x28
ori       x14, x25, 36 
xori      x15, x25, -13
#-------------------------
addi      x12, x8 , -24
xori      x11, x12, 23 
add       x22, x12, x29
ori       x25, x12, 28 
xori      x16, x12, 31 
sub       x7 , x12, x29
#-------------------------

#-------------xori instruction-------------------
#---Target register in rs1---
xori      x29, x8 , 3  
and       x11, x29, x19
#-------------------------
xori      x9 , x17, -3 
addi      x22, x9 , -17
addi      x13, x9 , 38 
#-------------------------
xori      x30, x18, -29
xori      x8 , x30, 6  
or        x17, x30, x31
and       x5 , x30, x30
#-------------------------
xori      x21, x30, 33 
or        x20, x21, x30
xor       x10, x21, x24
ori       x23, x21, -32
sub       x5 , x21, x14
#-------------------------
xori      x20, x26, 32 
xor       x31, x20, x23
and       x16, x20, x25
add       x19, x20, x5 
addi      x7 , x20, 16 
sub       x21, x20, x9 
#-------------------------

#-------------ori instruction-------------------
#---Target register in rs1---
ori       x15, x25, 38 
xor       x29, x15, x6 
#-------------------------
ori       x15, x16, -11
addi      x6 , x15, 23 
or        x25, x15, x13
#-------------------------
ori       x18, x13, 10 
add       x6 , x18, x27
or        x19, x18, x16
addi      x28, x18, -39
#-------------------------
ori       x24, x22, 40 
andi      x12, x24, 0  
xori      x27, x24, 24 
ori       x24, x24, -29
andi      x18, x24, 21 
#-------------------------
ori       x24, x29, 10 
xor       x6 , x24, x7 
addi      x6 , x24, -36
andi      x17, x24, 17 
sub       x15, x24, x22
sub       x14, x24, x6 
#-------------------------

#-------------andi instruction-------------------
#---Target register in rs1---
andi      x29, x12, 39 
xori      x22, x29, -38
#-------------------------
andi      x25, x6 , 9  
and       x5 , x25, x17
andi      x12, x25, -3 
#-------------------------
andi      x16, x15, -38
andi      x28, x16, 3  
sub       x22, x16, x17
and       x25, x16, x25
#-------------------------
andi      x16, x31, -9 
and       x21, x16, x22
and       x14, x16, x19
andi      x10, x16, 36 
addi      x18, x16, 29 
#-------------------------
andi      x6 , x10, -9 
or        x25, x6 , x7 
andi      x13, x6 , 31 
sub       x18, x6 , x21
xori      x23, x6 , 31 
sub       x28, x6 , x20
#-------------------------

#-------------add instruction-------------------
#---Target register in rs1---
add       x15, x30, x21
add       x12, x15, x15
#-------------------------
add       x29, x27, x11
xor       x11, x29, x10
sub       x18, x29, x22
#-------------------------
add       x19, x6 , x5 
xor       x6 , x19, x6 
addi      x31, x19, -13
add       x19, x19, x16
#-------------------------
add       x16, x30, x15
sub       x15, x16, x17
andi      x5 , x16, -17
sub       x29, x16, x20
or        x14, x16, x20
#-------------------------
add       x14, x6 , x31
andi      x23, x14, 4  
add       x5 , x14, x17
addi      x30, x14, -18
xori      x31, x14, 6  
and       x23, x14, x22
#-------------------------
#---Target register in rs2---
add       x13, x30, x9 
or        x24, x9 , x13
#-------------------------
add       x24, x11, x9 
add       x7 , x9 , x24
sub       x18, x28, x24
#-------------------------
add       x9 , x26, x7 
xor       x16, x5 , x9 
sub       x5 , x7 , x9 
add       x9 , x14, x9 
#-------------------------
add       x13, x26, x20
and       x8 , x20, x13
and       x15, x20, x13
and       x31, x10, x13
or        x22, x26, x13
#-------------------------
add       x24, x7 , x25
sub       x28, x13, x24
sub       x5 , x15, x24
and       x10, x15, x24
or        x21, x15, x24
sub       x15, x15, x24
#-------------------------

#-------------sub instruction-------------------
#---Target register in rs1---
sub       x17, x21, x20
addi      x28, x17, -25
#-------------------------
sub       x18, x26, x30
or        x26, x18, x18
xor       x24, x18, x6 
#-------------------------
sub       x24, x20, x22
ori       x31, x24, -35
ori       x16, x24, -20
and       x9 , x24, x22
#-------------------------
sub       x17, x6 , x28
add       x8 , x17, x9 
addi      x6 , x17, 33 
add       x27, x17, x23
sub       x18, x17, x26
#-------------------------
sub       x24, x6 , x31
andi      x13, x24, -5 
add       x10, x24, x5 
ori       x29, x24, -21
sub       x25, x24, x23
add       x6 , x24, x10
#-------------------------
#---Target register in rs2---
sub       x13, x28, x12
add       x12, x12, x13
#-------------------------
sub       x19, x28, x26
sub       x7 , x31, x19
add       x18, x29, x19
#-------------------------
sub       x8 , x23, x27
add       x5 , x31, x8 
xor       x18, x31, x8 
xor       x6 , x18, x8 
#-------------------------
sub       x27, x19, x5 
xor       x22, x12, x27
or        x22, x29, x27
or        x9 , x26, x27
and       x14, x16, x27
#-------------------------
sub       x15, x11, x7 
add       x23, x7 , x15
xor       x13, x23, x15
and       x27, x30, x15
sub       x16, x30, x15
and       x23, x30, x15
#-------------------------

#-------------xor instruction-------------------
#---Target register in rs1---
xor       x13, x12, x26
or        x10, x13, x16
#-------------------------
xor       x10, x25, x24
addi      x20, x10, 27 
and       x30, x10, x29
#-------------------------
xor       x23, x11, x30
andi      x6 , x23, -15
or        x10, x23, x31
or        x19, x23, x30
#-------------------------
xor       x9 , x28, x13
sub       x15, x9 , x7 
addi      x27, x9 , -22
sub       x10, x9 , x10
sub       x24, x9 , x27
#-------------------------
xor       x20, x17, x27
or        x12, x20, x10
or        x19, x20, x23
xori      x29, x20, 27 
add       x26, x20, x21
sub       x13, x20, x18
#-------------------------
#---Target register in rs2---
xor       x31, x9 , x8 
or        x28, x20, x31
#-------------------------
xor       x30, x8 , x31
xor       x9 , x17, x30
sub       x24, x12, x30
#-------------------------
xor       x22, x13, x21
and       x7 , x21, x22
and       x14, x20, x22
add       x29, x19, x22
#-------------------------
xor       x31, x24, x7 
and       x25, x25, x31
sub       x22, x28, x31
and       x19, x11, x31
add       x23, x7 , x31
#-------------------------
xor       x15, x31, x14
sub       x18, x29, x15
xor       x6 , x30, x15
sub       x16, x11, x15
add       x12, x18, x15
or        x9 , x18, x15
#-------------------------

#-------------or instruction-------------------
#---Target register in rs1---
or        x10, x29, x15
sub       x8 , x10, x26
#-------------------------
or        x5 , x26, x30
sub       x18, x5 , x20
ori       x23, x5 , 24 
#-------------------------
or        x31, x24, x13
or        x12, x31, x13
and       x30, x31, x23
and       x6 , x31, x10
#-------------------------
or        x21, x26, x30
addi      x28, x21, 34 
xor       x14, x21, x28
sub       x21, x21, x13
xori      x29, x21, 32 
#-------------------------
or        x15, x27, x24
xor       x17, x15, x14
sub       x7 , x15, x25
sub       x21, x15, x26
sub       x19, x15, x24
sub       x17, x15, x12
#-------------------------
#---Target register in rs2---
or        x7 , x21, x18
xor       x23, x29, x7 
#-------------------------
or        x12, x11, x26
xor       x20, x10, x12
sub       x18, x10, x12
#-------------------------
or        x20, x11, x29
and       x5 , x25, x20
xor       x12, x25, x20
and       x14, x25, x20
#-------------------------
or        x19, x12, x16
and       x17, x16, x19
or        x12, x15, x19
or        x24, x15, x19
or        x18, x21, x19
#-------------------------
or        x26, x15, x22
add       x12, x30, x26
sub       x23, x30, x26
add       x7 , x30, x26
or        x22, x19, x26
sub       x8 , x22, x26
#-------------------------

#-------------and instruction-------------------
#---Target register in rs1---
and       x26, x6 , x23
addi      x28, x26, 20 
#-------------------------
and       x31, x10, x11
add       x21, x31, x19
addi      x30, x31, -40
#-------------------------
and       x11, x25, x12
andi      x20, x11, 28 
ori       x10, x11, -17
or        x12, x11, x16
#-------------------------
and       x7 , x15, x27
xori      x24, x7 , -8 
ori       x14, x7 , 20 
or        x7 , x7 , x15
ori       x31, x7 , -20
#-------------------------
and       x24, x29, x26
xori      x31, x24, 13 
andi      x7 , x24, -10
or        x21, x24, x17
sub       x7 , x24, x30
xor       x23, x24, x30
#-------------------------
#---Target register in rs2---
and       x28, x26, x18
xor       x18, x22, x28
#-------------------------
and       x10, x5 , x15
and       x12, x13, x10
and       x10, x13, x10
#-------------------------
and       x24, x12, x21
or        x19, x21, x24
add       x16, x21, x24
xor       x10, x28, x24
#-------------------------
and       x31, x6 , x8 
and       x26, x8 , x31
and       x25, x8 , x31
xor       x17, x21, x31
sub       x21, x6 , x31
#-------------------------
and       x19, x7 , x28
xor       x23, x27, x19
xor       x9 , x20, x19
and       x24, x20, x19
add       x5 , x20, x19
and       x21, x20, x19
#-------------------------

#-------------addi instruction-------------------
#---Target register in rs1---
addi      x9 , x26, -3 
ori       x13, x9 , 37 
#-------------------------
addi      x24, x29, -12
xor       x10, x24, x30
and       x22, x24, x30
#-------------------------
addi      x23, x14, 5  
ori       x15, x23, -9 
or        x13, x23, x28
add       x12, x23, x18
#-------------------------
addi      x7 , x14, -7 
andi      x13, x7 , 37 
andi      x5 , x7 , 6  
sub       x15, x7 , x27
ori       x25, x7 , 23 
#-------------------------
addi      x18, x11, -37
xori      x22, x18, 14 
and       x20, x18, x6 
xori      x31, x18, 7  
sub       x27, x18, x30
and       x11, x18, x24
#-------------------------

#-------------xori instruction-------------------
#---Target register in rs1---
xori      x20, x28, 23 
xori      x25, x20, 37 
#-------------------------
xori      x10, x26, -22
or        x22, x10, x24
and       x7 , x10, x27
#-------------------------
xori      x28, x10, 8  
add       x25, x28, x29
xori      x6 , x28, -13
andi      x30, x28, -19
#-------------------------
xori      x30, x26, -14
and       x21, x30, x21
or        x12, x30, x29
andi      x24, x30, 2  
xor       x25, x30, x13
#-------------------------
xori      x30, x11, 29 
xori      x6 , x30, -30
sub       x9 , x30, x11
sub       x13, x30, x20
xori      x29, x30, -2 
and       x23, x30, x13
#-------------------------

#-------------ori instruction-------------------
#---Target register in rs1---
ori       x8 , x17, -16
add       x5 , x8 , x24
#-------------------------
ori       x11, x10, 30 
and       x22, x11, x7 
addi      x31, x11, 26 
#-------------------------
ori       x26, x13, -5 
xor       x9 , x26, x21
or        x13, x26, x29
or        x15, x26, x6 
#-------------------------
ori       x8 , x19, 10 
or        x25, x8 , x25
andi      x9 , x8 , -25
and       x18, x8 , x19
addi      x13, x8 , 36 
#-------------------------
ori       x24, x19, -34
add       x25, x24, x24
xor       x12, x24, x24
ori       x29, x24, 1  
addi      x22, x24, 13 
sub       x6 , x24, x5 
#-------------------------

#-------------andi instruction-------------------
#---Target register in rs1---
andi      x6 , x9 , -40
and       x26, x6 , x7 
#-------------------------
andi      x5 , x8 , 27 
addi      x15, x5 , -13
or        x27, x5 , x8 
#-------------------------
andi      x23, x20, -37
ori       x21, x23, 11 
add       x22, x23, x23
xor       x29, x23, x26
#-------------------------
andi      x17, x10, -26
xor       x18, x17, x15
addi      x30, x17, -30
and       x7 , x17, x12
xori      x30, x17, -28
#-------------------------
andi      x22, x14, 17 
or        x11, x22, x9 
andi      x12, x22, 16 
sub       x5 , x22, x22
or        x16, x22, x26
sub       x7 , x22, x31
#-------------------------
romromrom:
# Register filling
    addi x5 , x0, 4
loop1:
    beq  x0 , x5,  beq00
    addi x5 , x5, -1
    nop
    j loop1
beq00:
    addi x1 , x0,  1
    addi x2 , x0,  2
    addi x3 , x0,  3
    addi x4 , x0,  4
    addi x5 , x0,  5
    addi x6 , x0,  6
    addi x7 , x0,  7
    addi x8 , x0,  8
    addi x9 , x0,  9
    addi x10, x0,  10
    addi x11, x0,  11
    addi x12, x0,  12
    addi x13, x0,  13
    addi x14, x0,  14
    addi x15, x0,  15
    addi x16, x0,  16
    addi x17, x0,  17
    addi x18, x0,  18
    addi x19, x0,  19
    addi x20, x0,  20
    addi x21, x0,  21
    addi x22, x0,  22
    addi x23, x0,  23
    addi x24, x0,  24
    addi x25, x0,  25
    addi x26, x0,  26
    addi x27, x0,  27
    addi x28, x0,  28
    addi x29, x0,  29
    addi x30, x0,  30
    addi x31, x0,  31

    addi x23, x28, 17
    and x24, x23, x28
    or  x7,  x22, x23
    sub x19, x23, x18

# Rom1
    addi  x1, x0,  4
    addi  x2, x0,  -1
    addi  x3, x0,  2
    slti  x4, x1,  2
    slti  x4, x2,  1
    sltiu x4, x1,  2
    sltiu x4, x2,  1
    xori  x4, x1,  7
    xori  x4, x1,  1
    ori   x4, x1,  7
    ori   x4, x1,  1
    andi  x4, x1,  7
    andi  x4, x1,  1
    slli  x4, x1,  3
    srli  x4, x16, 3
    srai  x4, x17, 4
    add   x5, x2, x1
    sub   x5, x1, x2
    sll   x5, x1, x3
    slt   x5, x1, x2
    slt   x5, x2, x1
    sltu  x5, x1, x2
    sltu  x5, x2, x1
    xor   x5, x1, x2
    srl   x5, x5, x3
    sra   x5, x5, x3
    or    x5, x1, x2
    and   x5, x1, x2
    auipc x7, 0
    jal jal1
    addi  x1, x0,   100
    addi  x2, x0,  -100
    addi  x3, x0,   200
jal1:
    addi  x1, x0,   23
    addi  x2, x0,  -26
    addi  x3, x0,   49
    jal  x8, jalr1
    addi  x1, x0,   41
    addi  x2, x0,  -42
    addi  x3, x0,   83
jalr1:addi  x1, x0,   11
    addi  x2, x0,  -12
    addi  x3, x0,  -13

    # RISC-V
    addi x1, x0,  4
    addi x2, x0, -1
    addi x3, x0,  2
init:             
    add x1, x2, x1
    sub x4, x1, x2
    sll x5, x1, x3
    slt x6, x1, x2
    slt x7, x2, x1
    sltu x8, x1, x2
    sltu x9, x2, x1
    xor x10, x1, x2
    srl x11, x5, x3
    sra x12, x5, x3
    or x13, x1, x2
    and x14, x1, x2
    bne x1, x2, init
    beq x1, x2, beq1
    addi x1, x0, 1
    addi x2, x0, 2
    addi x3, x0, 3
beq1:
    slti x6, x1, 2
    slti x7, x2, 1
    sltiu x8, x1, 2
    sltiu x9, x2, 1
    xori x10, x1, 7
    xori x11, x1, 1
    ori x12, x1, 7
    ori x13, x1, 1
    andi x14, x1, 7
    andi x15, x1, 1
    slli x16, x1, 3
    srli x17, x16, 3
    srai x18, x17, 4
    blt x1, x3, blt1
    addi x1, x0, 721
    addi x2, x0, 522
    addi x3, x0, 443
    addi x1, x0, 343
    addi x2, x0, 245
    addi x3, x0, 163
    addi x1, x0, 778
    addi x2, x0, 898
    addi x3, x0, 779
blt1:
    bge x3, x1, bge1
    addi x1, x0, -1
    addi x2, x0, -2
    addi x3, x0, -3
    addi x1, x0, -4
    addi x2, x0, -5
    addi x3, x0, -6
    addi x1, x0, -7
    addi x2, x0, -8
    addi x3, x0, -9
bge1:
    bgeu x5, x10, bgeu1
    addi x1, x0, 101
    addi x2, x0, 225
    addi x3, x0, 345
    addi x1, x0, 478
    addi x2, x0, 568
    addi x3, x0, 645
    addi x1, x0, 787
    addi x2, x0, 854
    addi x3, x0, 920
bgeu1:
    bltu x10, x5, exit
    addi x1, x0, 11
    addi x2, x0, 22
    addi x3, x0, 33
    addi x1, x0, 44
    addi x2, x0, 55
    addi x3, x0, 66
    addi x1, x0, 47
    addi x2, x0, 88
    addi x3, x0, 99
    .align 12
exit:
    nop
