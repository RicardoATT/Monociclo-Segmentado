addi x4, x0, 15
addi x5, x0, 16
addi x6, x0, 17
add  x7, x6, x2
add  x8, x6, x3
bge  x4, x5, salto
beq  x4, x5, fin
ld   x9, 0(x0)
add  x10, x9, x3
salto: ld   x9, 8(x0)
ld   x10, 48(x0)
add  x11, x10, x9
fin:
