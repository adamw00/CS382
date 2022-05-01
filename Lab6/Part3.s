.text
.global _start
.extern printf

_start:
	mov X1, #10
	mov X2, #0
	
L1: 	CBZ X1, Exit
	ADD X2, X2, X1
	SUB X1, X1, #1
	B L1
Exit:

	ADR x0, string
	mov X1, X2
	bl printf
	
	mov x0, #0
	mov w8, #93
	svc #0

	
.data
	string:
	.ascii "Sum of 1 to 10 = %d\n\0"
.end
