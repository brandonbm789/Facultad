	.text
	N:       .dword 1024	// Number of elements in the vectors
	
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
	mov 	x1, 0
	mov 	x0, 0
	bl	m5_dump_stats
// 	for(j = 0; j < 1024; j++) {
// 		for(i = 0; i < 10; i++) {
//			if(i > 5) {				//b_if1
//				x = True;
//			}
//			if(x) {					//b_if2
//				i = 10;
//			}
//		}							//b_loop
// 	}
// Cicla 6 veces, y la 7ma termina.
// Es mejor el predictor global porque son 3 predicciones
// por ciclo.
// b_loop: [T,T,T,T,T,T,T,NT] los dos predictores deducen T
// b_if1:  [NT,NT,NT,NT,NT,NT,T] los dos predictores deducen NT
// b_if2:  [NT,NT,NT,NT,NT,NT,T] local predice NT, pero global
// predice T de estar en caliente. Porque depende de b_if1.
// Con este ejemplo el predictor de torneo eligiria siempre 
// al global sobre el local, por la falla que tuvo de mas el
// local en b_if2. Por lo que rinde igual al global.
// El ciclo de j < 1024 lo pense para que se caliente el predictor global.

//---------------------- CODE HERE ------------------------------------

	ldr x7, N
begin:
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

	sub x7, x7, 1	// para el loop grande
	cmp x7, #0
	b.gt begin

//---------------------- END CODE -------------------------------------

	mov 	x0, 0
	mov 	x1, 0
	bl	m5_dump_stats
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
