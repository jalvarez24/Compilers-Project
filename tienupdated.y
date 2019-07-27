%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *str) 
{
fprintf(stderr,"error: %s\n",str);
}
%}


//token definitions:
%start start 
%token BEGIN
%token END
%token INTEGER
%token PRINT
%token PROGRAM
%token VAR

%%
start: 	PROGRAM pname ';' VAR declist ';' BEGIN statlist END '.' {printf("'PROGRAM','VAR','BEGIN',AND 'END' were found.");}; //need to print error catching message for when not found.
pname	: id	{printf("PROGRAM is expected");}
	;
id	:letter letter 
	| letter letter digit 
	| letter letter letter digit digit
	;
declist	:dec ':' type
	;
dec	:id ',' dec 
	| id
	| id dec 	{yyerror(", is missing");}
	;
type	:INTEGER	{printf("VAR is expected");}
	;
statlist	:stat ';' 
	| stat ';' statlist
	;
stat	:print 
	| assign
	;
print:	PRINT  output ')'	{yyerror("( is missing");}
	PRINT '('output		{yyerror(") is missing");}
	PRINT '('output')'	
	;
output	:"string" ',' id
	;
assign	:id '=' expr
	;
expr	:term
	 | expr '+' term 
	| expr '-' term
	;
term	:term '*' factor 
	| term '/' factor 
	| factor
	;
factor	:id 
	| num 
	| expr
	;	
num	:digit 
	| digit digit;
digit	: '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9';
letter	: 'a'|'b'|'c'|'d'|'e'|'f';

%%

yylex(){
	char str[20];
	char c;
	int pos = 0;
	c = getchar();
	strcpy( str, c);
	pos++;
	while( c != ' '| c!= ',' |  c != '\''){
		strcat( str, c);
		pos++;
	}
}
int main(){
	yyparse();
	return 1;
}
