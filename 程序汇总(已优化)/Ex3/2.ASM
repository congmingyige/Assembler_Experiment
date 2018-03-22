
data segment
        buf db 'Hello',13,10,'END$'
data ends

stack segment
        db 100 DUP (0)
stack ends

code segment
        assume cs:code,ds:data,ss:stack
begin:  mov ax,data
        mov ds,ax
        lea bx,buf      ;bx=PianYi address of buf

     la:mov dl,[bx]
        cmp dl,'$'
        jz exit
        cmp dl,'a'
        jb k
        cmp dl,'z'
        ja k
        sub dl,20h      ;if dl in ['a'~'z'],then sub 20h(change into DaXie)

      k:mov ah,2
        int 21h
        inc bx
        jmp la

   exit:mov ah,4ch
        int 21h

code ends
        end begin
      
