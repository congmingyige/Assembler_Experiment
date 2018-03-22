stack segment
        dw 64 dup(?)
stack ends

code segment
        assume cs:code,ss:stack
                ;26 characters 'A'~'Z'
  start:mov cx,001ah
        mov bl,41h
        mov ah,02h
     a1:mov dl,bl
        int 21h
        inc bl
        push cx
		;loop 0fffh times
        mov cx,0fffh
     a2:loop a2
        pop cx
        dec cx
		;if cx<>0 , jmp a1  the combination of dec & jnz
        jnz a1

        mov ah,4ch
        int 21h

code ends
        end start
