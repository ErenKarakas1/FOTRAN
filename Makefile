out: lex.yy.c
	gcc -o out lex.yy.c
lex.yy.c: lex.l
	lex lex.l
