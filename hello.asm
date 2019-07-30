;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf

section .data
    message db 'Hello from asm', 0

section .text

main:
    sub rsp, 0x28                        ; Reserve the shadow space
    mov rcx, message                    ; First argument is address of message
    call printf                            ; puts(message)
    add rsp, 0x28                        ; Remove shadow space
    ret