.text
.global _start
.extern printf

_start:
	mov x1, #3
	mov x2, #4
	SUB x3, X2, #4
	CBNZ X3, L2
	ADD x7, x1, #1
	
L1: B L3
L2: SUB x7, X1, #2
L3:	ADR x0, str
	mov x1, x7
	bl printf
	
	mov x0, #0
	mov w8, #93
	svc #0

	
.data
	str:
	.ascii "value of f = %d\n\0"
.end
