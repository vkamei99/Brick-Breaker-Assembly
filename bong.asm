;==================================================================;
;                    Jogo Brick Breaker
;==================================================================;
segment code
..start:
    mov         ax,data
    mov         ds,ax
    mov         ax,stack
    mov         ss,ax
    mov         sp,stacktop

; Salvar modo corrente de video
    mov         ah,0Fh
    int         10h
    mov         [modo_anterior],al   

; Alterar modo de video para gráfico 640x480 16 cores
    mov         al,12h
    mov         ah,0
    int         10h
        
; Limpa si, di, e define onde a bolinha começa
    xor si, si
    xor di, di
    mov cx, 0800h
    mov si, 319
    mov di, 240

;apaga o titulo ;usado para apagar o texto de game over
    mov     cx,50			;proximo caracter
    mov     bx,0
    mov     dh,14			;linha 0-29
    mov     dl,10 			;coluna 0-79
	mov	    byte[cor],preto

apaga_title:
	call    cursor
    mov     al,[bx+apaga]
	call    caracter
    inc     bx	                ;proximo caracter
	inc 	dl	                ;avanca a coluna
    loop    apaga_title

;escrever o cabecalho
    mov     cx,20			;numero de caracteres
    mov     bx,0
    mov     dh,14			;linha 0-29
    mov     dl,29 			;coluna 0-79
	mov	    byte[cor],branco

show_title:
	call    cursor
    mov     al,[bx+title]
	call    caracter
    inc     bx	                ;proximo caracter
	inc 	dl	                ;avanca a coluna
    loop    show_title

inicio:
    mov ah,00h
    int 16h

    cmp al,0Dh ;'enter' -> start no jogo
    je desenha_layout 

    jmp inicio

desenha_layout:
    mov     byte [cor], preto    ; apaga title com rect
    mov     ax, 230
    push    ax
    mov     ax, 240
    push    ax
    mov     ax, 390
    push    ax
    mov     ax, 255
    push    ax
    call    rect

    mov     byte[cor],branco_intenso    ; esquerda
    mov     ax,0
    push        ax
    mov     ax,0
    push        ax
    mov     ax,0
    push        ax
    mov     ax,479
    push        ax
    call        line

    mov     byte[cor],branco_intenso    ; cima
    mov     ax,0
    push        ax
    mov     ax,479
    push        ax
    mov     ax,639
    push        ax
    mov     ax,479
    push        ax
    call        line

    mov     byte[cor],branco_intenso    ; direita
    mov     ax,639
    push        ax
    mov     ax,0
    push        ax
    mov     ax,639
    push        ax
    mov     ax,479
    push        ax
    call        line 

desenha_blocos:    ;Largura: 95, Altura: 20, Espaçamento: 10
    ;1,1
        mov     byte [cor], magenta   
        mov     ax, 10
        push    ax
        mov     ax, 450
        push    ax
        mov     ax, 105
        push    ax
        mov     ax, 470
        push    ax
        call    rect
    ;1,2 
        mov     byte [cor], azul              
        mov     ax, 115
        push    ax
        mov     ax, 450
        push    ax
        mov     ax, 210
        push    ax
        mov     ax, 470
        push    ax
        call    rect
    ;1,3
        mov     byte [cor], cyan   
        mov     ax, 220
        push    ax
        mov     ax, 450
        push    ax
        mov     ax, 315
        push    ax
        mov     ax, 470
        push    ax
        call    rect
    ;1,4
        mov     byte [cor], verde_claro   
        mov     ax, 325
        push    ax
        mov     ax, 450
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 470
        push    ax
        call    rect
    ;1,5
        mov     byte [cor], amarelo   
        mov     ax, 430
        push    ax
        mov     ax, 450
        push    ax
        mov     ax, 525
        push    ax
        mov     ax, 470
        push    ax
        call    rect
    ;1,6
        mov     byte [cor], vermelho   
        mov     ax, 535
        push    ax
        mov     ax, 450
        push    ax
        mov     ax, 630
        push    ax
        mov     ax, 470
        push    ax
        call    rect
    ;2,1 
        mov     byte [cor], vermelho          
        mov     ax, 10
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 105
        push    ax
        mov     ax, 440
        push    ax
        call    rect
    ;2,2
        mov     byte [cor], amarelo           
        mov     ax, 115
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 210
        push    ax
        mov     ax, 440
        push    ax
        call    rect
    ;2,3
        mov     byte [cor], verde_claro   
        mov     ax, 220
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 315
        push    ax
        mov     ax, 440
        push    ax
        call    rect
    ;2,4
        mov     byte [cor], cyan   
        mov     ax, 325
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 440
        push    ax
        call    rect
    ;2,5
        mov     byte [cor], azul   
        mov     ax, 430
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 525
        push    ax
        mov     ax, 440
        push    ax
        call    rect
    ;2,6
        mov     byte [cor], magenta 
        mov     ax, 535
        push    ax
        mov     ax, 420
        push    ax
        mov     ax, 630
        push    ax
        mov     ax, 440
        push    ax
        call    rect

main:
    ; Desenhar a bola
    mov     byte[cor],branco_intenso  
    mov     ax, si 
    push        ax
    mov     ax, di
    push        ax
    mov     ax,10
    push        ax
    call    full_circle

    ; Delay utilizando a interrupção int 15h
    mov     ah, 86h
    mov     cx, 0
    mov     dx, 100 
    int     15h

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

    ; Barra horizontal
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

    cmp     di, 464
    jge     colisao_cima

    cmp     di, 16
    jle     colisao_baixo

    ; Verificar entrada do teclado
    mov     ah,01h
	int     16h
	jnz     jmp_check
    ;Verifica a colisão com a barra
    cmp     di, 55
    jle      colisao_barra

    ; Verificar colisão com blocos
    call    colisao_blocos
loop main

jmp_check:
    jmp check_com

jmp_boost2:
    jmp main

jmp_sair:
    jmp sair

; Funções de colisão
colisao_barra:      
    cmp si,word[x_barra]
    jl jmp_boost2

    cmp si,word[x_barra_end]
    jg jmp_boost2

    neg word[vy]
    jmp main

colisao_direita:
    neg word[vx]
    jmp main   

colisao_cima:
    neg word[vy]
    jmp main

colisao_esquerda:
    neg word[vx]
    jmp main  

colisao_baixo:        ;esta colisão é diferente pois é usada para ser o game over
    mov     	cx,27 ;seta config para escrever game over
    mov     	bx,0
    mov     	dh,14
    mov     	dl,26
    mov		    byte[cor],vermelho

game_over:
    call    cursor
    mov     al,[bx+fim]
    call    caracter
    inc     bx
    inc     dl
    loop    game_over
    
esperar_entrada:
    mov ah,00h
    int 16h

    cmp al,6Eh ;'n' -> Sair
    je jmp_sair 
    cmp al,4Eh ;'N' -> Sair
    je jmp_sair 

    cmp al,'y' ;'n' -> Sair
    je jmp_salva

    jmp esperar_entrada
jmp_salva:
    jmp salva_inicio

pause:
    mov     	cx,6 ;seta config para escrever paused
    mov     	bx,0
    mov     	dh,14
    mov     	dl,36 ;dl=coluna  (0-79)
    mov		    byte[cor],branco_intenso

loop_pause_text:
    call    cursor
    mov     al,[bx+paused]
    call    caracter
    inc     bx
    inc     dl
    loop    loop_pause_text

    ; Desenhar a bola
    mov     byte[cor],branco_intenso  
    mov     ax, si 
    push        ax
    mov     ax, di
    push        ax
    mov     ax,10
    push        ax
    call    full_circle

esperar_unpause:
    mov ah,00h
    int 16h

    cmp al,'p' 
    je unpause

    jmp esperar_unpause

unpause:
    mov     	cx,50 ;seta config para apagar texto paused
    mov     	bx,0
    mov     	dh,14
    mov     	dl,10 ;dl=coluna  (0-79)
    mov		    byte[cor],preto

loop_apaga_pause_text:
    call    cursor
    mov     al,[bx+apaga]
    call    caracter
    inc     bx
    inc     dl
    loop    loop_apaga_pause_text
    
    jmp main

check_com: ; checa tecla
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

    cmp al,27h ;'>'-> Move para direita
    je PADDLE_RIGHT
    cmp al,25h ;'<'-> Move para direita
    je PADDLE_LEFT

    cmp al,50h ;'P' -> Pause
    je jmp_pause
    cmp al,70h ;'p'
    je jmp_pause

    cmp al,51h ;'Q' -> Sair
    je sair
    cmp al,71h ;'q'
    je sair

    jmp main
jmp_pause:
    jmp pause
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

    jmp main

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

    jmp main

jmp_boost:
    jmp main

salva_inicio: ;redefine as variaveis para seus valores iniciais
    mov     word[vx], 3
    mov     word[vy], 3
    mov     word[x_barra], 270      
    mov     word[x_barra_end], 370
    mov     word[y_barra], 40
    mov     word[y1], 420     
    mov     word[y2], 420     
    mov     word[y3], 420     
    mov     word[y4], 420     
    mov     word[y5], 420     
    mov     word[y6], 420     
    mov     word[pontos], 0
    jmp ..start

colisao_blocos:
;colisão dos blocos da coluna 1
    mov     ax,word[y1] ;posição y inicial dos blocos da coluna 1
    sub     ax,10        ;diminui 10 por causa do raio da bola

    cmp     di, ax  ;colisão com a parte de baixo
    jl      bloco2
    add     ax, 30  ;soma 30 pixels para a ter a colisão da parte de cima
    cmp     di, ax  ;colisão com a parte de cima
    jg      bloco2

    cmp     si, 5  ;colisão direita
    jl      bloco2
    cmp     si, 110 ;colisão esquerda
    jg      bloco2

    ;apaga blocos da coluna 1
    mov     byte [cor], preto 
    mov     ax, 10          ;x1        
    push    ax
    mov     ax, word[y1]    ;y1
    push    ax
    mov     ax, 105         ;x2
    push    ax
    mov     bx, word[y1]
    add     bx, 20          ;soma 20
    mov     ax, bx          ;y2
    push    ax
    call    rect

    mov     ax, word[y1]
    add     ax, 30          ;adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y1],ax     ;salva novo valor de y1
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco2:
    ;colisão dos blocos da coluna 2
    mov     ax,word[y2] ;posição y inicial dos blocos da coluna 2
    sub     ax,10        ;soma 5 por causa do raio da bola

    cmp     di, ax  ;colisão com a parte de baixo
    jl      bloco3
    add     ax, 20  ;soma vinte pixels para a ter a colisão da parte de cima
    cmp     di, ax  ;colisão com a parte de cima
    jg      bloco3

    cmp     si, 110  ;colisão direita
    jl      bloco3
    cmp     si, 215 ;colisão esquerda
    jg      bloco3

    mov     byte [cor], preto ;apaga blocos da coluna 2
    mov     ax, 115          ;x1        
    push    ax
    mov     ax, word[y2]    ;y1
    push    ax
    mov     ax, 210         ;x2
    push    ax
    mov     bx, word[y2]
    add     bx, 20          ;soma 20
    mov     ax, bx          ;y2
    push    ax
    call    rect

    mov     ax, word[y2]
    add     ax, 30          ;adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y2],ax     ;salva novo valor de y2
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco3:
    ;colisão dos blocos da coluna 3
    mov     ax,word[y3] ;posição y inicial dos blocos da coluna 3
    sub     ax,10        ;soma 5 por causa do raio da bola

    cmp     di, ax  ;colisão com a parte de baixo
    jl      bloco4
    add     ax, 20  ;soma vinte pixels para a ter a colisão da parte de cima
    cmp     di, ax  ;colisão com a parte de cima
    jg      bloco4

    cmp     si, 215  ;colisão direita
    jl      bloco4
    cmp     si, 320 ;colisão esquerda
    jg      bloco4

    mov     byte [cor], preto ;apaga blocos da coluna 3
    mov     ax, 220          ;x1        
    push    ax
    mov     ax, word[y3]    ;y1
    push    ax
    mov     ax, 315         ;x2
    push    ax
    mov     bx, word[y3]
    add     bx, 20          ;soma 20
    mov     ax, bx          ;y2
    push    ax
    call    rect

    mov     ax, word[y3]
    add     ax, 30          ;adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y3],ax     ;salva novo valor de y3
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco4:
    ;colisão dos blocos da coluna 4
    mov     ax,word[y4] ;posição y inicial dos blocos da coluna 4
    sub     ax,10        ;soma 5 por causa do raio da bola

    cmp     di, ax  ;colisão com a parte de baixo
    jl      bloco5
    add     ax, 20  ;soma vinte pixels para a ter a colisão da parte de cima
    cmp     di, ax  ;colisão com a parte de cima
    jg      bloco5

    cmp     si, 320  ;colisão direita
    jl      bloco5
    cmp     si, 425 ;colisão esquerda
    jg      bloco5

    mov     byte [cor], preto ;apaga blocos da coluna 4
    mov     ax, 325          ;x1        
    push    ax
    mov     ax, word[y4]    ;y1
    push    ax
    mov     ax, 420         ;x2
    push    ax
    mov     bx, word[y4]
    add     bx, 20          ;soma 20
    mov     ax, bx          ;y2
    push    ax
    call    rect

    mov     ax, word[y4]
    add     ax, 30          ;adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y4],ax     ;salva novo valor de y4
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]
bloco5:
    ;colisão dos blocos da coluna 5
    mov     ax,word[y5] ;posição y inicial dos blocos da coluna 5
    sub     ax,10        ;soma 5 por causa do raio da bola

    cmp     di, ax  ;colisão com a parte de baixo
    jl      bloco6
    add     ax, 20  ;soma vinte pixels para a ter a colisão da parte de cima
    cmp     di, ax  ;colisão com a parte de cima
    jg      bloco6

    cmp     si, 425  ;colisão direita
    jl      bloco6
    cmp     si, 530 ;colisão esquerda
    jg      bloco6

    mov     byte [cor], preto ;apaga blocos da coluna 5
    mov     ax, 430          ;x1        
    push    ax
    mov     ax, word[y5]    ;y1
    push    ax
    mov     ax, 525         ;x2
    push    ax
    mov     bx, word[y5]
    add     bx, 20          ;soma 20
    mov     ax, bx          ;y2
    push    ax
    call    rect

    mov     ax, word[y5]
    add     ax, 30          ;adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y5],ax     ;salva novo valor de y5
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]
bloco6:
    ;colisão dos blocos da coluna 6
    mov     ax,word[y6] ;posição y inicial dos blocos da coluna 6
    sub     ax,10        ;soma 5 por causa do raio da bola

    cmp     di, ax  ;colisão com a parte de baixo
    jl      termina_checagem
    add     ax, 20  ;soma vinte pixels para a ter a colisão da parte de cima
    cmp     di, ax  ;colisão com a parte de cima
    jg      termina_checagem

    cmp     si, 540  ;colisão direita
    jl      termina_checagem
    cmp     si, 635 ;colisão esquerda
    jg      termina_checagem

    mov     byte [cor], preto ;apaga blocos da coluna 6
    mov     ax, 525          ;x1        
    push    ax
    mov     ax, word[y6]    ;y1
    push    ax
    mov     ax, 630         ;x2
    push    ax
    mov     bx, word[y6]
    add     bx, 20          ;soma 20
    mov     ax, bx          ;y2
    push    ax
    call    rect

    mov     ax, word[y6]
    add     ax, 30          ;adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y6],ax     ;salva novo valor de y6
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]
termina_checagem:
    cmp     word[pontos], 12
    jge     winner
    jmp     main

winner:
    mov     	cx,39 ;seta config para escrever texto de vencedor
    mov     	bx,0
    mov     	dh,14
    mov     	dl,20
    mov		    byte[cor],verde

winner_text:
    call    cursor
    mov     al,[bx+win]
    call    caracter
    inc     bx
    inc     dl
    loop    winner_text
    jmp     esperar_entrada
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
                   
title       db      'Press enter to start'
fim         db      'Game Over! reiniciar? (y/n)'
win         db      'Parabens! Voce Ganhou! reiniciar? (y/n)'
paused      db      'Paused'
apaga       db      '                                                  '


x_barra     dw      270      ;posição inicial 
x_barra_end dw      370     ;posição final
y_barra     dw      40      ;altura da barra

y1          dw      420
y3          dw      420
y2          dw      420
y4          dw      420
y5          dw      420
y6          dw      420

pontos      dw      0

;*************************************************************************
segment stack stack
            resb        512
stacktop: