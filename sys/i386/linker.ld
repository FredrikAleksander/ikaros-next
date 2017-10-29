ENTRY (_start)

SECTIONS
{
	. = 0xC0100000;
	__start = .;
	__text_start = .;
	.text ALIGN (4K) : AT (ADDR (.text) - 0xC0000000)
	{
		*(.multiboot)
		*(.init)
		*(.text)
	}
	. = ALIGN(4096); /* align to page size */
    __text_end = .;

	__rodata_start = .;
	.rodata ALIGN (4K) : AT (ADDR (.rodata) - 0xC0000000)
	{
		*(.rodata)
	}
	. = ALIGN(4096); /* align to page size */
    __rodata_end = .;

	__data_start = .;
	.data ALIGN (4K) : AT (ADDR (.data) - 0xC0000000)
	{
		*(.data)
	}
	. = ALIGN(4096); /* align to page size */
    __data_end = .;

	__bss_start = .;
	.bss ALIGN (4K) : AT (ADDR (.bss) - 0xC0000000)
	{
		*(COMMON)
		*(.bss)
		*(.bootstrap_stack)
	}
	. = ALIGN(4096); /* align to page size */
	__bss_end = .;

	__fini_start = .;
	.fini ALIGN (4K) : AT (ADDR (.fini) - 0xC0000000)
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