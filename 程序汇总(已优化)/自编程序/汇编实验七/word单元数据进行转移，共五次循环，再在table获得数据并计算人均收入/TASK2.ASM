data segment
        dw ?,?,?,?,?
        dw ?,?,?,?,?
        dw ?,?,?,?,?
   year db '1975','1976','1977','1978','1979','1980','1981','1982'
        db '1983','1984','1985','1986','1987','1988','1989','1990'
        db '1991','1992','1993','1994','1995'

  total dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

 person dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
        dw 11542,14430,15257,17800
data ends

table segment
        db 21 dup('year summ ne ?? ')
table ends

stack segment
        db 50 dup(?)
stack ends

code segment
        assume cs:code,ds:data,es:table,ss:stack
  start:
        mov ax,data
        mov ds,ax

        mov ax,table
        mov es,ax

        mov ax,stack
        mov ss,ax
        mov sp,50

        mov ax,offset year              ;address of data
        mov ds:[0],ax
        add ax,2
        mov ds:[2],ax
        mov ax,offset total
        mov ds:[4],ax
        add ax,2
        mov ds:[6],ax
        mov word ptr ds:[8],offset person

        mov word ptr ds:[10],4          ;the asscending amount
        mov word ptr ds:[12],4
        mov word ptr ds:[14],4
        mov word ptr ds:[16],4
        mov word ptr ds:[18],2

        mov word ptr ds:[20],0          ;address of table
        mov word ptr ds:[22],2
        mov word ptr ds:[24],5
        mov word ptr ds:[26],7
        mov word ptr ds:[28],10

        mov bx,0
      p:
        mov si,ds:[bx]                  ;the address of data
        mov di,ds:[bx+20]               ;the address of table

        mov cx,21                       ;1995-1975+1=21
      s:mov ax,ds:[si]
        mov es:[di],ax
        add si,ds:[bx+10]
        add di,16
        loop s
        
        add bx,2
        cmp bx,10
        jnz p
                                        ;average salary
        mov di,0
        mov cx,21
      q:
        mov ax,es:[di+5]
        mov dx,es:[di+7]
        div word ptr es:[di+0Ah]
        mov es:[di+0Dh],ax
        add di,10h
        loop q

                                        ;output:decimal mode
        mov cx,21                       ;row=21
        mov bx,0
        mov ah,2
      t:push cx

        mov dl,es:[bx]  ;0
        int 21h
        inc bx

        mov dl,es:[bx]  ;1
        int 21h
        inc bx

        mov dl,es:[bx]  ;2
        int 21h
        inc bx

        mov dl,es:[bx]  ;3
        int 21h
        inc bx

        mov dl,es:[bx]  ;4
        int 21h
        inc bx

        mov ax,es:[bx]  ;5~8
        mov dx,es:[bx+2]
        cmp dx,0
        jz a
        cmp ax,10000
        jb a
        call HtoD_dword
        jmp b
      a:call HtoD_word
      b:add bx,4

        ;mov ah,2
        mov dl,es:[bx]  ;9
        int 21h
        inc bx

        mov ax,es:[bx]  ;0A~0B  
        cmp ax,10000
        ja c
        call HtoD_word  ;<10000
        jmp d
      c:mov dx,0
        call HtoD_dword ;>=10000
      d:add bx,2

        ;mov ah,2
        mov dl,es:[bx]  ;0C
        int 21h
        inc bx

        mov ax,es:[bx]  ;0A~0B  
        cmp ax,10000    
        ja e
        call HtoD_word  ;<10000
        jmp f
      e:mov dx,0
        call HtoD_dword ;>=10000
      f:add bx,2

        inc bx          ;0F

        mov dl,0dh      ;'\n'
        int 21h
        mov dl,0ah
        int 21h

        loop g
        jmp exit
      g:jmp near ptr t

   exit:mov ah,4ch
        int 21h

HtoD_word:
        push bx
        push cx
        mov bx,10       ;division
        mov cx,0
        mov dx,0        ;high part:dx_ax<10000<65536 , thus dx=0
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

        pop cx
        pop bx

        ret

HtoD_dword:
        push bx
        push cx
                        ;the number should lower than 6,5536,0000. the maxisum is 5937000,so we can use this program.
        mov bx,10000    
        div bx          ;ax(Shang)<65536(high part);dx(Yu)<10000(low part)
        push dx         ;store low part

        call HtoD_word
                        ;output '0'(low part must contain four character if the number larger than 10000)
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

        pop cx
        pop bx
        ret

code ends
        end start
