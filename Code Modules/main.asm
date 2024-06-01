; main.asm

segment code
..start:
    ; Inicialização do segmento de dados e pilha
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, stacktop

    ; Salvar modo corrente de vídeo
    mov ah, 0Fh
    int 10h
    mov [modo_anterior], al   

    ; Alterar modo de vídeo para gráfico 640x480 16 cores
    mov al, 12h
    mov ah, 0
    int 10h

    ; Limpar registros e definir posição inicial da bola
    xor si, si
    xor di, di
    mov cx, 0800h
    mov si, 319
    mov di, 240

    call apaga_title
    call show_title

inicio:
    mov ah, 00h
    int 16h

    cmp al, 0Dh ; 'enter' -> iniciar o jogo
    je desenha_layout

    jmp inicio

desenha_layout:
    call desenha_retangulo
    call desenha_blocos
    jmp main_loop

main_loop:
    call desenha_bola
    call delay
    call apaga_bola
    call desenha_barra
    call atualiza_posicao_bola
    call verifica_colisoes
    call check_input

    jmp main_loop

check_input:
    ; Verificar entrada do teclado
    mov ah, 01h
    int 16h
    jnz jmp_check

    ; Verifica a colisão com a barra
    cmp di, 55
    jle colisao_barra

    jmp main_loop

jmp_check:
    call trata_entrada
    jmp main_loop

jmp_pause:
    call pause
    jmp main_loop

jmp_sair:
    call sair

colisao_barra:
    cmp si, [x_barra]
    jl jmp_boost2

    cmp si, [x_barra_end]
    jg jmp_boost2

    neg [vy]
    jmp main_loop

jmp_boost2:
    jmp main_loop

jmp_sair:
    call sair

segment data
    cor db 15 ; branco_intenso
    modo_anterior db 0
    linha dw 0
    coluna dw 0
    deltax dw 0
    deltay dw 0
    velocidade dw 1
    vx dw 3
    vy dw 3
    saved_vx dw 0
    saved_vy dw 0
    title db 'Press enter to start', 0
    fim db 'Game Over! reiniciar? (y/n)', 0
    win db 'Parabens! Voce Ganhou! reiniciar? (y/n)', 0
    paused db 'Paused', 0
    apaga db '                                                  ', 0
    x_barra dw 270
    x_barra_end dw 370
    y_barra dw 40
    rect_x1 dw 10, 115, 220, 325, 430, 535
    rect_x2 dw 105, 210, 315, 420, 525, 630
    rect_y1 dw 420, 420, 420, 420, 420, 420
    rect_y2 dw 440, 440, 440, 440, 440, 440
    num_rects db 6
    y1 dw 420
    y2 dw 420
    y3 dw 420
    y4 dw 420
    y5 dw 420
    y6 dw 420
    pontos dw 0

segment stack stack
    resb 512
stacktop:

; Incluir outros módulos
%include "graphics.asm"
%include "game_logic.asm"
%include "collision.asm"
