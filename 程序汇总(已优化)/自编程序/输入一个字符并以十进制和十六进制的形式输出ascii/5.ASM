
code segment
        assume cs:code
        mov ah,1
        int 21h
        mov bl,al
                ;H      at least two character , <0FFh
        mov ah,2
        mov dl,' '
        int 21h
                ;al:input
        mov ah,0
        mov al,bl
        mov dl,16
        div dl
        cmp ah,10
        jb x1
        add ah,37h
        jmp x2
     x1:add ah,30h
     x2:
        cmp al,10
        jb x3
        add al,37h
        jmp x4
     x3:add al,30h
     x4:
        mov bh,ah

        mov ah,2
        mov dl,al
        int 21h
        mov dl,bh
        int 21h

        mov dl,'H'
        int 21h
                ;D
        mov ah,2
        mov dl,' '
        int 21h
                ;BaiWei
        mov ah,0
        mov al,bl
        mov bh,100 
        div bh
        cmp al,0
        jz x5
                ;output BaiWei & del BaiWei
                ;bl=YuShu
        mov bl,ah
        mov ah,2
        mov dl,al
        add dl,30h
        int 21h
     x5:                
        mov ah,0
        mov al,bl
        mov bh,10
        div bh
                ;Shang:al YuShu:ah
        mov bh,ah
                ;ShiWei
        mov ah,2
        mov dl,al
        add dl,30h
        int 21h
                ;GeWei
        mov dl,bh
        add dl,30h
        int 21h

        mov dl,'D'
        int 21h

        mov ah,4ch
        int 21h
code ends

end
