.text
.global _start
.extern printf
.extern scanf
_start:
	SUB SP, SP, #8
	LDR X0, =scan
	LDR X1, =num
	BL scanf
	LDR X1, =num
	LDUR X21, [X1, #0]
	ADR X19, arr
	LDR X20, arr_len
	MOV X22, #0 // left index
	MOV X26, #0
	SUB X23, X20, #1 // right index
	B while_

while_:
   	SUBS XZR, X22, X23
    	B.GT notfound
    	ADD X25, X23, X22
    	LSR X25, X25, #1
    	LSL X26, X25, #3
    	ADD X28, X19, X26
    	LDUR X27, [X28, 0] // The value of mid
    	SUBS XZR, X27, X21
  	B.EQ found
	B.GT upright
	B upleft
    
upleft:
	ADD X25, X25, #1
	MOV X22, X25
	B while_

upright:
	SUB X25, X25, #1
	MOV X23, X25
	B while_
    
found:
	ADR X0, msgs
	MOV X1, X25
	BL printf

	MOV X0, 0
	MOV W8, 93
	SVC 0
    
notfound:
	ADR X0, msgf
	BL printf

	MOV X0, 0
	MOV W8, 93
	SVC 0
	
.data
	arr: .dword 2, 3, 4, 5, 6, 7
	arr_len: .quad 6
	num: .dword 0

	msgs: .ascii "Query was found in element: %d\n\0"
	msgf: .ascii "Query was not found\n\0"
	scan: .ascii "%d"

.end

