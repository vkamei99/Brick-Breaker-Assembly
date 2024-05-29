segment code
..start:
    mov         ax,data
    mov         ds,ax
    mov         ax,stack
    mov         ss,ax
    mov         sp,stacktop

; salvar modo corrente de video(vendo como est� o modo de video da maquina)
    mov         ah,0Fh
    int         10h
    mov         [modo_anterior],al   

; alterar modo de video para gr�fico 640x480 16 cores
    mov         al,12h
    mov         ah,0
    int         10h
        
;desenha circulos poe a bola no meio da tela
    xor si, si
    xor di, di
    mov cx, 0800h
    mov si, 319
    mov di, 240

    ;escrever o cabecalho
    mov     cx,56			;numero de caracteres
    mov     bx,0
    mov     dh,1			;linha 0-29
    mov     dl,1 			;coluna 0-79
	mov	    byte[cor],branco

show_title:
	call    cursor
    mov     al,[bx+title]
	call    caracter
    inc     bx	                ;proximo caracter
	inc 	dl	                ;avanca a coluna
    loop    show_title

    mov     cx,56			;numero de caracteres
    mov     bx,0
    mov     dh,2			;linha 0-29
    mov     dl,1 			;coluna 0-79
	mov	   byte[cor],branco

show_stats:
	call    cursor
    mov     al,[bx+stats]
	call    caracter
    inc     bx	                ;proximo caracter
	inc  	dl	                ;avanca a coluna
    loop    show_stats
    

;desenhar retas

    call    desenha_layout

desenha_layout:
    mov     byte[cor],branco_intenso    ;baixo
    mov     ax,0
    push        ax
    mov     ax,0
    push        ax
    mov     ax,639
    push        ax
    mov     ax,0
    push        ax
    call        line


    mov     byte[cor],branco_intenso    ;esquerda
    mov     ax,0
    push        ax
    mov     ax,0
    push        ax
    mov     ax,0
    push        ax
    mov     ax,479
    push        ax
    call        line

    mov     byte[cor],branco_intenso    ;cima
    mov     ax,0
    push        ax
    mov     ax,479
    push        ax
    mov     ax,639
    push        ax
    mov     ax,479
    push        ax
    call        line

    mov     byte[cor],branco_intenso    ;direita
    mov     ax,639
    push        ax
    mov     ax,0
    push        ax
    mov     ax,639
    push        ax
    mov     ax,479
    push        ax
    call        line

    mov     byte[cor],branco_intenso    ;cabecalho
    mov     ax,0
    push        ax
    mov     ax,430
    push        ax
    mov     ax, 640
    push        ax
    mov     ax,430
    push        ax
    call        line         

volta:
    ; Desenhar a bola
    mov     byte[cor],magenta  
    mov     ax, si
    push        ax
    mov     ax, di
    push        ax
    mov     ax,10
    push        ax
    call    full_circle

    mov ax, 100 ; Por exemplo, 1000 ms (1 segundo).
    mov ah, 86h
    int 15h

    pop ax
    pop ax
    pop ax

    ; Limpar a bola anterior (desenhar a bola em preto para apagar)
    mov     byte[cor],preto 
    mov     ax, si
    push        ax
    mov     ax, di
    push        ax
    mov     ax,10
    push        ax
    call    full_circle
    pop ax
    pop ax
    pop ax

    ;barra horizontal
    mov     byte[cor],branco_intenso    
    mov     ax, word[x_barra]
    push        ax
    mov     ax, word[y_barra]
    push        ax
    mov     ax, word[x_barra_end]
    push        ax
    mov     ax, word[y_barra]
    push        ax
    call        line
    pop ax
    pop ax
    pop ax
    
    ; Atualizar a posição da bola
    add si, word[vx]
    add di, word[vy]

    ; Verificar colisões com as bordas
    cmp     si, 624
    jge     colisao_direita

    cmp     si, 16
    jle     colisao_esquerda

    cmp     di, 414
    jge     colisao_cima

    cmp     di, 16
    jle     colisao_baixo

    mov ah,01h
	int 16h
	jnz jmp_tecla
    call colisao_barra

loop volta

jmp_tecla:
    jmp check_com

jmp_boost2:
    jmp volta

;funções de colisão abaixo
colisao_barra:      

    cmp di, 50
    jg jmp_boost2

    cmp si,word[x_barra]
    jl jmp_boost2

    cmp si,word[x_barra_end]
    jg jmp_boost2

    neg word[vy]
    add word[unidades_jogador],1 
    call update_texto_pontos_jogador_un
    
    jmp volta

colisao_direita:
    neg word[vx]
    add word[unidades_computador],1
    call update_texto_pontos_computador_un  
    jmp volta   

colisao_cima:
    neg word[vy]
    jmp volta

colisao_esquerda:
    neg word[vx]
    jmp volta  

colisao_baixo:
    mov     	cx,26			;n�mero de caracteres
    mov     	bx,0
    mov     	dh,14			;linha 0-29
    mov     	dl,26			;coluna 0-79
    mov		byte[cor],vermelho

game_over:
    call    cursor
    mov     al,[bx+fim]
    call    caracter
    inc     bx                  ;proximo caracter
    inc     dl                  ;avanca a coluna
    loop    game_over
    
esperar_entrada:
    mov ah,00h
    int 16h

    cmp al,6Eh ;'n' -> Sair
    je sair 
    cmp al,4Eh ;'N' -> Sair
    je sair 

    jmp esperar_entrada

pause:
    cmp word[vx], 0
    je unpause      

    mov ax, word[vx]
    mov word[saved_vx], ax
    mov ax, word[vy]
    mov word[saved_vy], ax

    mov word[vx], 0
    mov word[vy], 0
    jmp volta

unpause:
    mov ax, word[saved_vx]
    mov word[vx], ax
    mov ax, word[saved_vy]
    mov word[vy], ax
    jmp volta

check_com: ;checa tecla
    mov ah,00h
    int 16h
    
    cmp al,41h ;'A' -> Move para esquerda
    je PADDLE_LEFT
    cmp al,61h ;'a'
    je PADDLE_LEFT
    
    cmp al,44h ;'D' -> Move para direita
    je PADDLE_RIGHT
    cmp al,64h ;'d'
    je PADDLE_RIGHT

    cmp al,50h ;'P' -> Move para direita
    je pause
    cmp al,70h ;'p'
    je pause

    cmp al,53h ;'S' -> Sair
    je sair
    cmp al,73h ;'s'
    je sair

    jmp volta

sair:
    mov ah,0 ; set video mode
    mov al,[modo_anterior] ; recupera o modo anterior
    int 10h
    mov ax,4c00h
    int 21h

PADDLE_LEFT: ; Move barra para a esquerda
    cmp word[x_barra],10
    jle jmp_boost

    mov     byte[cor],preto   ; apaga barra
    mov     ax, word[x_barra]
    push    ax
    mov     ax, word[y_barra]
    push    ax
    mov     ax, word[x_barra_end]
    push    ax
    mov     ax, word[y_barra]
    push    ax
    call    line
    pop ax
    pop ax
    pop ax

    sub word[x_barra], 10
    sub word[x_barra_end], 10

    jmp volta

PADDLE_RIGHT: ; Move barra para a direita
    cmp word[x_barra_end],629
    jge jmp_boost

    mov     byte[cor],preto   ; apaga barra
    mov     ax, word[x_barra]
    push    ax
    mov     ax, word[y_barra]
    push    ax
    mov     ax, word[x_barra_end]
    push    ax
    mov     ax, word[y_barra]
    push    ax
    call    line
    pop ax
    pop ax
    pop ax

    add word[x_barra], 10
    add word[x_barra_end], 10

    jmp volta

jmp_boost:
    jmp volta

;=========================================================;
;                 Funções Update placar                   ;
;=========================================================;

update_texto_pontos_jogador_un:
    xor ax,ax
    mov al,[unidades_jogador] 

    cmp al,10
    je update_texto_pontos_jogador_de
    
    add al,30h                       
    mov [texto_pontos_jogador],al

    mov     cx,1			;numero de caracteres
    mov     bx,0
    mov     dh,2			;linha 0-29
    mov     dl,18 			;coluna 0-79
	mov	   byte[cor],rosa

    call un_jogador
    jmp volta
    

un_jogador:
	call    cursor
    mov     al,[bx+texto_pontos_jogador]
	call    caracter
    dec     bx	                ;proximo caracter
	inc  	dl	                ;avanca a coluna
    loop    un_jogador
    ret

update_texto_pontos_jogador_de:
    xor ax,ax
    add byte[dezenas_jogador],1

    mov al, [dezenas_jogador]

    add al,30h                       
    mov [texto_pontos_jogador],al

    mov     cx,1			;numero de caracteres
    mov     bx,0
    mov     dh,2			;linha 0-29
    mov     dl,17 			;coluna 0-79
	mov	   byte[cor],rosa

    call de_jogador
    xor ax,ax
    mov byte[unidades_jogador], 0
    jmp update_texto_pontos_jogador_un
    ret

de_jogador:
    call    cursor
    mov     al,[bx+texto_pontos_jogador]
	call    caracter
    dec     bx	                ;proximo caracter
	inc  	dl	                ;avanca a coluna
    loop    de_jogador
    ret

un_computador:
	call    cursor
    mov     al,[bx+texto_pontos_computador]
	call    caracter
    dec     bx	                ;proximo caracter
	inc  	dl	                ;avanca a coluna
    loop    un_computador
    ret

update_texto_pontos_computador_un:
    xor ax,ax
    mov al,[unidades_computador]

    cmp al,10
    je update_texto_pontos_computador_de 

    add al,30h                       
    mov [texto_pontos_computador],al

    mov     cx,1			;numero de caracteres
    mov     bx,0
    mov     dh,2			;linha 0-29
    mov     dl,23 			;coluna 0-79
	mov	   byte[cor],rosa

    call un_computador
    jmp volta

de_computador:
    call    cursor
    mov     al,[bx+texto_pontos_computador]
	call    caracter
    dec     bx	                ;proximo caracter
	inc  	dl	                ;avanca a coluna
    loop    de_computador
    ret

update_texto_pontos_computador_de:
    xor ax,ax
    add byte[dezenas_computador],1

    mov al, [dezenas_computador]

    add al,30h                       
    mov [texto_pontos_computador],al

    mov     cx,1			;numero de caracteres
    mov     bx,0
    mov     dh,2			;linha 0-29
    mov     dl,22 			;coluna 0-79
	mov	   byte[cor],rosa

    call de_computador
    xor ax,ax
    mov byte[unidades_computador], 0
    jmp update_texto_pontos_computador_un
    ret

;=========================================================;

;=========================================================;
;                Update Display Velocidade                ;
;=========================================================;

display_vel:
    call    cursor
    mov     al,[bx+texto_vel_display]
	call    caracter
    dec     bx	                ;proximo caracter
	inc  	dl	                ;avanca a coluna
    loop display_vel
    ret

update_veldisp:
    xor ax,ax
    mov al,byte[vel_display] 
    
    add al,30h                       
    mov [texto_vel_display],al

    mov     cx,1			;numero de caracteres
    mov     bx,0
    mov     dh,2			;linha 0-29
    mov     dl,53 			;coluna 0-79
	mov	   byte[cor],rosa

    call display_vel               
    ret


;===============================================================================================================;

l4:
    call    cursor
    mov     al,[bx+mens]
    call    caracter
    inc     bx                  ;proximo caracter
    inc     dl                  ;avanca a coluna
    inc     byte [cor]          ;mudar a cor para a seguinte
    loop    l4
    
    mov     ah,08h
    int     21h
    mov     ah,0                    ; set video mode
    mov     al,[modo_anterior]      ; modo anterior
    int     10h
    mov     ax,4c00h
    int     21h

;***************************************************************************
;
;   fun��o cursor
;
; dh = linha (0-29) e  dl=coluna  (0-79)
cursor:
    pushf
    push        ax
    push        bx
    push        cx
    push        dx
    push        si
    push        di
    push        bp
    mov         ah,2
    mov         bh,0
    int         10h
    pop     bp
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    ret
;_____________________________________________________________________________
;
;   fun��o caracter escrito na posi��o do cursor
;
; al= caracter a ser escrito
; cor definida na variavel cor
caracter:
    pushf
    push        ax
    push        bx
    push        cx
    push        dx
    push        si
    push        di
    push        bp
    mov         ah,9
    mov         bh,0
    mov         cx,1
    mov         bl,[cor]
    int         10h
    pop     bp
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    ret
;_____________________________________________________________________________
;
;   fun��o plot_xy
;
; push x; push y; call plot_xy;  (x<639, y<479)
; cor definida na variavel cor
plot_xy:
    push        bp
    mov         bp,sp
    pushf
    push        ax
    push        bx
    push        cx
    push        dx
    push        si
    push        di
    mov         ah,0ch
    mov         al,[cor]
    mov         bh,0
    mov         dx,479
    sub         dx,[bp+4]
    mov         cx,[bp+6]
    int         10h
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    pop     bp
    ret     4
;_____________________________________________________________________________
;    fun��o circle
;    push xc; push yc; push r; call circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
;   cor definida na variavel cor
circle:
    push    bp
    mov     bp,sp
    pushf                        ;coloca os flags na pilha
    push    ax
    push    bx
    push    cx
    push    dx
    push    si
    push    di
    
    mov     ax,[bp+8]    ; resgata xc
    mov     bx,[bp+6]    ; resgata yc
    mov     cx,[bp+4]    ; resgata r
    
    mov     dx,bx   
    add     dx,cx       ;ponto extremo superior
    push    ax          
    push    dx
    call plot_xy
    
    mov     dx,bx
    sub     dx,cx       ;ponto extremo inferior
    push    ax          
    push    dx
    call plot_xy
    
    mov     dx,ax   
    add     dx,cx       ;ponto extremo direita
    push    dx          
    push    bx
    call plot_xy
    
    mov     dx,ax
    sub     dx,cx       ;ponto extremo esquerda
    push    dx          
    push    bx
    call plot_xy
        
    mov     di,cx
    sub     di,1     ;di=r-1
    mov     dx,0    ;dx ser� a vari�vel x. cx � a variavel y
    
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay:               ;loop
    mov     si,di
    cmp     si,0
    jg      inf       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
    mov     si,dx       ;o jl � importante porque trata-se de conta com sinal
    sal     si,1        ;multiplica por doi (shift arithmetic left)
    add     si,3
    add     di,si     ;nesse ponto d=d+2*dx+3
    inc     dx      ;incrementa dx
    jmp     plotar
inf:    
    mov     si,dx
    sub     si,cx       ;faz x - y (dx-cx), e salva em di 
    sal     si,1
    add     si,5
    add     di,si       ;nesse ponto d=d+2*(dx-cx)+5
    inc     dx      ;incrementa x (dx)
    dec     cx      ;decrementa y (cx)
    
plotar: 
    mov     si,dx
    add     si,ax
    push    si          ;coloca a abcisa x+xc na pilha
    mov     si,cx
    add     si,bx
    push    si          ;coloca a ordenada y+yc na pilha
    call plot_xy        ;toma conta do segundo octante
    mov     si,ax
    add     si,dx
    push    si          ;coloca a abcisa xc+x na pilha
    mov     si,bx
    sub     si,cx
    push    si          ;coloca a ordenada yc-y na pilha
    call plot_xy        ;toma conta do s�timo octante
    mov     si,ax
    add     si,cx
    push    si          ;coloca a abcisa xc+y na pilha
    mov     si,bx
    add     si,dx
    push    si          ;coloca a ordenada yc+x na pilha
    call plot_xy        ;toma conta do segundo octante
    mov     si,ax
    add     si,cx
    push    si          ;coloca a abcisa xc+y na pilha
    mov     si,bx
    sub     si,dx
    push    si          ;coloca a ordenada yc-x na pilha
    call plot_xy        ;toma conta do oitavo octante
    mov     si,ax
    sub     si,dx
    push    si          ;coloca a abcisa xc-x na pilha
    mov     si,bx
    add     si,cx
    push    si          ;coloca a ordenada yc+y na pilha
    call plot_xy        ;toma conta do terceiro octante
    mov     si,ax
    sub     si,dx
    push    si          ;coloca a abcisa xc-x na pilha
    mov     si,bx
    sub     si,cx
    push    si          ;coloca a ordenada yc-y na pilha
    call plot_xy        ;toma conta do sexto octante
    mov     si,ax
    sub     si,cx
    push    si          ;coloca a abcisa xc-y na pilha
    mov     si,bx
    sub     si,dx
    push    si          ;coloca a ordenada yc-x na pilha
    call plot_xy        ;toma conta do quinto octante
    mov     si,ax
    sub     si,cx
    push    si          ;coloca a abcisa xc-y na pilha
    mov     si,bx
    add     si,dx
    push    si          ;coloca a ordenada yc-x na pilha
    call plot_xy        ;toma conta do quarto octante
    
    cmp     cx,dx
    jb      fim_circle  ;se cx (y) est� abaixo de dx (x), termina     
    jmp     stay        ;se cx (y) est� acima de dx (x), continua no loop
    
    
fim_circle:
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    pop     bp
    ret     6
;-----------------------------------------------------------------------------
;    fun��o full_circle
;    push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor                    
full_circle:
    push    bp
    mov     bp,sp
    pushf                        ;coloca os flags na pilha
    push    ax
    push    bx
    push    cx
    push    dx
    push    si
    push    di

    mov     ax,[bp+8]    ; resgata xc
    mov     bx,[bp+6]    ; resgata yc
    mov     cx,[bp+4]    ; resgata r
    
    mov     si,bx
    sub     si,cx
    push    ax          ;coloca xc na pilha         
    push    si          ;coloca yc-r na pilha
    mov     si,bx
    add     si,cx
    push    ax      ;coloca xc na pilha
    push    si      ;coloca yc+r na pilha
    call line
    
        
    mov     di,cx
    sub     di,1     ;di=r-1
    mov     dx,0    ;dx ser� a vari�vel x. cx � a variavel y
    
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay_full:              ;loop
    mov     si,di
    cmp     si,0
    jg      inf_full       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
    mov     si,dx       ;o jl � importante porque trata-se de conta com sinal
    sal     si,1        ;multiplica por doi (shift arithmetic left)
    add     si,3
    add     di,si     ;nesse ponto d=d+2*dx+3
    inc     dx      ;incrementa dx
    jmp     plotar_full
inf_full:   
    mov     si,dx
    sub     si,cx       ;faz x - y (dx-cx), e salva em di 
    sal     si,1
    add     si,5
    add     di,si       ;nesse ponto d=d+2*(dx-cx)+5
    inc     dx      ;incrementa x (dx)
    dec     cx      ;decrementa y (cx)
    
plotar_full:    
    mov     si,ax
    add     si,cx
    push    si      ;coloca a abcisa y+xc na pilha          
    mov     si,bx
    sub     si,dx
    push    si      ;coloca a ordenada yc-x na pilha
    mov     si,ax
    add     si,cx
    push    si      ;coloca a abcisa y+xc na pilha  
    mov     si,bx
    add     si,dx
    push    si      ;coloca a ordenada yc+x na pilha    
    call    line
    
    mov     si,ax
    add     si,dx
    push    si      ;coloca a abcisa xc+x na pilha          
    mov     si,bx
    sub     si,cx
    push    si      ;coloca a ordenada yc-y na pilha
    mov     si,ax
    add     si,dx
    push    si      ;coloca a abcisa xc+x na pilha  
    mov     si,bx
    add     si,cx
    push    si      ;coloca a ordenada yc+y na pilha    
    call    line
    
    mov     si,ax
    sub     si,dx
    push    si      ;coloca a abcisa xc-x na pilha          
    mov     si,bx
    sub     si,cx
    push    si      ;coloca a ordenada yc-y na pilha
    mov     si,ax
    sub     si,dx
    push    si      ;coloca a abcisa xc-x na pilha  
    mov     si,bx
    add     si,cx
    push    si      ;coloca a ordenada yc+y na pilha    
    call    line
    
    mov     si,ax
    sub     si,cx
    push    si      ;coloca a abcisa xc-y na pilha          
    mov     si,bx
    sub     si,dx
    push    si      ;coloca a ordenada yc-x na pilha
    mov     si,ax
    sub     si,cx
    push    si      ;coloca a abcisa xc-y na pilha  
    mov     si,bx
    add     si,dx
    push    si      ;coloca a ordenada yc+x na pilha    
    call    line
    
    cmp     cx,dx
    jb      fim_full_circle  ;se cx (y) est� abaixo de dx (x), termina     
    jmp     stay_full       ;se cx (y) est� acima de dx (x), continua no loop
    
    
fim_full_circle:
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    pop     bp
    ret     6
;-----------------------------------------------------------------------------
;
;   fun��o line
;
; push x1; push y1; push x2; push y2; call line;  (x<639, y<479)
line:
    push        bp
    mov     bp,sp
    pushf                        ;coloca os flags na pilha
    push        ax
    push        bx
    push        cx
    push        dx
    push        si
    push        di
    mov     ax,[bp+10]   ; resgata os valores das coordenadas
    mov     bx,[bp+8]    ; resgata os valores das coordenadas
    mov     cx,[bp+6]    ; resgata os valores das coordenadas
    mov     dx,[bp+4]    ; resgata os valores das coordenadas
    cmp     ax,cx
    je      line2
    jb      line1
    xchg        ax,cx
    xchg        bx,dx
    jmp     line1
line2:      ; deltax=0
    cmp     bx,dx  ;subtrai dx de bx
    jb      line3
    xchg        bx,dx        ;troca os valores de bx e dx entre eles
line3:  ; dx > bx
    push        ax
    push        bx
    call        plot_xy
    cmp     bx,dx
    jne     line31
    jmp     fim_line
line31:     inc     bx
    jmp     line3
;deltax <>0
line1:
; comparar m�dulos de deltax e deltay sabendo que cx>ax
    ; cx > ax
    push        cx
    sub     cx,ax
    mov     [deltax],cx
    pop     cx
    push        dx
    sub     dx,bx
    ja      line32
    neg     dx
line32:     
    mov     [deltay],dx
    pop     dx

    push        ax
    mov     ax,[deltax]
    cmp     ax,[deltay]
    pop     ax
    jb      line5

    ; cx > ax e deltax>deltay
    push        cx
    sub     cx,ax
    mov     [deltax],cx
    pop     cx
    push        dx
    sub     dx,bx
    mov     [deltay],dx
    pop     dx

    mov     si,ax
line4:
    push        ax
    push        dx
    push        si
    sub     si,ax   ;(x-x1)
    mov     ax,[deltay]
    imul        si
    mov     si,[deltax]     ;arredondar
    shr     si,1
; se numerador (DX)>0 soma se <0 subtrai
    cmp     dx,0
    jl      ar1
    add     ax,si
    adc     dx,0
    jmp     arc1
ar1:        sub     ax,si
    sbb     dx,0
arc1:
    idiv        word [deltax]
    add     ax,bx
    pop     si
    push        si
    push        ax
    call        plot_xy
    pop     dx
    pop     ax
    cmp     si,cx
    je      fim_line
    inc     si
    jmp     line4

line5:      cmp     bx,dx
    jb      line7
    xchg        ax,cx
    xchg        bx,dx
line7:
    push        cx
    sub     cx,ax
    mov     [deltax],cx
    pop     cx
    push        dx
    sub     dx,bx
    mov     [deltay],dx
    pop     dx
    mov     si,bx
line6:
    push        dx
    push        si
    push        ax
    sub     si,bx   ;(y-y1)
    mov     ax,[deltax]
    imul        si
    mov     si,[deltay]     ;arredondar
    shr     si,1
; se numerador (DX)>0 soma se <0 subtrai
    cmp     dx,0
    jl      ar2
    add     ax,si
    adc     dx,0
    jmp     arc2
ar2:        sub     ax,si
    sbb     dx,0
arc2:
    idiv        word [deltay]
    mov     di,ax
    pop     ax
    add     di,ax
    pop     si
    push        di
    push        si
    call        plot_xy
    pop     dx
    cmp     si,dx
    je      fim_line
    inc     si
    jmp     line6

fim_line:
    pop     di
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    popf
    pop     bp
    ret     8

rect:
    push        bp
    mov     bp,sp
    pushf                        ;coloca os flags na pilha
    push        ax
    push        bx
    push        cx
    push        dx
    push        si
    push        di
    ; resgata os valores das coordenadas
    mov     ax,[bp+10]   ; x1
    mov     bx,[bp+8]    ; y1
    mov     cx,[bp+6]    ; x2
    mov     dx,[bp+4]    ; y2
fill:
    push ax       ; x1
    push bx       ; y
    push cx       ; x2
    push bx       ; y
    call line     ; Desenhar uma linha horizontal

    inc bx        ; Próxima linha vertical
    cmp bx, dx    ; Se chegou ao limite inferior, parar
    jle fill

    ; Restaurar o estado original
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    popf
    pop bp
    ret 8
    
delay: ; Esteja atento pois talvez seja importante salvar contexto (no caso, CX, o que NÃO foi feito aqui).
    push cx
    mov cx, word [velocidade] ; Carrega “velocidade” em cx (contador para loop)
del2:
    push cx ; Coloca cx na pilha para usa-lo em outro loop
    mov cx, 0500h ; Teste modificando este valor
del1:
    loop del1 ; No loop del1, cx é decrementado até que volte a ser zero
    pop cx ; Recupera cx da pilha
    loop del2 ; No loop del2, cx é decrementado até que seja zero
    pop cx
    ret

;*******************************************************************
segment data

cor     db      branco_intenso

;   I R G B COR
;   0 0 0 0 preto
;   0 0 0 1 azul
;   0 0 1 0 verde
;   0 0 1 1 cyan
;   0 1 0 0 vermelho
;   0 1 0 1 magenta
;   0 1 1 0 marrom
;   0 1 1 1 branco
;   1 0 0 0 cinza
;   1 0 0 1 azul claro
;   1 0 1 0 verde claro
;   1 0 1 1 cyan claro
;   1 1 0 0 rosa
;   1 1 0 1 magenta claro
;   1 1 1 0 amarelo
;   1 1 1 1 branco intenso

preto       equ     0
azul        equ     1
verde       equ     2
cyan        equ     3
vermelho    equ     4
magenta     equ     5
marrom      equ     6
branco      equ     7
cinza       equ     8
azul_claro  equ     9
verde_claro equ     10
cyan_claro  equ     11
rosa        equ     12
magenta_claro   equ     13
amarelo     equ     14
branco_intenso  equ     15

modo_anterior   db      0
linha       dw          0
coluna      dw          0
deltax      dw      0
deltay      dw      0   
mens        db          'Funcao Grafica'

velocidade  dw      1
vx          dw      3
vy          dw      3
saved_vx    dw      0
saved_vy    dw      0

title           db      'Trabalho 1 de Programacao de Sistemas Embarcados 2024/1 '
stats           db      'Viktor e Felipe 00 x 00 Computador                      '
fim           db        'Game Over reiniciar? (y/n)'

vel_display db 1
texto_vel_display db '1','$'

x_barra dw 270      ;posição inicial 
x_barra_end dw 370  ;posição final
y_barra dw  40   ;

unidades_jogador db 0
dezenas_jogador db 0

unidades_computador db 0
dezenas_computador db 0

texto_pontos_jogador db '0','$'
texto_pontos_computador db '0','$'

;*************************************************************************
segment stack stack
            resb        512
stacktop: