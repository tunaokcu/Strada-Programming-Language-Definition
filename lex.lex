%{
#include <stdio.h>
#include "y.tab.h"
extern int yylval;
void yyerror(char *);
%}
%option yylineno


digit	[0-9]
alphabetic	[A-Za-z] 
alphanumeric	[A-Za-z0-9_] 
char	[.|\n]
delimiter	[;:!"#$%&'()*+,-./<=>?@ ^_|{}~]
%% 
\n	{ /*extern int lineno; lineno++;*/ return(NEWLINE); }
\/\*({delimiter}|{alphanumeric})*\*\/	return(COMMENT);
Node	return(NODE);
flipSwitch|isOn|time|connect|send|receive|getSensor|getSensorNames|getConnectionNames|removeConnection	return(NODE_METHODS);
\;	return(SC);
\=	return(ASSIGN); 
\+\=	return(PLUS_ASSIGN);
\-\=	return(MINUS_ASSIGN);
\+	return(PLUS);
\-	return(MINUS);
\/	return(DIV);
\*	return(MULT);
\*\*	return(EXPONENTIAL);
\%	return(MOD);
\<	return(LESS_THAN);
\>	return(GREATER_THAN);
\<\=	return(LESS_EQ);
\>\=	return(GREATER_EQ);
\=\=	return(EQUALITY);
\!\=	return(INEQUALITY);
if	return(IF);
else 	return(ELSE);
for 	return(FOR);
while 	return(WHILE);
\(	return(LP);
\)	return(RP);
\{	return(LBRACE);
\}	return(RBRACE);
\[	return(LINDEX);
\]	return(RINDEX);
int	return(INT);
float	return(FLOAT);	
char	return(CHAR);
string	return(STRING);
bool	return(BOOL);
long	return(LONG);
break	return(BREAK);
return	return(RETURN);
true	return(BOOL_VALUE);
false	return(BOOL_VALUE);
{digit}+	return(INT_VALUE);
[-]?{digit}*(\.)?{digit}+	return(FLOAT_VALUE);
\'{alphanumeric}*\' return(CHAR_VALUE);
\"({alphanumeric}|{delimiter})*\"	return(STRING_VALUE);
\|\|	return(OR);
\&\&	return(AND);
\!	return(NOT);
_*{alphabetic}+{alphanumeric}*	return(IDENTIFIER);
\,	return(COMMA);
\.	return(DOT);


%% 
int yywrap() { return 1; }
