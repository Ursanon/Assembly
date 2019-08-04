;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf

section .data
    print_num_format: db "%s number: %d", 0xA, 0
    rax_message: db "RAX register:", 0
    rbx_message: db "RBX register:", 0

section .text

main:
    mov rsi, 123
    mov rbx, 321

    call print_registers
    call swap_with_stack
    call print_registers

    ret

print_registers:
    mov rdx, rax_message
    mov r8, rsi
    call print_number

    mov rdx, rbx_message
    mov r8, rbx
    call print_number
    
    ret

;******************************
;swaps rsi and rbx registers using stack
;******************************
swap_with_stack:
    push rsi
    push rbx
    pop rsi
    pop rbx
    ret

;******************************
;prints string from rdx and number from r8 register
;******************************
print_number:
    sub rsp, 0x28                        ;Reserve the shadow space for Windows

    mov rcx, print_num_format
    call printf

    add rsp, 0x28                        ;Release shadow space
    ret