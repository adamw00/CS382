.text
.global _start
.extern printf

_start:
	mov X1, #7	//set a
	mov X2, #7	//set b
	ADD X3, X1, X2	//a+b
	SUB X8, X3, #14	//a+b-14
	CBNZ X8, L2	//if a+b == 0
	mov X10, #3
	
L1: B L3		//skips over L2 (only runs L2 if CBNZ)
L2: mov X10, #-2
L3:	ADR x0, string
	mov X1, X10
	bl printf
	
	mov x0, #0
	mov w8, #93
	svc #0

	
.data
	string:
	.ascii "value of c = %d\n\0"
.end
