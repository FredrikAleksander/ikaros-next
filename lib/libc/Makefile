TARGET?=x86_64-ikaros
TARGETARCH?=$(shell ../../scripts/arch-from-target.sh $(TARGET))
ARCHDIR=$(TARGETARCH)
BUILDDIR?=build/$(TARGET)
DESTDIR?=../../sysroot
BSP?=

CC=$(TARGET)-gcc
AR=$(TARGET)-ar
RANLIB=$(TARGET)-ranlib

CFLAGS=$(ARCH_CFLAGS) -O2 -std=c99 -Wall -Wextra -nostdlib
LDFLAGS=-nostdlib

CRT_ASM_SOURCES=$(wildcard $(ARCHDIR)/crt/*.S)
CRT_SOURCES=$(wildcard $(ARCHDIR)/crt/*.c)
ASM_SOURCES=$(wildcard $(ARCHDIR)/src/*.S)
C_SOURCES=$(wildcard src/*.c) $(wildcard $(ARCHDIR)/src/*.c)

C_OBJS=$(C_SOURCES:%.c=$(BUILDDIR)/%.o)
ASM_OBJS=$(ASM_SOURCES:%.S=$(BUILDDIR)/%.o)
OBJS=$(ASM_OBJS) $(C_OBJS)
CRT_C_OBJS=$(CRT_C_SOURCES:%.c=$(BUILDDIR)/%.o)
CRT_ASM_OBJS=$(CRT_ASM_SOURCES:%.S=$(BUILDDIR)/%.o)
CRT_OBJS=$(CRT_C_OBJS) $(CRT_ASM_OBJS)
LIBC=$(BUILDDIR)/libc.a

C_DEPS=$(C_SOURCES:%.c=$(BUILDDIR)/%.d)
ASM_DEPS=$(ASM_SOURCES:%.S=$(BUILDDIR)/%.d)
CRT_ASM_DEPS=$(CRT_ASM_SOURCES:%.S=$(BUILDDIR)/%.d)
CRT_C_DEPS=$(CRT_SOURCES=%.c=$(BUILDDIR)/%.d)

.SUFFIXES: .o .c .S .d
.PHONY: all clean install install-headers install-libs

all: $(LIBC) $(CRT_OBJS)

$(BUILDDIR)/%.d: %.S
	@mkdir -p $(BUILDDIR)/$(shell dirname "$^")
	@$(CC) $(CFLAGS) $< -MM -MT $(@:%.d=%.o) > $@

$(BUILDDIR)/%.d: %.c
	@mkdir -p $(BUILDDIR)/$(shell dirname "$^")
	@$(CC) $(CFLAGS) $< -MM -MT $(@:%.d=%.o) > $@

%.o:
	$(CC) -c $^ -o $@ $(CFLAGS)

$(LIBC): $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $<
clean:
	rm -f $(LIBC) $(CRT_OBJS) $(OBJS)
install-headers:
	mkdir -p $(DESTDIR)/usr/include
	cp -Rf $(wildcard ../../include/*.h) $(DESTDIR)/usr/include
install-libs: $(LIBC) $(CRT_OBJS)
	mkdir -p $(DESTDIR)/usr/lib
	cp -f $(LIBC) $(DESTDIR)/usr/lib
	cp -f $(CRT_OBJS) $(DESTDIR)/usr/lib
install: install-headers install-libs

-include $(CRT_ASM_SOURCES:%.S=$(BUILDDIR)/%.d)
-include $(CRT_C_SOURCES:%.c=$(BUILDDIR)/%d)
-include $(C_SOURCES:%.c=$(BUILDDIR)/%.d)
-include $(ASM_SOURCES:%.S=$(BUILDDIR)/%.d)