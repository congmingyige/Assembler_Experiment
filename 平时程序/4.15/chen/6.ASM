code segment
        assume cs:code
  begin:mov ah,1
        int 21h    ;input from screen(al)
        cmp al,24h ;'$'
        jz exit

        cmp al,41h ;'A'
        jb output ;<'A'
        cmp al,5Ah ;'Z'
        jna operator ;'A'~'Z'
        cmp al,61h ;'a'
        jb output ;>'Z' and <'a'
        cmp al,7Ah ;'z'
        ja output ;>'z'
                  ;left 'a'~'z'
operator: ;'A'~'Z' and 'a'~'z'
        xor al,00100000B
 output:mov dl,al
        mov ah,2   
        int 21h    ;output from screen(dl)
        loop begin

   exit:mov ah,4Ch
        int 21h

code ends
        end begin
