%token COMMENT LP RP LBRACE RBRACE LINDEX RINDEX
%token NODE NODE_METHODS
%token SC BREAK RETURN COMMA DOT
%token ASSIGN PLUS_ASSIGN MINUS_ASSIGN PLUS MINUS DIV MULT EXPONENTIAL MOD 
%token LESS_THAN GREATER_THAN LESS_EQ GREATER_EQ EQUALITY INEQUALITY 
%token IF ELSE FOR WHILE 
%token INT FLOAT CHAR STRING BOOL LONG NULL
%token  BOOL_VALUE INT_VALUE FLOAT_VALUE CHAR_VALUE STRING_VALUE  LONG_VALUE
%token OR AND NOT IDENTIFIER 


%start program
%%

// Rules

program: stmt_list ;
stmt_list: stmt_list COMMENT | stmt_list stmt | stmt  | COMMENT | empty ;
stmt: simple_stmt | compound_stmt ;
type_specifier: INT | FLOAT | CHAR | BOOL | STRING | LONG | NODE ;


identifier_list: IDENTIFIER | IDENTIFIER COMMA identifier_list ;
empty: ;

simple_stmt: declaration_stmt | assignment_stmt | return_stmt | break_stmt | expression;
declaration_stmt: type_specifier identifier_list SC |  type_specifier assignment_stmt | array_declaration | node_declaration ;
array_declaration: type_specifier array_index SC ;

assignment_stmt: IDENTIFIER assignment_operator expression SC | 
array_assignment ;
array_assignment: array_index assignment_operator expression SC ;

assignment_operator:  | PLUS_ASSIGN | MINUS_ASSIGN ;

return_stmt: RETURN expression SC | RETURN SC ; 
break_stmt: BREAK SC ;

compound_stmt: function_definition_stmt | loop_stmt | conditional_stmt ;

function_definition_stmt:  type_specifier IDENTIFIER LP param_list RP LBRACE stmt_list RBRACE ;

param_list: empty | parameter | parameter COMMA param_list ;
parameter: type_specifier IDENTIFIER ;

loop_stmt: while_loop |  for_loop ;
while_loop: WHILE LP bool_expression RP LBRACE stmt_list RBRACE ;
for_loop: FOR LP type_specifier assignment_stmt SC bool_expression SC expression RP  LBRACE stmt_list RBRACE ; 
conditional_stmt: if_stmt | if_else_stmt ;
if_stmt: IF LP bool_expression RP LBRACE stmt_list RBRACE ;
if_else_stmt: IF LP bool_expression RP LBRACE stmt_list RBRACE ELSE LBRACE stmt_list RBRACE ;

expression: simple_expression | compound_expression ;

simple_expression: constant_expression | array_index | func_call_expression | method_call_expression | IDENTIFIER ;
constant_expression: INT_VALUE | FLOAT_VALUE | CHAR_VALUE | STRING_VALUE | BOOL_VALUE | LONG_VALUE ;

array_index: IDENTIFIER LINDEX expression RINDEX ;
func_call_expression: IDENTIFIER LBRACE argument_list RBRACE ; 

compound_expression: arithmetic_expression | bool_expression ;
arithmetic_expression: arithmetic_expression PLUS term | arithmetic_expression MINUS term | term ;
term: term DIV simple_expression | term MULT simple_expression | simple_expression ;
bool_expression: simple_expression relational_operators simple_expression | BOOL_VALUE | NOT BOOL_VALUE | IDENTIFIER | NOT IDENTIFIER | IDENTIFIER bool_operators IDENTIFIER ;

argument_list: empty | expression | expression COMMA argument_list ; 

relational_operators: LESS_THAN | GREATER_THAN | EQUALITY | INEQUALITY | LESS_EQ | GREATER_EQ ;
bool_operators: AND | OR ;


node_declaration: NODE IDENTIFIER SC ;
method_call_expression: IDENTIFIER DOT NODE_METHODS LP argument_list RP ;

%%
