segment code
global atualizar_bola, verificar_colisoes, delay, colisao_blocos, check_com

atualizar_bola:
    add si, word[vx]
    add di, word[vy]
    ret

verificar_colisoes:
    cmp si, 624
    jge colisao_direita

    cmp si, 16
    jle colisao_esquerda

    cmp di, 464
    jge colisao_cima

    cmp di, 16
    jle colisao_baixo

    ; Verifica colisão com a barra
    cmp di, 55
    jle colisao_barra

    call colisao_blocos
    ret

colisao_barra:
    cmp si, word[x_barra]
    jl jmp_boost2

    cmp si, word[x_barra_end]
    jg jmp_boost2

    neg word[vy]
    ret

colisao_direita:
    neg word[vx]
    ret

colisao_cima:
    neg word[vy]
    ret

colisao_esquerda:
    neg word[vx]
    ret

colisao_baixo:
    ; Esta colisão é diferente pois é usada para ser o game over
    mov cx, 27 ; Seta config para escrever game over
    mov bx, 0
    mov dh, 14
    mov dl, 26
    mov byte [cor], vermelho
    ; Código para game over (chama funções apropriadas)
    ret

colisao_blocos:
    ; Colisão dos blocos da coluna 1
    mov ax, word[y1] ; Posição y inicial dos blocos da coluna 1
    sub ax, 10 ; Diminui 10 por causa do raio da bola

    cmp di, ax ; Colisão com a parte de baixo
    jl bloco2
    add ax, 30 ; Soma 30 pixels para a ter a colisão da parte de cima
    cmp di, ax ; Colisão com a parte de cima
    jg bloco2

    cmp si, 5 ; Colisão direita
    jl bloco2
    cmp si, 110 ; Colisão esquerda
    jg bloco2

    ; Apaga blocos da coluna 1
    mov byte [cor], preto
    mov ax, 10 ; x1        
    push ax
    mov ax, word[y1] ; y1
    push ax
    mov ax, 105 ; x2
    push ax
    mov bx, word[y1]
    add bx, 20 ; Soma 20
    mov ax, bx ; y2
    push ax
    call rect

    mov ax, word[y1]
    add ax, 30 ; Adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov word[y1], ax ; Salva novo valor de y1
    mov ax, word[pontos]
    add ax, 1
    mov word[pontos], ax
    neg word [vy]
    ret

bloco2:
    ; Colisão dos blocos da coluna 2
    mov ax, word[y2] ; Posição y inicial dos blocos da coluna 2
    sub ax, 10 ; Soma 5 por causa do raio da bola

    cmp di, ax ; Colisão com a parte de baixo
    jl bloco3
    add ax, 20 ; Soma vinte pixels para a ter a colisão da parte de cima
    cmp di, ax ; Colisão com a parte de cima
    jg bloco3

    cmp si, 110 ; Colisão direita
    jl bloco3
    cmp si, 215 ; Colisão esquerda
    jg bloco3

    mov byte [cor], preto ; Apaga blocos da coluna 2
    mov ax, 115 ; x1        
    push ax
    mov ax, word[y2] ; y1
    push ax
    mov ax, 210 ; x2
    push ax
    mov bx, word[y2]
    add bx, 20 ; Soma 20
    mov ax, bx ; y2
    push ax
    call rect

    mov ax, word[y2]
    add ax, 30 ; Adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov word[y2], ax ; Salva novo valor de y2
    mov ax, word[pontos]
    add ax, 1
    mov word[pontos], ax
    neg word [vy]
    ret

bloco3:
    ; Colisão dos blocos da coluna 3
    mov ax, word[y3] ; Posição y inicial dos blocos da coluna 3
    sub ax, 10 ; Soma 5 por causa do raio da bola

    cmp di, ax ; Colisão com a parte de baixo
    jl bloco4
    add ax, 20 ; Soma vinte pixels para a ter a colisão da parte de cima
    cmp di, ax ; Colisão com a parte de cima
    jg bloco4

    cmp si, 215 ; Colisão direita
    jl bloco4
    cmp si, 320 ; Colisão esquerda
    jg bloco4

    mov byte [cor], preto ; Apaga blocos da coluna 3
    mov ax, 220 ; x1        
    push ax
    mov ax, word[y3] ; y1
    push ax
    mov ax, 315 ; x2
    push ax
    mov bx, word[y3]
    add bx, 20 ; Soma 20
    mov ax, bx ; y2
    push ax
    call rect

    mov ax, word[y3]
    add ax, 30 ; Adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov word[y3], ax ; Salva novo valor de y3
    mov ax, word[pontos]
    add ax, 1
    mov word[pontos], ax
    neg word [vy]
    ret

bloco4:
    ; Colisão dos blocos da coluna 4
    mov ax, word[y4] ; Posição y inicial dos blocos da coluna 4
    sub ax, 10 ; Soma 5 por causa do raio da bola

    cmp di, ax ; Colisão com a parte de baixo
    jl bloco5
    add ax, 20 ; Soma vinte pixels para a ter a colisão da parte de cima
    cmp di, ax ; Colisão com a parte de cima
    jg bloco5

    cmp si, 320 ; Colisão direita
    jl bloco5
    cmp si, 425 ; Colisão esquerda
    jg bloco5

    mov byte [cor], preto ; Apaga blocos da coluna 4
    mov ax, 325 ; x1        
    push ax
    mov ax, word[y4] ; y1
    push ax
    mov ax, 420 ; x2
    push ax
    mov bx, word[y4]
    add bx, 20 ; Soma 20
    mov ax, bx ; y2
    push ax
    call rect

    mov ax, word[y4]
    add ax, 30 ; Adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov word[y4], ax ; Salva novo valor de y4
    mov ax, word[pontos]
    add ax, 1
    mov word[pontos], ax
    neg word [vy]
    ret

bloco5:
    ; Colisão dos blocos da coluna 5
    mov ax, word[y5] ; Posição y inicial dos blocos da coluna 5
    sub ax, 10 ; Soma 5 por causa do raio da bola

    cmp di, ax ; Colisão com a parte de baixo
    jl bloco6
    add ax, 20 ; Soma vinte pixels para a ter a colisão da parte de cima
    cmp di, ax ; Colisão com a parte de cima
    jg bloco6

    cmp si, 425 ; Colisão direita
    jl bloco6
    cmp si, 530 ; Colisão esquerda
    jg bloco6

    mov byte [cor], preto ; Apaga blocos da coluna 5
    mov ax, 430 ; x1        
    push ax
    mov ax, word[y5] ; y1
    push ax
    mov ax, 525 ; x2
    push ax
    mov bx, word[y5]
    add bx, 20 ; Soma 20
    mov ax, bx ; y2
    push ax
    call rect

    mov ax, word[y5]
    add ax, 30 ; Adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov word[y5], ax ; Salva novo valor de y5
    mov ax, word[pontos]
    add ax, 1
    mov word[pontos], ax
    neg word [vy]
    ret

bloco6:
    ; Colisão dos blocos da coluna 6
    mov ax, word[y6] ; Posição y inicial dos blocos da coluna 6
    sub ax, 10 ; Soma 5 por causa do raio da bola

    cmp di, ax ; Colisão com a parte de baixo
    jl termina_checagem
    add ax, 20 ; Soma vinte pixels para a ter a colisão da parte de cima
    cmp di, ax ; Colisão com a parte de cima
    jg termina_checagem

    cmp si, 540 ; Colisão direita
    jl termina_checagem
    cmp si, 635 ; Colisão esquerda
    jg termina_checagem

    mov byte [cor], preto ; Apaga blocos da coluna 6
    mov ax, 525 ; x1        
    push ax
    mov ax, word[y6] ; y1
    push ax
    mov ax, 630 ; x2
    push ax
    mov bx, word[y6]
    add bx, 20 ; Soma 20
    mov ax, bx ; y2
    push ax
    call rect

    mov ax, word[y6]
    add ax, 30 ; Adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov word[y6], ax ; Salva novo valor de y6
    mov ax, word[pontos]
    add ax, 1
    mov word[pontos], ax
    neg word [vy]
    ret

termina_checagem:
    cmp word[pontos], 12
    jge winner
    ret

winner:
    mov cx, 39 ; Seta config para escrever texto de vencedor
    mov bx, 0
    mov dh, 14
    mov dl, 20
    mov byte [cor], verde

winner_text:
    call cursor
    mov al, [bx+win]
    call caracter
    inc bx
    inc dl
    loop winner_text
    jmp esperar_entrada

check_com:
    ; Verificação de tecla de comando
    mov ah, 00h
    int 16h
    
    cmp al, 41h ; 'A' -> Move para esquerda
    je PADDLE_LEFT
    cmp al, 61h ; 'a'
    je PADDLE_LEFT
    
    cmp al, 44h ; 'D' -> Move para direita
    je PADDLE_RIGHT
    cmp al, 64h ; 'd'
    je PADDLE_RIGHT

    cmp al, 27h ; '>' -> Move para direita
    je PADDLE_RIGHT
    cmp al, 25h ; '<' -> Move para direita
    je PADDLE_LEFT

    cmp al, 50h ; 'P' -> Pause
    je pause
    cmp al, 70h ; 'p'
    je pause

    cmp al, 51h ; 'Q' -> Sair
    je sair
    cmp al, 71h ; 'q'
    je sair

    jmp main

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

    ret

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

    ret

delay:
    ; Delay utilizando a interrupção int 15h
    mov ah, 86h
    mov cx, 0
    mov dx, 100
    int 15h
    ret
