;nasm 2.11.08

section .data
    msg db 'Hello from asm', 0
    msg_len equ $ - msg

section .text
    global _main
    
_main:
    mov edx, msg_len
    mov ecx, msg
    mov ebx, 1            ; stdout - file descriptor
    mov eax, 4            ; sys_write
    int 0x80              ; call kernel
    
    mov eax, 1            ; sys_exit
    int 0x80              ; call kernel