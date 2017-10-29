include arm/bsp$(BSP)/make.inc

CFLAGS+=-Iarm/include

CRT_ASM_SOURCES+=\
	$(wildcard arm/crt/*.S)
CRT_C_SOURCES+=\
	$(wildcard arm/crt/*.c)
LINK_LIST_START=\
	$(BUILDDIR)/arm/crt/crti.o \
	$(BUILDDIR)/arm/crt/crtbegin.o
LINK_LIST_END=\
	$(BUILDDIR)/arm/crt/crtend.o \
	$(BUILDDIR)/arm/crt/crtn.o