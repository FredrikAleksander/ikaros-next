CFLAGS+=-Iarm/bsp$(BSP)/include

KERNEL_ASM_SOURCES+=\
	$(wildcard arm/bsp$(BSP)/boot/*.S)
KERNEL_SOURCES+=\
	$(wildcard arm/bsp$(BSP)/boot/*.c)
LINKER_SCRIPT=arm/bsp$(BSP)/linker.ld