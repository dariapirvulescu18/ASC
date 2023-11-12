//media aritmetica//
.data
    n: .long 5
    s: .space 10
    v: .long 10, 20, 30, 40, 50
	
	formatPrint: .asciz "media aritmetica: %d\n"
.text

.global main

main:
    lea v, %edi
    xor %ecx, %ecx
    xor %ebx, %ebx
    xor %edx, %edx
    
etloop:
    cmp n, %ecx
    je etafis
    movl (%edi, %ecx,4),%eax
    add %eax, %ebx
    inc %ecx
    jmp etloop

    
etafis:
    mov %ebx, %eax
    mov n, %ecx
    div %ecx
    
    
    push %eax
    push $formatPrint
    call printf
    pop %ebx
    pop %ebx
    
 

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
    
    
    

