
data segment
        db ',','.','/','<','>','?',';',':',222,'"','[',']','\','{','}','|','~','`'
        db '!','@','#','$','%','^','&','*','(',')','-','_','+','='
data ends

stack segment
        db 30 dup(?)
stack ends

code segment
        assume cs:code,ss:stack,ds:data
  start:mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov ax,30
        mov sp,ax
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
                ;set small window
        mov cx,16       ;line 5~line 20
        mov bx,5
      A:
        mov ah,2
        mov dh,bl
        mov dl,15
        mov bh,0
        int 10h

        push cx
        push bx

                ;;set character
        mov ah,9
        mov al,' '
        mov bl,0
                ;blinking
        mov cx,51       ;65-15+1
        or bl,10000000B
                ;background color
        or bl,01000000B
                ;highlight
        or bl,00001000B
                ;character color
        or bl,00000010B
        int 10h       

        pop bx
        inc bx
        pop cx

        loop A
                ;;set cursor in the begining
        mov ah,2
        mov dh,5
        mov dl,15
        mov bh,0
        int 10h        
                ;(5,15)~(20,65)
        mov dh,5
        mov dl,15

      B:mov ah,8        ;pay attention , 8 , not 1
        int 21h
                ;if al=Esc,exit
        cmp al,27
        jz x1
        jmp y1
     x1:jmp near ptr exit
     y1:
                ;up/down/left/right:two input
        cmp al,0
        jnz r
                
        mov ah,1
        int 21
                 ;up
        cmp al,48h
        jz x2
        jmp y2
     x2:jmp near ptr up
     y2:
                ;down
        cmp al,50h
        jz x3
        jmp y3
     x3:jmp near ptr down
     y3:
                ;left
        cmp al,4Bh
        jz x4
        jmp y4
     x4:jmp near ptr left
     y4:        
                ;right
        cmp al,4Dh
        jz x5
        jmp y5
     x5:jmp near ptr right
     y5:

      r:
                ;'\n'
        cmp al,13
        jz x6
        jmp y6
     x6:jmp near ptr enter
     y6:
                ;backspace
        cmp al,8
        jz x7
        jmp y7
     x7:jmp near ptr back
     y7:
                ;tab
        cmp al,9
        jz x8
        jmp y8
     x8:jmp near ptr tab
     y8:
                ;'0'~'9'
        cmp al,'0'
        jb other
        cmp al,'9'
        jna normal
                ;'A'~'Z'
        cmp al,'A'
        jb other
        cmp al,'Z'
        jna normal
                ;'a'~'z'
        cmp al,'a'
        jb other
        cmp al,'z'
        jna normal
        jmp B
                ;other character which can typed
  other:mov bx,0
  check:cmp al,ds:[bx]
        jz normal
        inc bx
        cmp bx,32
        jnz check
                ;character:not the one
        jmp near ptr B
setcursor:              ;no need to set dh,dl
        mov ah,2
        mov bh,0
        int 10h
        jmp near ptr B

 normal:cmp dl,65
        jnz out1
        cmp dh,20
        jz x9
        jmp y9
     x9:jmp near ptr exit         ;input from the last position, exit
     y9:
   out1:push dx
        mov ah,2
        mov dl,al
        int 21h
        pop dx
        inc dl
        cmp dl,66
        jnz setcursor
        inc dh
        mov dl,15
        jmp setcursor

   back:cmp dl,15
        jnz out2
        cmp dh,5
        jz x10
        jmp y10
    x10:jmp near ptr B             ;delete from the first position, remain the same
    y10:
        dec dh
        mov dl,65
        jmp out3
   out2:dec dl
   out3:
                      ;setcursor:no need to set dh,dl
        mov ah,2
        mov bh,0
        int 10h        
        push dx
        mov ah,2
        mov dl,' '
        int 21h
        pop dx
        jmp setcursor

  enter:cmp dh,20
        jz x11
        jmp y11        
    x11:jmp near ptr B
    y11:
        inc dh
        mov dl,15
        jmp setcursor

    tab:mov al,' '
        jmp near ptr normal
        jmp near ptr B

     up:cmp dh,5
        jz x12
        jmp y12
    x12:jmp near ptr B
    y12:
        dec dh 
        jmp setcursor

   down:cmp dh,20
        jz x13
        jmp y13
    x13:jmp near ptr B
    y13:
        inc dh
        jmp near ptr setcursor

   left:cmp dl,15
        jz x14
        jmp y14
    x14:jmp near ptr B
    y14:
        dec dl
        jmp near ptr setcursor    

  right:cmp dl,65
        jz x15
        jmp y15
    x15:jmp near ptr B
    y15:
        inc dl
        jmp near ptr setcursor

   exit:mov ah,4ch
        int 21h

code ends
        end start
