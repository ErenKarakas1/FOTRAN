digit				[0-9]
letter				[A-Za-z]
alphanumeric        ({letter}|{digit})
identifier			(({letter})+({alphanumeric})*)
whitespace          ([ |\t|\n|\r]*)
char                ({alphanumeric}|{whitespace}|[;,=~&\|()\[\]{}])
string              ((\")({char})*(\"))
comment             ((\#)({char})*(\#))
%%
if					{return IF;}
elif                {return ELIF;}
else				{return ELSE;}
endif               {return ENDIF;}
func				{return FUNC;}
while				{return WHILE;}
foreach             {return FOREACH;}
in                  {return IN;}
return				{return RETURN;}
input               {return INPUT;}
output              {return OUTPUT;}
bool                {return TYPE;}
array               {return TYPE;}
TRUE                {return CONST;}
FALSE               {return CONST;}
{identifier}        {return IDENTIFIER;}
{string}            {return STRING;}
{comment}           {return COMMENT;}
\[					{return LSB;}
\]					{return RSB;}
\{					{return LCB;}
\}					{return RCB;}
\(					{return LP;}
\)					{return RP;}
\&                  {return AND;}
\|                  {return OR;}
\->                 {return IMPLIES;}
\<=>                {return D_IMPLIES;}
\~                  {return NOT_OP;}
\;                  {return SC;}
\,                  {return COMMA;}
\=                  {return ASSIGN;}
\n                  { extern int lineno; lineno++; }
%%
int yywrap() { return 1; }
