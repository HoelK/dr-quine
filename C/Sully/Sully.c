#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#define SOURCE "#include <stdio.h>%1$c#include <stdlib.h>%1$c#include <unistd.h>%1$c#include <sys/types.h>%1$c#include <sys/stat.h>%1$c#define SOURCE %3$c%5$s%3$c%1$c#define COMPILE_CMD %3$ccc -Wall -Werror -Wextra %%1$s -o %%2$s%3$c%1$c#define RED %3$c%6$cx1b[31m%3$c%1$c%1$cvoid error(char *err)%1$c{%1$c%2$cprintf(RED%3$c[ERROR] %3$c);%1$c%2$cprintf(err);%1$c%2$cprintf(%3$c%6$cn%3$c);%1$c%2$cexit(1);%2$c%1$c}%1$c%1$cint main()%1$c{%1$c%2$cint i = %4$d;%1$c%2$cchar exename[18], filename[20], cmd[70] = {0};%1$c%1$c%2$cif (i > 0)%1$c%2$c{%1$c%2$c%2$cprintf(%3$c[%%d] Creating filename...%6$cn%3$c, i);%1$c%2$c%2$csprintf(filename, %3$cSully_%%d.c%3$c, i - 1);%1$c%2$c%2$csprintf(exename, %3$cSully_%%d%3$c, i - 1);%1$c%2$c%2$csprintf(cmd, COMPILE_CMD, filename, exename);%1$c%1$c%2$c%2$cprintf(%3$c[%%d] Creating sourcefile...%6$cn%3$c, i);%1$c%2$c%2$cFILE *file = fopen(filename, %3$cw%3$c);%1$c%2$c%2$cif (!file)%1$c%2$c%2$c%2$cerror(%3$cFailed to create source file%3$c);%1$c%2$c%2$cfprintf(file, SOURCE, 10, 9, 34, i - 1, SOURCE, 92);%1$c%2$c%2$cif (fclose(file) == EOF)%1$c%2$c%2$c%2$cerror(%3$cFailed to close source file%3$c);%1$c%1$c%2$c%2$cprintf(%3$c[%%d] Compiling source file...%6$cn%3$c, i);%1$c%2$c%2$cif(system(cmd) != 0)%1$c%2$c%2$c%2$cerror(%3$cFailed to compile file%3$c);%1$c%1$c%2$c%2$cprintf(%3$c[%%d] Executing file...%6$cn%3$c, i);%1$c%2$c%2$csprintf(cmd, %3$c./%%s%3$c, exename);%1$c%2$c%2$cif(system(cmd) != 0)%1$c%2$c%2$c%2$cerror(%3$cFailed to execute file%3$c);%1$c%2$c}%1$c}%1$c"
#define COMPILE_CMD "cc -Wall -Werror -Wextra %1$s -o %2$s"
#define RED "\x1b[31m"

void error(char *err)
{
	printf(RED"[ERROR] ");
	printf(err);
	printf("\n");
	exit(1);	
}

int main()
{
	int i = 5;
	char exename[18], filename[20], cmd[70] = {0};

	if (i > 0)
	{
		printf("[%d] Creating filename...\n", i);
		sprintf(filename, "Sully_%d.c", i - 1);
		sprintf(exename, "Sully_%d", i - 1);
		sprintf(cmd, COMPILE_CMD, filename, exename);

		printf("[%d] Creating sourcefile...\n", i);
		FILE *file = fopen(filename, "w");
		if (!file)
			error("Failed to create source file");
		fprintf(file, SOURCE, 10, 9, 34, i - 1, SOURCE, 92);
		if (fclose(file) == EOF)
			error("Failed to close source file");

		printf("[%d] Compiling source file...\n", i);
		if(system(cmd) != 0)
			error("Failed to compile file");

		printf("[%d] Executing file...\n", i);
		sprintf(cmd, "./%s", exename);
		if(system(cmd) != 0)
			error("Failed to execute file");
	}
}
