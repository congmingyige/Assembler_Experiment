
code segment
        assume cs:code

        mov ah,6
        mov al,0
        mov ch,0
        mov cl,0
        mov dh,24
        mov dl,79
        mov bh,7
        int 10h

poscurse:
        mov ah,2
        mov dh,16
        mov dl,30
        mov bh,0
        int 10h

        mov cx,20
getchar:
        mov ah,1
        int 21h
        cmp al,'Q'
        jz exit
        loop getchar

        mov ah,6
        mov al,1
        mov ch,8
        mov cl,30
        mov dh,16
        mov dl,50
        mov bh,7
        int 10h

        jmp poscurse

   exit:mov ah,4ch
        int 21h

code ends

end
