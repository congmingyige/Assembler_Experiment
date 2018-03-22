assume cs:code

code segment

        mov ax,0020h
        mov ds,ax
        mov bx,0
        mov cx,64

      s:mov ds:[bx],bl
        inc bx
        loop s

        mov ah,4ch
        int 21h
code ends

end
