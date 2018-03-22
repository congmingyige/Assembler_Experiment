

;HtoD

data segment
      n dw ?                        
data ends

stack segment
        db 50 dup(?)
stack ends

code segment
        assume cs:code,ss:stack,ds:data
  start:mov ax,stack
        mov ss,ax
        mov sp,50
        mov ax,data
        mov ds,ax

        mov si,10
        mov di,10000
        mov bx,0
        mov cx,0
                        ;input the number which is lower than 6,5536,0000(65536(high)*10000(low))
      s:mov ah,1
        int 21h
        cmp al,0dh      ;when input '\n',quit
        jz t
        sub al,30h
        mov ah,0
        mov ds:[0],ax
                        ;high part
        mov ax,bx       
        mul si
        mov bx,ax
                        ;low part
        mov ax,cx       
        mul si          ;ax*10=dx_a
        div di          ;can't div 10000h(0000h~FFFFh)  =ax(Shang)...dx(Yu)

        add bx,ax       ;high part
        mov cx,dx       ;low part
        add cx,ds:[0]   ;it won't JinWei , because
                        ;dx_ax=ax*10 , the last character of dx_ax value 0 ,
                        ;dx=dx_ax%10000 , the last character of dx is 0 ,
                        ;dx=dx+ds:[0](0~9) , the last character won't JinWei ,
                        ;thus cx won't JinWei
        jmp s
      t:mov ax,cx
        mov dx,bx

        cmp dx,0
        jnz HtoD_dword
        call HtoD_word

   exit:mov ah,4ch
        int 21h

HtoD_word:                           
        mov bx,10       ;division
        mov cx,0
        mov dx,0        ;high part(dx_ax<10000)
      u:div bx
        push dx
        mov dx,0
        inc cx
        cmp ax,0
        jnz u

        mov ah,2
      v:pop dx          ;dx<10
        add dl,30h      ;0->48 48
        int 21h
        loop v

        ret

HtoD_dword:
        push ax         ;store low part
        mov ax,dx
        call HtoD_word
                        ;output '0'(low part must contain four character)
        pop bx          ;bx=low part
        mov ah,2
        mov dl,'0'
        cmp bx,1000
        ja w
        int 21h
        cmp bx,100
        ja w
        int 21h
        cmp bx,10
        ja w
        int 21h

      w:mov ax,bx       ;ax=low part
        call HtoD_word

        jmp exit

code ends
        end start

        ;mov ax,432
        ;call HtoD_word

        ;mov ax,0
        ;mov dx,1
        ;call HtoD_dword
