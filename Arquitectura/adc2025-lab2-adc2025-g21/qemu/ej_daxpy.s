	.data
	N:       .dword 4096	// Number of elements in the vectors
	Alpha:   .double 2.0	// Scalar value declarado como punto flotante
	
	.bss 
	X: .zero  32768       	// Vector X(4096)*8
	Y: .zero  32768        	// Vector Y(4096)*8
    Z: .zero  32768        	// Vector Y(4096)*8

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

	ldr x0, N		// x0 contiene 4096
	ldr x10, =Alpha	// x10 contiene la dir de Alpha
	ldr x2, =X		// x2 contiene la dir del vector X
	ldr x3, =Y		// x3 contiene la dir del vector Y
	ldr x4, =Z		// x4 contiene la dir del vector Z

// Usar registros de punto flotante dx
//---------------------- CODE HERE ------------------------------------

	ldr d0, [x10]	// d0 = 2.0
	mov x5, #0		// x5 indice de bytes
	lsl x6, x0, #3	// x6 = 32768 los bytes a procesar

loop:
	cmp x5, x6		// Si indice de bytes >= bytes a procesar, salimos del loop
	b.ge end_loop

	ldr d1, [x2, x5]// d1 = valor en dir base X + offset 
	ldr d2, [x3, x5]// d2 = valor en dir base Y + offset
	
	// Z[i] = Alpha * X[i] + Y[i]
	fmul d1, d0, d1	// d1 = Alpha * X[i]
	fadd d1, d1, d2	// d1 = (Alpha * X[i]) + Y[i]
	str d1, [x4, x5]// En dir base de Z + offser = d1

	add x5, x5, #8	// Sig elemento, ++i
	b loop

end_loop:

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
