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

   next:mov ah,2
                ;output ShiWei
        mov dl,bl                
        mov cl,4
        shr dl,cl       ;div 16(2^4)                
        or dl,30h                              
        int 21h
                ;output GeWei
        mov dl,bl                
        and dl,0fh      ;mod 16(2^4,(0f+1))
                
        or dl,30h
        mov ah,2        ;change to character
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
