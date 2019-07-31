;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf
extern puts

section .data
    message db 'Hello from asm', 0xA, 0 
    format db 'passed float: %f', 0
    v1 dd 3.1
section .text

main:
    sub rsp, 0x28                        ; Reserve the shadow space
    mov rcx, message                    ; First argument is address of message
    call printf                            ; printf(message)

    cvtss2sd xmm0, [v1]
    movq rdx, xmm0
    mov rcx, format 
    call printf

    add rsp, 0x28
    
    ret