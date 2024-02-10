#ifndef VGA_H
#define VGA_H

#define VGA_BUFFER 0xb8000

#define SCREEN_WIDTH  80
#define SCREEN_HEIGHT 25

#define GREEN_ON_BLACK 0x02

#define REG_VGA_CTLR 0x3d4
#define REG_VGA_DATA 0x3d5

void move_cursor(unsigned int offset);
void clear();

#endif
