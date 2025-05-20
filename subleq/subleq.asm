; subleq.asm — Self-modifying OISC (subleq) Emulator
; ---------------------------------------------------
; Build: nasm -f bin subleq.asm -o subleq.com
; Run:  in DOSBox or any 16-bit real-mode emulator
; Architecture: x86 real mode (.COM)
; Memory: 256 words (512 bytes)
; Registers:
;   SI = program counter (word index)
;   DI = memory base pointer
;   AX, BX, CX = general-purpose

org 0x100                 ; standard .COM offset

start:
    ; Set DI to start of memory array
    mov di, memory

    ; Initialize PC (stored in [pc_offset])
    xor si, si            ; si = 0

.main_loop:
    ; --- Fetch A ---
    mov cx, si
    shl cx, 1             ; cx = si * 2 (byte offset)
    mov bx, di
    add bx, cx
    mov ax, [bx]          ; ax = mem[si] = A
    mov word [a], ax

    ; --- Fetch B ---
    inc si
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]          ; ax = B
    mov word [b], ax

    ; --- Fetch C ---
    inc si
    mov cx, si
    shl cx, 1
    mov bx, di
    add bx, cx
    mov ax, [bx]          ; ax = C
    mov word [c], ax

    ; --- Perform mem[B] -= mem[A] ---
    mov ax, [a]
    shl ax, 1
    mov bx, di
    add bx, ax
    mov ax, [bx]          ; ax = mem[A]

    mov cx, [b]
    shl cx, 1
    mov bx, di
    add bx, cx
    mov cx, [bx]          ; cx = mem[B]
    sub cx, ax
    mov [bx], cx          ; mem[B] -= mem[A]

    ; --- Conditional jump ---
    test cx, cx
    jle .branch
    ; not ≤ 0 → PC += 3
    mov si, [pc_offset]
    add si, 3
    jmp .next

.branch:
    mov si, [c]
.next:
    mov [pc_offset], si
    jmp .main_loop

; --- Temp vars for A, B, C addresses ---
a: dw 0
b: dw 0
c: dw 0

; --- Memory (256 words = 512 bytes) ---
memory:
    ; Example program: countdown from 5 to 0 using:
    ; subleq 11, 10, 0
    dw 11, 10, 0       ; at mem[0..2]: subleq 11, 10, 0

    times 7 dw 0       ; pad to mem[10]
    dw 5              ; mem[10] = countdown variable
    dw 1              ; mem[11] = decrement constant

    ; Fill rest of 256-word memory
    times (256 - 12) dw 0

; --- Program counter offset ---
pc_offset: dw 0
