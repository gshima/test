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

(<[\?][^>]+[\?][>])  {printf("Peguei o xml: %s\n", yytext);} // ignora sempre o começo do xml, não considerando o primeiro <xml...>

(<[A-Za-z]+[ ]?[/][>]) {printf("Tag sem fechamento : %s\n", yytext);};

(<[/]*PRESTADOR_CIDADE>) { return BELEM_PRESTADOR_TAG; } // token da tag municipio prestador de Belem

(<[/]*TOMADOR_CIDADE>) { return BELEM_GERADOR_TAG; } // token da tag municipio gerador de Belem

(<[/]*VALOR_SERVICO>) { return BELEM_SERVICO_TAG; } // token da tag do valor de servico de Belem

(<[/]*VALOR_ISS_RET>) { return BELEM_ISS_TAG; } // token da tag do valor iss retido de Belem

(<[/]*tsMunTmd>) { return PARAUAPEBAS_GERADOR_TAG;} // token da tag municipio prestador de Parauapebas

(<[/]*tsMunPtd>) { return PARAUAPEBAS_PRESTADOR_TAG;} // token da tag municipio gerador de Parauapebas

(<[/]*tsVlrISSRet>) { return PARAUAPEBAS_ISS_TAG;} // token da tag do valor de iss retido de Parauapebas

(<[/]*tsVlrSvc>) { return PARAUAPEBAS_SERVICO_TAG;} // token da tag do valor de servico de Parauapebas

(<[/]*valorTotalServico>) { return SAOLUIS_SERVICO_TAG;} // token da tag valor de servico de Sao Luis

(<[/]*valorReducaoBC>) { return SAOLUIS_ISS_TAG;} // token da tag valor de servico de Sao Luis

(<[/]*descricaoMunicipio>) { return SAOLUIS_MUNICIPIO_TAG;} // token da tag municipio de Sao Luis

(<prestador>) { return SAOLUIS_PRESTADOR_ABRETAG;} // token da abre tag prestador de Sao Luis

(<[/]prestador>) { return SAOLUIS_PRESTADOR_FECHATAG;} // token da fecha tag prestador de Sao Luis

(<tomador>) { return SAOLUIS_GERADOR_ABRETAG;} // token da abre tag tomador de Sao Luis

(<[/]tomador>) { return SAOLUIS_GERADOR_FECHATAG;} // token da fecha tag tomador de Sao Luis

(<[/]*(ns3:)?ValorServicos>) { return CIDADES_SERVICO_TAG;} // token da tag valor de servico das cidades CORUMBA, JOAO MONLEVADE, NOVA LIMA, RIO DE JANEIRO

(<[/]*(ns3:)?IssRetido>) { return CIDADES_ISS_TAG;} // token da tag valor de servico das cidades CORUMBA, JOAO MONLEVADE, NOVA LIMA, RIO DE JANEIRO



[<][/][^>]+[>] {
  //printf("fecha:%s\n", yytext);
  return FECHATAG;
  } // token de fecha tag caso geral

[<][^>]+[>] {
  //printf("abre:%s\n", yytext);
  yylval.string = strdup(yytext); return ABRETAG;
  } // token de abre tag caso geral

[A-Za-z]+[ ]*[A-Za-z]*[ ]*[A-Za-z]* {// printf("string:%s\n", yytext);
                                        yylval.string = strdup(yytext);
                                        return STRING; // token de string
                                    }

([0-9]+[.]*[0-9]+[,][0-9]*)|([0-9]+[,]*[0-9]*)|([0-9]+[.]*[0-9]*) {   yylval.string = strdup(yytext);
                                        /*int i; int size = strlen(yytext);
                                        for(i = 0; i < size; i++)
                                        {
                                            if(yytext[i] == ',')
                                                yytext[i] = '.';
                                        }
                                        yylval.number= atof(yytext);*/
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
