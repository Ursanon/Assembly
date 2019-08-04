;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf

%define NUMBER 5

section .data
    print_num_format: db "%s number: %d", 0xA, 0
    start_log: db "starting"
    result_log: db "result"
section .text

main:
    mov r8, NUMBER
    mov rdx, start_log
    call print_number

    call start_factorial

    mov r8, rax
    mov rdx, result_log
    call print_number

    ret

;******************************
;sets rax to factorial of NUMBER constant
;******************************
start_factorial:
    mov rsi, NUMBER
    call factorial
    ret

factorial:
    cmp rsi, 1
    jg progress_factorial
    mov rax, 1
    ret

progress_factorial:
    dec rsi
    call factorial
    inc rsi
    mul rsi
    ret

;******************************
;prints number from r8 and string from rdx register
;******************************
print_number:
    sub rsp, 0x28                        ;Reserve the shadow space for Windows

    mov rcx, print_num_format
    call printf

    add rsp, 0x28                        ;Release shadow space
    ret