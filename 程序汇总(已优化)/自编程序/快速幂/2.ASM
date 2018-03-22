
;Quickpow

data segment
        ;dw [0,65536)
        dw 2,20,1000,1
                ;x,y,z,result   result=x^y mod z
                ;x,y,z<65536 result<65536
    vis dw 0
        dw 0ah
data ends

stack segment
        db 20 dup(?)
stack ends

code segment
        assume cs:code,ds:data,ss:stack
  start:mov ax,data
        mov ds,ax
        mov cx,ds:[2]   ;2=1(place)*2(length)
        
      A:mov dx,cx
        and dx,1
        jz B
        mov ax,ds:[6]
        mul word ptr ds:[0]     ;result*a%c
        div word ptr ds:[4]
        mov ds:[6],dx
      B:mov ax,ds:[0]
        mul word ptr ds:[0]     ;a*a%c
        div word ptr ds:[4]
        mov ds:[0],dx
        shr cx,1                ;allow: shr xx,1 / shr xx,cl
        jnz A
                ;output the number from ds:[6]
        mov bx,ds:[6]
        mov ch,4
      C:mov cl,4
        rol bx,cl
        mov dx,bx
        and dx,0fh
        add dl,30h
        cmp dl,3ah
        jl D
        add dl,7h

      D:cmp dl,30h
        jnz output
        cmp word ptr ds:[8],0
        jnz output
        mov dx,1
        mov ds:[8],dx
        dec ch
        jnz C

 output:mov ah,2
        int 21h
        dec ch
        jnz C

        ;mov ah,2
        mov dl,'H'
        int 21h
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
                ;output from ds:[6], decimal
        mov ax,stack
        mov ss,ax
        mov ax,20
        mov sp,ax
        mov cx,0
      E:mov dx,0
        mov ax,ds:[6]
        div word ptr ds:[10]
        inc cx
        push dx         ;dx<10  00dl
        mov ds:[6],ax
        cmp ax,0
        jnz E

        mov ah,2
      F:pop dx
        add dx,30h
        int 21h
        loop F

        ;mov ah,2
        mov dl,'D'
        int 21h

        mov ah,4ch
        int 21h

code ends
        end start

