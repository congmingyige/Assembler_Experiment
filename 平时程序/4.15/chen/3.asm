stack segment
        db 200 dup(0)
stack ends

code segment
        assume cs:code,ss:stack
  begin:mov ah,1
        int 21h

        sub al,20h
        mov dl,al

        mov ah,2
        int 21h

        mov ah,4ch
        int 21h
code ends
        end begin

