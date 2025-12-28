section .data
    ; RAM: 4 byte (Sadece 2 bitini kullanacağız)
    ram      db 0, 0, 0, 0
    acc      db 0
    msg_out  db "OUT: %d", 10, 0

section .text
    global _start
    extern printf

_start:
    ; --- ÖRNEK PROGRAM: LOAD 1, ADD 2, OUT 0 ---
    ; RAM[0] = 0 (LOAD), RAM[1] = 1 (VERI)
    ; RAM[2] = 1 (ADD),  RAM[3] = 2 (VERI)
    mov byte [ram+0], 0 
    mov byte [ram+1], 1
    mov byte [ram+2], 1
    mov byte [ram+3], 2

    mov rbx, 0          ; RBX = Program Counter (PC)

run_loop:
    cmp rbx, 4          ; PC < 4 kontrolü
    jge exit_proc

    mov al, [ram + rbx]     ; AL = Opcode (Komut)
    mov cl, [ram + rbx + 1] ; CL = Operand (Veri)

    ; --- DECODE & EXECUTE (Komut Çözme) ---
    cmp al, 0
    je op_load
    cmp al, 1
    je op_add
    cmp al, 2
    je op_str
    cmp al, 3
    je op_out
    jmp next_instr

op_load:
    mov [acc], cl
    jmp next_instr

op_add:
    mov al, [acc]
    add al, cl
    and al, 3           ; 2-bit sınırı (0-3 arası tutar)
    mov [acc], al
    jmp next_instr

op_str:
    and cl, 3           ; Adres sınırı
    mov al, [acc]
    mov [ram + rcx], al
    jmp next_instr

op_out:
    ; Ekrana yazdırma (printf çağrısı simülasyonu)
    ; ... (Sistem çağrıları buraya gelir)
    jmp next_instr

next_instr:
    add rbx, 2          ; PC += 2
    jmp run_loop

exit_proc:
    ; Programı kapat
    mov rax, 60
    xor rdi, rdi
    syscall
