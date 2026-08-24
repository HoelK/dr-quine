BITS 64
extern printf

; Comment 1

global main
section .text

main:
	; Comment 0
	SUB rsp, 8
	CALL ret_str
	ADD rsp, 8
	MOV rdi, rax
	MOV esi, 10
	MOV edx, 9
	MOV ecx, 34
	LEA r8, [rel s]
	SUB rsp, 8
	CALL printf
	ADD rsp, 8
	XOR rax, rax
	RET

ret_str:
	MOV rax, s
	RET

section .data
	s: db "BITS 64%1$cextern printf%1$c%1$c; Comment 1%1$c%1$cglobal main%1$csection .text%1$c%1$cmain:%1$c%2$c; Comment 0%1$c%2$cSUB rsp, 8%1$c%2$cCALL ret_str%1$c%2$cADD rsp, 8%1$c%2$cMOV rdi, rax%1$c%2$cMOV esi, 10%1$c%2$cMOV edx, 9%1$c%2$cMOV ecx, 34%1$c%2$cLEA r8, [rel s]%1$c%2$cSUB rsp, 8%1$c%2$cCALL printf%1$c%2$cADD rsp, 8%1$c%2$cXOR rax, rax%1$c%2$cRET%1$c%1$cret_str:%1$c%2$cMOV rax, s%1$c%2$cRET%1$c%1$csection .data%1$c%2$cs: db %3$c%4$s%3$c, 0%1$c", 0
