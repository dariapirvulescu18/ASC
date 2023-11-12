.data
    s1: .asciz "Elementele vectorului nu sunt distincte\n"
    s2: .asciz "Elementele vectorului sunt distincte\n"
    k: .space 4 
    n: .space 4
    v: .space 400
    formatRead2: .asciz "%d\n"
	formatRead: .asciz "%d %d\n"
	formatPrint: .asciz "elementul dublat este: %d\n"
.text

.global main

main:

etread:
    push $k
    push $n
    push $formatRead
    call scanf
    pop %ebx
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
    
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %eax, %eax
    xorl %edx, %edx
    mov n, %edx
    dec %edx
    lea v, %esi
    
forparcurgere:
    cmp %ecx, %edx
    je etafis2
    movl (%esi, %ecx, 4), %eax
    inc %ecx
    movl (%esi, %ecx, 4),%ebx
    cmp %eax, %ebx
    je etafis1
    jmp forparcurgere

etafis2:
    push $s2
    call puts
    pop %ebx
    
    jmp et_exit
    
    
etafis1:
    
    push $s1
    call puts
    pop %ebx
     
    push %eax
    push $formatPrint
    call printf
    pop %ebx
    pop %ebx
     
et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
    
   cerinta1:
        
exit_for1:
    #afisam matricea
    #avem doua for uri
    
  
        movl $0, i
    for_linii:
            movl i, %ecx
            cmp %ecx, n
            je et_exit
            movl $0, j
    for_coloane:
                movl j, %ecx
                cmp %ecx, n
                je newline

                movl i, %eax
                xorl %edx, %edx
                mull n
                addl j, %eax

               
                movl (%esi, %eax, 4), %ebx
                
                pushl %ebx
                pushl $fwrite
                call printf
                addl $8, %esp
                
                pushl $0
                call fflush
                addl $4, %esp
                
                incl j
                jmp for_coloane
newline:
    movl $4, %eax
    movl $1, %ebx
    movl $newLine, %ecx
    movl $2, %edx
    int $0x80
    
    incl i
    jmp for_linii


jmp et_exit
