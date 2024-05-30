colisao_blocos:
    ;bloco 1
    cmp di, 440
    jg bloco2

    cmp di, 420
    jl bloco2

    cmp si, 10
    jl bloco2

    cmp si, 105
    jg bloco2

    mov byte [cor], preto
    mov ax, 10    
    push ax
    mov ax, 420    
    push ax
    mov ax, 105    
    push ax
    mov ax, 440    
    push ax
    call rect

    neg word [vy]

bloco2:
    cmp di, 440
    jg bloco3

    cmp di, 420
    jl bloco3

    cmp si, 115
    jl bloco3

    cmp si, 210
    jg bloco3

    mov byte [cor], preto
    mov ax, 115    
    push ax
    mov ax, 420    
    push ax
    mov ax, 210    
    push ax
    mov ax, 440    
    push ax
    call rect

    neg word [vy]
bloco3:
    cmp di, 440
    jg bloco4

    cmp di, 420
    jl jmp_boost4

    cmp si, 220
    jl bloco4

    cmp si, 315
    jg bloco4

    mov byte [cor], preto
    mov ax, 220    
    push ax
    mov ax, 420    
    push ax
    mov ax, 315    
    push ax
    mov ax, 440    
    push ax
    call rect

    neg word [vy]

bloco4:
    cmp di, 440
    jg bloco5

    cmp di, 420
    jl bloco5

    cmp si, 325
    jl bloco5

    cmp si, 420
    jg bloco5

    mov byte [cor], preto
    mov ax, 325    
    push ax
    mov ax, 420    
    push ax
    mov ax, 420    
    push ax
    mov ax, 440    
    push ax
    call rect

    neg word [vy]
jmp_boost4:
    jmp main
bloco5:
    cmp di, 440
    jg jmp_boost4

    cmp di, 420
    jl jmp_boost4

    cmp si, 430
    jl jmp_boost4

    cmp si, 525
    jg jmp_boost4

    mov byte [cor], preto
    mov ax, 430    
    push ax
    mov ax, 420    
    push ax
    mov ax, 525    
    push ax
    mov ax, 440    
    push ax
    call rect

    neg word [vy]

bloco6:
    cmp di, 440
    jg jmp_boost4

    cmp di, 420
    jl jmp_boost4

    cmp si, 535
    jl jmp_boost4

    cmp si, 630
    jg jmp_boost4

    mov byte [cor], preto
    mov ax, 535    
    push ax
    mov ax, 420    
    push ax
    mov ax, 630    
    push ax
    mov ax, 440    
    push ax
    call rect

    neg word [vy]
