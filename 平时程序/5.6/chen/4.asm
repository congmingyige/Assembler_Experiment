stack segment
        db 64 dup(?)
stack ends

code segment
         assume cs:code,ss:stack
  start:
                ;output '\n'
        mov dl,0dh
        mov ah,2
        int 21h
        mov dl,0ah
        int 21h

        mov bl,0

   next:mov al,bl
                ;div 16(2^4)
        mov cl,4
        shr al,cl
                ;change to character
        or al,30h
                ;output ShiWei
        mov dl,al
        mov ah,2
        int 21h

        mov dl,bl
                ;just the last position exist
        and dl,0fh
                ;output GeWei
        or dl,30h
        mov ah,2
        int 21h

        mov al,bl
        inc al
        daa

        cmp al,30h
        jnc finish

        mov bl,al
                ;'0':'f' can't show on the first place
                ;loop ffff times 
        mov cx,0ffffh

  delay:loop delay
        jmp next

 finish:mov ah,4ch
        int 21h

code ends
        end start
