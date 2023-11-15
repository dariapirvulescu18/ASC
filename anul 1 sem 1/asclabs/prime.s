.data 
 n: .space 13
 formatstring: .asciz "%ld"
 formatprintc: .asciz "Numarul nu este prim\n"
 formatprintp: .asciz "Numarul este prim\n"
 
.text
.global main
main:

pushl $n
pushl $formatstring
call scanf
popl %ebx
popl %ebx
 
   mov $0, %edx
   mov n, %eax
   mov $2, %ebx
   cmp %eax, %ebx
    ja etafisc
    je etafisp
    mov $2, %ecx
   div %ebx
   mov %eax, %ebx
   
etloop:
     cmp %ebx, %ecx
      ja etafisp
     mov $0, %edx
     mov n, %eax
     div %ecx
     mov $0, %eax
     cmp %edx, %eax
     je etafisc
     add $1, %ecx
     jmp etloop
 

  
etafisc:
 pushl $formatprintc
 call printf
 popl %ebx
 
 
 jmp et_exit
 
etafisp:
 pushl $formatprintp
 call printf
 popl %ebx
 
 
 
et_exit:
 mov $1, %eax
 mov $0, %ebx
 int $0x80

