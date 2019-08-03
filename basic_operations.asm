;nasm 2.14.02
;Windows 10 x64

[bits 64]

global main
extern printf

section .data
    varByteLog: db "varByte: %d", 0xA, 0xA, 0
    varALog: db "varA: %d", 0xA, 0
    varBLog: db "varB: %d", 0xA, 0xA, 0
    addLog: db "addLog: %d", 0xA, 0
    subLog: db "subLog: %d", 0xA, 0
    incLog: db "incLog: VarA+1: %d", 0xA, 0
    decLog: db "decLog: VarA+1: %d", 0xA, 0xA, 0
    mulLog: db "mulLog: VarA * VarB: %d", 0xA, 0
    divLog: db "divLog: VarB / VarA: div: %d mod: %d", 0

    varByte db 0xA

    varA: dq 123
    varB: dq 321

section .text

main:
    jmp op_adding    
    ret

op_adding:
    sub rsp, 0x28                       ;shadow space for Windows
    
    mov bl, [varByte]                   ;load byte to low bx register
    movsx rdx, bl                       ;promote to sign extended, prepare to send to printf
    mov rcx, varByteLog                 ;prepare format to send to printf
    call printf                         ;call printf

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

    mov rdx, [varA]
    sub rdx, [varB]
    mov rcx, subLog
    call printf

    mov rdx, [varA]
    inc rdx
    mov rcx, incLog
    call printf

    mov rdx, [varA]
    dec rdx
    mov rcx, decLog
    call printf

    ;multiply unsigned
    mov rax, [varA]
    mov rdx, [varB]
    mul rdx
    mov rdx, rax
    mov rcx, mulLog
    call printf

    ;multiply signed
    mov rax, [varA]
    mov rdx, -5
    imul rdx
    mov rdx, rax
    mov rcx, mulLog
    call printf

    ;division 
    mov edx, 0
    mov rax, [varB]
    mov rcx, [varA]
    idiv rcx

    mov r8, rdx
    mov rdx, rax
    mov rcx, divLog
    call printf 

    add rsp, 0x28                       ;remove shadow space
    ret