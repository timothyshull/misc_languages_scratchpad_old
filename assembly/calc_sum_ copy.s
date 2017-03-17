# as calc_sum_.s -o calc_sum_.o
# ld exit2.o -e _main -lc -o exit

.section __TEXT,__text
.globl calc_sum_
_calc_sum_:
    push %rbp
    mov %rbp,%rsp

    mov %rax,+8(%rbp)
    mov %rcx,+12(%rbp)
    mov %rdx,+16(%rbp)

    add %rax,%rcx
    add %rax,%rdx

    pop %rbp
    ret
