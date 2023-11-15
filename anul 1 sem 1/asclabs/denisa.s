.data
formatPrint: .asciz "Numarul obtinut prin conversia sirului este: %d\n"
s: .space 20
n: .space 20
formatRead: .asciz "%d"
.text
.global main
main:
  
  push $s
  call gets
  pop %ebx
  
     lea s,%edi
     xorl %ecx, %ecx         
     xorl %eax, %eax
     xorl %edx, %edx
     xorl %ebx, %ebx
     mov $10, %esi 
 
  
et_loop:
  movb (%edi,%ecx,1),%dl
  inc %ecx
  cmp $0,%dl
  je etafis
  cmp $'1',%dl
  je et1
  cmp $'2',%dl
  je et1
  cmp $'3',%dl
  je et1
  cmp $'4',%dl
  je et1
  cmp $'5',%dl
  je et1
  cmp $'6',%dl
  je et1
  cmp $'7',%dl
  je et1
  cmp $'8',%dl
  je et1
  cmp $'9',%dl
  je et1
  cmp $'0',%dl
  je et1
  jmp et_loop
  
et1:
    xorl    %ebx, %ebx      # ebx = 0
   movb %dl, %bl            #
   xorl    %edx, %edx
   subl     $48, %ebx
   mull     %esi 
   addl %ebx, %eax
   jmp et_loop
   
etafis:
   
    push %eax
    push $formatPrint
    call printf
    pop %edx
    pop %edx
    
et_exit:

    mov $1, %eax

    xor %ebx, %ebx

    int $0x80

