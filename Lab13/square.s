//Adam Woo
//I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start

_start:
    MOV X19, #0 //Counter for read
    MOV X5, #0 //Length
    MOV X16, #0 //sum
    MOV X17, #10

read:
    MOV X0, #0 
    MOV X8, #63
    MOV X2, #1
    ADR X1, arr
    ADD X1, X1, X19
    SVC #0
    LDR X4, [X1]
    ADD X19, X19, #1
    CMP X4, #10
    BEQ square
    CMP X4, #45
    BEQ read
    
    SUB X4, X4, #48 
    MOV X17, #10
    MUL X16, X16, X17
    ADD X16, X16, X4
    B read

square:
    MUL X16, X16, X16 //X^2
    MOV X5, #0
    B L1

L1:
    MOV X17, #10 		//x17 = 10
    UDIV  X15, X16, X17 	//x15 = x16/10
    MSUB  X14, X15, X17, X16 	//x16 % x17 
    UDIV  X16, X16, X17
    ADD X14, X14, #48
    ADR X1, arr
    ADD X1, X5, X1
    STR X14, [X1]
    ADD X5, X5, #1
    CMP X16, #0
    BNE L1
    ADR X1, arr
    ADD X1, X5, X1
    STR X17, [X1]
    B printer

printer:
    SUB X5, X5, #1 //sub x5 by 1
    MOV X8, #64 
    MOV X0, #1
    MOV X2, #1
    ADR X1, arr //address of arr in x1
    ADD X1, X1, X5 //adding the address of
    SVC #0
    CMP X5, #0 //comparing to see if it is zero if so then newline
    BGE printer
    ADR X1, arr
    STR X17, [X1] //newline as last
    SVC #0
    B exit

exit:
    MOV X0, #0 
    MOV X8, #93
    SVC #0

.data
str:
    .ascii "%d\n\0"
.bss
arr:
    .skip 1000
.end
