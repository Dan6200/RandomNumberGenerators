.global main

.text
main:
	xor %rax,%rax
	movq $0xa83ef90aa31bcde8, %rax			#...seed
	movq $100,%rcx							#...make a hundred calls of the same function using its return value as the seed
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
	# x^44 + x^33 + x + 1 (mod 2)
	shr $63, %rbx 
	shr $31, %rcx 
	shr $20, %rdx 
	xor %rdx, %rcx
	xor %rcx, %rbx
	shrd $1, %rbx, %rax
	movq $fmt, %rdi
	movq %rax, %rsi
	pushq %rax
	xor %rax,%rax
	call printf
	popq %rax
	ret
fmt:
	.asciz "%llu\n"
