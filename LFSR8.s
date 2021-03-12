.global main
#	Convert to 8 bits and debug
.text
main:
	xor %rax,%rax
	mov start_state, %al			#...seed
	xorb %cl, %cl
rep:
	push %rcx
	call lfsr
	pop %rcx
	inc %cl
	cmp start_state, %al
	jne rep
	mov $fmt, %edi
	movzx %cl, %esi
	push %rax
	call printf
	pop %rax
	ret

lfsr:
	movb %al, %bl
	movb %al, %cl
	movb %al, %dl
	# x^8 + x^6 + x^5 + x^4 + 1 (mod 2)
	shrb $2, %bl 
	shrb $3, %cl 
	shrb $4, %dl 
	xorb %bl, %cl
	xorb %cl, %dl
	xorb %al, %dl
	shrb $1, %al
	shlb $7, %dl
	orb %dl,%al
	ret
.data
start_state:
	.int 255
fmt:
	.asciz "%d\n"
