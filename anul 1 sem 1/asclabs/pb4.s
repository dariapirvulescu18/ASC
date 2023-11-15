///cate nr sunt egale cu media lor aritmetica intr un vector//
.data
    n: .long 5
    s: .space 10
    v: .long 10, 20, 30, 40, 50
	
	formatPrint: .asciz "nr egale cu media aritmetica: %d\n"
.text

.global main

main:
    lea v, %edi
    xor %ecx, %ecx
    xor %ebx, %ebx
    xor %edx, %edx
    
etloop:
    cmp n, %ecx
    je etnr1
    movl (%edi, %ecx,4),%eax
    add %eax, %ebx
    inc %ecx
    jmp etloop

etnr1:    
    mov %ebx, %eax
    mov n, %ecx
    div %ecx
    xor %ecx, %ecx
    xor %edx, %edx
    
etnr2:
    cmp n, %ecx
    je etafis
    movl (%edi, %ecx,4),%ebx
    inc %ecx
    cmp %eax,%ebx
    je etinc
    jmp etnr2
    
etinc:
    inc %edx
    jmp etnr2    
    
etafis:
    push %edx
    push $formatPrint
    call printf
    pop %ebx
    pop %ebx
    
 

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
    
    
    

