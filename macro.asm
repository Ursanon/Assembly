;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf

%macro add_3 3
    mov rax, %1
    add rax, %2
    add rax, %3
%endmacro

section .data
    format db 'macro result: %d', 0xA, 0
    absq_format db 'abs(%d) = %d', 0xA, 0
    value0 dq -123
    value1 dq 12

section .text

absq:
    mov rax, rdi

    cqo                                     ; split rax into rdx:rax - if rax was positive rdx equals zero : otherwise 0xFFFFFF
    xor rax, rdx                            ; xor to get ~(rax -1)
    sub rax, rdx                            ; sub rdx (-1) from ~(rax - 1)  => ~rax 

    ret

main:
    sub rsp, 0x28                           ; Reserve the shadow space

    add_3 1, 1, 2

    mov rdx, rax
    mov rcx, format
    call printf

    mov rdi, [value1]
    call absq

    mov rdx, [value1]
    mov r8, rax
    mov rcx, absq_format
    call printf

    mov rdi, [value0]
    call absq

    mov rdx, [value0]
    mov r8, rax
    mov rcx, absq_format
    call printf

    add rsp, 0x28                           ; Add shadow space
    
    ret