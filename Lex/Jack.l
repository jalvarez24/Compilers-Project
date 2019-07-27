%{
#include <stdio.h>
%}

%%
[\n]+  printf("\b\n");
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
