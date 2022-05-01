.text
.global _start

_start:
	ADR X22, P	//TAKES IN DATA FOR X22
	ADR X10, PLength	
	LDUR X6, [X10, #0] //LENGTH OF ARRAY IN X6
	BL sort	//CALLS FIND FUNC

swap:
	//loading values
	LDUR X9, [SP, #0]	//X22
	LSL X1, X5, #3		//min_idx *= 8
	ADD X9, X9, X1
	LDUR X11, [X9, #0]	//arr[min_idx]
	SUB X9, X9, X1

	LSL X0, X3, #3		// i *= 8
	ADD X9, X9, X0
	LDUR X12, [X9, #0]	//arr[i]
	SUB X9, X9, X0

	//swapping
	MOV X2, X11		//temp = X11
	MOV X11, X12	//X11 = X12
	MOV X12, X2		//X12 = temp

	//storing values
	ADD X9, X9, X1
	STR X11, [X9, #0]	//arr[min_idx]
	SUB X9, X9, X1

	ADD X9, X9, X0
	STR X12, [X9, #0]	//arr[i]
	SUB X9, X9, X0

	STUR X9, [SP, #0]	//store updated X22

	BR X30	//return

sort:
	MOV X3, #0 //iterator i
	MOV X4, #0 //iterator j
	MOV X5, #0 //min_idx
	
	BL L1	//start loop
	BR X30	//end

L1:
	SUB X20, X6, #1		//n-1
	SUBS X10, X3, X20		
	BGT printIt				//if i > n-1 exit loop
	MOV X5, X3				//min_idx = i		
	MOV X4, X3				
	ADD X4, X4, #1			//j = i + 1
L2:
	SUBS X10, X4, X6
	BGT cont1			//if j>n break
	LSL X0, X4, #3		//j *= 8
	LSL X1, X5, #3		//min_idx *= 8

	ADD X22, X22, X0
	LDUR X7, [X22, #0]	//arr[j]
	SUB X22, X22, X0
	ADD X22, X22, X1
	LDUR X8, [X22, #0]	//arr[min_idx]
	SUB X22, X22, X1

	SUBS X10, X7, X8	// if (arr[j] < arr[min_idx])
	BGT cont2
	MOV X5, X4

cont2:	//continues inner loop
	ADD X4, X4, #1		//increment j
	B L2				//inner loop

cont1:	//continues outer loop
	SUB SP, SP, #8		//start SP
	STUR X22, [SP, #0]	//add array to SP
	BL swap				//swap
	LDUR X22, [SP, #0]	//update array from SP
	ADD SP, SP, #8		//remove SP
	ADD X3, X3, #1		//increment i
	B L1				//outer loop

done:
	MOV X24, #0 	// x=0 
	B printIt
	
printIt:
	
	SUB X26, X24, X6
	CBZ X26, end	//x == n break
	LSL X25, X24, #3
	ADR X0, msg

	ADD X22, X22, X25
	LDUR X1, [X22, #0]
	SUB X22, X22, X25

	BL printf
	ADD X24, X24, #1
	B printIt

end:
	LDR X0, =print_num	//PRINTING AND STUFFS
	BL printf
	MOV X0, #0
	MOV w8, #93
	SVC #0

	
.data
msg:
	.ascii "%d "	
print_num:
	.ascii "\n\0"
		
PLength:
	.quad 5
P:
	.quad 10,2,6,4,8

	
