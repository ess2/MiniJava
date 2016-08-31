package analisador.lexico;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import parser.Symbols;

// Imports adicionados
import java.io.*;
%%

%public
%class Lexer
%unicode	
%cup
%implements Symbols
%line
%column

%{
    private ComplexSymbolFactory symbolFactory;

	public Lexer(File file, ComplexSymbolFactory symbolFactory) throws IOException {
		this(new BufferedReader(new InputStreamReader(new FileInputStream(file))));
        this.symbolFactory = symbolFactory;
    }

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code, new Location(yyline+1,yycolumn+1, yychar),
		        new Location(yyline+1,yycolumn+yylength(), yychar+yylength()));
    }

    public Symbol symbol(String name, int code, String lexem){
	    return symbolFactory.newSymbol(name, code, new Location(yyline+1, yycolumn +1, yychar),
				new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
%}

%eofval{
    return symbolFactory.newSymbol("EOF", EOF);
%eofval}


identifier = (_|[A-Za-z])(_|[A-Za-z]|[0-9])*
whitespace = [ \n\t\r\f]
intliteral = 0|"-"?([1-9][0-9]*)
comment = "//".|"/*"([^"*"]|[\r\n]|("*"+([^"*/"]|[\r\n])))*"*"+"/"

%%

"boolean" {return symbolFactory.newSymbol(yytext(), BOOLEAN);}
"class" {return symbolFactory.newSymbol(yytext(), CLASS);}
"public" {return symbolFactory.newSymbol(yytext(), PUBLIC);}
"extends" {return symbolFactory.newSymbol(yytext(), EXTENDS);}
"static" {return symbolFactory.newSymbol(yytext(), STATIC);}
"void" {return symbolFactory.newSymbol(yytext(), VOID);}
"main" {return symbolFactory.newSymbol(yytext(), MAIN);}
"String" {return symbolFactory.newSymbol(yytext(), STRING);}
"int" {return symbolFactory.newSymbol(yytext(), INT);}
"while" {return symbolFactory.newSymbol(yytext(), WHILE);}
"if" {return symbolFactory.newSymbol(yytext(), IF);}
"else" {return symbolFactory.newSymbol(yytext(), ELSE);}
"return" {return symbolFactory.newSymbol(yytext(), RETURN);}
"length" {return symbolFactory.newSymbol(yytext(), LENGTH);}
"new" {return symbolFactory.newSymbol(yytext(), NEW);}
"true" {return symbolFactory.newSymbol(yytext(), TRUE, true);}
"false" {return symbolFactory.newSymbol(yytext(), FALSE, false);}
"this" {return symbolFactory.newSymbol(yytext(), THIS);}
"System.out.println" {return symbolFactory.newSymbol(yytext(), SYSO);}


";" {return symbolFactory.newSymbol(yytext(), SEMICOLON);}
"," {return symbolFactory.newSymbol(yytext(), COMMA);}
"." {return symbolFactory.newSymbol(yytext(), POINT);}
"=" {return symbolFactory.newSymbol(yytext(), ASSIGN);}


"*" {return symbolFactory.newSymbol(yytext(), MULTIPLY);}
"+" {return symbolFactory.newSymbol(yytext(), PLUS);}
"-" {return symbolFactory.newSymbol(yytext(), MINUS);}
"/" {return symbolFactory.newSymbol(yytext(), DIVISOR);}
"%" {return symbolFactory.newSymbol(yytext(), PERCENT);}


"(" {return symbolFactory.newSymbol(yytext(), OPEN_PARENT);}
")" {return symbolFactory.newSymbol(yytext(), CLOSE_PARENT);}
"{" {return symbolFactory.newSymbol(yytext(), OPEN_KEYS);}
"}" {return symbolFactory.newSymbol(yytext(), CLOSE_KEYS);}
"[" {return symbolFactory.newSymbol(yytext(), OPEN_BRACK);}
"]" {return symbolFactory.newSymbol(yytext(), CLOSE_BRACK);}


"==" {return symbolFactory.newSymbol(yytext(), EQUALS);}
">=" {return symbolFactory.newSymbol(yytext(), GREATER_EQUAL);}
"<=" {return symbolFactory.newSymbol(yytext(), LESS_EQUAL);}
">" {return symbolFactory.newSymbol(yytext(), GREATER);}
"<" {return symbolFactory.newSymbol(yytext(), LESS);}
"&&" {return symbolFactory.newSymbol(yytext(), AND);}
"||" {return symbolFactory.newSymbol(yytext(), OR);}
"!=" {return symbolFactory.newSymbol(yytext(), DIFF);}
"!" {return symbolFactory.newSymbol(yytext(), EXCLAMATION);}


{comment} {/*não cria nada*/ }
{whitespace} { /*não cria nada*/ }
{identifier} { return symbolFactory.newSymbol(yytext(), IDENTIFIER, yytext()); }
{intliteral} { return symbolFactory.newSymbol(yytext(), INTEGER, yytext()); }


. { throw new RuntimeException("Caractere ilegal! '" + yytext() + "' na linha: " + yyline + ", coluna: " + yycolumn); }
