org 0x100

start:
    mov di, memory
    xor si, si

.main_loop:
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]
    mov [a], ax

    inc si
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]
    mov [b], ax

    inc si
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]
    mov [c], ax

    cmp word [b], -1
    jne .not_output

    mov ax, [a]
    shl ax, 1
    mov bx, di
    add bx, ax
    mov al, [bx]
    mov ah, 0x0E
    int 0x10

    mov si, [pc_offset]
    add si, 3
    jmp .set_pc

.not_output:
    mov ax, [a]
    shl ax, 1
    mov bx, di
    add bx, ax
    mov ax, [bx]

    mov cx, [b]
    shl cx, 1
    mov bx, di
    add bx, cx
    mov cx, [bx]
    sub cx, ax
    mov [bx], cx

    test cx, cx
    jle .do_jump
    mov si, [pc_offset]
    add si, 3
    jmp .set_pc

.do_jump:
    mov si, [c]

.set_pc:
    mov [pc_offset], si
    jmp .main_loop

a: dw 0
b: dw 0
c: dw 0
pc_offset: dw 0

; --- HELLO + newline using subleq print ---
memory:
    dw 30, -1, 3
    dw 31, -1, 6
    dw 32, -1, 9
    dw 33, -1, 12
    dw 34, -1, 15
    dw 35, -1, 18
    dw 36, -1, 21
    dw 0, 0, 21      ; infinite loop

    times (30 - ($ - memory)/2) dw 0

    dw 'H'
    dw 'E'
    dw 'L'
    dw 'L'
    dw 'O'
    dw 13    ; \r
    dw 10    ; \n

    times (256 - 37) dw 0
memory:
    dw 30
    dw -1
    dw 3
    dw 31
    dw -1
    dw 6
    dw 32
    dw -1
    dw 9
    dw 33
    dw -1
    dw 12
    dw 34
    dw -1
    dw 15
    dw 35
    dw -1
    dw 18
    dw 36
    dw -1
    dw 21
    dw 0
    dw 0
    dw 21
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
    dw 0
