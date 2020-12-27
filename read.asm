format ELF64
public _start

section '.bss' writable
    buffsize equ 64
    buff rb buffsize

section '.text' executable
_start:
    mov rax, 3
    xor rbx, rbx
    mov rcx, buff
    mov rdx, buffsize
    int 0x80
    mov rax, 4
    mov rbx, 1
    int 0x80
    mov rax, 1
    xor rbx, rbx
    int 0x80 
