.data
	x: .long 18
	y: .long 27
.text
.globl main
main:
	movl x, %eax
	movl y, % esi
	movl %esi, x
	movl %eax, y

	mov $1, %eax
	mov $0, %ebx
	int $0x80 
