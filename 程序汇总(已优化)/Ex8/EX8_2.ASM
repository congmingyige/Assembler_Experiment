stack segment
        dw 64 dup(?)
stack ends

data segment
 string db 'university'
 lenstr equ $-string        
data ends

code segment
        assume cs:code,ds:data,ss:stack
  start:mov ax,data
        mov ds,ax
        
        mov ah,0
        mov al,3
        int 10h

        mov bp,seg string
        mov es,bp
        mov bp,offset string
        mov cx,lenstr
        mov dx,0
        mov bl,25h
        mov al,0
        mov ah,13h
        int 10h

        mov ah,4ch
        int 21h
code ends
        end start

