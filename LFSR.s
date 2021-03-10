.global main

.text
main:
	xor %rax,%rax
	movq $0xa83ef90aa31bcde8, %rax			#...seed
	movq $100,%rcx					#...make a hundred calls of the same function using its return value as the seed
rep:
	pushq %rcx
	call lfsr
	popq %rcx
	loop rep
	ret

lfsr:
	movq %rax, %rbx
	movq %rax, %rcx
	movq %rax, %rdx
	shl $63, %rbx 
	shl $31, %rcx 
	shl $20, %rdx 
	xor %rdx, %rcx
	xor %rcx, %rbx
	shld $1, %rbx, %rax
	movq $fmt, %rdi
	movq %rax, %rsi
	pushq %rax
	xor %rax,%rax
	call printf
	popq %rax
	ret
fmt:
	.asciz "%llu\n"
