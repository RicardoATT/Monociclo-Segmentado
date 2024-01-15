addi x4, x0, 1
addi x5, x0, 20
addi x6, x0, 15
resta:	sub x5, x5, x4
blt  x6, x5, resta
add  x7, x6, x5 
addi x8, x7, 70