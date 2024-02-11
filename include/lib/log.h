#ifndef LOG_H
#define LOG_H

typedef unsigned char log_level_t;

#define LOG_LEVEL_INFO 0
#define LOG_LEVEL_ERROR 1

void log_init(void);

void log_emit(log_level_t level, char *s);

#endif
