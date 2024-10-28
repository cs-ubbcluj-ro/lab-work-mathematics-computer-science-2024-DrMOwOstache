%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 1000

enum tokens {
	Identifier,
	Constant,
	Reserved word,
	Separator,
	Operator
}

enum type {
	INTEGER,
	FLOAT,
	CHARACTER,
	BOOL,
	STRING
}

typedef struct {
	char name[50];
} Symbol;

Symbol symbol_table[MAX_SYMBOLS];
int symbol_count = 0;

void add_symbol(const char *name) 
{
	if (symbol_count < MAX_SYMBOLS) 
	{
		for(int i = 0; i<symbol_count; i++)
			if(strcmp(symbol_table[symbol_count].name, name)==0)
				return;
		strcpy(symbol_table[symbol_count].name, name);
        	symbol_count++;
        } 
        else 
        	printf("Symbol table overflow!\n");
}

void print_symbol_table() {
    	printf("Symbol Table:\n");
    	for (int i = 0; i < symbol_count; i++) 
		printf("Name: %s, Position: %d\n", symbol_table[i].name, i);
}

%}

SEPARATOR		[\<\>\{\}\[\]\(\):; \n\t]
OPERATORS_PREDEFINED	"<<"|">>"|"+"|"-"|"/"|"*"|"%"|"<"|"<="|">"|">="|"=="|"="|"!="|"&&"|"||"

SIGN			"-"|"+"
DIGIT_NN		[1-9]
DIGIT			"0"|{DIGIT_NN}
NUMBER			{DIGIT}+
NUMBER_NN		{DIGIT_NN}{NUMBER}|"0"
INT			{SIGN}?{NUMBER_NN}
FLOAT			{INT}"."{NUMBER}?
BOOL			"true"|"false"
LETTER			[a-zA-Z] 
CHAR			"LETTER"|"DIGIT"|[!><?*&^%$#(){}\[\]+=-_:;\|]
STRING			\"{CHAR}*\"|""
CONST			{FLOAT}|{BOOL}|{CHAR}|{INT}|{STRING}
TYPE			"char" | "bool" | "float" | "int" | "string"
RESERVED_WORDS		{TYPE}|"if"|"for"|"cin"|"cout"|"void"|"return"
ID_LEX			{LETTER}|{DIGIT}|"_"
ID_LIST			{ID_LEX}+
ID			{LETTER}{ID_LIST}?
OPERATOR		"+"|"-"|"/"|"*"|"%"
COMPARITOR		"and"|"&&"|"or"|"||"
CONST_ID		{CONST}|{ID}
RELATION_CHAR		">" | "<" | ">=" | "<=" | "==" | "!="

%%

{RESERVED_WORDS}	{
				printf("RESERVED_WORDS: %s\n", yytext);
			}
			
{ID}			{
				printf("IDENTIFIER: %s\n", yytext);
				add_symbol(yytext)
			}

{SEPARATOR}		{
				printf("SEPARATOR: %s\n" yytext);
			}

{CONST}			{
				printf("CONSTANT: %s\n", yytext);
			}
			
{OPERATORS_PREDEFINED}	{
				printf("OPERATORS_PREDEFINED: %s\n", yytext);
			}

[ \t\n]+  { /* Ignore whitespace */ }

%%

int main(int argc, char **argv) {
    yylex();  // Start scanning
    print_symbol_table(); // Print the symbol table
    return 0;
}

int yywrap() {
    return 1;
}
