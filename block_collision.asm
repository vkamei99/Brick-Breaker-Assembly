colisao_blocos:
    ;apaga blocos da coluna 1
    mov     ax, word[y1] ; posição y inicial dos blocos da coluna 1

    cmp     di, ax  ; colisão com a parte de baixo
    jl      bloco2
    
    add     ax, 20  ; soma vinte pixels para ter a colisão da parte de cima

    cmp     di, ax  ; colisão com a parte de cima
    jg      bloco2

    cmp     si, 10  ; colisão direita
    jl      bloco2

    cmp     si, 105 ; colisão esquerda
    jg      bloco2

    mov     byte [cor], preto ; apaga blocos da coluna 1
    mov     ax, 10          ; x1        
    push    ax
    mov     ax, word[y1]    ; y1
    push    ax
    mov     ax, 105         ; x2
    push    ax
    mov     bx, word[y1]
    add     bx, 20          ; soma 20
    mov     ax, bx          ; y2
    push    ax
    call    rect

    mov     ax, word[y1]
    add     ax, 30          ; adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y1], ax    ; salva novo valor de y1
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco2:
    mov     ax, 420

    cmp     di, ax  ; colisão com a parte de baixo
    jl      bloco3
    
    add     ax, 20  ; soma vinte pixels para ter a colisão da parte de cima

    cmp     di, ax  ; colisão com a parte de cima
    jg      bloco3

    cmp     si, 115 ; colisão direita
    jl      bloco3

    cmp     si, 210 ; colisão esquerda
    jg      bloco3

    mov     byte [cor], preto
    mov     ax, 115    
    push    ax
    mov     ax, 420    
    push    ax
    mov     ax, 210    
    push    ax
    mov     ax, 440    
    push    ax
    call    rect

    mov     ax, 420
    add     ax, 30          ; adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y2], ax    ; salva novo valor de y2
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco3:
    mov     ax, 420

    cmp     di, ax  ; colisão com a parte de baixo
    jl      bloco4
    
    add     ax, 20  ; soma vinte pixels para ter a colisão da parte de cima

    cmp     di, ax  ; colisão com a parte de cima
    jg      bloco4

    cmp     si, 220 ; colisão direita
    jl      bloco4

    cmp     si, 315 ; colisão esquerda
    jg      bloco4

    mov     byte [cor], preto
    mov     ax, 220    
    push    ax
    mov     ax, 420    
    push    ax
    mov     ax, 315    
    push    ax
    mov     ax, 440    
    push    ax
    call    rect

    mov     ax, 420
    add     ax, 30          ; adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y3], ax    ; salva novo valor de y3
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco4:
    mov     ax, 420

    cmp     di, ax  ; colisão com a parte de baixo
    jl      bloco5
    
    add     ax, 20  ; soma vinte pixels para ter a colisão da parte de cima

    cmp     di, ax  ; colisão com a parte de cima
    jg      bloco5

    cmp     si, 325 ; colisão direita
    jl      bloco5

    cmp     si, 420 ; colisão esquerda
    jg      bloco5

    mov     byte [cor], preto
    mov     ax, 325    
    push    ax
    mov     ax, 420    
    push    ax
    mov     ax, 420    
    push    ax
    mov     ax, 440    
    push    ax
    call    rect

    mov     ax, 420
    add     ax, 30          ; adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y4], ax    ; salva novo valor de y4
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco5:
    mov     ax, 420

    cmp     di, ax  ; colisão com a parte de baixo
    jl      bloco6
    
    add     ax, 20  ; soma vinte pixels para ter a colisão da parte de cima

    cmp     di, ax  ; colisão com a parte de cima
    jg      bloco6

    cmp     si, 430 ; colisão direita
    jl      bloco6

    cmp     si, 525 ; colisão esquerda
    jg      bloco6

    mov     byte [cor], preto
    mov     ax, 430    
    push    ax
    mov     ax, 420    
    push    ax
    mov     ax, 525    
    push    ax
    mov     ax, 440    
    push    ax
    call    rect

    mov     ax, 420
    add     ax, 30          ; adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y5], ax    ; salva novo valor de y5
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]

bloco6:
    mov     ax, 420

    cmp     di, ax  ; colisão com a parte de baixo
    jl      jmp_boost3
    
    add     ax, 20  ; soma vinte pixels para ter a colisão da parte de cima

    cmp     di, ax  ; colisão com a parte de cima
    jg      jmp_boost3

    cmp     si, 535 ; colisão direita
    jl      jmp_boost3

    cmp     si, 630 ; colisão esquerda
    jg      jmp_boost3

    mov     byte [cor], preto
    mov     ax, 535    
    push    ax
    mov     ax, 420    
    push    ax
    mov     ax, 630    
    push    ax
    mov     ax, 440    
    push    ax
    call    rect

    mov     ax, 420
    add     ax, 30          ; adiciona o espaçamento e o tamanho dos blocos para a nova posição
    mov     word[y6], ax    ; salva novo valor de y6
    mov     ax, word[pontos]
    add     ax, 1
    mov     word[pontos], ax
    neg     word [vy]