TARGET?=x86_64-ikaros
TARGETARCH?=$(shell ../scripts/arch-from-target.sh $(TARGET))
ARCHDIR=$(TARGETARCH)
BUILDDIR?=build/$(TARGET)
DESTDIR?=../sysroot
BSP?=rpi2
CC=$(TARGET)-gcc
AR=$(TARGET)-ar
RANLIB=$(TARGET)-ranlib

CFLAGS=-O2 -ffreestanding -nostdlib -D_KERNEL -std=c99 -Wall -Wextra -I$(shell pwd)
LDFLAGS=-ffreestanding -nostdlib

CRT_ASM_SOURCES=
CRT_C_SOURCES=
KERNEL_ASM_SOURCES=
KERNEL_SOURCES=
LINK_LIST_START=
LINK_LIST_END=
LINKER_SCRIPT=

include $(ARCHDIR)/make.inc

KERNEL_C_OBJS=$(KERNEL_SOURCES:%.c=$(BUILDDIR)/%.o)
KERNEL_ASM_OBJS=$(KERNEL_ASM_SOURCES:%.S=$(BUILDDIR)/%.o)
KERNEL_OBJS= \
	$(KERNEL_C_OBJS) \
	$(KERNEL_ASM_OBJS)
KERNEL=$(BUILDDIR)/ikaros-$(TARGETARCH).elf

CRTBEGIN_OBJ:=$(shell $(CC) $(CFLAGS) -print-file-name=crtbegin.o)
CRTEND_OBJ:=$(shell $(CC) $(CFLAGS) -print-file-name=crtend.o)

LINK_LIST=\
	$(LINK_LIST_START) \
	$(KERNEL_OBJS) \
	$(LINK_LIST_END)

.SUFFIXES: .o .c .S
.PHONY: all clean install install-headers install-kernel

all: $(KERNEL)

%.o: %.c %.S
	$(CC) -c $^ -o $@ $(CFLAGS)

$(BUILDDIR)/%.d: %.S
	@mkdir -p $(BUILDDIR)/$(shell dirname "$<")
	-@$(CC) $(CFLAGS) $< -MM -MT $(@:%.d=%.o) > $@

$(BUILDDIR)/%.d: %.c
	@mkdir -p $(BUILDDIR)/$(shell dirname "$<")
	-@$(CC) $(CFLAGS) $< -MM -MT $(@:%.d=%.o) > $@

$(KERNEL): $(LINK_LIST)
	$(CC) -o $@ -T $(LINKER_SCRIPT) $(LDFLAGS) $(LINK_LIST)

clean:
	rm -f $(KERNEL)
	rm -f $(KERNEL_OBJS)

install-headers:
	echo $(BUILDDIR)/$(ARCHDIR)/crt/crtbegin.o
	mkdir -p $(DESTDIR)/usr/include/sys
	cp -Rf $(wildcard sys/*.h) $(DESTDIR)/usr/include/sys

install-kernel: $(KERNEL)
	mkdir -p $(DESTDIR)/boot
	cp $(KERNEL) $(DESTDIR)/boot/kernel

install: install-headers install-kernel

-include $(CRT_ASM_SOURCES:%.S=$(BUILDDIR)/%.d)
-include $(CRT_C_SOURCES:%.c=$(BUILDDIR)/%.d)
-include $(KERNEL_SOURCES:%.c=$(BUILDDIR)/%.d)
-include $(KERNEL_ASM_SOURCES:%.S=$(BUILDDIR)/%.d)
