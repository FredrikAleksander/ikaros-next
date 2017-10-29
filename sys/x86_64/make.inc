include 	x86/make.inc

CFLAGS+=-mno-red-zone -mno-mmx -mno-sse -mno-sse2 -Ix86_64/include

CRT_ASM_SOURCES+=\
	$(wildcard x86_64/crt/*.S)
CRT_C_SOURCES+=\
	$(wildcard x86_64/crt/*.c)
KERNEL_ASM_SOURCES+=\
	$(wildcard x86_64/boot/*.S)
KERNEL_SOURCES+=\
	$(wildcard x86_64/boot/*.c)
LINK_LIST_START=\
	$(BUILDDIR)/x86_64/crt/crti.o \
	$(BUILDDIR)/x86_64/crt/crtbegin.o
LINK_LIST_END=\
	$(BUILDDIR)/x86_64/crt/crtend.o \
	$(BUILDDIR)/x86_64/crt/crtn.o

LINKER_SCRIPT=x86_64/linker.ld