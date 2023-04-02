%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
int error_count = 0;
%}
%token IF ELIF ELSE ENDIF FUNC WHILE FOREACH IN RETURN
%token INPUT OUTPUT
%token  TYPE CONST
%token  IDENTIFIER STRING COMMENT
%token  LSB RSB LCB RCB LP RP SC COMMA
%token  D_IMPLIES IMPLIES AND OR NOT_OP ASSIGN

%left   D_IMPLIES
%right  IMPLIES
%left   AND
%left   OR
%left   NOT_OP
%right  ASSIGN

%%
program:
    stmt_list
;

stmt_list:
    stmt
    | stmt stmt_list
;

stmt:
    while_loop
    | foreach_loop
    | decleration_stmt
    | output_stmt
    | input_stmt
    | return_stmt
    | assignment_stmt
    | if_stmt
    | fixed_array_decleration
    | function
    | func_call
    | COMMENT
    | error SC { yyerrok; }
;

decleration_stmt:
    identifier_list SC
;

output_stmt:
    OUTPUT STRING SC
    | OUTPUT logic_expr SC
;

input_stmt:
    INPUT identifier_list SC
;

return_stmt:
    RETURN logic_expr SC
;

assignment_stmt:
    IDENTIFIER ASSIGN logic_expr SC
;

if_stmt:
    IF LP logic_expr RP LCB stmt_list RCB ENDIF
    | IF LP logic_expr RP LCB stmt_list RCB elif_stmt ENDIF
    | IF LP logic_expr RP LCB stmt_list RCB ELSE LCB stmt_list RCB ENDIF
    | IF LP logic_expr RP LCB stmt_list RCB elif_stmt ELSE LCB stmt_list RCB ENDIF
;

elif_stmt:
    ELIF LP logic_expr RP LCB stmt_list RCB
    | ELIF LP logic_expr RP LCB stmt_list RCB elif_stmt
;

fixed_array_decleration:
    IDENTIFIER LSB expr_list RSB SC
;

function:
    FUNC TYPE IDENTIFIER LP identifier_list RP LCB stmt_list RCB
;

func_call:
    IDENTIFIER LP expr_list RP
;

foreach_loop:
    FOREACH IDENTIFIER IN IDENTIFIER LCB stmt_list RCB
    | FOREACH IDENTIFIER IN LP const_list RP LCB stmt_list RCB
;

while_loop:
    WHILE LP logic_expr RP LCB stmt_list RCB
;

identifier_list:
    IDENTIFIER
    | IDENTIFIER COMMA identifier_list
;

logic_expr:
    logic_expr D_IMPLIES implies_term
    | implies_term
;

implies_term:
    or_term IMPLIES implies_term
    | or_term
;

or_term:
    or_term OR and_term
    | and_term
;

and_term:
    and_term AND not_term
    | not_term
;

not_term:
    NOT_OP value
    | value
;

value:
    IDENTIFIER
    | CONST
    | LP logic_expr RP
    | func_call
;

const_list:
    CONST
    | CONST COMMA const_list
;

expr_list:
    logic_expr
    | logic_expr COMMA expr_list
;
%%
#include "lex.yy.c"
int lineno = 1;

int main() {
    yyparse();
    if (error_count > 0) {
        printf("\nTotal syntax errors: %d\n", error_count);
    }
    else {
        printf("Input program is valid\n");
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "%s on line %d!\n", s, lineno);
    error_count++;
}