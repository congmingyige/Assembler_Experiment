code segment


assume cs:code
  begin:mov ah,1
        int 21h
        ;when input '$' output
        cmp al,24h
        jz exit
        cmp al,60h
        JA lowercase ;'a'~'z'
        JB uppercase ;'A'~'Z'
        loop output

lowercase: ;change to lowercase
        and al,11011111B
        loop output

uppercase: ;change to uppercase
        or al,00100000B
        loop output

 output: ;output a modified char
        mov dl,al

        mov ah,2
        int 21h
        loop begin

   exit:mov ah,4ch
        int 21h
                               
code ends
        end begin
