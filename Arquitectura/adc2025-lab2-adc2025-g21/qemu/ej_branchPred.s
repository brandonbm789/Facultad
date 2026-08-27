	.text
	
	.bss 

	.arch armv8-a
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp

//---------------------- CODE HERE ------------------------------------

	mov x5, #0		// i = 0
	mov x1, #0		// X = False

loop:
	cmp x5, #5		// para i > 5
	b.le end_if1
	mov x1, #1		// X = True
end_if1:
	cmp x1, #1		// para X == True
	b.ne end_if2
	mov x5, #10		// i = 10
end_if2:
	add x5, x5, #1	// i++
	cmp x5, #10		// para i < 10
	b.lt loop

//---------------------- END CODE -------------------------------------

	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
