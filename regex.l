%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>		
#include <math.h>

int _lineno = 1;
int token_index = 0;
void printVal(){
}

%}

DIGITO		[0-9]
LETRA		[a-zA-Z]
ALFA		{LETRA}|{DIGITO}
NUMERO		{DIGITO}+
EXPONENTE	[eE][+-]{NUMERO}
REAL		{NUMERO}.{NUMERO}{EXPONENTE}?
PALABRA		{LETRA}+
CADENA		["']([ ]?({ALFA}|%|,|.|;|:|_|-)+[ ]?)*["']
ID		{LETRA}{ALFA}*
%%
"Main"|"main"	{ printf("MAIN "); }
"("		{ printf("parent-a= ( "); }
"void"		{ printf(" VOID "); }
")"		{ printf(" parent-c= ) "); }
"{"		{ printf("inicio= { "); }
"}"		{ printf("fin= } "); ++_lineno; }
" {"		{ printf(" inicio= { "); }
" }"		{ printf(" fin= } "); ++_lineno; }
"["		{ printf(" corch-a= [ "); }
"]"		{ printf(" corch-c= ] "); }
"int"		{ printf("ENTERO "); }
"float"		{ printf("REAL "); }
"char"		{ printf("CARACTER "); }
" int"		{ printf(" ENTERO "); }
" float"	{ printf(" REAL "); }
" char"		{ printf(" CARACTER "); }
"printf"	{ printf("ESCRIBIR "); }
"scanf"		{ printf("LEER "); }
" printf"	{ printf(" ESCRIBIR "); }
" scanf"	{ printf(" LEER "); }
"  printf"	{ printf("  ESCRIBIR "); }
"  scanf"	{ printf("  LEER "); }
"<--"		{ printf(" op-asign= <-- "); }
"+" 		{ printf(" op-sum= + "); }
"-" 		{ printf(" op-sust= - "); }
"*" 		{ printf(" op-mult= * "); }
"/" 		{ printf(" op-div= / "); }
"^" 		{ printf(" op-exp= ^ "); }
"="		{ printf(" op-igual= = "); }
"<="		{ printf(" op-menig= <= "); }
">="		{ printf(" op-mayig= >= "); }
"<>"		{ printf(" op-difer= <> "); }
">"		{ printf(" op-mayor= > "); }
"<"		{ printf(" op-menor= < "); } 
"=="		{ printf(" op-comp= == "); }
"||"		{ printf(" op-o= || "); }
"&&"		{ printf(" op-y= && "); }
"~"		{ printf(" op-no= ~ "); }
"true"		{ printf(" op-ver= true "); }
"false" 	{ printf(" op-fal= false "); }
"if"		{ printf("SI "); }
"else"		{ printf("SI-NO "); }
"for"		{ printf("PARA "); }
"do"		{ printf("HACER "); }
"while"		{ printf("MIENTRAS QUE "); }
"switch"	{ printf("DEPENDIENDO DE "); }
{CADENA}	{ printf("cte-cadena= %s ", yytext); }
{ID}		{ printf("ID= %s ", yytext); }
{REAL}		{ printf("cte-real= %s ", yytext); }
{NUMERO}	{ printf("cte-entero= %s ", yytext); }
" if"		{ printf(" SI "); }
" else"		{ printf(" SI-NO "); }
" for"		{ printf(" PARA "); }
" do"		{ printf(" HACER "); }
" while"	{ printf(" MIENTRAS QUE "); }
" switch"	{ printf(" DEPENDIENDO DE "); }
" "{CADENA}	{ printf(" cte-cadena= %s ", yytext); }
" "{ID}		{ printf(" ID= %s ", yytext); }
" "{REAL}	{ printf(" cte-real= %s ", yytext); }
" "{NUMERO}	{ printf(" cte-entero= %s ", yytext); }
","		{ printf(" coma= , "); }
";"		{ printf(" punto-coma= ; "); }
[ ]		;
"\n"		{ printVal(); printf("\n"); ++_lineno; }
.		{ printf("\nERROR EN LINEA %d, EN %s\n", _lineno, yytext); ++_lineno; }
%%
int main(int argc, char *argv[]){
	char **tokens = calloc(10, sizeof(char*));
	++argv, --argc;
	if (argc > 0) {
		yyin = fopen(argv[0], "r");
	} else {
		yyin = stdin;	
	}
	yylex();
	for (int i = 0; i < 10; i++){
		tokens[i] = calloc(1, sizeof(char) *100);
	}
	if (tokens != NULL){
		printf("Memory allocated!");
	}
	free(tokens);
	return 0;
}
