# out: lex.yy.c
# 	gcc -o out lex.yy.c
parser: lex.yy.c y.tab.c
	gcc -o parser y.tab.c

y.tab.c: CS315_S23_Team16.yacc
	yacc CS315_S23_Team16.yacc

lex.yy.c: CS315_S23_Team16.lex
	lex CS315_S23_Team16.lex

clean:
	rm -f parser lex.yy.c y.tab.c
