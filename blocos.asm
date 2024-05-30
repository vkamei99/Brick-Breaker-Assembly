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