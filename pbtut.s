.data

    k: .space 4
    n: .space 4
    v: .space 400
    formatScanf: .asciz "%d"
    formatRead: .asciz "%d %d"
    formatPrint: .asciz "elementul dublat este: %d\n"
    s1: .asciz "Elementele vectorului nu sunt distincte\n"
    s2: .asciz "Elementele vectorului sunt distincte\n"

.text

.global main

main:

etread:

    push $k
    push $n
    push $formatRead 
    call scanf
    pop %ebx
    pop %ebx
    pop %ebx

etreadvector:

    xorl %ecx, %ecx

forcitire:

    cmpl n,%ecx
    jge forparcurgere1
    pushl %ecx
    xorl %edx, %edx
    lea v, %esi

    movl %ecx, %eax

    movl $4, %ecx

    mull %ecx

    addl %esi, %eax

    pushl %eax

    pushl $formatScanf

    call scanf

    popl %ebx

    popl %ebx



    popl %ecx

    incl %ecx

    jmp forcitire

forparcurgere1:

    xorl %ecx, %ecx

    

forparcurgere:

    cmp %ecx, n

    je etafis2

    movl (%esi, %ecx, 4), %eax

    movl    %ecx, %edx

    incl    %edx

        forparcurgerej:

        cmp     %edx, n

    je    forparcurgereContinue

        movl (%esi, %edx, 4), %ebx

        cmp %eax, %ebx

        je etafis1

    incl    %edx

    jmp    forparcurgerej

    forparcurgereContinue:

    incl    %ecx

    jmp forparcurgere

etafis2:

    push $s2

    call puts

    pop %ebx

    jmp et_exit
etafis1:

        pushl %eax      #pregatesc restaurarea lui %eax
    
    push $s1
    call puts
    pop %ebx
    
        popl  %eax      #l am restaurat pe %eax

    push %eax
    push $formatPrint
    call printf
    pop %ebx
    pop %ebx

et_exit:

    mov $1, %eax

    xor %ebx, %ebx

    int $0x80
