//Adam Woo
//I pledge my Honor that I have abided by the Stevens Honor System.

.text
.global _start
.extern printf

_start:
	mov x8, #0  
	mov x9, #0
	adr x0, max
	ldur d11, [x0]
	fmov d9, d11
	adr x0, min
	ldur d11, [x0]
	fmov d14, d11
	adr x0, x
	adr x1, y
	mov x3, #0
	mov x21, #0
	mov x4, #1
	mov x22, #1
	bl inner

outer:
	add x8, x8, #1
	mov x9, x8
	add x9, x9, #1
	cmp x8, #8
	bge exit
	bl inner

inner:
	mov x11, #8
	mul x10, x8, x11
	ldr d10, [x0, x10]
	ldr d11, [x1, x10]
	
	mul x10, x9, x11
	ldr d12, [x0, x10]
	ldr d13, [x1, x10]
	cmp x9, #8
	bge outer
	bl dist

index:
	add x9, x9, #1
	bl inner
	
updatemin:
	fmov d14, d11
	mov x21, x8
	mov x20, x9
	bl index
	
updatemax:
	fmov d9, d11
	mov x3, x8
	mov x4, x9
	bl index
	
dist:
	fsub d10, d10, d12
	fmul d10, d10, d10
	fsub d11, d11, d13
	fmul d11, d11, d11
	fadd d11, d10, d11
	fcmp d11, d9
	bge updatemax
	fcmp d11, d14
	blt updatemin
	bl index

exit:
	ldr x0, =msgmax
	mov x1, x3
	mov x2, x4
	bl printf
	ldr x0, =msgmin
	mov x1, x21
	mov x2, x20
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0

.data
N:
	.dword 7
max: 
	.double 0.0
min: 
	.double 2147483647
	

x:
	.double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 10.9303, 8.4813, 2.6505
y:
	.double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 11.4057, 5.0371, 4.1196
msgmax:
	.ascii "Largest x,y is: %d,%d \n\0"
msgmin:
	.ascii "Smallest x,y is: %d,%d \n\0"

.end

