load_kernel:
    mov si, MSG_LOAD_KERNEL
    call print_string

    mov bx, KERNEL_OFFSET
    mov dh, 9
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret
