
;Hexadecimal to Decimal

data segment
      s dw 0FE01h
  radix dw 0ah
data ends

stack segment
        db 20 dup(?)
stack ends

code segment
        assume cs:code,ds:data,ss:stack
  start:
        mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov ax,20
        mov sp,ax
        mov cx,0
      A:mov dx,0
        mov ax,ds:[0]
        div word ptr ds:[2]
        inc cx
        push dx         ;dx<10  00dl
        mov ds:[0],ax
        cmp ax,0
        jnz A

        mov ah,2
      B:pop dx
        add dx,30h
        int 21h
        loop B

        mov ah,4ch
        int 21h

code ends
        end start

