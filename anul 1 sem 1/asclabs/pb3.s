//vector ordonat crescator sau nu//
.data
    n: .long 4
    v: .long 10, 20, 30, 40, 50
	formatPrint: .asciz "indice: %d\n"
	s: .asciz "vector ordonat crescator\n"
.text

.global main

main:
    lea v, %edi
    xor %ecx, %ecx
    xor %ebx, %ebx
    xor %edx, %edx
    
etloop:
    cmp n, %ecx
    je etafismesaj
    movl (%edi, %ecx,4),%eax
    inc %ecx
    movl (%edi, %ecx,4),%ebx
    cmp %eax, %ebx
    jl etafisin
    jmp etloop

    
etafisin:
    push %ecx
    push $formatPrint
    call printf
    pop %ebx
    pop %ebx
    jmp et_exit
    
etafismesaj:  
    push $s
    call puts
    pop %ebx
    jmp et_exit

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
    
    
    

