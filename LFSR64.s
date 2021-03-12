.global main
# Directive to create a maximal length 64-bit LFSR...
# The Random Number seed is repeated after 2^64 - 1 cycles!!!

.text
main:
	xor %rax,%rax
	mov start_state, %rax				#...Seed. Must NOT be Zero!
	movq $0,%rcx						

#	2^64 - 1 is too Large! To check if it's a random number and not just and infinite loop
# 	...stop at an arbitary number of cycles like 2^36 and see if the current value 
# 	...is different from it's start state
	movq $0xFFFFFFFFF, %rdx			    #...Check infinite loops, stop at 2^36

# loop to count how many different none repeating random numbers
rep:
	pushq %rcx
#	Repetitively make calls of the same function using its return value as the seed.
#	Stop when the seed value repeats or at some arbitrary length.
	call lfsr							
	popq %rcx
	inc %rcx
	cmp %rcx, %rdx
	je break_loop
	cmp start_state, %rax
	jne rep

break_loop:
# 	Print the Number of cycles so far...
	movq $fmt, %rdi
	movq %rcx, %rsi
	pushq %rax
	call printf
	popq %rax
# 	Print the Starting Value the seed/start_state...
	movq $fmt, %rdi
	movq start_state, %rsi
	pushq %rax
	call printf
	popq %rax
# 	Print the Current Value...
	movq $fmt, %rdi
	movq %rax, %rsi
	pushq %rax
	call printf
	popq %rax
#	Return...
	ret

# function: Linear Feedback Shift Register...
lfsr:
	movq %rax, %rbx
	movq %rax, %rcx
	# x^64 + x^44 + x^33 + 1 (mod 2)
	shrq $31, %rbx 
	shrq $20, %rcx 
	xorq %rbx, %rcx
	xorq %rax, %rcx
	shrd $1, %rcx, %rax
	ret

.data
fmt:
	.asciz "%llu\n"
start_state:
	.quad 0xa83ef90aa31bcde8
