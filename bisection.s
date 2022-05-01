//Adam Woo
//I pledge my Honor that I have abided by the Stevens Honor System.

.text
.global _start
.extern printf

_start:
    B L1
    
L1:
    ADR X0, a
    LDUR D23, [X0, 0]
    ADR X0, b
    LDUR D24, [X0, 0]
    FADD D25, D23, D24
    FMOV D0, 2.0
    FDIV D25, D25, D0
    BL c
    B last
    ADR X0, t
    LDUR D0, [X0, 0]
    FCMP D19, D0
    B.LS last
    FCMP D19, 0
    B.LT changea
    FCMP D19, 0
    B.GT changeb
    B L1

changea:
    ADR X0, a
    STUR D25, [X0, 0]
    B L1

changeb:
    ADR X0, b
    STUR D25, [X0, 0]
    B L1

c:
    SUB SP, SP, 8
    STUR LR, [SP, 0]
    FMOV D19, 1.0 //sum
    FMOV D1, 1.0
    FSUB D19, D19, D1
    LDR X19, N //exponent
    ADR X21, coeff
    BL calculate
    LDUR LR, [SP, 0]
    ADD SP, SP, 8
    BR LR
    
calculate:
    SUB SP, SP, 8
    STUR LR, [SP, 0]
    BL full
    SUB X19, X19, 1
    ADD X21, X21, 8
    CMP X19, 0
    B.GE calculate
    LDUR LR, [SP, 0]
    ADD SP, SP, 8
    BR LR

full:
    SUB SP, SP, 8
    STUR LR, [SP, 0]
    MOV X22, X19
    FMOV D21, 1.0 // total
    FMOV D22, D25 
    BL with
    LDUR D1, [X21, 0]
    FMUL D21, D21, D1
    FADD D19, D19, D21
    LDUR LR, [SP, 0]
    ADD SP, SP, 8
    BR LR
    
with:
    CMP X22, 0
    B.EQ without
    FMUL D21, D21, D22
    SUB X22, X22, 1
    CMP X22, 0
    B.GT with
    BR LR
    
without:
    FMOV D21, 1.0
    BR LR


last:
    ADR X0, msg
    FMOV D0, D25
    BL printf

    MOV X0, 0
	MOV W8, 93
	SVC 0


.data

coeff:
    .double 0.2, 1.9, -0.3, 3.1, 0.2
N:
    .dword 4

a:
    .double -1.0
b:
    .double 1.0
    
t:
    .double 0.01
    
    
msg: .ascii "Total: %lf\n\0"



.end

