;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf

%define LOOP_SIZE 5

section .data
    loop_message: db "Loop!", 0xA, 0

section .text

main:
    mov rbx, 0
looper:
    inc rbx

    call print_message

    cmp rbx, LOOP_SIZE

    jl looper

    ret

print_message:
    sub rsp, 0x28                        ;Reserve the shadow space for Windows

    mov rcx, loop_message
    call printf

    add rsp, 0x28                        ;Release shadow space
    ret