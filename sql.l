%{
#include <stdio.h>
#include "sql.tab.h"
/*
extern C2(void) {
  int yylex(void);
}
*/
int line_number = 1;

%}

Delimiter    [ \t]
WhiteSpace   {Delimiter}+
Letter       [A-Za-z]
Digit        [0-9]
Integer      {Digit}+
Float        {Digit}+"."{Digit}+
Date	     (0[1-9]|1[012])"/"(0[1-9]|[12][0-9]|3[01])"/"[0-9][0-9][0-9][0-9]
Other	     [-!@#$%&+:"~`]


%%
{WhiteSpace}				 { ; }
[Cc][Rr][Ee][Aa][Tt][Ee]                 {return(CREATE);}
[Dd][Rr][Oo][Pp]                         {return(DROP);}
[Ll][Oo][Aa][Dd]                         {return(LOAD);}
[Ss][Aa][Vv][Ee]                         {return(SAVE);}
[Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee]         {return(DATABASE);}
[Tt][Aa][Bb][Ll][Ee]                     {return(TABLE);}
[Ii][Nn][Ss][Ee][Rr][Tt]                 {return(INSERT);}
[Ii][Nn][Tt][Oo]                         {return(INTO);}
[Ff][Rr][Oo][Mm]                         {return(FROM);}
[Ww][Hh][Ee][Rr][Ee]                     {return(WHERE);}
[Ss][Ee][Tt]                    	 {return(SET);}
[Dd][Ee][Ll][Ee][Tt][Ee]                 {return(DELETE);}
[Uu][Pp][Dd][Aa][Tt][Ee]                 {return(UPDATE);}
[Ss][Ee][Ll][Ee][Cc][Tt]                 {return(SELECT);}
[Ww][Ss][Ee][Ll][Ee][Cc][Tt]             {return(WSELECT);}
[Vv][Aa][Ll][Uu][Ee][Ss]                 {return(VALUES);}
[Ii][Nn][Tt][Ee][Gg][Ee][Rr]             {return(INTEGER);}
[Nn][Uu][Mm][Bb][Ee][Rr]                 {return(NUMBER);}
[Cc][Hh][Aa][Rr][Aa][Cc][Tt][Ee][Rr]     {return(CHARACTER);}
[Dd][Aa][Tt][Ee]			 {return(DATE);}
[a-zA-Z][a-zA-Z0-9_]*			 {return(ID);}
"*"                      {return(AST);}
"("                      {return(LP);}
")"                      {return(RP);}
","                      {return(COMMA);}
"<"                      {return(LT);}
">"                      {return(GT);}
"<="                     {return(LTEQ);}
">="                     {return(GTEQ);}
"=="			 {return(EQEQ);}
"!="			 {return(NOTEQ);}
";"                      {return(SEMIC);}
"="			 {return(EQ);}
{Float}                  {return(DEC);}
"-"{Float}               {return(DEC);}
{Integer}                 {return(INT);}
"-"{Integer}              {return(INT);}
"'"[ \ta-zA-Z0-9]+"'"   {return(STR);}
{Date}		         {return(DATETYPE);}
\n			 { ; } 
.	                 {return 0;}
%%

