final.tab.c final.tab.h: final.y
	bison -d final.y

lex.yy.c: final.l final.tab.h
	flex final.l

final: lex.yy.c final.tab.c final.tab.h
	g++ final.tab.c lex.yy.c -lfl -o final
