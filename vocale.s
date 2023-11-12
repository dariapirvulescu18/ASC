//cate vocale are un sir//q
.data
	s: .space 51 
	formatPrint: .asciz "Numarul de vocale este: %d\n"
.text

.global main

main:
	push $s
    call gets
    pop %ebx
    
    lea s, %edi
    mov $0, %ecx
    mov $0, %ebx
    
et_loop:
    movb (%edi,%ecx,1),%ah
    cmp $0, %ah
    je etafis
    inc %ecx
    cmp $'a',%ah
    je et1
    cmp $'e',%ah
    je et1
    cmp $'i',%ah
    je et1
    cmp $'o',%ah
    je et1
    cmp $'u',%ah
    je et1
    cmp $'A',%ah
    je et1
    cmp $'E',%ah
    je et1
    cmp $'I',%ah
    je et1
    cmp $'O',%ah
    je et1
    cmp $'U',%ah
    je et1
    jmp et_loop
et1:
    inc %ebx
    jmp et_loop
    
etafis:
    push %ebx
    push $formatPrint
    call printf
    pop %edx
    pop %edx
    
 

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
    
    
    

