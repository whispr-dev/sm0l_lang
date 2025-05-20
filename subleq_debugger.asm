org 0x100

start:
    mov di, memory
    xor si, si

.main_loop:
    ; Fetch A
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]
    mov [a], ax

    ; Fetch B
    inc si
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]
    mov [b], ax

    ; Fetch C
    inc si
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]
    mov [c], ax

    ; --- Print debug info ---
    call print_debug

    ; --- HALT if B == -3 ---
    cmp word [b], -3
    jne .check_output
    jmp .halt

.check_output:
    cmp word [b], -1
    jne .not_output

    ; --- INPUT: subleq A, -2, C ---
    cmp word [b], -2
    jne .not_output
    call get_input
    mov si, [pc_offset]
    add si, 3
    jmp .set_pc

    ; --- Output mem[A] as char ---
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

; --- BIOS debug printer ---
print_debug:
    pusha

    ; Print PC:
    mov dx, pc_text
    call print_string
    mov ax, [pc_offset]
    call print_num

    ; Print regs A/B/C
    mov dx, reg_a
    call print_string
    mov ax, [a]
    call print_num

    mov dx, reg_b
    call print_string
    mov ax, [b]
    call print_num

    mov dx, reg_c
    call print_string
    mov ax, [c]
    call print_num

    ; Print mem[A]
    mov ax, [a]
    shl ax, 1
    mov bx, di
    add bx, ax
    mov ax, [bx]
    mov dx, mema
    call print_string
    call print_num

    ; Prompt
    mov dx, waitmsg
    call print_string

    ; Wait for key
    mov ah, 0
    int 16h

    ; newline
    mov al, 13
    call print_char
    mov al, 10
    call print_char

    popa
    ret

print_string:
    pusha
.print_loop:
    lodsb
    or al, al
    jz .done
    call print_char
    jmp .print_loop
.done:
    popa
    ret

print_char:
    mov ah, 0x0E
    int 10h
    ret

print_num:
    pusha
    mov cx, 0
    mov bx, 10
    xor dx, dx
    cmp ax, 0
    jge .skipneg
    mov al, '-'
    call print_char
    neg ax
.skipneg:
.reverse:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz .reverse
.printloop:
    pop dx
    add dl, '0'
    mov al, dl
    call print_char
    loop .printloop
    popa
    ret

.halt:
    mov ah, 0x4C
    xor al, al
    int 21h

a: dw 0
b: dw 0
c: dw 0
pc_offset: dw 0

get_input:
    pusha
    mov ah, 0        ; BIOS: wait for keypress
    int 16h
    ; AL now has the ASCII char
    mov ax, [a]
    shl ax, 1
    mov bx, memory
    add bx, ax
    mov [bx], al     ; store ASCII into mem[A]
    popa
    ret

; --- Debug strings ---
pc_text  db 'PC: ', 0
reg_a    db ' | A=', 0
reg_b    db ' B=', 0
reg_c    db ' C=', 0
mema     db ' mem[A]=', 0
waitmsg  db ' Press any key...', 0

; --- Program Memory: HELLO\r\n ---
memory:
    dw 30, -1, 3
    dw 31, -1, 6
    dw 32, -1, 9
    dw 33, -1, 12
    dw 34, -1, 15
    dw 35, -1, 18
    dw 36, -1, 21
    dw 0, -3, 21      ; halt

    times (30 - ($ - memory)/2) dw 0

    dw 'H'
    dw 'E'
    dw 'L'
    dw 'L'
    dw 'O'
    dw 13
    dw 10

    times (256 - 37) dw 0
