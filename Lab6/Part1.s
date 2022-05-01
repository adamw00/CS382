.text
.global _start
.extern printf

_start:
	mov X1, #3	//set g
	mov X2, #4	//set i
	SUB X3, X2, #4	//i-4
	CBNZ X3, L2	//if i==0?
	ADD X4, X1, #1
	
L1: B L3		//skips over L2 (only runs L2 if CBNZ)
L2: SUB X4, X1, #2
L3:	ADR x0, string
	mov X1, X4
	bl printf
	
	mov x0, #0
	mov w8, #93
	svc #0

	
.data
	string:
	.ascii "value of f = %d\n\0"
.end
