segment .data
    LF equ 0xa
    SYS_WRITE equ 4

section .data
    message db "[+] modifying your MSRS...!", LF
    n_value_dec dd 0x00000000
    n_value_more dd 0x14

section .text

global _start

_start:
    mov edx, message
    call print_string
    mov ecx, 0x199 
    rdmsr
    mov eax, [n_value_dec]
    mov edx, [n_value_more]
    wrmsr

%macro PRINT_STRING 2
    mov eax, SYS_WRITE
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

message_length equ $ - message
