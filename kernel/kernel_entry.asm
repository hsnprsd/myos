[bits 32]
[extern main]

call main
jmp $ ; hang forever when we return from kernel
