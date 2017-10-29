.section .text

.global _start
_start:
	# ELF SystemV ABI.  Stack pointer points to 
	# argc, argv is located at %esp + 4,
	# and envp is located at %esp + 4 + 4 * argc.
	# Following envp are any auxiliary vectors.

	# Initialiaze stack frame list
	movl $0, %ebp
	pushl %ebp # eip=0
	pushl %ebp # ebp=0
	movl %esp, %ebp

	pushl %edx

	# Setup arguments
	movl (%esp), %edi # argc = [esp]
	movl %esp,   %esi # esi  = esp
	addl $4,     %esi # argv = esi + 4
	movl $4,     %ecx
	movl %edi,   %eax # eax  = argc
	mull %ecx         # eax *= 4
	movl %eax, %edx   # edx  = eax
	addl $4, %edx     # envp = edx + 4

	popl %ecx 

	# Preserve the arguments for calling main later
	pushl %edx
	pushl %esi
	pushl %edi

	call _crt_init # Initialize C library
	call _init     # Call global constructors
	call _crt_main
	
	movl %eax, %edi # exit_code = <Main return value>
	pushl %edi
	call exit
	popl %edi
	call _Exit
.size _start, . - _start