%{
#include <stdio.h>
#include <stdlib.h>
#include <cstdio>
#include <iostream>
using namespace std;


extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);

%}

%start start 
//%token BEGIN
//%token END
%token INTEGER
//%token PRINT
%token PROGRAM
//%token VAR
%token variable
%token name	
%token value
%token output


%%

start	:PROGRAM start	{printf("PROGRAM is expected");}
	|VAR start	{printf("VAR is expected");}	
	|BEGIN start	{printf("BEGIN is expected");}
	|END		{printf("END is expected");}

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
%%
int main(int, char**) {
	// open a file handle to a particular file:
	FILE *myfile = fopen("final.txt", "r");
	// make sure it's valid:
	if (!myfile) {
		std::cout << "I can't open final.txt!" << std::endl;
		return -1;
	}
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;

	// parse through the input until there is no more:
	
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror(const char *s) {
	cout << "Parsing error.  Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}
