%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

extern int yylineno;

%}

SIGN				"-"|"+"
DIGIT_NN			[1-9]

DIGIT				"0"|{DIGIT_NN}
NUMBER				{DIGIT}+
NUMBER_NN			{DIGIT_NN}{NUMBER}|"0"
INT					{SIGN}?{NUMBER_NN}
FLOAT				{INT}"."{NUMBER}?
STRING			"\""[a-zA-Z0-9!><?*&^%$#(){}\[\]+=-_:;\|]*"\""|""

TYPE				"char"|"bool"|"float"|"int"|"string"
RESERVED_WORDS		{TYPE}|"if"|"for"|"cin"|"cout"|"void"|"return"

OPERATOR			"+"|"-"|"/"|"*"|"%"
COMPARISON_CHAR		"and"|"&&"|"or"|"||"
RELATION_CHAR		">"|"<"|">="|"<="|"=="|"!="
CHAR				"\""{LETTER}"\""|"\""{DIGIT}"\""|"\""[!><?*&^%$#(){}\[\]+=-_:;\|]"\""
ID					{LETTER}{ID_LIST}?
BOOL				"true"|"false"
CONST				{FLOAT}|{BOOL}|{CHAR}|{INT}|{STRING}
CONST_ID			{CONST}|{ID}
ID_LEX				{LETTER}|{DIGIT}|"_"
ID_LIST				{ID_LEX}+
LETTER				[a-zA-Z] 


%%


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

\n                  { yylineno++; }

[ \t]+  { /* Ignore whitespace */ }

.*         {}

%%


