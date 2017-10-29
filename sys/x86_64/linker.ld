ENTRY (_start)

SECTIONS
{
	. = 1M;
	__start = .;
	__text_start = .;
	.text ALIGN (4K) : AT (ADDR (.text))
	{
		*(.multiboot)
		*(.init)
		*(.text)
	}
	. = ALIGN(4096); /* align to page size */
    __text_end = .;

	__rodata_start = .;
	.rodata ALIGN (4K) : AT (ADDR (.rodata))
	{
		*(.rodata)
	}
	. = ALIGN(4096); /* align to page size */
    __rodata_end = .;

	__data_start = .;
	.data ALIGN (4K) : AT (ADDR (.data))
	{
		*(.data)
	}
	. = ALIGN(4096); /* align to page size */
    __data_end = .;

	__bss_start = .;
	.bss ALIGN (4K) : AT (ADDR (.bss))
	{
		*(COMMON)
		*(.bss)
		*(.bootstrap_stack)
	}
	. = ALIGN(4096); /* align to page size */
	__bss_end = .;

	__fini_start = .;
	.fini ALIGN (4K) : AT (ADDR (.fini))
	{
		*(.fini)
	}
	. = ALIGN(4096); /* align to page size */
	__fini_end = .;
	
	.eh_frame : { *(.eh_frame) }
	.ctors : { *(.ctors) }
	.dtors : { *(.dtors) }
	. = ALIGN(4096);
	__end = .;
}