segment code
global init_video
global salvar_inicio

init_video:
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
    ret

salvar_inicio:
    ; Redefine as variáveis para seus valores iniciais
    mov word[vx], 3
    mov word[vy], 3
    mov word[x_barra], 270
    mov word[x_barra_end], 370
    mov word[y_barra], 40
    mov word[y1], 420
    mov word[y2], 420
    mov word[y3], 420
    mov word[y4], 420
    mov word[y5], 420
    mov word[y6], 420
    mov word[pontos], 0
    ret

segment data
global cor, modo_anterior
global preto, branco, branco_intenso, magenta_claro, azul, cyan, verde_claro, amarelo, vermelho
global title, fim, win, paused, apaga

cor db branco_intenso

preto equ 0
azul equ 1
verde equ 2
cyan equ 3
vermelho equ 4
magenta equ 5
marrom equ 6
branco equ 7
cinza equ 8
azul_claro equ 9
verde_claro equ 10
cyan_claro equ 11
rosa equ 12
magenta_claro equ 13
amarelo equ 14
branco_intenso equ 15

modo_anterior db 0

title db 'Press enter to start', 0
fim db 'Game Over! reiniciar? (y/n)', 0
win db 'Parabens! Voce Ganhou! reiniciar? (y/n)', 0
paused db 'Paused', 0
apaga db '                                                  ', 0

global velocidade, vx, vy, saved_vx, saved_vy, x_barra, x_barra_end, y_barra
global rect_x1, rect_x2, rect_y1, rect_y2, num_rects, y1, y2, y3, y4, y5, y6, pontos

velocidade resw 1
vx resw 1
vy resw 1
saved_vx resw 1
saved_vy resw 1
x_barra resw 1
x_barra_end resw 1
y_barra resw 1
rect_x1 resw 6
rect_x2 resw 6
rect_y1 resw 6
rect_y2 resw 6
num_rects resb 1
y1 resw 1
y2 resw 1
y3 resw 1
y4 resw 1
y5 resw 1
y6 resw 1
pontos resw 1

segment stack stack
    resb 512
stacktop:
