grammar Microlexer;

/* Program */
empty							: ;
program           : PROGRAM id BEGIN pgm_body END ;
id                : IDENTIFIER ;
pgm_body          : decl func_declarations ;
decl							: string_decl_list | var_decl_list | decl ;

/* Global String Declaration */
string_decl_list  : string_decl_list string_decl | string_decl ;
string_decl       : STRING id ':=' str ';' | empty;
str               : STRINGLITERAL ;
string_decl_tail  : string_decl_tail string_decl | string_decl ;


/* Variable Declaration */
var_decl_list     : var_decl_list var_decl | var_decl ;
var_decl          : var_type id_list ';' | empty ;
var_type	        : FLOAT | INT ;
any_type          : var_type | VOID ;
id_list           : id id_tail ;
id_tail           : ',' id id_tail | empty ;
var_decl_tail     : var_decl_tail var_decl | var_decl ;

/* Function Paramater List */
param_decl_list   : param_decl param_decl_tail ;
param_decl        : var_type id ;
param_decl_tail   : ',' param_decl param_decl_tail | empty ;

/* Function Declarations */
func_declarations : func_decl func_decl_tail? ;
func_decl         : FUNCTION any_type id (param_decl_list?) BEGIN func_body END | empty ;
func_decl_tail    : func_decl_tail func_decl | func_decl ;
func_body         : decl stmt_list ;

/* Statement List */
stmt_list         : stmt stmt_tail | empty;
stmt_tail         : stmt stmt_tail | empty;
stmt              : base_stmt | if_stmt | do_while_stmt ;
base_stmt         : assign_stmt | read_stmt | write_stmt | return_stmt ;

/* Basic Statements */
assign_stmt       : assign_expr ;
assign_expr       : id ':=' expr ;
read_stmt         : READ ( id_list ) ;
write_stmt        : WRITE ( id_list ) ;
return_stmt       : RETURN expr ;

/* Expressions */
expr              : factor expr_tail ;
expr_tail         : addop factor expr_tail | empty;
factor            : postfix_expr factor_tail ;
factor_tail       : mulop postfix_expr factor_tail | empty;
postfix_expr      : primary | call_expr ;
call_expr         : id ( expr_list? ) ;
expr_list         : expr expr_list_tail ;
expr_list_tail    : ',' expr expr_list_tail | empty;
primary           : '('expr')' | id | INTLITERAL | FLOATLITERAL ;
addop             : '+' | '-' ;
mulop             : '*' | '/' ;

/* Complex Statements and Condition */ 
if_stmt           : IF ( cond ) decl? stmt_list else_part ENDIF ;
else_part         : ELSIF ( cond ) decl? stmt_list else_part | empty;
cond              : expr compop expr | TRUE | FALSE ;
compop            : '<' | '>' | '=' | '!=' | '<=' | '>=' ;

/* ECE 468 students use this version of do_while_stmt */
do_while_stmt       : DO decl? stmt_list WHILE ( cond ) ;


KEYWORD 			: ('PROGRAM'|'BEGIN'|'END'|'FUNCTION'|'READ'|'WRITE'|'IF'|
								'ELSIF'|'ENDIF'|'DO'|'WHILE'|'CONTINUE'|'BREAK'|'RETURN'|
								'INT'|'VOID'|'STRING'|'FLOAT'|'TRUE'|'FALSE') ;

IDENTIFIER 		: [a-zA-Z][a-zA-Z0-9]* ;

FLOATLITERAL 	: [0-9]*[\.][0-9]+ ;

INTLITERAL 		: [0-9]+ ;

STRINGLITERAL : '"'.+?'"' ;

OPERATOR 		: ([+\-*/=<>();,] | (':='|'!='|'<='|'>=')) ;

COMMENTS 			: '--'.*?'\n' -> skip ;
WS  					: [ \t\n\r]+ -> skip ;
