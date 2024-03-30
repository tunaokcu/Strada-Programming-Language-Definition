parser: y.tab.c lex.yy.c
	cc -o parser lex.yy.c y.tab.c
y.tab.c: CS315f22_team46.yacc
	yacc -d CS315f22_team46.yacc
lex.yy.c: CS315f22_team46.lex
	lex CS315f22_team46.lex
clean:
	rm -f lex.yy.c y.tab.c y.tab.h parser