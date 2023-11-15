.data
s: .space 51
formatScanf: .asciz "%s\n"
.text
.global main
main:
push $s
push $formatScanf
call scanf
pop %ebx
pop %ebx

movl $s, %edi
xorl %ecx, %ecx
xorl %ebx, %ebx

etloop:
  movb (%edi, %ecx, 1), %ah
  cmp $0, %ah
  je et_exit
  inc %ecx
  cmp $'a', %ah
  je et1
  cmp $'e', %ah
  je et1
  cmp $'i', %ah
  je et1
  cmp $'o', %ah
  je et1
  cmp $'u', %ah
  je et1
   jmp etloop
et1:
  inc %ebx
  jmp etloop
et_exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80
