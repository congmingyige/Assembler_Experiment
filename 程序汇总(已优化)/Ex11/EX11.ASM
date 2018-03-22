crlfmacrd
        mov ah,02h
        mov dl,0dh
        int 21h
        ;mov ah,02h
        mov dl,0ah
        int 21h
endm

data segment
        mess1 db 'INPUT STRING , THE FLAG IS $'
        mess2 db 'NON-DIGITAL , CHAR CONST= $'
data ends

stack segment
        sta dw 32 dup(?)
        top dw ?
stack ends

code segment
        assume cs:code,ds:data,ss:stack
  start:mov ax,data
        mov ds,ax
        mov es,ax
        mov sp,top
        mov bx,0
                ;output mess1
        mov ah,09h
        mov dx,offset mess1
        int 21h
                ;input a char
        mov ah,02h
        mov dl,'$'
        int 21h

        crlf
    XXX:mov ah,01h
        int 21h
                ;'$'
        cmp al,'$'
        jz UUU
                ;'\n'
        cmp al,0dh
        jnz III
        crlf
        jmp VVV
    III:cmp al,30h
        jb YYY
        cmp al,39h
        jbe VVV         ;non '0'~'9':YYY
    YYY:inc bx
    VVV:jmp XXX
    UUU:crlf
        mov ah,09h
        mov dx,offset mess2
        int 21h
        mov ax,bx
        call disp
        mov ah,02h
        mov dl,'H'
        int 21h         ;hex
        mov ax,4c00h
        int 21h
        dispp proc near
        mov bl,al
    KKK:mov dl,bl
        mov cl,04
        rol dl,cl
        and dl,0fh
        call displ
        ret
        dispp endp
code ends
        end start        
