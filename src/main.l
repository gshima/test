/* Nome: Mariane Tiemi Iguti RA: 147279
   EA876 -Trabalho 01 */
%{

#include <stdlib.h>
#include <string.h>

void yyerror(char *);
#include "y.tab.h"

%}

%%

(<[\?]xml[^>]+[>]) ; // ignora sempre o começo do xml, não considera o primeiro <xml...>

(<[/]*PRESTADOR_CIDADE>) { return BELEM_PRESTADOR_TAG; } // token da tag municipio prestador de Belem

(<[/]*TOMADOR_CIDADE>) { return BELEM_GERADOR_TAG; } // token da tag municipio gerador de Belem

(<[/]*VALOR_SERVICO>) { return BELEM_SERVICO_TAG; } // token da tag do valor de servico de Belem

(<[/]*VALOR_ISS_RET>) { return BELEM_ISS_TAG; } // token da tag do valor iss retido de Belem

(<[/]*tsMunTmd>) { return PARAUAPEBAS_GERADOR_TAG;} // token da tag municipio prestador de Parauapebas

(<[/]*tsMunPtd>) { return PARAUAPEBAS_PRESTADOR_TAG;} // token da tag municipio gerador de Parauapebas

(<[/]*IssRet>) { return PARAUAPEBAS_ISS_TAG;} // token da tag do valor de servico de Parauapebas

(<(ns3:)*PrestadorServico>) { printf("tag p:%s\n", yytext);return CORUMBA_JOAOMON_PRESTADOR_ABRETAG; } // token da abre tag prestador de Corumba/Joao Monlevade

(<[/](ns3:)*PrestadorServico>) { printf("tag p:%s\n", yytext);return CORUMBA_JOAOMON_PRESTADOR_FECHATAG; } // token de fecha tag prestador de Corumba/Joao Monlevade

(<(ns3:)*CodigoMunicipio>) { printf("tag c:%s\n", yytext);return CORUMBA_JOAOMON_RJ_CODIGO_ABRETAG; } // token da abre tag codigo de municipio de Corumba/Joao Monlevade

(<[/](ns3:)*CodigoMunicipio>) { printf("tag c:%s\n", yytext);return CORUMBA_JOAOMON_RJ_CODIGO_FECHATAG; } // token da fecha tag codigo de municipio de Corumba/Joao Monlevade

(<[/]*(ns3:)*ValorServicos>) { return CORUMBA_JOAOMON_RJ_PARAUAPEBAS_SERVICO_TAG; } // token da tag valor de servico de Corumba/Joao Monlevade/Paraupebas

(<[/]*(ns3:)*IssRetido>) {return CORUMBA_JOAOMON_RJ_NOVALIMA_ISS_TAG; } // token da tag do valor iss retido de Corumba/Joao Monlevade/Nova Lima

(<prestador>) { return SAOLUIS_PRESTADOR_ABRETAG; }  // token da abre tag prestador de Sao Luis

(<[/]prestador>) { return SAOLUIS_PRESTADOR_FECHATAG; }  // token da fecha tag prestador de Sao Luis

(<tomador>) { return SAOLUIS_GERADOR_ABRETAG; }  // token da abre tag gerador de Sao Luis

(<[/]tomador>) { return SAOLUIS_GERADOR_FECHATAG; }  // token da fecha tag  gerador de Sao Luis

(<descricaoMunicipio>) { return SAOLUIS_MUNICIPIO_ABRETAG; }  // token da abre tag municipio de Sao Luis

(<[/]descricaoMunicipio>) { return SAOLUIS_MUNICIPIO_FECHATAG; } // token da fecha tag municipio de Sao Luis

(<[/]*valorTotalServico>) { return SAOLUIS_SERVICO_TAG; } // token da tag de valor de servico de Sao Luis

(<IdentificacaoPrestador>) { printf("abreprest:%s\n", yytext);return RIO_PRESTADOR_ABRETAG; } // token da abre tag prestador do Rio de Janeiro

(<[/]IdentificacaoPrestador>) { printf("fechaprest:%s\n", yytext);return RIO_PRESTADOR_FECHATAG; } // token da fecha tag prestador do Rio de Janeiro

(<(ns3:)*IdentificacaoTomador>) { return CORUMBA_JOAOMON_RJ_GERADOR_ABRETAG; } // token da abre tag gerador do Rio de Janeiro, Corumba, Joao Monlevade

(<[/](ns3:)*IdentificacaoTomador>) { return CORUMBA_JOAOMON_RJ_GERADOR_FECHATAG; } // token da fecha tag gerador do Rio de Janeiro, Corumba, Joao Monlevade




[<][A-Za-z][^>]+[>] { printf("abre:%s\n", yytext);
                        yylval.string = strdup(yytext);
                        return ABRETAG; // token de abre tag caso geral
                    }

[<][/][^>]+[>] { printf("fecha:%s\n", yytext);return FECHATAG; } // token de fecha tag caso geral

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
