%{
#include<stdio.h>
#include<math.h>
int _lineno = 1;
%}

DIGITO		[0-9]
LETRA		[a-zA-Z]
ALFA		{LETRA}|{DIGITO}
NUMERO		{DIGITO}+
EXPONENTE	[eE][+-]{NUMERO}
REAL		{NUMERO}.{NUMERO}{EXPONENTE}?
PALABRA		{LETRA}+
CADENA		["']([ ]?({ALFA}|%|,|;|:|_|-)+[ ]?)*["']
ID		{LETRA}{ALFA}*
%%
"Main"|"main"	{ printf("MAIN "); }
"("		{ printf("parent-a= ( "); }
"void"		{ printf(" VOID "); }
")"		{ printf(" parent-c= ) "); }
"{"		{ printf("inicio= { "); ++_lineno; }
"}"		{ printf("fin= } "); ++_lineno; }
"int"		{ printf(" ENTERO "); }
"float"		{ printf(" REAL "); }
"char"		{ printf(" CARACTER "); }
"printf"	{ printf(" ESCRIBIR "); }
"scanf"		{ printf(" LEER "); }
"="		{ printf(" op-igual= ="); }
"+" 		{ printf(" op-sum= + "); }
"-" 		{ printf(" op-subs= - "); }
"*" 		{ printf(" op-mult= * "); }
"/" 		{ printf(" op-div= / "); }
"^" 		{ printf(" op-exp= ^ "); }
{CADENA}	{ printf(" cte-cadena= %s ", yytext); }
{ID}		{ printf(" ID= %s ", yytext); }
{REAL}		{ printf(" cte-real= %s ", yytext); }
{NUMERO}	{ printf(" cte-entero= %s ", yytext); }
","		{ printf(" coma= , ");}
";"		{ printf(" punto-coma= ; "); ++_lineno;}
[ ]		;
"\n"		{printf("\n"); ++_lineno;}
.		{ printf("\nERROR EN LINEA %d, EN %s\n", _lineno, yytext); ++_lineno;}
%%
int main(int argc, char *argv[]){
	++argv, --argc;
	if(argc > 0){
		yyin = fopen(argv[0], "r");
	}else{
		yyin = stdin;	
	}
	yylex();
	return 0;
}
