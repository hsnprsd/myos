C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

all: os.img

run: all
	qemu-system-x86_64 -drive format=raw,file=os.img

os.img: boot/boot_sect.bin kernel.bin
	cat $^ > $@

%.o: %.c ${HEADERS}
	gcc -Wall -ffreestanding -I. -c $< -o $@

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.bin: %.asm
	nasm $< -f bin -I boot -o $@

%.o: %.asm
	nasm $< -f elf64 -o $@

clean:
	rm -fr *.bin *.o os.img
	rm -fr kernel/*.o boot/*.bin drivers/*.o
