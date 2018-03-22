stack segment
        dw 100 dup(?)
stack ends

data segment
        buff dw 3c6dh
data ends

code segment
        assume cs:code,ds:data,ss:stack
  start:mov ax,data
        mov ds,ax                
        lea si,buff
        mov bx,[si]
        mov ch,4

     a1:mov cl,4
        rol bx,cl
        mov al,bl
                ;just exist the last position
        and al,0fh
                ;change to ascii
        add al,30h
                ;if '0'~'9',not add 7h;otherwise 'A'~'F', add 7h(10(3Ah)->A(41h))
        cmp al,3ah
        jl a2
        add al,7h

     a2:mov dl,al
        mov ah,2
        int 21h

        dec ch
        jnz a1

        mov ah,4ch
        int 21h
                        
code ends
        end start
