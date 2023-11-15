.data
    k: .space 4 
    n: .space 4
    v: .space 400
    formatRead2: .asciz "%d\n"
	formatRead: .asciz "%d %d\n"
	formatPrint: .asciz "numarul de elemente perfecte este: %d\n"
.text

.global main
perfect:





main:
etread:
    
    push $n
    push $formatRead
    call scanf
    pop %ebx
    pop %ebx
   
etreadvector:
    xorl %ecx, %ecx
    xorl %ebx, %ebx
    
forcitire:
    cmpl n,%ecx
    jge forparcurgere
    pushl %ecx
    xorl %edx, %edx
    lea v, %esi 
    movl %ecx, %eax
    movl $4, %ecx
    mull %ecx
    addl %esi, %eax
    
    pushl %eax
    pushl $formatRead2
    call scanf
    popl %ebx
    popl %ebx
    popl %ecx
    incl %ecx
    jmp forcitire
    
forparcurgere:


























    
