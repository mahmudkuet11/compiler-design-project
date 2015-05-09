/* C Declarations */

%{
	#include<stdio.h>
	#include "1107003.tab.h"
	#include<stdlib.h>
	extern int yylval;
%}

/* RE and Actions */

%%

[0-9]+	{
		yylval = atoi(yytext);
		return NUM;
	}

[a-z]	{
		yylval = *yytext - 'a';
		return	VAR;
	}

"_if"	{ return IF;	}
"_else"	{ return ELSE;	}
"_add_"  {return ADD;}
"_sub_" {return SUB;}
"_mul_" {return MUL;}
"_div_"  {return DIV;}
">>" {return GREATER;}
"<<" {return SMALLER;}
"_pow_"  {return POWER;}
"_fact"    {return FAC;}
"_tan"    {return TAN;}
"_sin"    {return SIN;}
"_cos"    {return COS;}
[-+/*<>=,();] 	{
			yylval = yytext[0];
			return *yytext;
		}

[ \t\n]*	;

.	{
		yyerror("Unknown Character.\n");
	}
%%

int yywrap()
{

return 1;
}

main(){
yyin=fopen("input.txt","r");
	yyparse();

}
