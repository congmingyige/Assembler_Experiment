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
        add dl,30h                              
        int 21h
                ;output GeWei
        mov dl,bl                
        and dl,0fh      ;mod 16(2^4,(0f+1))
                
        add dl,30h
        mov ah,2        ;change to character
        int 21h
                        ;JinWei
        cmp dl,39h      ;number '9'  (30 number'0')
        jz special
        inc bl   
        jmp judge

special:add bl,7

                        ;when bl=30 , exit
  judge:cmp bl,30h
        jz finish

        mov cx,0ffffh
  delay:loop delay

        jmp next

 finish:mov ah,4ch
        int 21h

code ends
        end start
