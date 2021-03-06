include x86/make.inc

CFLAGS+=-mno-mmx -mno-sse -mno-sse2 -Ii386/include

CRT_ASM_SOURCES+=\
	$(wildcard i386/crt/*.S)
CRT_C_SOURCES+=\
	$(wildcard i386/crt/*.c)
KERNEL_ASM_SOURCES+=\
	$(wildcard i386/boot/*.S)
KERNEL_SOURCES+=\
	$(wildcard i386/boot/*.c)
LINK_LIST_START=\
	$(BUILDDIR)/i386/crt/crti.o \
	$(BUILDDIR)/i386/crt/crtbegin.o
LINK_LIST_END=\
	$(BUILDDIR)/i386/crt/crtend.o \
	$(BUILDDIR)/i386/crt/crtn.o

LINKER_SCRIPT=i386/linker.ld