#ifndef VGA_H
#define VGA_H

#define VGA_BUFFER 0xb8000

#define SCREEN_WIDTH  80
#define SCREEN_HEIGHT 25

#define WHITE_ON_BLACK 0x0f
#define GREEN_ON_BLACK 0x04

#define REG_VGA_CTLR 0x3d4
#define REG_VGA_DATA 0x3d5

void clear_screen(unsigned char attr);

void put_string(char* s, unsigned int offset, unsigned char attr);

void set_cursor(unsigned int offset);

#endif
