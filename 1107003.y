/* C Declarations */

%{
	#include<stdio.h>
	#include<math.h>
	double PI = 3.1416;
	int sym[26];

%}




/* bison declarations */

%token NUM VAR ADD SUB MUL DIV IF ELSE GREATER SMALLER POWER FAC SIN COS TAN
%nonassoc IFX
%nonassoc ELSE
%left GREATER SMALLER
%left ADD SUB POWER FAC SIN COS TAN
%left MUL DIV




/* Grammar rules and actions follow.  */

%%

program: /* EMPTY INPUT */

	| program statement
	;

statement: ';'

	| expression ';' 				{ printf("value of expression: %d\n", $1); }

        | VAR '=' expression ';' 		{
								sym[$1] = $3;
								printf("value of the variable: %d\t\n",$3);
						}

	| IF '(' expression ')' expression ';' %prec IFX {
								if($3){
									printf("\nvalue of expression in if: %d\n",$5);
								}
								else{
								printf("condition value zero in else block\n");
								}
							}

	| IF '(' expression ')' expression ';' ELSE expression ';' {
								 	if($3){
										printf("value of the expression in if: %d\n",$5);
									}
									else{
										printf("value of the expression in else: %d\n",$8);
									}
								   }
	;

expression: NUM				{ $$ = $1; 	}

	| VAR				{ $$ = sym[$1]; }

	| expression POWER expression { $$ = pow($1,$3); }

	| expression FAC  {

         int total=1;
		 int n=$1;
		 for(;n>0;n--)
		 {

		 total*=n;
		 }
		 $$=total;

	}

	| TAN expression {

	            $$=tan($2*(PI/180));
	}

	| SIN expression {

	            $$=sin($2*(PI/180));
	}

	| COS expression {

	            $$=cos($2*(PI/180));
	}

	| expression ADD expression	{ $$ = $1 + $3; }

	| expression SUB expression	{ $$ = $1 - $3; }

	| expression MUL expression	{ $$ = $1 * $3; }

	| expression DIV expression	{ 	if($3)
				  		{
				     			$$ = $1 / $3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		}
				    	}

	| expression SMALLER expression	{ $$ = $1 < $3; }

	| expression GREATER expression	{ $$ = $1 > $3; }

	| '(' expression ')'		{ $$ = $2;	}
	;
%%




yyerror(char *s){
	printf( "%s\n", s);
}
