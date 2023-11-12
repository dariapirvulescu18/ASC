#maximul si de cate ori apare#
.data
    v: .space 400
    fscanf: .asciz "%d"
    fprintf: .asciz "Maximul apare de: %d ori \n"
    n: .space 4
    elem: .space 4
    
.text


maxim:
    push %ebp
    movl %esp, %ebp

    push %edi
   
    
     
     movl 8(%ebp), %edi  #vector#
     movl 12(%ebp), %ecx  #n ul#  
     decl %ecx
     movl (%edi,%ecx,4), %eax  #ultimul el in ebx#
    
     
     
   maxi_loop:
    cmp $0,%ecx
    jl maxi_exit
    movl (%edi, %ecx, 4), %edx
    decl %ecx
    cmp %edx,%eax
    jl et1
    jmp maxi_loop
    
   et1:
    movl %edx,%eax
    jmp maxi_loop 
    
     
   maxi_exit:
    
	pushl 12(%ebp)
	pushl %eax
    pushl 8(%ebp)
	call proc1
	addl $12, %esp

    
   
    popl %edi
   
    popl %ebp
    ret
    
proc1:
     push %ebp
     movl %esp, %ebp
     push %edi
     push %ebx
     push %esi
    
     movl 8(%ebp), %edi #vectorul
     movl 12(%ebp), %edx #maximul
     movl 16(%ebp), %ebx #n ul
     xorl %ecx, %ecx  #i ul
     xorl %eax, %eax
     
    loop:
        cmp %ebx, %ecx
        je loop_exit
        movl (%edi, %ecx, 4) , %esi
        incl %ecx
        cmp %edx, %esi
        je et
        jmp loop
     et:
      incl %eax
      jmp loop 
 loop_exit:  
     popl %esi
     popl %ebx
     popl %edi
    
     popl %ebp
     ret 
        
.global main
main:
    lea v, %edi
    push $n
    push $fscanf
    call scanf
    addl $8, %esp
    
    xorl %ecx, %ecx
    
read_loop:
    cmp n,%ecx
    je read_exit
    
    pushl %ecx
    
    pushl $elem 
    push $fscanf
    call scanf
    addl $8, %esp
    
    pop %ecx
    
    movl elem,%edx
    movl %edx,(%edi, %ecx,4)
    incl %ecx
    jmp read_loop



read_exit: 
          
    
     push n
     push %edi
     call maxim
     addl $8, %esp
     
     push %eax
     push $fprintf
     call printf
     addl $8, %esp

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80     
    
        
     
       
    
     
     
     
     
     
     
     
     
     
     
     
     
     
     
       



