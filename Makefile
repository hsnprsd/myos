CC = clang
CCFLAGS = -g -O0 -ffreestanding -target i386 -Iinclude
LD = ld

SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${SOURCES:.c=.o}

all: myos.img

run: all
	qemu-system-i386 -drive file=myos.img,if=floppy,format=raw

myos.img: boot/boot_sect.bin kernel/kernel.bin
	cat $^ > $@

%.o: %.c ${HEADERS}
	$(CC) $(CCFLAGS) -c $< -o $@

kernel/kernel.bin: kernel/entry.o ${OBJ}
	$(LD) -o $@ -m elf_i386 -s -Ttext 0x1000 $^ --oformat binary

%.bin: %.asm
	nasm $< -f bin -I boot -o $@

%.o: %.asm
	nasm $< -f elf32 -o $@

clean:
	rm -rf **/*.bin **/*.o myos.img
