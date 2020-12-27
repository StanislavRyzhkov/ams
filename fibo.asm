format ELF64
public _start

section '.bss' writable
    buff rb 1

section '.text' executable
_start:
    mov rax, 123
    call print_number
    mov rax, 345
    call print_number
    call exit

section '.print_number' executable
print_number:
    ; push rax
    ; push rbx
    ; push rcx
    ; push rdx
    xor rcx, rcx 
    .next_iter:
        cmp rax, 0
        je .print_iter
        xor rdx, rdx ; не совсем понятно, зачем обнулять
        mov rbx, 10
        div rbx
        add rdx, '0' 
        push rdx
        inc rcx
        jmp .next_iter
    .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx  
        jmp .print_iter
    .close:
        call next_line
        ; pop rdx
        ; pop rcx
        ; pop rbx
        ; pop rax 
        ret 

section '.next_line' executable
next_line:
    push rax
    mov rax, 0xA
    call print_char
    pop rax
    ret            
                
section '.print_char' executable
print_char:
    push rax
    push rbx
    push rcx
    push rdx
    mov [buff], al    
    mov rax, 4
    mov rbx, 1
    mov rcx, buff
    mov rdx, 1
    int 0x80
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

section '.exit' executable
exit:
    mov rax, 1
    xor rbx, rbx
    int 0x80
