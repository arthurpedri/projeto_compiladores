









Conflitos de Shift / Reduce foram todos causados em regras onde uma expressão era expandida para ser uma operação entre expressões.
Temos 12 operações e 5 estados, isso faz 60 conflitos que são resolvidos por shift de forma correta, o conflito 61 acontece de forma
parecida quando estamos no estado 52 com o uso do ELSE, que também é resolvido de forma correta com o shift.
Exemplos de cada um dos estados, de acordo com o verbose do bison:

State 39

   13 exp: ID ATTR exp .
   15    | exp . op exp
   N_EQUAL       shift, and go to state 25
   N_EQUAL       [reduce using rule 13 (exp)]

State 48

  15 exp: exp . op exp
  15    | exp op exp .

   N_EQUAL       shift, and go to state 25
   N_EQUAL       [reduce using rule 15 (exp)]

State 52

  15 exp: exp . op exp
  17    | IF exp THEN exp . else_exp

   N_EQUAL       shift, and go to state 25
   N_EQUAL       [reduce using rule 20 (else_exp)]

   ELSE          [reduce using rule 20 (else_exp)]

State 53

  15 exp: exp . op exp
  18    | WHILE exp DO exp .

   N_EQUAL       shift, and go to state 25
   N_EQUAL       [reduce using rule 18 (exp)]

State 64

  15 exp: exp . op exp
  21 else_exp: ELSE exp .

   N_EQUAL       shift, and go to state 25
   N_EQUAL       [reduce using rule 21 (else_exp)]


Gramática (com símbolos normais):

initial: exp_seq
  | dec_seq

dec_seq: dec
    | dec dec_seq
    ;

id_seq: ID
    | ID , id_seq
    ;

dec: var ID := exp
    | function ID ( id_seq ) := exp

exp: /* vazio */
    | STR
    | INTEGER_LITERAL
		| ID
    | ID := exp
    | ID ( exp_list )
    | exp op exp
    | ( exp_seq )
    | if exp then exp else_exp
    | while exp do exp
    | let dec_seq in exp_seq enc
		;


else_exp: /* vazio */
    | else exp
    ;


exp_seq: exp
		| exp_seq ; exp
		;

exp_list:    exp
    | exp_list , exp
    ;

op :  *
    | /
    | +
    | -
    | =
    | <>
    | >
    | <
    | >=
    | <=
    | &
    | |
