assume cs:codesg

codesg segment
        mov ax,2000h
        mov ss,ax	;ss=2000h
        mov sp,10h
        add sp,4
        push ax		;ax=2000h
        push bx		;bx=0
        pop ax		;ax=0
        pop bx		;bx=2000h
        mov ax,4c00h
        int 21h
codesg ends

end
