;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf

section .data
    varALog: db "varA: %d", 0xA, 0
    varBLog: db "varB: %d", 0xA, 0xA, 0
    addLog: db "addLog: %d", 0xA, 0
    
    varA: dd 123
    varB: dd 321

section .text

main:
    jmp op_adding
    ret

op_adding:
    ;shadow space for Windows
    sub rsp, 0x28
    
    ;log varA
    mov rdx, [varA]
    mov rcx, varALog
    call printf

    ;log varB
    mov rdx, [varB]
    mov rcx, varBLog
    call printf

    ;long addition
    mov rax, [varA]
    mov rbx, [varB]
    add rax, rbx

    ; print addition
    mov rdx, rax
    mov rcx, addLog
    call printf

    ;in-place addition and print
    mov rdx, [varA]                     ;move varA to rdx (printf will use rdx)
    add rdx, [varB]                     ;add directly to rdx register
    mov rcx, addLog                     ;move log format
    call printf                         ;call printf

    add rsp, 0x28
    ;remove shadow space
    ret