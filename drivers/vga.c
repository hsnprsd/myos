#include "drivers/vga.h"

unsigned char port_byte_in(unsigned short port) {
    unsigned char result ;
    __asm__("in %%dx, %%al" : "=a"(result) : "d"(port));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
    __asm__("out %%al, %%dx" : : "a"(data), "d"(port));
}

void clear_screen(unsigned char attr) {
    unsigned short* buf = (unsigned short*)VGA_BUFFER;
    for (unsigned int i = 0; i < SCREEN_HEIGHT * SCREEN_WIDTH; i++) {
        buf[i] = ' ' | (attr << 8);
    }
}

void put_string(char *s, unsigned int offset, unsigned char attr) {
    unsigned short* buf = (unsigned short*)VGA_BUFFER;
    for (unsigned int i = 0; s[i]; i++, offset++) {
        buf[offset] = s[i] | (attr << 8);
    }
}

void set_cursor(unsigned int offset) {
    port_byte_out(REG_VGA_CTLR, 0xe);
    port_byte_out(REG_VGA_DATA, offset >> 8);
    port_byte_out(REG_VGA_CTLR, 0xf);
    port_byte_out(REG_VGA_DATA, offset);
}
