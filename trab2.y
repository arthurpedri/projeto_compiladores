%{
#include "arvore.h"
int yyerror(no **raiz, char *s);
int yylex(void);


%}

%union{
  int		int_val;
  char*	str_val;
  no* nodo_val;
}

%start initial

%parse-param {no **raiz}

%token <int_val> INTEGER_LITERAL
%token <str_val> N_EQUAL
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
%token <str_val> PLUS
%token <str_val> MULT
%token <nodo_val> raiz

%type <nodo_val> initial
%type <nodo_val> exp
%type <nodo_val> dec
%type <nodo_val> dec_seq
%type <nodo_val> id_seq
%type <nodo_val> else_exp
%type <nodo_val> exp_seq
%type <nodo_val> exp_list
%type <nodo_val> op

%%

initial: exp { *raiz = subArvore("initial", 1, $1, NULL, NULL, NULL, NULL, NULL, NULL);}
  | dec_seq { *raiz = subArvore("initial", 1, $1, NULL, NULL, NULL, NULL, NULL, NULL);}

dec_seq: dec { $$ = subArvore("dec_seq", 1, $1, NULL, NULL, NULL, NULL, NULL, NULL);}
    | dec dec_seq { $$ = subArvore("dec_seq", 2, $1, $2, NULL, NULL, NULL, NULL, NULL);}
    ;

id_seq: ID { $$ = subArvore("id_seq", 1, novoNo("ID"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | ID COLON id_seq { $$ = subArvore("id_seq", 3, novoNo("ID"), novoNo(","), $3, NULL, NULL, NULL, NULL);}
    ;

dec: VAR ID ATTR exp { $$ = subArvore("dec", 4, novoNo("VAR"), novoNo("ID"), novoNo(":="), $4, NULL, NULL, NULL);}
    | FUNCTION ID O_PAR id_seq C_PAR ATTR exp { $$ = subArvore("dec", 7, novoNo("FUNCTION"), novoNo("ID"), novoNo("("), $4, novoNo(")"), novoNo(":="), $7);}


exp: /* empty */ { $$ = subArvore("exp", 1, novoNo("VAZIO"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | STR { $$ = subArvore("exp", 1, novoNo("STR"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | INTEGER_LITERAL { $$ = subArvore("exp", 1, novoNo("INTEGER_LITERAL"), NULL, NULL, NULL, NULL, NULL, NULL);}
		| ID { $$ = subArvore("exp", 1, novoNo("ID"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | ID ATTR exp { $$ = subArvore("exp", 3, novoNo("ID"), novoNo(":="), $3, NULL, NULL, NULL, NULL);}
    | ID O_PAR exp_list C_PAR { $$ = subArvore("exp", 4, novoNo("ID"), novoNo("("), $3, novoNo(")"), NULL, NULL, NULL);}
    | exp op exp { $$ = subArvore("exp", 3, $1, $2, $3, NULL, NULL, NULL, NULL);}
    | O_PAR exp_seq C_PAR { $$ = subArvore("exp", 3, novoNo("("), $2, novoNo(")"), NULL, NULL, NULL, NULL);} 
    | IF exp THEN exp else_exp { $$ = subArvore("exp", 5, novoNo("IF"), $2, novoNo("THEN"), $4, $5, NULL, NULL);}
    | WHILE exp DO exp { $$ = subArvore("exp", 4, novoNo("WHILE"), $2, novoNo("DO"), $4, NULL, NULL, NULL);}
    | LET dec_seq IN exp_seq END { $$ = subArvore("exp", 5, novoNo("LET"), $2, novoNo("IN"), $4, novoNo("END"), NULL, NULL);}
		;


else_exp: /* empty */ { $$ = subArvore("else_exp", 1, novoNo("VAZIO"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | ELSE exp { $$ = subArvore("else_exp", 2, novoNo("ELSE"), $2, NULL, NULL, NULL, NULL, NULL);}
    ;


exp_seq: exp { $$ = subArvore("exp_seq", 1, $1, NULL, NULL, NULL, NULL, NULL, NULL);}
		| exp_seq S_COLON exp { $$ = subArvore("exp_seq", 3, $1, novoNo(";"), $3, NULL, NULL, NULL, NULL);}
		;

exp_list:    exp { $$ = subArvore("exp_list", 1, $1, NULL, NULL, NULL, NULL, NULL, NULL);}
    | exp_list COLON exp { $$ = subArvore("exp_list", 1, $1, novoNo(","), $3, NULL, NULL, NULL, NULL);}
    ;

op :  MULT  { $$ = subArvore("op", 1, novoNo("MULT"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | DIV  { $$ = subArvore("op", 1, novoNo("DIV"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | PLUS  { $$ = subArvore("op", 1, novoNo("PLUS"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | MINUS  { $$ = subArvore("op", 1, novoNo("MINUS"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | EQUAL  { $$ = subArvore("op", 1, novoNo("EQUAL"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | N_EQUAL  { $$ = subArvore("op", 1, novoNo("N_EQUAL"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | BIGGER  { $$ = subArvore("op", 1, novoNo("BIGGER"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | LESS  { $$ = subArvore("op", 1, novoNo("LESS"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | BIGGER_EQUAL  { $$ = subArvore("op", 1, novoNo("BIGGER_EQUAL"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | LESS_EQUAL  { $$ = subArvore("op", 1, novoNo("LESS_EQUAL"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | AND  { $$ = subArvore("op", 1, novoNo("AND"), NULL, NULL, NULL, NULL, NULL, NULL);}
    | OR  { $$ = subArvore("op", 1, novoNo("OR"), NULL, NULL, NULL, NULL, NULL, NULL);}

%%

int destroiArvore (no *raiz){
  if (!raiz) return 0;

  for (int i = 0; i<raiz->qtd_filhos; i++){
    destroiArvore(raiz->filho[i]);
    free(raiz->filho[i]);
  }
  return 1;
}

no *novoNo(char *nome){
  no *novo;
  novo = malloc(sizeof(no));
  strcpy(novo->nome, nome);
  novo->qtd_filhos = 0;
  return novo;
}

no *subArvore(char *nome, int filhos, no *filho1, no *filho2, no *filho3, no *filho4, no *filho5, no *filho6, no *filho7){
  no *novo;
  novo = malloc(sizeof(no));
  strcpy(novo->nome, nome);
  novo->qtd_filhos = 0;
  for (int i = 0; i < filhos; ++i)
  {
    novo->filho[i] = malloc(sizeof(no));
  }
  if(filhos >= 1){
    novo->qtd_filhos++;
    novo->filho[0] = filho1;

    if(filhos >= 2){
      novo->qtd_filhos++;
      novo->filho[1] = filho2;

      if(filhos >= 3){
        novo->qtd_filhos++;
        novo->filho[2] = filho3;

        if(filhos >= 4){
          novo->qtd_filhos++;
          novo->filho[3] = filho4;

          if(filhos >= 5){
            novo->qtd_filhos++;
            novo->filho[4] = filho5;

            if(filhos >= 6){
              novo->qtd_filhos++;
              novo->filho[5] = filho6;

              if(filhos >= 7){
                novo->qtd_filhos++;
                novo->filho[6] = filho7;
                
              }
            }
          }
        }
      }
    }
  }
  return novo;
}


void printarvore(no *raiz, int ultimo, int nivel){
  for (int i = 0; i < nivel; ++i)
  {
    printf("  ");
  }
  if (!raiz->qtd_filhos) {
    if(!ultimo)
      printf("%s,\n", raiz->nome);
    else
      printf("%s\n", raiz->nome);
    return;
  }
  printf("%s {\n", raiz->nome );
  for (int i = 0; i < raiz->qtd_filhos - 1; ++i)
  {
    printarvore(raiz->filho[i], 0, nivel + 1);
  }
  printarvore(raiz->filho[raiz->qtd_filhos - 1], 1, nivel + 1);

  for (int i = 0; i < nivel; ++i)
  {
    printf("  ");
  }
  printf("}\n");
}




int yyparse();
int main(int argc, char *argv[] )
{
  no *raiz = NULL;
  yyparse(&raiz);
  printarvore(raiz, 0, 0);
  destroiArvore(raiz);
}

int yyerror(no **raiz, char *s)
{
  extern int linha;
  extern char *yytext;

  printf("ERRO: %s no símbolo \"%s\" na linha %d\n", s, yytext, linha);
  exit(1);
}
