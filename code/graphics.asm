segment code
global desenhar_layout, desenhar_blocos, desenhar_bola, limpar_bola, desenhar_barra

desenhar_layout:
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

    ret

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

    ret

desenhar_bola:
    mov     byte[cor],branco_intenso  
    mov     ax, si 
    push        ax
    mov     ax, di
    push        ax
    mov     ax,10
    push        ax
    call    full_circle
    ret

limpar_bola:
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
    ret

desenhar_barra:
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
    ret
