segment code
global cursor, caracter

cursor:
    pushf
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    mov ah, 2
    mov bh, 0
    int 10h
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    popf
    ret

caracter:
    pushf
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    mov ah, 9
    mov bh, 0
    mov cx, 1
    mov bl, [cor]
    int 10h
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    popf
    ret
