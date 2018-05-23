%{

#include <stdio.h>
#include <string.h>
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

int main(int argc, char const *argv[])
{
	 yylex();

	if (simbolo_16)
		printf("& : %d\n",simbolo_16);
	if (simbolo_4)
		printf("( : %d\n",simbolo_4);
	if (simbolo_5)
		printf(") : %d\n", simbolo_5);
	if (simbolo_8)
		printf("* : %d\n", simbolo_8);
	if (simbolo_6)
		printf("+ : %d\n",simbolo_6);
	if (simbolo_3)
		printf(", : %d\n",simbolo_3);
	if (simbolo_7)
		printf("- : %d\n",simbolo_7);
	if (simbolo_9)
		printf("/ : %d\n",simbolo_9);
	if (simbolo_1)
		printf(":= : %d\n",simbolo_1);
	if (simbolo_2)
		printf("; : %d\n", simbolo_2);
	if (simbolo_13)
		printf("< : %d\n",simbolo_13);
	if (simbolo_15)
		printf("<= : %d\n", simbolo_15);
	if (simbolo_11)
		printf("<> : %d\n",simbolo_11);
	if (simbolo_10)
		printf("= : %d\n", simbolo_10);
	if (simbolo_12)
		printf("> : %d\n", simbolo_12);
	if (simbolo_14)
		printf(">= : %d\n",simbolo_14);
	if (simbolo_17)
		printf("| : %d\n",simbolo_17);
	if (palavra_7)
		printf("do : %d\n",palavra_7);
	if (palavra_5)
		printf("else : %d\n", palavra_5);
	if (palavra_10)
		printf("end : %d\n",palavra_10);
	if (palavra_2)
		printf("function : %d\n",palavra_2);
	if (palavra_3)
		printf("if : %d\n", palavra_3);
	if (palavra_9)
		printf("in : %d\n",palavra_9);
	if (palavra_8)
		printf("let : %d\n", palavra_8);
	if (palavra_4)
		printf("then : %d\n",palavra_4);
	if (palavra_1)
		printf("var : %d\n", palavra_1);
	if (palavra_6)
		printf("while : %d\n",palavra_6);
	if (coment)
		printf("COMENTÁRIO : %d\n",coment);
	if (desconhecido)
		printf("DESCONHECIDO : %d\n", desconhecido);
	if (identificadores)
		printf("IDENTIFICADOR : %d\n", identificadores);
	if (num)
		printf("INTEIRO : %d\n", num);
}
 
int yywrap()
{
	return(1);
}

