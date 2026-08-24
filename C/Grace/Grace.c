#include <stdio.h>
#define FILE_NAME "Grace_kid.c"
#define STR "#include <stdio.h>%1$c#define FILE_NAME %2$cGrace_kid.c%2$c%1$c#define STR %2$c%3$s%2$c%1$c#define main_func() int main(){ FILE *file = fopen(FILE_NAME, %2$cw%2$c); if (file == NULL) return 1; fprintf(file, STR, 10, 34, STR); return 0; }%1$c%1$cmain_func()%1$c/*Comment*/%1$c"
#define main_func() int main(){ FILE *file = fopen(FILE_NAME, "w"); if (file == NULL) return 1; fprintf(file, STR, 10, 34, STR); return 0; }

main_func()
/*Comment*/
