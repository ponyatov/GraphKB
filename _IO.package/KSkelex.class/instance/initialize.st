initialization
initialize
	| files |
	
	super initialize: 'skelex'.
	
	log := ( dir / 'log.log' ) writeStream. log close.
	src := ( dir / 'src.src' ) writeStream. src close.
	
	ypp := ( dir / 'ypp.ypp' ) writeStream. ypp lineEndConvention: #lf.
	ypp nextPutAll: ( KYACC headline ) , '
%{
#include "hpp.hpp"
%}
%defines %union {  Sym*o; }
%token <o> SYM
%%
REPL : | REPL SYM { cout << $2 << endl; }
%%
' ; close.
	
	lpp := ( dir / 'lpp.lpp' ) writeStream. lpp lineEndConvention: #lf.
	lpp nextPutAll: ( KLEX headline ) , '
%{
#include "hpp.hpp"
%}
%option noyywrap yylineno
%%
' ; close.
	
	cpp nextPutAll: '
#define YYERR "\n\n"<<yylineno<<":"<<msg<<"["<<yytext<<"]\n\n"
void yyerror(string msg) { cout<<YYERR; cerr<<YYERR; exit(-1); }
int main(){ return yyparse(); }
' ; close.
	
	hpp nextPutAll: '
struct Sym {
	Sym(string);
};

extern int yylex();
extern int yylineno;
extern char* yytext;
#define TOC(C,X) { yylval.o = new C(yytext); return X; }
extern int yyparse();
extern void yyerror(string);

#endif // _H_HPP
' ; close.
	
	mk nextPutAll: '
log.log: src.src ./exe.exe
	./exe.exe < $< > $@ && tail $(TAIL) $@
C = cpp.cpp ypp.tab.cpp lex.yy.c
H = hpp.hpp ypp.tab.hpp
./exe.exe: $(C) $(H)
	$(CXX) $(CXXFLAGS) -o $@ $(C) $(L)
ypp.tab.cpp: ypp.ypp
	bison $<
lex.yy.c: lpp.lpp
	flex $<
'; close.

	gitignore nextPutAll: '
ypp.tab.?pp
lex.yy.c
' ; close.

	files := 'log.log src.src ypp.ypp lpp.lpp hpp.hpp cpp.cpp'.
	bat nextPutAll: files; close.
	rc  nextPutAll: files; close.
