[bits 16]
[org 0x7C00]

KERNEL_OFFSET equ 0x1000

boot_main:
    mov [BOOT_DRIVE], dl

    mov bp, 0x9000
    mov sp, bp

    mov si, MSG_REAL_MODE
    call print_string

    call load_kernel

    call switch_to_pm ; we never return from here
    jmp $

%include "./print_string.asm"
%include "./gdt.asm"
%include "./disk_load.asm"
%include "./kernel_load.asm"
%include "./print_string_pm.asm"
%include "./pm.asm"

[bits 32]

begin_pm:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    call KERNEL_OFFSET

    jmp $ ; Hang

CR equ 0x0d    ; Carriage return
LF equ 0x0a    ; Line feed

BOOT_DRIVE: db 0

MSG_REAL_MODE       db "Started in 16-bit Real Mode", CR, LF, 0
MSG_LOAD_GDT        db "Loading GDT...", CR, LF, 0
MSG_LOAD_KERNEL     db "Loading Kernel...", CR, LF, 0
MSG_ENTER_PROT_MODE db "Entering 32-bit Protected Mode...", CR, LF, 0
MSG_PROT_MODE       db "Successfully landed in 32-bit Protected Mode", 0

times 510-($-$$) db 0
db 0x55, 0xAA
