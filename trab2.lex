%{

#include <stdio.h>
#include <string.h>
#include "trab2.tab.h"
int yyerror(char *s);
int linha = 1;

%}


INT [0-9]+
ID [a-zA-Z][a-zA-Z0-9_]*
STR \"(\\.|[^"\\])*\"
NULL [ \t\n]


%x comentario

%%
"/*" { BEGIN(comentario);}
":=" { yylval.str_val = strdup(yytext); return ATTR; }
";"  { yylval.str_val = strdup(yytext); return S_COLON; }
","  { yylval.str_val = strdup(yytext); return COLON; }
"("  { yylval.str_val = strdup(yytext); return O_PAR; }
")"  { yylval.str_val = strdup(yytext); return C_PAR; }
"+"  { yylval.str_val = strdup(yytext); return PLUS; }
"-"  { yylval.str_val = strdup(yytext); return MINUS; }
"*"  { yylval.str_val = strdup(yytext); return MULT; }
"/"  { yylval.str_val = strdup(yytext); return DIV; }
"="  { yylval.str_val = strdup(yytext); return EQUAL; }
"<>"  { yylval.str_val = strdup(yytext); return N_EQUAL; }
">"  { yylval.str_val = strdup(yytext); return BIGGER; }
"<"  { yylval.str_val = strdup(yytext); return LESS; }
">="  { yylval.str_val = strdup(yytext); return BIGGER_EQUAL; }
"<="  { yylval.str_val = strdup(yytext); return LESS_EQUAL; }
"&"  { yylval.str_val = strdup(yytext); return AND; }
"|"   { yylval.str_val = strdup(yytext); return OR; }
"var" { yylval.str_val = strdup(yytext); return VAR; }
"function" { yylval.str_val = strdup(yytext); return FUNCTION; }
"if" { yylval.str_val = strdup(yytext); return IF; }
"then" { yylval.str_val = strdup(yytext); return THEN; }
"else" { yylval.str_val = strdup(yytext); return ELSE; }
"while" { yylval.str_val = strdup(yytext); return WHILE; }
"do" { yylval.str_val = strdup(yytext); return DO; }
"let" { yylval.str_val = strdup(yytext); return LET; }
"in" { yylval.str_val = strdup(yytext); return IN; }
"end" { yylval.str_val = strdup(yytext); return END; }
{INT} { yylval.int_val = atoi(yytext); return INTEGER_LITERAL; } // lembrar que pode dar o erro igual da calculadora
{ID} { yylval.str_val = strdup(yytext); return ID; }
{STR} { yylval.str_val = strdup(yytext); return STR; }
<comentario>"*/" { BEGIN(INITIAL);}
<comentario>. {};
<comentario>\n { linha++; }
<INITIAL>\n { linha++; }
<INITIAL>[ \t] {};
<INITIAL>. {};

%%
