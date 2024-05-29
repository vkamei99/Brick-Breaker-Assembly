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

    mov     byte [cor], preto    ; apaga title
    mov     ax, 200
    push    ax
    mov     ax, 240
    push    ax
    mov     ax, 430
    push    ax
    mov     ax, 255
    push    ax
    call    rect

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
    mov     byte [cor], preto    ; apaga title
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
    mov     byte [cor], magenta_claro   
    mov     ax, 10
    push    ax
    mov     ax, 450
    push    ax
    mov     ax, 105
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
    ;2,6
    mov     byte [cor], magenta_claro 
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
    mov     byte[cor],azul  
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
    mov ah,01h
	int 16h
	jnz jmp_tecla
    call colisao_barra

loop main