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
"void"		{ printf(" VOID "); }
"int"		{ printf(" ENTERO "); }
"float"		{ printf(" REAL "); }
"char"		{ printf(" CARACTER "); }
"printf"	{ printf(" ESCRIBIR "); }
"scanf"		{ printf(" LEER "); }
"+" 		{ printf(" op-sum= + "); }
"-" 		{ printf(" op-subs= - "); }
"*" 		{ printf(" op-mult= * "); }
"/" 		{ printf(" op-div= / "); }
"^" 		{ printf(" op-exp= ^ "); }
"="		{ printf(" op-igual= ="); }
"<--"		{ printf(" op-asign= <-- "); }
","		{ printf(" coma= , ");}
";"		{ printf(" punto-coma= ; "); ++_lineno;}
"("		{ printf(" parent-a= ( "); }
")"		{ printf(" parent-c= ) "); }
"["		{ printf(" corch-a= [ "); }
"]"		{ printf(" corch-c= ] "); }
"{"		{ printf(" llave-a= { "); ++_lineno; }
"}"		{ printf(" llave-b= } "); ++_lineno; }
"\n"		{printf("\n"); ++_lineno;}
{CADENA}	{ printf(" cte-cadena= %s ", yytext); }
{ID}		{ printf(" ID= %s ", yytext); }
{REAL}		{ printf(" cte-real= %s ", yytext); }
{NUMERO}	{ printf(" cte-entero= %s ", yytext); }
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
