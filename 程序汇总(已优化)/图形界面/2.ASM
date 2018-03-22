
code segment
        assume cs:code
                ;;big background
        mov ah,6
        mov al,0
        mov ch,0
        mov cl,0
        mov dh,24
        mov dl,79
        mov bh,7
        int 10h

        mov ah,9
        mov cx,0FFFFh
        mov al,' '
        mov bl,00110000B
        int 10h
poscurse:
                ;;set cursor
        mov ah,2
        mov dh,20
        mov dl,15
        dec dl
        mov bh,0
        int 10h

                ;;set character
        mov ah,9
        mov al,' '
        mov bl,0
                ;blinking
        mov cx,52
        or bl,10000000B
                ;background color
        or bl,01000000B
                ;highlight
        or bl,00001000B
                ;character color
        or bl,00000010B
        int 10h       
                ;output ' '
        mov ah,2
        mov dl,' '
        int 21h
                ;output from keyboard , a line ,20 characters
        mov cx,50
getchar:
        mov ah,1
        int 21h
        cmp al,'Q'
        jz exit
        cmp al,0dh
        jz enter
        cmp al,'9'
        jz enter
        loop getchar
        jmp up
  enter:mov ah,2
        mov dh,20
        mov dl,65
        mov bh,0
        int 10h

     up:mov ah,6
        mov al,1
        mov ch,5
        mov cl,15
        dec cl
        mov dh,20
        mov dl,65
        mov bh,7
        int 10h

        jmp poscurse


   exit:mov ah,4ch
        int 21h

code ends

end
