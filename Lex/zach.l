%{
#include <stdio.h>
%}

%%
"(*"[^)]*"*)" /*Remove all comments*/
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
