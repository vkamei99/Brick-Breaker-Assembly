; game_logic.asm

global delay, atualiza_posicao_bola, verifica_colisoes, trata_entrada, pause, sair

extern vx, vy, si, di, cor, modo_anterior

delay:
    ; Implementação da função delay
    mov ah, 86h
    mov cx, 0
    mov dx, 100 
    int 15h
    ret

atualiza_posicao_bola:
    ; Implementação da função atualiza_posicao_bola
    add si, [vx]
    add di, [vy]
    ret

verifica_colisoes:
    ; Implementação da função verifica_colisoes
    cmp si, 624
    jge colisao_direita

    cmp si, 16
    jle colisao_esquerda

    cmp di, 464
    jge colisao_cima

    cmp di, 16
    jle colisao_baixo
    ret

trata_entrada:
    ; Implementação da função trata_entrada
    mov ah, 00h
    int 16h
    
    cmp al, 41h ;'A' -> Move para esquerda
    je PADDLE_LEFT
    cmp al, 61h ;'a'
    je PADDLE_LEFT
    
    cmp al, 44h ;'D' -> Move para direita
    je PADDLE_RIGHT
    cmp al, 64h ;'d'
    je PADDLE_RIGHT

    cmp al, 27h ;'>'-> Move para direita
    je PADDLE_RIGHT
    cmp al, 25h ;'<'-> Move para direita
    je PADDLE_LEFT

    cmp al, 50h ;'P' -> Pause
    je jmp_pause
    cmp al, 70h ;'p'
    je jmp_pause

    cmp al, 51h ;'Q' -> Sair
    je sair
    cmp al, 71h ;'q'
    je sair

    ret

pause:
    cmp [vx], 0
    je unpause      

    mov ax, [vx]
    mov [saved_vx], ax
    mov ax, [vy]
    mov [saved_vy], ax

    mov [vx], 0
    mov [vy], 0

    mov cx, 6
    mov bx, 0
    mov dh, 14
    mov dl, 36
    mov byte [cor], 15

loop_pause_text:
    call cursor
    mov al, [bx+paused]
    call caracter
    inc bx
    inc dl
    loop loop_pause_text

    ret

unpause:
    mov ax, [saved_vx]
    mov [vx], ax
    mov ax, [saved_vy]
    mov [vy], ax

    mov cx, 50
    mov bx, 0
    mov dh, 14
    mov dl, 10
    mov byte [cor], 0

loop_apaga_pause_text:
    call cursor
    mov al, [bx+apaga]
    call caracter
    inc bx
    inc dl
    loop loop_apaga_pause_text
    
    ret

sair:
    mov ah, 0
    mov al, [modo_anterior]
    int 10h
    mov ax, 4c00h
    int 21h
    ret

PADDLE_LEFT:
    cmp [x_barra], 10
    jle jmp_boost

    mov byte [cor], 0
    mov ax, [x_barra]
    push ax
    mov ax, [y_barra]
    push ax
    mov ax, [x_barra
