%{
#include <stdio.h>
#include <stdlib.h>    
    
extern int yylineno;

extern int yydebug = 1;

%}

%union {
    int int_val;
    float float_val;
    char char_val;
    char* str_val;
}

%token <int_val> NUMBER_NN 
%token <str_val> COMPARISON_CHAR RESERVED_WORDS CONST_ID RELATION_CHAR CONST TYPE
%token <char_val> OPERATOR
%token ID_LIST ID
%token I_KEYWORD O_KEYWORD FOR_KEYWORD RETURN_KEYWORD IF_KEYWORD ELSE_KEYWORD VOID_KEYWORD INPUT OUTPUT

%left '+' '-' 
%left '*' '/' '%'
%left UMINUS 

%nonassoc '.' 

%start function_dec_list

%%

function_dec_list:
      function_dec
    | function_dec function_dec_list
    ;

function_dec:
      TYPE ID '(' declaration_list ')' '{' statement_list return_stmt ';' '}'
    | VOID_KEYWORD ID '(' declaration_list ')' '{' statement_list '}'
    | TYPE ID '(' ')' '{' statement_list return_stmt ';' '}'
    | VOID_KEYWORD ID '(' ')' '{' statement_list '}'
    ;

statement_list:
      statement ';'
    | statement ';' statement_list
    | /* epsilon */
    ;

statement:
      simple_stmt
    | struct_stmt
    | return_stmt
    ;

return_stmt:
      RETURN_KEYWORD relation_list
    | RETURN_KEYWORD expresion 
    ;

struct_stmt:
      for_stmt
    | if_statement
    ;

for_stmt:
      FOR_KEYWORD '(' declaration_list ';' relation_list ';' assign_list ')' statement
    | FOR_KEYWORD '(' declaration_list ';' relation_list ';' assign_list ')' '{' statement_list '}'
    ;

simple_stmt:
      io_statement
    | assign_stmt
    | func_ref
    | declaration_list
    ;

assign_list:
      assign_stmt
    | assign_stmt ',' assign_list
    ;

io_statement:
      I_KEYWORD INPUT ID
    | O_KEYWORD OUTPUT func_ref
    | O_KEYWORD OUTPUT ID
    | O_KEYWORD OUTPUT CONST
    ;     

if_statement:
      IF_KEYWORD '(' relation_list ')' statement_list
    | IF_KEYWORD '(' relation_list ')' statement_list ELSE_KEYWORD statement_list
    | IF_KEYWORD '(' relation_list ')' statement_list ELSE_KEYWORD ' ' if_statement
    ;

relation_list:
      relation
    | relation COMPARISON_CHAR relation_list
    ;

relation:
      expresion RELATION_CHAR expresion

expresion:
      ID
    | ID OPERATOR expresion
    | CONST
    | CONST OPERATOR expresion
    | func_ref
    | func_ref OPERATOR expresion
    ;


declaration_list:
      declaration
    | declaration ',' declaration_list
    ;

declaration:
      TYPE ' ' ID '=' CONST
    | TYPE ' ' ID '[' NUMBER_NN ']' '=' array_dec
    | TYPE ' ' ID
    ;

assign_stmt:
      ID '=' ID
    | ID '=' func_ref
    | ID '=' CONST
    ;

func_ref:
      ID '(' ')'
    | ID '(' const_id_list ')'
    ;

const_id_list:
      CONST_ID
    | CONST_ID ',' const_id_list
    ;

array_dec:
      '{' '}'
    | '{' const_list '}'
    ;

const_list:
      CONST
    | CONST ',' const_list
    ;


%%

void yyerror(s)
char *s;
{   
 fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
} 

int main(int argc, char **argv) {
    //yylex();  // Start scanning
    //print_symbol_table(); // Print the symbol table
    return yyparse();
}

yywrap()
{
  return(1);
}
