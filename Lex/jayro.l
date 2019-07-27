//Lex File for Jayro
%{
#include <stdio.h>
%}

%%
"(*"[^)]*"*)" /* ignore all comments */
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
