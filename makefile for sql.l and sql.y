trial: lex.yy.o sql.tab.o sql.o
	cc -o trial lex.yy.o sql.tab.o sql.o 

sql.o: sql.c 
	cc -c sql.c

sql.tab.o: sql.tab.c
	cc -c sql.tab.c

sql.tab.c: sql.y
	bison -d sql.y

lex.yy.o: lex.yy.c 
	cc -c lex.yy.c

lex.yy.c: sql.l sql.tab.c
	flex --header-file=lexer.h sql.l
