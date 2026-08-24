BITS 64
global main
extern exit
extern fopen
extern fprintf
extern fclose
extern printf

; Comment 0

section .text
%macro OPEN 0
		LEA rdi, [rel filename]
		LEA rsi, [rel mode]
		SUB rsp, 8
		CALL fopen
		TEST rax, rax
		JZ .error
%endmacro

%macro WRITE 0
		MOV rbx, rax
		MOV rdi, rax
		LEA rsi, [rel s]
		MOV edx, 10
		MOV ecx, 9
		MOV r8, 34
		LEA r9, [rel s]
		XOR rax, rax
		CALL fprintf
		TEST eax, eax
		JS .error
%endmacro

%macro CLOSE 0
		MOV rdi, rbx
		CALL fclose
		ADD rsp, 8
		TEST eax, eax
		JNZ .error
		RET
%endmacro

main:
		OPEN
		WRITE
		CLOSE

.error:
		MOV edi, 1
		CALL exit

section .data
	s: db "BITS 64%1$cglobal main%1$cextern exit%1$cextern fopen%1$cextern fprintf%1$cextern fclose%1$cextern printf%1$c%1$c; Comment 0%1$c%1$csection .text%1$c%%macro OPEN 0%1$c%2$c%2$cLEA rdi, [rel filename]%1$c%2$c%2$cLEA rsi, [rel mode]%1$c%2$c%2$cSUB rsp, 8%1$c%2$c%2$cCALL fopen%1$c%2$c%2$cTEST rax, rax%1$c%2$c%2$cJZ .error%1$c%%endmacro%1$c%1$c%%macro WRITE 0%1$c%2$c%2$cMOV rbx, rax%1$c%2$c%2$cMOV rdi, rax%1$c%2$c%2$cLEA rsi, [rel s]%1$c%2$c%2$cMOV edx, 10%1$c%2$c%2$cMOV ecx, 9%1$c%2$c%2$cMOV r8, 34%1$c%2$c%2$cLEA r9, [rel s]%1$c%2$c%2$cXOR rax, rax%1$c%2$c%2$cCALL fprintf%1$c%2$c%2$cTEST eax, eax%1$c%2$c%2$cJS .error%1$c%%endmacro%1$c%1$c%%macro CLOSE 0%1$c%2$c%2$cMOV rdi, rbx%1$c%2$c%2$cCALL fclose%1$c%2$c%2$cADD rsp, 8%1$c%2$c%2$cTEST eax, eax%1$c%2$c%2$cJNZ .error%1$c%2$c%2$cRET%1$c%%endmacro%1$c%1$cmain:%1$c%2$c%2$cOPEN%1$c%2$c%2$cWRITE%1$c%2$c%2$cCLOSE%1$c%1$c.error:%1$c%2$c%2$cMOV edi, 1%1$c%2$c%2$cCALL exit%1$c%1$csection .data%1$c%2$cs: db %3$c%4$s%3$c, 0%1$c%2$cfilename: db %3$cGrace_kid.s%3$c, 0%1$c%2$cmode: db %3$cw%3$c, 0%1$c", 0
	filename: db "Grace_kid.s", 0
	mode: db "w", 0
