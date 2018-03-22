
stack segment stack
        db 100 dup(?)
stack ends

data segment 
        buf1 db 50,?,50 dup(?)
        buf2 db 50,?,50 dup(?)
        tip1 db 0dh,0ah
             db 'Buf1= ','$'
        tip2 db 0dh,0ah
             db 'Buf2= ','$'
data ends

code segment
        assume cs:code,ds:data,ss:stack
  start:mov ax,data
        mov ds,ax

                ;output tip1
        mov dx,offset tip1
        mov ah,9
        int 21h

                ;input to buf1
        mov dx,offset buf1
        mov ah,0ah
        int 21h
                ;add '$' to buf1
        mov bh,00h
        mov si,dx
        mov bl,[si+1]
        mov al,'$'
        mov [bx+si+2],al

        mov cx,bx
                          
                ;output tip2
        mov dx,offset tip2
        mov ah,9
        int 21h
  
                ;input to buf2
        mov dx,offset buf2
        mov ah,0ah
        int 21h
                ;add '$' to buf1
        mov bh,00h
        mov si,dx
        mov bl,[si+1]
        mov al,'$'
        mov [bx+si+2],al
                ;output buf1
        mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
        mov dx,offset buf1
        add dx,2
        mov ah,9
        int 21h
                ;cx=min(length(buf1),length(buf2))
        cmp cx,bx
        jna next
        mov cx,bx
   next:
                ;compare each position
        mov si,offset buf1
        mov di,offset buf2
        mov bx,2
      s:mov al,[bx+si]
        cmp al,[bx+di]
        ja bigger
        jc smaller
        add bx,1
        loop s
                ;judge whose len is cx
        mov al,[bx+si]
        cmp al,'$'
        jne bigger
        mov al,[bx+di]
        cmp al,'$'
        jne smaller
                         
   same:mov dl,'='
        jmp output

 bigger:mov dl,'>'
        jmp output

smaller:mov dl,'<'
        jmp output
	
 output:
                ;output symbol
        mov ah,2
        int 21h
                ;output buf2
        mov dx,offset buf2
        add dx,2
        mov ah,9
        int 21h

        mov ah,4ch
        int 21h

code ends
        end start
;ab abc
;abc ab
;abc abc
;ab d
;d ab

