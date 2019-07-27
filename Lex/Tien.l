%{
#include <stdio.h>
%}

%%
^[]   printf("\b");   /*remove space at beginning*/
[ \t]+  putchar( ' ' );   
[ \t]+$   /*ignore space at the end of line*/
%%

int main()
{
yyin=fopen("final.txt","r");
yylex();
}
int yywrap()
{
return 1;
}
