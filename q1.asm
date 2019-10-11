;
;       Objective: Find out multiplication of two given square matrix

%include "io.mac"

.DATA
msg1    db  "Enter size of square matrix: ",0
msg2    db  "Enter frist matrix: ",0
msg3    db  "Enter second matrix: ",0
msg4    db  "First matrix is: ",0
msg5    db  "Second matrix is: ",0
msg6    db  "Resultant matrix: ",0
space   db  " ",0
i           dw   0
j           dw   0
k           dw   0
sum         dw   0
index1      dw   0
index2      dw   0

.UDATA
n resw 1
size_matrix resw 1
matrix_first resw 100 
matrix_second resw 100 
matrix_resultant resw 100


.CODE
    .STARTUP

    PutStr msg1
    GetInt [n]
    mov eax,[n]
    imul eax,[n]
    mov [size_matrix],eax
    PutStr msg2
    nwln
    push word[size_matrix]
    push matrix_first
    call read_matrix

    PutStr msg3
    nwln
    push word[size_matrix]
    push matrix_second
    call read_matrix

    PutStr msg4
    nwln
    push word[n]
    push matrix_first
    call print_matrix

    PutStr msg5
    nwln
    push word[n]
    push matrix_second
    call print_matrix

    push word[n];
    push matrix_first
    push matrix_second
    push matrix_resultant
    call multiply_matrix

    PutStr msg6
    nwln
    push word[n]
    push matrix_resultant
    call print_matrix 

done:
    .EXIT

    read_matrix:
        push ebp
        mov ebp,esp
        xor ax,ax
        mov ebx,[ebp+8]
        read_loop:
            GetInt cx
            mov [ebx],cx
            add ebx,2
            inc ax
            cmp ax,[ebp+12]
        jne read_loop
        read_loop_end:
            leave
            ret

    print_matrix:
        push ebp
        mov ebp,esp
        xor bx,bx
        mov ecx,[ebp+8]
        print_loop:
            xor ax,ax
            print_row:
                PutInt word[ecx]
                PutStr space
                add ecx,2
                inc ax
                cmp ax,[ebp+12]
            jne print_row
                nwln
                inc bx
                cmp bx,[ebp+12]
            jne print_loop
            print_loop_end:
                leave
                ret

    multiply_matrix:
        push ebp
        mov ebp,esp
        mov eax, [ebp+16]
        mov ebx,[ebp+12]
        mov ecx, [ebp+8]
        mul_loop:
            xor dx,dx
            mov word[j],dx
    
            mul_loop_row:
                xor dx,dx
                mov word[k],dx
                mov word[sum],dx

                mul_loop_add:
                    mov dx,word[i]
                    imul dx,[ebp+20]
                    add dx,word[k]
                    mov [index1],dx

                    mov dx,word[k]
                    imul dx,[ebp+20]
                    add dx, word[j]
                    mov [index2],dx

                    add ax, word[index1]
                    add ax, word[index1]
                    add bx, word[index2]
                    add bx, word[index2]

                    mov dx, [eax]
                    imul dx, [ebx]
                    add [sum],dx

                    sub ax, word[index1]
                    sub ax, word[index1]
                    sub bx, word[index2]
                    sub bx, word[index2]
    
                    inc word[k]
                    mov dx, word[k]
                    cmp dx, [ebp+20]
                jne mul_loop_add

                mov dx, word[sum]
                mov word[ecx],dx
                add ecx,2
                inc word[j]
                mov dx,word[j]
                cmp dx,[ebp+20]
            jne mul_loop_row

            inc word[i]
            mov dx,word[i]
            cmp dx,[ebp+20]
        jne mul_loop

        mul_loop_end:
            leave
            ret
