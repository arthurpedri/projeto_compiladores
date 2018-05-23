/* Mini Calculator */
/* calc.y */

%{

int yyerror(char *s);
int yylex(void);
%}

%union{
  int		int_val;
  string*	str_val;
}

%start initial 

%token	<int_val>	INTEGER_LITERAL
%type	<int_val>	exp
%left	PLUS
%left	MULT

%%

initial: exp
  | dec_seq

dec_seq: /* empty */
    | dec dec_seq
    ;

id_seq: id
    | id id_seq
    ;

dec: VAR ID ATTR exp
    | FUNCTION ID O_PAR id_seq C_PAR ATTR exp


exp:		/* empty */
    | STR
    | INT
		| ID exp_id
    | MINUS exp
    | exp op exp
    | O_PAR exp_seq C_PAR


    | IF exp THEN exp else_exp
    | WHILE exp DO exp
    | let dec_seq in exp_seq end
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

int yyerror(string s)
{
  extern int linha;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << linha << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}


