code segment

assume cs:code
     g1:mov ah,1
        int 21h         ;input to al
        cmp al,'$'
        jz exit         ;if al='$' then exit
        mov dl,al
        mov ah,2        ;output from dl
        int 21h
        jmp g1          ;cycle
   exit:mov ah,4ch      ;just need ah,don't need al
        int 21h         ;-p to check
code ends
        end g1
