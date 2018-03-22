assume cs:code

code segment
  start:mov ah,1
        int 21h
                ;'\n'
        cmp al,0dh
        jz tc 
                ;'0'~'9'
        cmp al,'0'
        jb next
        cmp al,'9'
        ja a

        mov dl,al
        mov ah,2
        int 21h

        jmp start

                ;'A'~'Z'
      a:cmp al,41h
        jb next
        cmp al,5ah
        ja b

      c:mov dl,'C'
        mov ah,2
        int 21h

   next:jmp start
                ;'a'~z'
      b:cmp al,61h
        jb next
        cmp al,7ah
        ja next
        jmp C

     tc:mov ah,4ch
        int 21h

code ends
        end start

