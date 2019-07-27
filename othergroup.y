%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern FILE *yyin;


void yyerror (const char *msg) {
  printf("ERROR(PARSER): %s\n", msg);
}

%}

%token		  type



%token		  NUMBER
%token		  NAME

%token            PLUS
%token            MINUS
%token            TIMES
%token            SLASH
%token            LPAREN
%token            RPAREN
%token            SEMICOLON
%token            COMMA
%token            PERIOD
%token            BECOMES
%token            EQL
%token            NEQ
%token            LSS
%token            GTR
%token            LEQ
%token            GEQ
%token            BEGIN
%token            CALLSYM
%token            CONSTSYM
%token            DOSYM
%token            END
%token            IFSYM
%token            ODDSYM
%token            PROCSYM
%token            THENSYM
%token            VARSYM
%token            WHILESYM
%token		  PROGRAM
%token 		  VAR
%token		  UNKNOWN
%token		  PRINT
%%
program:  
	start
	| unknown {fprintf(yyin, "stroke\nshowpage\n");}
	;
start:
	PROGRAM pname
	| VAR
	| declist
	| BEGIN statlist END
	;

pname:
	id
	;

id:
	/*letter{letter|digit} not worrking since we dont end letters here*/
	;

declist:
	dec
	| type
	;

dec:
	id 
	dec {id}
	;

statlist:
	stat
	| stat statlist
	;

stat:
	print | assign
	;
	
print:
	PRINT {printf("This should be the output!!!!!!, we also have a useless PRINT TOKEN NOW");}
	;

output:
	{"string",} id
	;

assign:
	
	/* id = expr               having errors    */
	;

expr:
	term 
	| {expr + term}
	| {expr - term}
	;

term:
	{term * factor}
	| {term / factor}
	| factor
	;

factor:
	id
	| number
	| {(expr)}
	;

number:
	digit{digit}
	;

digit:
	;

letter:
	;

unknown:
	UNKNOWN	{printf("UNKNOWN\n");}
	;

%%
