/* Mini Calculator */
/* calc.y */

%{
#include <stdio.h>
int yyerror(char *s);
int yylex(void);
%}

%union{
  int		int_val;
  char*	str_val;
}

%start initial

%token <int_val>	INTEGER_LITERAL
%token <str_val> N_EQUAL
// %token <str_val> INT
%token <str_val> STR
%token <str_val> ID
%token <str_val> EQUAL
%token <str_val> IF
%token <str_val> WHILE
%token <str_val> FUNCTION
%token <str_val> MINUS
%token <str_val> DO
%token <str_val> ATTR
%token <str_val> BIGGER
%token <str_val> BIGGER_EQUAL
%token <str_val> S_COLON
%token <str_val> THEN
%token <str_val> LESS
%token <str_val> COLON
%token <str_val> C_PAR
%token <str_val> O_PAR
%token <str_val> DIV
%token <str_val> ELSE
%token <str_val> OR
%token <str_val> AND
%token <str_val> LESS_EQUAL
%token <str_val> VAR
%token <str_val> LET
%token <str_val> IN
%token <str_val> END
// %type	<int_val>	exp
%left	PLUS
%left	MULT

%%

initial: exp
  | dec_seq

dec_seq: /* empty */
    | dec dec_seq
    ;

id_seq: ID
    | ID id_seq
    ;

dec: VAR ID ATTR exp
    | FUNCTION ID O_PAR id_seq C_PAR ATTR exp


exp: /* empty */
    | STR
    | INTEGER_LITERAL
		| ID exp_id
    | MINUS exp
    | exp op exp
    | O_PAR exp_seq C_PAR
    | IF exp THEN exp else_exp
    | WHILE exp DO exp
    | LET dec_seq IN exp_seq END
		;

exp_id: /* empty */
    | ATTR exp
    | O_PAR exp_list C_PAR
    ;

else_exp: /* empty */
    | ELSE else_if
    ;

else_if: exp
    | IF exp THEN exp else_exp
    ;

exp_seq: exp
		| exp_seq S_COLON exp
		;

exp_list:    exp
    | exp_list COLON exp
    ;

op :  MULT
    | DIV
    | PLUS
    | MINUS
    | EQUAL
    | N_EQUAL
    | BIGGER
    | LESS
    | BIGGER_EQUAL
    | LESS_EQUAL
    | AND
    | OR

%%
// char *progname;
int yyparse();
main( argc, argv )
char *argv[];
{
  // progname = argv[0];
  // strcpy(format,"%g\n");
  yyparse();
}

int yyerror(char *s)
{
  extern int linha;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c

  // cerr << "ERROR: " << s << " at symbol \"" << yytext;
  // cerr << "\" on line " << linha << endl;
  printf("ERROR: %s AT symbol \"%s\" on line %d\n", s, yytext, linha);
  exit(1);
}

// int yyerror(char *s)
// {
//   return yyerror(s);
// }
