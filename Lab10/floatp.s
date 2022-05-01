// Adam Woo
// I pledge my Honor that I have abided by the Stevens Honor System.
// y = 2.5x^3 -15.5x^2 + 20x + 15
// interval [-0.5,5]

.text
.global _start
.extern printf


_start:
	ADR X16, n
	LDUR D16, [X16, #0]
	ADR X17, a
	LDUR D17, [X17, #0]
	MOV X0, #0
	FMOV D18, X0
loop:
	FMUL D3, D17, D17
	FMUL D3, D3, D17
	
	FMOV D10, #2.5
	FMUL D3, D3, D10
	FMUL D4, D17, D17
	
	FMOV D10, #15.5
	FMUL D4, D4, D10
	
	FMOV D10, #20
	FMUL D5, D17, D10
	FSUB D3, D3, D4
	
	FMOV D10, #15
	FADD D5, D5, D10
	FADD D3, D3, D5
	FADD D18, D18, D3
	
	FMOV D10, #0.5
	FADD D17, D17, D10
	
	SUBS X16, X16, #11
	B.GE loop
    
	ADR X0, msg
	FMOV D0, D17
	ADR X1, result
	LDUR D1, [X1, #0]
	FSUB D2, D0, D1
    
	BL printf
    
	MOV X0, #0
	MOV W8, #93
	SVC #0
	





.data
a: .double -0.5 // left limit
b: .double  5   // right limit
n: .double  11  // # of rectangles
msg: .ascii "The approximation is %lf\nThe actual value is %lf\nThe difference is %lf\n\0"
result: .double   74.1067708333333

.bss
r: .skip   74// result of the integral

.end
