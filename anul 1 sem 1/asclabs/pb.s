//cate cuvinte are un sir//
.data
    s: .space 51 
	formatPrint: .asciz "Numarul de cuvinte este: %d\n"
.text

.global main

main:

etread:

	push $s
    call gets
    pop %ebx
    
etcuv:
    lea s, %edi
    xor %eax, %eax
    xor %ebx, %ebx
    
etloop:    
    movb (%edi,%eax,1), %al
    inc %eax
    cmpb $0, %al
    je etafis
    cmpb $32, %al
    je et1
    jmp etloop
    
et1:
    inc %ebx
    jmp etloop  
          
etafis:
    
   
    inc %ebx
    
    push %ebx
    push $formatPrint
    call printf
    pop %edx
    pop %edx
    
 

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
    
    
    

