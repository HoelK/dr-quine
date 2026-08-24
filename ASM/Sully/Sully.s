BITS 64
global main
extern fopen
extern fclose
extern fprintf
extern sprintf
extern printf
extern system

%define count 5
%assign count_next count - 1
%defstr count_str count_next
%strcat n_raw "Sully_", count_str
%strcat n_file "Sully_", count_str, ".s"

section .text

main:
		MOV ecx, count
		CMP ecx, 0
		JLE .end
		SUB rsp, 8
		;CALL PART
		CALL file_creation
		CALL file_writing
		CALL file_closing
		CALL file_compilation
		CALL file_execute
		;END CALL PART
		ADD rsp, 8

.end:
		XOR rax, rax
		RET

file_creation:
		LEA rdi, [rel filename]
		MOV rsi, mode
		SUB rsp, 8
		CALL fopen
		ADD rsp, 8
		TEST rax, rax
		JZ .error
		MOV r12, rax ; Save file address in r12
		RET

.error:
		LEA rdi, [rel error_open]
		CALL error
		
file_writing:
		MOV rdi, r12
		LEA rsi, [rel source]
		MOV edx, 10
		MOV ecx, 9
		MOV r8, 34
		LEA r9, [rel source]
		PUSH count-1
		XOR rax, rax
		CALL fprintf
		ADD rsp, 8
		TEST rax, rax
		JS .error
		RET

.error:
		LEA rdi, [rel error_write]
		CALL error

file_closing:
		MOV rdi, r12
		SUB rsp, 8
		CALL fclose
		ADD rsp, 8
		TEST rax, rax
		JNZ .error
		RET

.error:
		LEA rdi, [rel error_close]
		CALL error

file_compilation:
		LEA rdi, [rel cmp]
		SUB rsp, 8
		CALL system
		ADD rsp, 8
		TEST rax, rax
		JNZ .error
		RET

.error:
		LEA rdi, [rel error_comp]
		CALL error

file_execute:
		LEA rdi, [rel exe]
		SUB rsp, 8
		CALL system
		ADD rsp, 8
		TEST rax, rax
		JNZ .error
		RET

.error:
		LEA rdi, [rel error_exec]
		CALL error

error:
		XOR rax, rax
		SUB rsp, 8
		CALL printf
		ADD rsp, 8
		MOV rax, 0x3C
		MOV rdi, 1
		SYSCALL

section .data
	mode: db "w", 0
	exename: db n_raw, 0
	filename: db n_file, 0
	exe: db "./", n_raw, 0
	error_open: db "[ERROR] Counldn't open file", 10, 0
	error_write: db "[ERROR] Couldn't write in file", 10, 0
	error_close: db "[ERROR] Couldn't close file", 10, 0
	error_comp: db "[ERROR] Couldn't compile file", 10, 0
	error_exec: db "[ERROR] Couldn't execute file", 10, 0
	cmp: db "nasm -f elf64 ", n_file, " -o ", n_raw, ".o && gcc -no-pie ", n_raw, ".o -o ", n_raw, 0
	source: db "BITS 64%1$cglobal main%1$cextern fopen%1$cextern fclose%1$cextern fprintf%1$cextern sprintf%1$cextern printf%1$cextern system%1$c%1$c%%define count %5$d%1$c%%assign count_next count - 1%1$c%%defstr count_str count_next%1$c%%strcat n_raw %3$cSully_%3$c, count_str%1$c%%strcat n_file %3$cSully_%3$c, count_str, %3$c.s%3$c%1$c%1$csection .text%1$c%1$cmain:%1$c%2$c%2$cMOV ecx, count%1$c%2$c%2$cCMP ecx, 0%1$c%2$c%2$cJLE .end%1$c%2$c%2$cSUB rsp, 8%1$c%2$c%2$c;CALL PART%1$c%2$c%2$cCALL file_creation%1$c%2$c%2$cCALL file_writing%1$c%2$c%2$cCALL file_closing%1$c%2$c%2$cCALL file_compilation%1$c%2$c%2$cCALL file_execute%1$c%2$c%2$c;END CALL PART%1$c%2$c%2$cADD rsp, 8%1$c%1$c.end:%1$c%2$c%2$cXOR rax, rax%1$c%2$c%2$cRET%1$c%1$cfile_creation:%1$c%2$c%2$cLEA rdi, [rel filename]%1$c%2$c%2$cMOV rsi, mode%1$c%2$c%2$cSUB rsp, 8%1$c%2$c%2$cCALL fopen%1$c%2$c%2$cADD rsp, 8%1$c%2$c%2$cTEST rax, rax%1$c%2$c%2$cJZ .error%1$c%2$c%2$cMOV r12, rax ; Save file address in r12%1$c%2$c%2$cRET%1$c%1$c.error:%1$c%2$c%2$cLEA rdi, [rel error_open]%1$c%2$c%2$cCALL error%1$c%2$c%2$c%1$cfile_writing:%1$c%2$c%2$cMOV rdi, r12%1$c%2$c%2$cLEA rsi, [rel source]%1$c%2$c%2$cMOV edx, 10%1$c%2$c%2$cMOV ecx, 9%1$c%2$c%2$cMOV r8, 34%1$c%2$c%2$cLEA r9, [rel source]%1$c%2$c%2$cPUSH count-1%1$c%2$c%2$cXOR rax, rax%1$c%2$c%2$cCALL fprintf%1$c%2$c%2$cADD rsp, 8%1$c%2$c%2$cTEST rax, rax%1$c%2$c%2$cJS .error%1$c%2$c%2$cRET%1$c%1$c.error:%1$c%2$c%2$cLEA rdi, [rel error_write]%1$c%2$c%2$cCALL error%1$c%1$cfile_closing:%1$c%2$c%2$cMOV rdi, r12%1$c%2$c%2$cSUB rsp, 8%1$c%2$c%2$cCALL fclose%1$c%2$c%2$cADD rsp, 8%1$c%2$c%2$cTEST rax, rax%1$c%2$c%2$cJNZ .error%1$c%2$c%2$cRET%1$c%1$c.error:%1$c%2$c%2$cLEA rdi, [rel error_close]%1$c%2$c%2$cCALL error%1$c%1$cfile_compilation:%1$c%2$c%2$cLEA rdi, [rel cmp]%1$c%2$c%2$cSUB rsp, 8%1$c%2$c%2$cCALL system%1$c%2$c%2$cADD rsp, 8%1$c%2$c%2$cTEST rax, rax%1$c%2$c%2$cJNZ .error%1$c%2$c%2$cRET%1$c%1$c.error:%1$c%2$c%2$cLEA rdi, [rel error_comp]%1$c%2$c%2$cCALL error%1$c%1$cfile_execute:%1$c%2$c%2$cLEA rdi, [rel exe]%1$c%2$c%2$cSUB rsp, 8%1$c%2$c%2$cCALL system%1$c%2$c%2$cADD rsp, 8%1$c%2$c%2$cTEST rax, rax%1$c%2$c%2$cJNZ .error%1$c%2$c%2$cRET%1$c%1$c.error:%1$c%2$c%2$cLEA rdi, [rel error_exec]%1$c%2$c%2$cCALL error%1$c%1$cerror:%1$c%2$c%2$cXOR rax, rax%1$c%2$c%2$cSUB rsp, 8%1$c%2$c%2$cCALL printf%1$c%2$c%2$cADD rsp, 8%1$c%2$c%2$cMOV rax, 0x3C%1$c%2$c%2$cMOV rdi, 1%1$c%2$c%2$cSYSCALL%1$c%1$csection .data%1$c%2$cmode: db %3$cw%3$c, 0%1$c%2$cexename: db n_raw, 0%1$c%2$cfilename: db n_file, 0%1$c%2$cexe: db %3$c./%3$c, n_raw, 0%1$c%2$cerror_open: db %3$c[ERROR] Counldn't open file%3$c, 10, 0%1$c%2$cerror_write: db %3$c[ERROR] Couldn't write in file%3$c, 10, 0%1$c%2$cerror_close: db %3$c[ERROR] Couldn't close file%3$c, 10, 0%1$c%2$cerror_comp: db %3$c[ERROR] Couldn't compile file%3$c, 10, 0%1$c%2$cerror_exec: db %3$c[ERROR] Couldn't execute file%3$c, 10, 0%1$c%2$ccmp: db %3$cnasm -f elf64 %3$c, n_file, %3$c -o %3$c, n_raw, %3$c.o && gcc -no-pie %3$c, n_raw, %3$c.o -o %3$c, n_raw, 0%1$c%2$csource: db %3$c%4$s%3$c, 0%1$c", 0
