#ifndef __SYS__LIBK_H
#define __SYS__LIBK_H 1

#include <sys/cdefs.h>

#ifdef __KERNEL

int strncmp(const char* __restrict src, const char* __restrict dst, size_t num);
int strncasecmp(const char* __restrict src, const char* __restrict dst, size_t num);

#endif

#endif