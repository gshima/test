/* Nome: Mariane Tiemi Iguti      RA: 147279
   Nome: Gabriela Akemi Shima     RA: 135819

   EA876 -Trabalho 01 */
%{

#include <stdlib.h>
#include <string.h>

void yyerror(char *);
#include "y.tab.h"

//
%}

%%

(<[\?][^>]+[\?][>])  {printf("Peguei o xml: %s\n", yytext);}; // ignora sempre o começo do xml, não considerando o primeiro <xml...>

(<[/]*PRESTADOR_CIDADE>) { return BELEM_PRESTADOR_TAG; } // token da tag municipio prestador de Belem

(<[/]*TOMADOR_CIDADE>) { return BELEM_GERADOR_TAG; } // token da tag municipio gerador de Belem

(<[/]*VALOR_SERVICO>) { return BELEM_SERVICO_TAG; } // token da tag do valor de servico de Belem

(<[/]*VALOR_ISS_RET>) { return BELEM_ISS_TAG; } // token da tag do valor iss retido de Belem


[<][/][^>]+[>] { printf("fecha:%s\n", yytext);return FECHATAG; } // token de fecha tag caso geral

[<][^>]+[>] { printf("abre:%s\n", yytext); yylval.string = strdup(yytext); return ABRETAG; } // token de abre tag caso geral

[A-Za-z]+[ ]*[A-Za-z]*[ ]*[A-Za-z]* {// printf("string:%s\n", yytext);
                                        yylval.string = strdup(yytext);
                                        return STRING; // token de string
                                    }

([0-9]+[,]*[0-9]*)|([0-9]+[.]*[0-9]*) {
                                        int i; int size = strlen(yytext);
                                        for(i = 0; i < size; i++)
                                        {
                                            if(yytext[i] == ',')
                                                yytext[i] = '.';
                                        }
                                        yylval.number= atof(yytext);
                                       //printf("numero:%.2f\n", yylval.number);
                                        return NUMERO; // token para numeros float e ints

                                      }

[\t]* ;
[\n]* ;
. ;

%%

int yywrap()
{
  return 1;
}
