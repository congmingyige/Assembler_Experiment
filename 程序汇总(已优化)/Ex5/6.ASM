stack segment stack
        db 64 dup(?)
stack ends

data segment
        buff db 50,?,50 dup(?)
                ;\n\r
        mes1 db 0dh,0ah
             db 'What is your name?:$'
        mes2 db 0dh,0ah
             db 'hello!','$','abc'
data ends

code segment
        assume cs:code,ds:data,ss:stack
  start:mov ax,data
        mov ds,ax

                ;output mes1
        mov dx,offset mes1
        mov ah,9
        int 21h

                ;input to buff
        mov dx,offset buff
        mov ah,0ah
        int 21h

                ;output mes2
        mov dx,offset mes2
        mov ah,9
        int 21h

                ;output ' '
        mov dl,' '
        mov ah,2
        int 21h

        mov ch,0
        lea si,[buff+2]
        mov bx,offset buff
        mov cx,[bx+1]
        mov ch,0
        ;mov ah,2
      s:mov dl,[si]
        int 21h
        inc si
        loop s
        mov ah,4ch

        int 21h

code ends
        end start
