#include "vga.h"

unsigned char port_byte_in(unsigned short port) {
    unsigned char result ;
    __asm__ ( "in %%dx, %%al" : "=a"(result) : "d"(port));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
    __asm__("out %%al, %%dx" : : "a"(data), "d"(port));
}

void move_cursor(unsigned int offset) {
    port_byte_out(REG_VGA_CTLR, 0xe);
    port_byte_out(REG_VGA_DATA, offset >> 8);
    port_byte_out(REG_VGA_CTLR, 0xf);
    port_byte_out(REG_VGA_DATA, offset);
}

// clear the screen
void clear() {
    unsigned char* buf = (unsigned char*)VGA_BUFFER;
    for (unsigned int i = 0; i < SCREEN_HEIGHT * SCREEN_WIDTH; i++) {
        buf[i << 1] = GREEN_ON_BLACK;
        buf[i << 1 | 1] = ' ';
    }

    // move the cursor to (0, 0)
    move_cursor(0);
}
