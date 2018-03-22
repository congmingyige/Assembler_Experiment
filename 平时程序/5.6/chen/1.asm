stack segment
        db 200 dup(0)

stack ends

code segment
        assume cs:code,ss:stack
  start:
                ;input x
        mov ah,1
        int 21h
        mov bl,al
                ;output '\n'
        mov ah,2
        mov dl,0dh
        int 21h
        ;mov ah,2
        mov dl,0ah
        int 21h
                ;input y
        mov ah,1
        int 21h
                ;change to ascii
        sub al,30h
        sub bl,30h
                ;multiply: ax=al*bl
        mul bl
                ;ax div 10 result: Shang:al,Yu:ah
        mov bl,10
        div bl
                ;change to number
        add ax,3030h
        mov bx,ax
                ;output '\n'
        mov ah,2
        mov dl,0dh
        int 21h
        ;mov ah,2
        mov dl,0ah
        int 21h

                ;output two numbers                
        mov ah,2
                ;if bl=0 ,don't input
        cmp bl,30h
        jz output

        mov dl,bl        
        int 21h

 output:mov dl,bh
        int 21h

        mov ah,4ch
        int 21h

code ends
        end start
