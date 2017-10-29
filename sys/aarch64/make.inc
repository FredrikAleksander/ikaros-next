include aarch64/bsp$(BSP)/make.inc

CFLAGS+=-Iaarch64/include

CRT_ASM_SOURCES+=\
	$(wildcard aarch64/crt/*.S)
CRT_C_SOURCES+=\
	$(wildcard aarch64/crt/*.c)
LINK_LIST_START=\
	$(BUILDDIR)/aarch64/crt/crti.o \
	$(BUILDDIR)/aarch64/crt/crtbegin.o
LINK_LIST_END=\
	$(BUILDDIR)/aarch64/crt/crtend.o \
	$(BUILDDIR)/aarch64/crt/crtn.o