[bits 16]

switch_to_pm:
    cli

    mov si, MSG_LOAD_GDT
    call print_string

    lgdt [gdt_descriptor]

    mov si, MSG_ENTER_PROT_MODE
    call print_string

    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm

[bits 32]

init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call begin_pm
