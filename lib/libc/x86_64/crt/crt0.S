.section .text

.global _start
.type _start,@function
_start:
	# Setup arguments
	movq (%rsp), %rdi # argc = [rsp]
	movq %rsp,   %rsi # rsi  = rsp
	addq $8,     %rsi # argv = rsi + 8
	movq $8,     %rcx
	movq %rdi,   %rax # rax  = argc
	mulq %rcx         # rax *= 8

	# Initialiaze stack frame list
	xorq  %rbp, %rbp
	pushq %rbp # rip=0
	pushq %rbp # rbp=0
	movq  %rsp, %rbp
	
	# Push dynamic linker finalizer
	pushq %rdx
	movq %rax, %rdx   # rdx  = rax
	addq $8, %rdx     # envp = rdx + 8
	addq %rsi, %rdx

	popq %rcx
	
	# Preserve the arguments for calling main later
	pushq %rdx
	pushq %rsi
	pushq %rdi

	call _crt_init # Initialize C library
	call _init     # Call global constructors
	call _crt_main
	xorq %rdi, %rdi
	movl %eax, %edi # exit_code = <Main return value>
	call exit
	call _Exit
.size _start, . - _start