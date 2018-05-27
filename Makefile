all:
	bison -d trab2.y
	flex trab2.lex
	gcc trab2.tab.c lex.yy.c -o conta -lfl
