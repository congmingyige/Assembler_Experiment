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

        mov ah,4ch
        int 21h

code ends
        end start
