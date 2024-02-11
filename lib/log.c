#include "lib/log.h"

#include "drivers/vga.h"

static unsigned short current_line = 0;

void log_init(void) {
    clear_screen(WHITE_ON_BLACK);
    set_cursor(0);
}

void log_emit(log_level_t level, char *s) {
    unsigned char attr = WHITE_ON_BLACK;
    if (level == LOG_LEVEL_ERROR) {
        attr = GREEN_ON_BLACK;
    }
    unsigned int offset = current_line * SCREEN_WIDTH;
    put_string("> ", offset, attr);
    put_string(s, offset + 2, attr);
    set_cursor(offset + SCREEN_WIDTH);
}
