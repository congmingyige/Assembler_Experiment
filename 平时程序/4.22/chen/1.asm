stack segment stack
        dw 256 dup(?)
stack ends

data segment
        a db 10h
        b db 30h
data ends

code segment
        assume cs:code,ss:stack,ds:data
  start:mov ax,data
        mov ds,ax

                ;output 'A= '
        mov ah,2
        mov dl,'A'
        int 21h
        mov dl,'='
        int 21h
        mov dl,' '
        int 21h

                ;input A
        mov ah,1
        int 21h
        mov a,al

                ;output ' B= '
        mov ah,2
                ;Space
        mov dl,20h
        int 21h
        mov dl,'B'
        int 21h
        mov dl,'='
        int 21h
        mov dl,' '
        int 21h

                ;input B
        mov ah,1
        int 21h
        mov b,al

                ;compare
        cmp a,al
        ja bigger

        jb smaller

        jmp equal


 bigger:mov bl,'>'
        jmp output

smaller:mov bl,'<'
        jmp output

  equal:mov bl,'='

 output:mov ah,2
                ;HuanHang:\r\n
        mov dl,0Ah
        int 21h
        mov dl,0Dh
        int 21h
        mov dl,a
        int 21h
        mov dl,bl
        int 21h
        mov dl,b
        int 21h
        
        mov ah,4ch
        int 21h

code ends
        end start

