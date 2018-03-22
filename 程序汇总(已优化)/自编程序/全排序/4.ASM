  
;QuanPaiLie

data segment
    num db 10 dup(?)
  mess1 db 'Please input n(n<=8): $'
  mess2 db 'QuanPaiLie: ',0dh,0ah,'$'
data ends

stack segment
        db 20 dup(?)       
stack ends

code segment
        assume cs:code,ds:data,ss:stack
  start:mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov ax,20
        mov sp,ax
                ;output mess1
        mov ah,9
        mov dx,offset mess1
        int 21h
                ;input n(n<10)
        mov ah,1
        int 21h        
        mov cl,al
        mov ch,0
        sub cx,30h
        mov dx,cx
        push cx
        push cx
                ;output '\n'
        mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
                ;output mess2
        mov ah,9
        mov dx,offset mess2
        int 21h        
                ;initialization:n number(s)
        mov bx,0        
      A:inc bx
        mov word ptr [bx],bx            ;begin from xx:0001
        loop A
                ;total
        pop cx
        mov ax,1
      B:mul cx
        loop B
        mov cx,ax
                ;work
        pop dx
      C:
                ;output n number(s)
        push cx
        mov bx,0
        mov ah,2        
        mov cx,dx
        push dx
      D:inc bx
        mov dl,[bx]
        add dl,30h
        int 21h
        loop D
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
        pop dx
                ;;change kth condition into (k+1)th condition       
                ;find a position i , st. a[i]<a[i+1]
        mov si,dx
      E:dec si
        mov al,ds:[si]          ;?
        cmp al,ds:[si+1]        ;?
        ;cmp byte ptr ds:[si],ds:[si+1]
        ja E
                ;find a biggest position j , st. a[i]<a[j]
        mov di,dx
        inc di
      F:dec di
        mov al,ds:[si]          ;?
        cmp al,ds:[di]
        ;cmp byte ptr ds:[si],ds:[di]
        ja F
                ;change a[i],a[j]
        mov al,ds:[si]
        mov bl,ds:[di]          ;?
        mov ds:[si],bl          ;?
        ;mov byte ptr ds:[si],ds:[di]
        mov ds:[di],al
                ;reverse a[i+1]~a[n]
        mov di,dx
        inc di
      G:inc si
        dec di
                ;if si>=di , it means the finish of reverse
        cmp si,di
        jnb H
                ;change
        mov al,ds:[si]
        mov bl,ds:[di]          ;?
        mov ds:[si],bl          ;?
        ;mov byte ptr ds:[si],ds:[di]
        mov ds:[di],al
        jmp G

      H:pop cx
        loop C

        mov ah,4ch
        int 21h
code ends
        end start
