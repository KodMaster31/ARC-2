section .data
    ; 1-bit RAM (sadece LSB kullanılır)
    ram db 1, 1, 0, 0

    acc db 0        ; 1-bit accumulator
    pc  db 0        ; 2-bit program counter

    ; Program:
    ; LOAD 0
    ; AND  1
    ; OUT
    ; STORE 2
    program db 00b, 01b, 11b, 10b
    operand db 00b, 01b, 00b, 10b

    msg db "OUT: %d", 10, 0

section .text
    global _start
    extern printf

_start:
cpu_loop:
    movzx ecx, byte [pc]
    cmp ecx, 4
    jge exit

    ; FETCH
    mov al, [program + ecx]   ; opcode
    mov bl, [operand + ecx]   ; arg
    and bl, 3                 ; 2-bit address

    ; DECODE
    cmp al, 0
    je op_load
    cmp al, 1
    je op_and
    cmp al, 2
    je op_store
    cmp al, 3
    je op_out
    jmp next

op_load:
    mov dl, [ram + rbx]
    and dl, 1
    mov [acc], dl
    jmp next

op_and:
    mov dl, [acc]
    and dl, [ram + rbx]
    and dl, 1
    mov [acc], dl
    jmp next

op_store:
    mov dl, [acc]
    and dl, 1
    mov [ram + rbx], dl
    jmp next

op_out:
    movzx rsi, byte [acc]
    lea rdi, [msg]
    xor eax, eax
    call printf
    jmp next

next:
    inc byte [pc]
    and byte [pc], 3          ; PC = 2-bit
    jmp cpu_loop

exit:
    mov eax, 60
    xor edi, edi
    syscall
