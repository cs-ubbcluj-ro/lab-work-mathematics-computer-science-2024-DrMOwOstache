%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "trok_yacc.tab.h"

extern int yylineno;

%}

SEPARATOR				[\<\>\{\}\[\]\(\):\;]
OPERATORS_PREDEFINED	"<<"|">>"|"+"|"-"|"/"|"*"|"%"|"<"|"<="|">"|">="|"=="|"="|"!="|"&&"|"||"

SIGN				"-"|"+"
DIGIT_NN			[1-9]
DIGIT				"0"|{DIGIT_NN}
NUMBER				{DIGIT}+
NUMBER_NN			{DIGIT_NN}{NUMBER}|"0"
INT					{SIGN}?{NUMBER_NN}
FLOAT				{INT}"."{NUMBER}?
BOOL				"true"|"false"
LETTER				[a-zA-Z] 
CHAR				"LETTER"|"DIGIT"|[!><?*&^%$#(){}\[\]+=-_:;\|]
STRING				"\""{CHAR}*"\""|""
CONST				{FLOAT}|{BOOL}|{CHAR}|{INT}|{STRING}
TYPE				"char"|"bool"|"float"|"int"|"string"
RESERVED_WORDS		{TYPE}|"if"|"for"|"cin"|"cout"|"void"|"return"
ID_LEX				{LETTER}|{DIGIT}|"_"
ID_LIST				{ID_LEX}+
ID					{LETTER}{ID_LIST}?
OPERATOR			"+"|"-"|"/"|"*"|"%"
COMPARISON_CHAR		"and"|"&&"|"or"|"||"
CONST_ID			{CONST}|{ID}
RELATION_CHAR		">"|"<"|">="|"<="|"=="|"!="

%%

{SEPARATOR}			{
						return(SEPARATOR);
					}

{OPERATORS_PREDEFINED}	{return(OPERATORS_PREDEFINED);}


{NUMBER_NN}			{
						return(NUMBER_NN);
					}

{CONST}				{
						return(CONST);
					}

{TYPE}				{
						return(TYPE);
					}

{ID_LIST}			{
						return(ID_LIST);
					}

{ID}				{
						return(ID);
					}

{RESERVED_WORDS}	{
						return(RESERVED_WORDS);
					}

{OPERATOR}			{
						return(OPERATOR);
					}

{COMPARISON_CHAR}	{
						return(COMPARISON_CHAR);
					}

{CONST_ID}			{
						return(CONST_ID);
					}

{RELATION_CHAR}		{
						return(RELATION_CHAR);
					}

"cin"              	{ return(I_KEYWORD); }
"cout"             	{ return(O_KEYWORD); }
"for"              	{ return(FOR_KEYWORD); }
"return"           	{ return(RETURN_KEYWORD); }
"if"               	{ return(IF_KEYWORD); }
"else"             	{ return(ELSE_KEYWORD); }
"void"             	{ return(VOID_KEYWORD); }
">>"				{ return(INPUT); }
"<<"				{ return(OUTPUT); }


[ \t\n]+  { /* Ignore whitespace */ }

\n                  { yylineno++; }

%%

int main(int argc, char **argv) {
    yylex();  // Start scanning
    //print_symbol_table(); // Print the symbol table
    return yyparse();
}

yywrap()
{
  return(1);
}
