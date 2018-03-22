
;Problem:get prime which is lower than 10000

data segment
  radix dw 0ah                  ;pay attention! 0ah , not 10h
      n dw 100                  ;if no input , n=...
    vis db 0,0,10000 dup(1)     ;1:prime 0:not prime  ;vis[0]=false,vis[1]=false
  prime dw 10000 dup(?)         ;10000 in [0~2^16=65536),thus can store
  mess1 db 'Please input n(n<=10000): $'
  mess2 db 'Prime lower than n: $'
data ends

stack segment
        db 20 dup(?)        
stack ends

code segment
        assume cs:code,ds:data,ss:stack
  start:
        mov ax,data
        mov ds,ax
                ;output mess1
        mov ah,9
        mov dx,offset mess1
        int 21h
                ;input n
        mov bx,offset n
        mov word ptr ds:[bx],0
        mov ch,0
  input:mov ah,1
        int 21h
        cmp al,0dh
        jz init
        mov cl,al
        mov bx,offset n
        mov ax,ds:[bx]
        mov bx,offset radix
        mul word ptr ds:[bx]
        add ax,cx
        sub ax,30h
        mov bx,offset n
        mov word ptr [bx],ax
        jmp input
                ;initialization
   init:mov bx,offset n
        mov cx,[bx]
        dec cx
        mov si,1        ;i(current prime)
        mov di,0        ;ans*2(dw)
      A:inc si
        mov bx,offset vis
        cmp byte ptr [bx+si],1
        jnz B
                ;si is a prime
        mov bx,offset prime
        mov [bx+di],si
        add di,2

      B:push cx
        mov cx,0
                ;if i*zhi[j]>n then break
      C:mov bx,offset prime
        add bx,cx
        mov ax,si
        mul word ptr [bx]       ;dx_ax:dx=0
        mov bx,offset n
        cmp ax,[bx]
        ja D
                ;vis[i*zhi[j]]=false
        mov bx,offset vis
        add bx,ax
        mov al,0
        mov [bx],al
                ;if i%zhi[j]=0 then break
        mov bx,offset prime
        add bx,cx
        mov dx,0
        mov ax,si
        div word ptr [bx]
        cmp dx,0
        jz D
        add cx,2        
        cmp cx,di
        jnz C

      D:pop cx
        loop A
                ;output mess2
        mov dx,offset mess2
        mov ah,9
        int 21h
                ;output
        mov bx,offset prime
        mov ax,stack
        mov ss,ax
        mov ax,20
        mov sp,ax

      E:mov dx,0
        mov ax,ds:[bx]
        div word ptr ds:[0]
        inc cx
        push dx         ;dx<10  00dl
        mov ds:[bx],ax
        cmp ax,0
        jnz E

        mov ah,2
      F:pop dx
        add dx,30h
        int 21h
        loop F

        mov dl,' '
        int 21h
        sub di,2
        jz G
        add bx,2
        jmp E

      G:mov ah,4ch
        int 21h
                
code ends
        end start

