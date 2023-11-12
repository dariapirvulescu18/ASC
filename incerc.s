.data
n: .long 5
m: .long 100
formatPrintf: .asciz "%ld \n"
.text
.global main
f:
pushl %ebp
movl %esp, %ebp
movl 8(%ebp),%ecx
movl 12(%ebp),%eax
xorl %edx,%edx
divl %ecx
pushl %eax

f_for:
push %ecx

pushl %ecx
pushl $formatPrintf
call printf
popl %ebx
popl %ebx

pushl $0
call fflush
popl %ebx
pop %ecx
loop f_for
jmp f_exit

f_exit:
popl %eax
popl %ebp
ret

main:
movl n, %edx
decl %edx

pushl m
pushl %edx
call f
popl %ebx
popl %ebx

pushl %eax
pushl $formatPrintf
call printf
popl %ebx
popl %ebx

pushl $0
call fflush
popl %ebx

et_exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
