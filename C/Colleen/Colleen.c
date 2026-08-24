#include <stdio.h>

/*Comment 0*/
char *ret_str() { return "#include <stdio.h>%1$c%1$c/*Comment 0*/%1$cchar *ret_str() { return %3$c%4$s%3$c; }%1$c%1$cint main()%1$c{%1$c%2$c/*Comment 1*/%1$c%2$cchar *s = ret_str();%1$c%2$cprintf(s, 10, 9, 34, s);%1$c%2$creturn 0;%1$c}%1$c"; }

int main()
{
	/*Comment 1*/
	char *s = ret_str();
	printf(s, 10, 9, 34, s);
	return 0;
}
