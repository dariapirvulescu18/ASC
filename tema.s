.data
nrcerinta: .space 4
nrnod: .space 4
leg: .space 4 
ln: .space 4  
vector: .space 400  
lineIndex: .space 4
columnIndex: .space 4
matrix: .space 4000
citire: .asciz "%ld"
scriere: .asciz "%ld "
newline: .asciz "\n"
contori: .space 4
contorj: .space 4
.text
.global main
main:

pushl $nrcerinta
pushl $citire
call scanf
addl $8, %esp

pushl $nrnod
pushl $citire
call scanf
addl $8, %esp

movl $0,%ecx
xorl %edx,%edx

lea vector, %edi

nr_legaturi: 
	cmp nrnod,%ecx
	je cont
	pushl %ecx
	
	pushl $leg
	pushl $citire
	call scanf
	addl $8, %esp
	
	popl %ecx
	
	movl leg,%edx
	movl %edx, (%edi,%ecx,4) 
	incl %ecx
	jmp nr_legaturi
	
cont:  	
 lea matrix, %esi
 movl $0, contori
 loop:
    movl contori, %eax 
    cmp nrnod,%eax  
    je afisare_matrice  
    movl (%edi,%eax,4), %ebx    
    movl $0,contorj  
    loop2:
       cmp %ebx,contorj 
       je c  
 
       pushl $ln
       pushl $citire
       call scanf
       addl $8, %esp
       
       movl $0,%edx
        
       movl contori, %eax
       mull nrnod
       addl ln, %eax
       
       movl $1,(%esi,%eax,4)
      
       incl contorj
       jmp loop2
       
    c:
      incl contori
      jmp loop
      
afisare_matrice:
	movl $0, lineIndex
       for_lines:
       		movl nrnod, %ecx
       		cmp lineIndex, %ecx
       		je et_exit
       		movl $0, columnIndex
       		for_columns:
       			cmp columnIndex, %ecx
       			je cont_for_lines
       			movl $0, %edx	
       			movl lineIndex, %eax
       			mull %ecx
       			addl columnIndex, %eax
       			movl (%esi, %eax, 4), %ebx
       			
       			pushl %ebx
       			pushl $scriere
       			call printf
       			popl %ebx
       			popl %ebx
       			
       			pushl $0
       			call fflush
       			popl %ebx
       			
       			addl $1, columnIndex
       			jmp for_columns
       	cont_for_lines:
       		movl $4,%eax
       		movl $1, %ebx
       		movl $newline, %ecx
       		movl $2, %edx
       		int $0x80
       		
       		addl $1, lineIndex
       		jmp for_lines	
	 
et_exit:
 mov $1, %eax
 xor %ebx, %ebx
 int $0x80

	
