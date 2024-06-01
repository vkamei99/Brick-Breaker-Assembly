; graphics.asm

global apaga_title, show_title, desenha_layout, desenha_bola, apaga_bola, desenha_barra, desenha_retangulo

extern cor, x_barra, x_barra_end, y_barra

apaga_title:
    ; Implementação da função apaga_title
    mov     cx,50
    mov     bx,0
    mov     dh,14
    mov     dl,10
    mov     byte [cor], 0

apaga_title_loop:
    call cursor
    mov al,[bx+apaga]
    call caracter
    inc bx
    inc dl
    loop apaga_title_loop
    ret

show_title:
    ; Implementação da função show_title
    mov     cx,20
    mov     bx,0
    mov     dh,14
    mov     dl,29
    mov     byte [cor], 15

show_title_loop:
    call cursor
    mov al,[bx+title]
    call caracter
    inc bx
    inc dl
    loop show_title_loop
    ret

desenha_layout:
    ; Implementação da função desenha_layout
    mov     byte [cor], 0
    mov     ax, 230
    push ax
    mov     ax, 240
    push ax
    mov     ax, 390
    push ax
    mov     ax, 255
    push ax
    call desenha_retangulo

    mov     byte [cor], 15
    mov     ax, 0
    push ax
    mov     ax, 0
    push ax
    mov     ax, 0
    push ax
    mov     ax, 479
    push ax
    call line

    mov     ax, 0
    push ax
    mov     ax, 479
    push ax
    mov     ax, 639
    push ax
    mov     ax, 479
    push ax
    call line

    mov     ax, 639
    push ax
    mov     ax, 0
    push ax
    mov     ax, 639
    push ax
    mov     ax, 479
    push ax
    call line 
    ret

desenha_bola:
    ; Implementação da função desenha_bola
    mov     byte [cor], 15
    mov     ax, si 
    push ax
    mov     ax, di
    push ax
    mov     ax, 10
    push ax
    call full_circle
    ret

apaga_bola:
    ; Implementação da função apaga_bola
    mov     byte [cor], 0
    mov     ax, si
    push ax
    mov     ax, di
    push ax
    mov     ax, 10
    push ax
    call full_circle
    pop ax
    pop ax
    pop ax
    ret

desenha_barra:
    ; Implementação da função desenha_barra
    mov     byte [cor], 15    
    mov     ax, [x_barra]
    push ax
    mov     ax, [y_barra]
    push ax
    mov     ax, [x_barra_end]
    push ax
    mov     ax, [y_barra]
    push ax
    call line
    pop ax
    pop ax
    pop ax
    ret



