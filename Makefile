all:	
	flex trab1.lex
	gcc lex.yy.c -o conta -lfl