C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

all: myos.img

run: all
	qemu-system-i386 -drive file=myos.img,if=floppy,format=raw

myos.img: boot/boot_sect.bin kernel/kernel.bin
	cat $^ > $@

%.o: %.c ${HEADERS}
	clang -g -O0 -ffreestanding -target i386 -I. -c $< -o $@

kernel/kernel.bin: kernel/entry.o ${OBJ}
	ld -o $@ -m elf_i386 -s -Ttext 0x1000 $^ --oformat binary

%.bin: %.asm
	nasm $< -f bin -I boot -o $@

%.o: %.asm
	nasm $< -f elf32 -o $@

clean:
	rm -rf **/*.bin **/*.o myos.img
