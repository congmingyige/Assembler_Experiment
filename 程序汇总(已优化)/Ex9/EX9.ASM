
data segment
        mes1 db 'SCORE[<60]     :','$'
        mes2 db 'SCORE[60-69]   :','$'
        mes3 db 'SCORE[70-79]   :','$'
        mes4 db 'SCORE[80-89]   :','$'
        mes5 db 'SCORE[90-99]   :','$'
        mes6 db 'SCORE[=100]    :','$'
        mes7 db 'TOTAL NUMBER   :','$'
        result db 92,85,74,81,70,68,65,78,54,43
               db 94,100,83,88,79,83,79,69,62,60
        total db 00
        s5    db 00
        s6    db 00
        s7    db 00
        s8    db 00
        s9    db 00
        s10   db 00
data ends

code segment
        assume cs:code,ds:data
  start:mov ax,data
        mov ds,ax
        mov si,offset result
        mov cx,20
   comp:mov al,[si]
        cmp al,60
        jb five
        cmp al,70
        jb six
        cmp al,80
        jb seven
        cmp al,90
        jb eight
        cmp al,100
        jb nine
        cmp al,100
        je ten
        jmp next
   five:mov al,[s5]
        add al,1
        daa
        mov [s5],al
        jmp next
    six:mov al,[s6]
        add al,1
        daa
        mov [s6],al
        jmp next
  seven:mov al,[s7]
        add al,1
        daa
        mov [s7],al
        jmp next
  eight:mov al,[s8]
        add al,1
        daa
        mov [s8],al
        jmp next
   nine:mov al,[s9]
        add al,1
        daa
        mov [s9],al
        jmp next
    ten:mov al,[s10]
        add al,1
        daa
        mov [s10],al
        jmp next
   next:mov al,[total]
        add al,1
        daa
        mov [total],al
        inc si
        loop comp

        mov dx,offset mes1
        mov ah,9
        int 21h
        mov al,[s5]
        call disp

        mov dx,offset mes2
                ;call disp will change the value of al , thus set al each time
        mov ah,9
        int 21h
        mov al,[s6]
        call disp

        mov dx,offset mes3
        mov ah,9
        int 21h
        mov al,[s7]
        call disp

        mov dx,offset mes4
        mov ah,9
        int 21h
        mov al,[s8]
        call disp

        mov dx,offset mes5
        mov ah,9
        int 21h
        mov al,[s9]
        call disp

        mov dx,offset mes6
        mov ah,9
        int 21h
        mov al,[s10]
        call disp

        mov dx,offset mes7
        mov ah,9
        int 21h
        mov al,[total]
        call disp

        mov ah,4ch
        int 21h

   disp proc near
        push cx
        mov bl,al
        and al,0f0h
        mov cl,4
        shr al,cl
        add al,30h

        mov dl,al
        mov ah,2
        int 21h

        mov al,bl
        and al,0fh
        add al,30h

        mov dl,al
        ;mov ah,2
        int 21h

        mov dl,0dh
        ;mov ah,2
        int 21h
        mov dl,0ah
        ;mov ah,2
        int 21h

        pop cx
        ret
   disp endp
code ends
        end start
