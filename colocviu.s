.data
    n:    .space 4
    read: .asciz "%d"
    fwrite:  .asciz "%ld "
.text

f:
    push %ebp
    movl %esp, %ebp
    push %ebx
    subl $4, %esp
    
    movl 8(%ebp),%eax   #n=%eax
    movl $2, %ebx
    movl $3, %ecx
    
    for:
        cmp $1, %eax
        je et
        xorl %edx, %edx
        divl %ebx
        movl 8(%ebp),%eax 
        cmp $1, %edx
        je et_impar
        cmp $0, %edx
        je et_par
        
     et_impar: 
        mull %ecx
        addl $1, %eax
        incl -4(%ebp)
        jmp for
        
      et_par:
        div %ebx
        incl -4(%ebp)
        jmp for
           
     et:
        movl -4(%ebp), %eax
        addl $4, %esp
        pop %ebx
        pop %ebp
        ret   

.global main
main:
    push $n
    push $read
    call scanf
    addl $8, %esp
    
    push n
    call f
    addl $4, %esp
    
    push %eax
    push $fwrite
    call printf
    addl $8, %esp
    
    push $0
    call fflush
    pop %ebx
    
exit:
    mov $1, %eax
	mov $0, %ebx
	int $0x80


