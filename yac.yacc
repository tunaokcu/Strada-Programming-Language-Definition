%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token NEWLINE COMMENT LP RP LBRACE RBRACE LINDEX RINDEX NODE NODE_METHODS SC BREAK RETURN COMMA DOT ASSIGN PLUS_ASSIGN MINUS_ASSIGN PLUS MINUS DIV MULT EXPONENTIAL MOD LESS_THAN GREATER_THAN LESS_EQ GREATER_EQ EQUALITY INEQUALITY IF ELSE FOR WHILE INT FLOAT CHAR STRING BOOL LONG BOOL_VALUE INT_VALUE FLOAT_VALUE CHAR_VALUE STRING_VALUE LONG_VALUE OR AND NOT IDENTIFIER 

%start program
%%

// Rules

program: sub_program
sub_program: stmt_list | empty ;
stmt_list: stmt_list stmt | stmt ;
stmt: NEWLINE | COMMENT | error | simple_stmt | compound_stmt ;
type_specifier: INT | FLOAT | CHAR | BOOL | STRING | LONG ;

identifier_list: IDENTIFIER | IDENTIFIER COMMA identifier_list ;
empty: ;


simple_stmt: declaration_stmt | assignment_stmt | return_stmt | break_stmt | expression SC ;
declaration_stmt: type_specifier identifier_list SC | type_specifier assignment_stmt | array_declaration | node_declaration ;
array_declaration: type_specifier array_index SC ;

assignment_stmt: IDENTIFIER assignment_operator expression SC | array_assignment ;
array_assignment: array_index assignment_operator expression SC ;



assignment_operator: ASSIGN | PLUS_ASSIGN | MINUS_ASSIGN ;

return_stmt: RETURN expression SC | RETURN SC ; 
break_stmt: BREAK SC ;

compound_stmt: function_definition_stmt | loop_stmt | conditional_stmt ;
function_definition_stmt: type_specifier IDENTIFIER LP param_list RP LBRACE sub_program RBRACE ;
param_list: empty | full_param_list ;
full_param_list: parameter | parameter COMMA param_list ;
parameter: type_specifier IDENTIFIER ;

loop_stmt: while_loop | for_loop ;
while_loop: WHILE LP bool_expression RP LBRACE sub_program RBRACE ;
for_loop: FOR LP type_specifier assignment_stmt bool_expression SC simple_stmt RP LBRACE sub_program RBRACE ;

conditional_stmt: if_stmt | if_else_stmt ;
if_stmt: IF LP bool_expression RP LBRACE sub_program RBRACE ;
if_else_stmt: IF LP bool_expression RP LBRACE sub_program RBRACE ELSE LBRACE sub_program RBRACE ;

expression: bool_expression ; 
bool_expression: expression OR bool_term | bool_term ;
bool_term: bool_term AND relational_term | relational_term ;
relational_term: bool_factor relational_operators bool_factor | bool_factor ;
relational_operators: LESS_THAN | GREATER_THAN | EQUALITY | INEQUALITY | LESS_EQ | GREATER_EQ ;
bool_factor: arithmetic_expression | NOT arithmetic_expression ;
//arithmetic_expression relational_operators arithmetic_expression || NOT LP arithmetic_expression relational_operators arithmetic_expression RP || IDENTIFIER || NOT IDENTIFIER || BOOL_VALUE ; 


arithmetic_expression: arithmetic_expression PLUS term | arithmetic_expression MINUS term | term ;
term: term DIV simple_expression | term MULT simple_expression | simple_expression ;
simple_expression: constant_expression | array_index | func_call_expression | method_call_expression | IDENTIFIER ;
constant_expression: INT_VALUE | FLOAT_VALUE | CHAR_VALUE | STRING_VALUE | LONG_VALUE | BOOL_VALUE ;








array_index: IDENTIFIER LINDEX expression RINDEX ;
func_call_expression: IDENTIFIER LP argument_list RP ; 

argument_list: empty | full_argument_list ;
full_argument_list: expression | expression COMMA argument_list ; 

node_declaration: NODE IDENTIFIER SC ;
method_call_expression: IDENTIFIER DOT NODE_METHODS LP argument_list RP ;


%%

void yyerror(char* s) {
   fprintf(stderr, "line %d: %s\n", yylineno, s);

}
int main(void){
 yyparse();

}

