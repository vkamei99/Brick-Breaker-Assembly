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