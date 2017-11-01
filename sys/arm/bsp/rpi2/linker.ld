ENTRY(_start)
 
SECTIONS
{
    /* Starts at LOADER_ADDR. */
    . = 0x8000;
    __start = .;
    __text_start = .;
    .text :
    {
        KEEP(*(.text.boot))
        *(.text)
    }
    . = ALIGN(4096); /* align to page size */
    __text_end = .;
 
    __rodata_start = .;
    .rodata :
    {
        *(.rodata)
    }
    . = ALIGN(4096); /* align to page size */
    __rodata_end = .;
 
    __data_start = .;
    .data :
    {
        *(.data)
    }
    . = ALIGN(4096); /* align to page size */
    __data_end = .;
 
    __bss_start = .;
    .bss :
    {
        bss = .;
        *(.bss)
    }
    __bss_end = .;
	.init_array :
	{
		crti.o(.init_array)
		KEEP (*(SORT(EXCLUDE_FILE(crti.o crtn.o) .init_array.*)))
		KEEP (*(EXCLUDE_FILE(crti.o crtn.o) .init_array))
		crtn.o(.init_array)
	}
	.fini_array :
	{
		crti.o(.fini_array)
		KEEP (*(SORT(EXCLUDE_FILE(crti.o crtn.o) .fini_array.*)))
		KEEP (*(EXCLUDE_FILE(crti.o crtn.o) .fini_array))
		crtn.o(.fini_array)
	}
    __end = .;
}