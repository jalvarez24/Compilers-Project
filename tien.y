%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *str)
{
	fprintf(stderr, "error %s\n", str);
}
%}

%start start 
%token BEGIN
%token END
%token INTEGER
%token PRINT
%token PROGRAM
%token VAR
%token variable
%token name	//
%token value
%token output


%%

start	:PROGRAM start	{printf("PROGRAM is expected);}
	|VAR start	{printf("VAR is expected);}	
	|BEGIN start	{printf("BEGIN is expected);}
	|END		{printf("END is expected);}

PROGAME	:name
	;
VAR	:declist
	;

declist	: dec ':' type
	;

dec	:name ',' dec
	|name dec	{printf(", is missing");}
	|name
	;

type	: INTEGER
	;

BEGIN	:statlist
	;

statlist :stat ';'
	|stat 		{printf("; is missing");}
	| stat ';' statlist
	|stat statlist	{printf("; is missing");}
	;

stat	:PRINT
	|assign
	;

PRINT	:'('output'),' name
	|output'),' name	{printf("( is missing");}
	|'('output',' name	{printf(") is missing");}
	|'('output')' name	{printf(", is missing");}
	;

assign	: name '=' expr
	| name expr	{printf("= is missing");}
	;

expr	: term
	| expr '+' term
	| expr '-' term
	;
term	: term '*' factor
	| term '/' factor
	|factor
	;
factor	: name
	|value
	|'('expr')'
	;
END	: '.'
	|' '	{printf(". is missing");}
	;

int main(void){
	return yyparse();
}
