C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

all: os.bin

run: all
	qemu-system-i386 -fda os.bin

os.bin: boot/boot_sect.bin kernel.bin
	cat $^ > $@

%.o: %.c ${HEADERS}
	clang -g -O0 -ffreestanding -target i386 -I. -c $< -o $@

kernel.bin: kernel/entry.o ${OBJ}
	ld -o $@ -m elf_i386 -s -Ttext 0x1000 $^ --oformat binary

%.bin: %.asm
	nasm $< -f bin -I boot -o $@

%.o: %.asm
	nasm $< -f elf32 -o $@

clean:
	rm -fr *.bin *.o os.img
	rm -fr kernel/*.o boot/*.bin drivers/*.o
