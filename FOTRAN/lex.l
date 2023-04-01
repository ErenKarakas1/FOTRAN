%option main
digit				[0-9]
letter				[A-Za-z]
alphanumeric        ({letter}|{digit})
operation           <=>|\||\&|=>|^
op                  ({operation}{1})
identifier			(({letter})+({alphanumeric})*)
whitespace          \ |\n
char                ({alphanumeric}|{whitespace}|[;,=~&\|()\[\]{}])
string              ((\")({char})*(\"))
comment             ((\#)({char})*(\#))
%%
if					printf("IF ");
else				printf("ELSE ");
func				printf("FUNC");
while				printf("WHILE ");
foreach             printf("FOREACH ");
in                  printf("IN ");
return				printf("RETURN");
input               printf("INPUT");
output              printf("OUTPUT");
bool                printf("TYPE_DEF");
array               printf("TYPE_DEF");
TRUE                printf("CONST ");
FALSE               printf("CONST ");
{identifier}        printf("IDENTIFIER ");
{op}                printf("OP ");
{string}            printf("STRING ");
{comment}           printf("COMMENT ");
\[					printf("LSB ");
\]					printf("RSB ");
\{					printf("LCB ");
\}					printf("RCB ");
\(					printf("LP ");
\)					printf("RP ");
\;                  printf("SC ");
\,                  printf("COMMA ");
\=                  printf("ASSIGN ");
\~                  printf("NOT_OP ");
