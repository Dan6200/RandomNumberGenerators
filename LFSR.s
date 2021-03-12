.global main
#	Convert to 8 bits and debug
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
	movq %rax, %rcx
	movq %rax, %rdx
	# x^44 + x^32 + 1 (mod 2)
	shr $32, %rcx 
	shr $20, %rdx 
	xor %rdx, %rcx
	shrd $1, %rcx, %rax
	movq $fmt, %rdi
	movq %rax, %rsi
	pushq %rax
	xor %rax,%rax
	call printf
	popq %rax
	ret
fmt:
	.asciz "%llu\n"
