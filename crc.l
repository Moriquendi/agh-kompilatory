%{
  #include "dstruct.h"
  #include "y.tab.h"
  #include <string.h>
%}


%s CL VAR METHOD

ws    [ \t]
nonws [^ \t\n]
word  {ws}*{nonws}+
words {word}{ws}+

validName [a-zA-Z][a-zA-Z0-9]*

%%


[ \t\n]*  {}
class       {BEGIN CL;
             return CLASS; }
"{"         { return BEGIN_SCOPE; }
"}"         {return END; }

  /*
RESPONSIBILITY {BEGIN METHOD;
                return RESPONSIBILITY; }
                */
                /*
COLABRATION    {return COLABRATION; }
  */

[;]            { return yytext[0]; }
"("            { return OPEN_BRACKET; }
")"            { return CLOSE_BRACKET; }

int            {BEGIN VAR; return INT; }
char           {BEGIN VAR; return CHAR; }

  /*
"*"            {return PTR; }
USING          {return USING; }
HAS_A          {return HAS_A; }
KIND_OF        {return KIND_OF; }
  */

<CL>{word}    {BEGIN INITIAL;
                          strcpy(yylval.stval,yytext);
                          return CLASSNAME; }
                          /*
<VAR>{validName}       { BEGIN INITIAL;
                                strcpy(yylval.stval,yytext);
                                return METHODNAME; }
*/
<VAR>{validName}           { BEGIN INITIAL;
                           strcpy(yylval.stval,yytext);
                           return VARIABLE; }

[a-zA-Z][a-zA-Z0-9]*  { return STRING; }

%%
int yywrap(void)
{return 1;
}
