#include "lib/log.h"

void main(void) {
    log_init();
    log_emit(LOG_LEVEL_INFO, "hello world!");
}
