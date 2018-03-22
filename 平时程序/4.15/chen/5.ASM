code segment
assume cs:code
  begin:mov ah,1
        int 21h
        ;input '$' is the symbol of the end of program
        cmp al,24h ;'$':24h
        jz exit
        cmp al,41h ;'A'
        jb output  ;<'A'
        cmp al,5Ah ;'Z'
        jna upper ;'A'~'Z'

        cmp al,7Ah ;'z'
        ja output ;>'z'
        cmp al,61h ;'a'
        jnb lower ;'a'~'z'

        loop output ;>'Z' and <'a'

  upper: ;change to lowercase
        and al,11011111B
        loop output

  lower: ;change to uppercase
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
