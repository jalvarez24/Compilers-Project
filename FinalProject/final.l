%{
using namespace std;
#include <stdio.h>
#include <string>
#include <iostream>
extern char* yytext;

#include "final.tab.h"
#define YY_DECL extern "C" int yylex()

extern void fixSpace(const char* str, int len, bool isAlphaBefore, char c);

%}

digit             [0-9]
alpha             [A-Za-z_]
alpha_num         ({alpha}|{digit})
operator	  ["-"|"+"|"/"|"*"|"="]
whitespace	  [ \t\n]+
comment		"(*"[^)]*"*)"

%%


[\n]+  printf("\b\n"); 		/*Remove lines*/

{comment}"\n" 			/*Remove line comments*/

[ ]+{comment} printf("\b");	/*Remove comments inline w/ code*/

^[ ]*				/*Ignore spaces at the beginning of the line.*/

[ \t]+  putchar( ' ' );     	/*Remove extra spaces*/	

[ \t]+$   			/*Ignore space at the end of line*/

{whitespace}";" {printf(";");}

{whitespace}"," {printf(",");}


"‘".+"’" { printf("%s", yytext); } /*Do not modify any text within quotes*/
		   

{alpha_num}+"=" {
			/*Fixes the spacing issue when reading a '=' */
			fixSpace(yytext, yyleng, true, '=');
		}

"="{alpha_num}  {
			/*Fixes the spacing issue when reading a '=' */
			fixSpace(yytext, yyleng, false, '=');
		}

"*" printf(" * ");	/*Fixes the spacing issue when reading a '*' */

{alpha_num}+":" {
			/*Fixes the spacing issue when reading a ':' */
			fixSpace(yytext, yyleng, true, ':');
		}

%%


int yywrap()
{
	return 1;
}


void fixSpace(const char* str, int len, bool isAlphaBefore, char c)
{

	//Copy the token into a string variable
	string s(str);
	
	//If the alphanumeric character is before
	//the passsed-in char insert a space before, otherwise
	//insert it after.
	if(isAlphaBefore)
	{
		s[len - 1] = ' '; 
		s = s + c; 
	}
	else
	{
		s[0] = ' '; 
		s = c + s; 
	}

	//Write out the result.
	printf("%s", s.c_str());
}


