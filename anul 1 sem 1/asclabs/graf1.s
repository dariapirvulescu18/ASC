.data
    m1:      .space 50000
    m2:      .space 50000
    mres:    .space 50000
    v:       .space 500
    cerinta: .space 4
    n:       .space 4
    leg:     .space 4
    x:       .space 4
    i:       .space 4
    j:       .space 4
    k:       .space 4
    ns:      .space 4
    nd:      .space 4
    fread:   .asciz "%ld"
    fwrite:  .asciz "%ld "
    fwriteNL:  .asciz "%ld\n"
    newLine: .asciz "\n"
.text

schimb:
    push %ebp
    movl %esp, %ebp
    push %edi
    push %esi
    push %ebx
   
    subl $8, %esp       
    
    movl $-1,-4(%ebp)            #i=-1
    movl 16(%ebp), %ebx         #mutam n ul in ebx
    
    movl 8(%ebp), %edi          #mutam m1 in edi
    movl 12(%ebp), %esi         #mutam m2 in esi
    
    mere1:
        incl -4(%ebp)             #i++
        cmp %ebx, -4(%ebp)
        je iesire
        movl $-1,-8(%ebp)            #j=-1
        
      mere2:
        incl -8(%ebp)           #j++ 
        cmp %ebx, -8(%ebp)
        je mere1
        xorl %edx, %edx
        movl -4(%ebp),%eax      #eax=i
        mull %ebx               #eax=i*n
        addl -8(%ebp), %eax    #eax=i*n+j
        
        #in eax avem adresa din m1 ce trb mutata in m2
        
        movl (%edi, %eax, 4), %ecx
        movl %ecx, (%esi,%eax, 4)
        jmp mere2
        
        
  iesire:
        
    addl $8, %esp
    pop %ebx
    pop %esi
    pop %edi
    pop %ebp
    ret

  matrix_mult:
  
    push %ebp
    movl %esp, %ebp
    push %ebx
    push %edi
    push %esi
    subl $12, %esp   #cream loc pentru i, j, k
    
    movl $-1, -4(%ebp)   #i=-1
    movl 20(%ebp), %esi  #mutam n in esi
    
    #simulam 3 for uri
    form1:
        incl -4(%ebp)                #i++
        cmp -4(%ebp), %esi      #comparam i cu n
        je finish
        movl $-1, -8(%ebp)           #j=-1
        
        form2:
            incl -8(%ebp)            #j++
            cmp -8(%ebp), %esi   #comparam j cu n
            je form1
            movl $-1, -12(%ebp)     #k=-1
            
            #mres trb initializat cu 0
            xorl %edx, %edx
            movl -4(%ebp),%eax      #eax=i
            mull 20(%ebp)           #eax=i*n
            addl -8(%ebp), %eax     #eax=i*n+j
            movl 16(%ebp), %edi     #edi=mres
            movl $0, (%edi,%eax,4)
                
            form3:
                incl -12(%ebp)      #k++
                cmp -12(%ebp), %esi    #comparam k cu n
                je form2
      #calculam adresele la care se afla el ce trebuie inmultite
                xorl %edx, %edx
                movl -4(%ebp),%eax      #eax=i
                mull 20(%ebp)           #eax=i*n
                addl -12(%ebp), %eax    #eax=i*n+k
                
                movl 8(%ebp),%edi           #mutam prima matrice in edi
                movl (%edi, %eax,4), %ecx   #ecx=el ce trb inmultit
                
                xorl %edx, %edx
                movl -12(%ebp), %eax    #eax=k
                mull 20(%ebp)           #eax=k*n
                addl -8(%ebp), %eax     #eax=k*n+j

               movl 12(%ebp),%edi            #mutam a 2a matrice in edi
               movl (%edi, %eax,4), %ebx    #ebx=el ce trb inmultit
               
               #facem inmultirea
                xorl %edx, %edx
                movl %ecx, %eax
                mull %ebx
                movl %eax, %ebx     #in ebx avem produsul       
                
               #calculam adresa unde trb pus produsl in eax
                xorl %edx, %edx
                movl -4(%ebp),%eax      #eax=i
                mull 20(%ebp)           #eax=i*n
                addl -8(%ebp), %eax    #eax=i*n+j
                
                movl 16(%ebp), %edi      #mutam matricea noua in edi
                addl %ebx, (%edi, %eax, 4)
                
                jmp form3
    finish:
      addl $12, %esp
      popl %esi
      popl %edi
      popl %ebx
      popl %ebp
      ret
.global main

main:

citire_cerinta:
    pushl $cerinta
    pushl $fread
    call scanf
    addl $8, %esp
    

        pushl $n   #citim nr de noduri
        pushl $fread
        call scanf
        addl $8, %esp
        
#citim vectorul in care stocam legaturile
        
         lea v, %edi   #in edi vom avea vectorul
         xorl %ecx, %ecx
       
read_loop:
    cmp n,%ecx
    je read_exit
    
    pushl %ecx          #salvam registrul pe stiva
    
    pushl $leg          #citim nr de leg pt fiecare nod
    push $fread
    call scanf
    addl $8, %esp
    
    popl %ecx           #restaurare ecx
    
    movl leg,%edx       #mutam in vector nr citit
    movl %edx,(%edi, %ecx,4)
    
    incl %ecx
    jmp read_loop

read_exit: 
        lea m1, %esi  #in esi vom avea matricea
        #vom simula un for in for
        
        movl $-1, i   #contor for1
        
        
     for1:
            incl i
            movl i, %eax     
            cmp n, %eax                     #i<n
            je exit_for1
            
            movl (%edi, %eax,4),%ebx     #mutam el din v in ebx
            movl $0, j                   #contor for2
     for2:       
            cmp %ebx, j                  #j<v[i]
            je for1
            
            push $x                      #citim legaturile
            push $fread
            call scanf
            addl $8, %esp
            
            movl i, %eax

            xorl %edx, %edx             
            mull n                     
            addl x, %eax
            
         
            movl $1, (%esi,%eax, 4)
            
            incl j
            jmp for2
            
 exit_for1:           
    movl $1, %eax
    movl $2, %ebx
    
    cmp %eax, cerinta
    je cerinta1
    cmp %ebx, cerinta
    je cerinta2
     
 
cerinta1:
        

    #afisam matricea
    #avem doua for uri
    
  
        movl $0, i
    for_linii:
            movl i, %ecx
            cmp %ecx, n
            je et_exit
            movl $0, j
    for_coloane:
                movl j, %ecx
                cmp %ecx, n
                je newline

                movl i, %eax
                xorl %edx, %edx
                mull n
                addl j, %eax

               
                movl (%esi, %eax, 4), %ebx
                
                pushl %ebx
                pushl $fwrite
                call printf
                addl $8, %esp
                
                pushl $0
                call fflush
                addl $4, %esp
                
                incl j
                jmp for_coloane
newline:
    movl $4, %eax
    movl $1, %ebx
    movl $newLine, %ecx
    movl $2, %edx
    int $0x80
    
    incl i
    jmp for_linii


jmp et_exit

cerinta2:

    pushl $k
    pushl $fread
    call scanf
    addl $8, %esp
    
    pushl $ns
    pushl $fread
    call scanf
    addl $8, %esp
    
    pushl $nd
    pushl $fread
    call scanf
    addl $8, %esp
    
  #caz paricular pentru k=1
   movl $1,%eax
   cmp %eax,k
   je et_afisparticular
  
  #inmultimim matricea cu ea insesi de k-1 ori
    decl k
    
   #copiem ce este in m1 in m2 apeland schimb
   
    dbg: 
     push n
     push $m2
     push $m1
     call schimb
     addl $12, %esp 
      
    fork:
        xorl %ebx, %ebx
        cmp k, %ebx
        je et_afis
        
        #facem call la procedura
        
        push n
        push $mres
        push $m2
        push $m1
        call matrix_mult
        addl $16, %esp
        
        #schimbam matricele
        push n
        push $m2
        push $mres
        call schimb
        addl $12, %esp
         
                
        decl k
        jmp fork
        
et_afisparticular:

        #calculam adresa la care se afla raspunsul-->ns*n+nd
        lea m1, %edi    
            
        xorl %edx, %edx
        movl ns, %eax
        mull n
        addl nd, %eax
        
        movl (%edi,%eax, 4), %ebx
        jmp afis       
        
et_afis:  
      
        #calculam adresa la care se afla raspunsul-->ns*n+nd
        lea mres, %edi    
            
        xorl %edx, %edx
        movl ns,%eax
        mull n
        addl nd, %eax
        
        movl (%edi,%eax, 4), %ebx
        
  afis:   
        #afisam raspunsul
        
        pushl %ebx
        pushl $fwriteNL
        call printf
        addl $8, %esp
                
        jmp et_exit

    
   

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
    
    
