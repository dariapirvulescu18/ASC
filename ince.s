.data
    x1: .long 5
    x2: .long 12
    x3: .long 27
    n: .long 3
    s: .long 0
    fp: .asciz "%d\n"
.text

.global main
main:
  movl $x1, %edi
  movl $0, %ecx
et_loop:
    cmp n, %ecx
    je et_exit
    
    movl (%edi, %ecx, 4), %eax
    addl %eax, s
    
    incl %ecx
    jmp et_loop
     
et_exit:
    push s
    push $fp
    call printf
    addl $8, %esp
    
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
