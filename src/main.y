/* Nome: Mariane Tiemi Iguti RA: 147279
   EA876 - Laboratório 3 - PythonListParser */
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *c);
int yylex(void);

char *municipio_gerador, *municipio_prestador, *pilha[5], *valor_servico, *valor_iss;
int cont = 0;
//float valor_servico, valor_iss;

%}

%token ABRETAG FECHATAG
%token BELEM_PRESTADOR_TAG BELEM_GERADOR_TAG BELEM_SERVICO_TAG BELEM_ISS_TAG // tokens para caso Belem
%token PARAUAPEBAS_PRESTADOR_TAG PARAUAPEBAS_GERADOR_TAG PARAUAPEBAS_SERVICO_TAG PARAUAPEBAS_ISS_TAG //token para caso Parauapebas
%token SAOLUIS_PRESTADOR_ABRETAG SAOLUIS_PRESTADOR_FECHATAG SAOLUIS_GERADOR_ABRETAG SAOLUIS_GERADOR_FECHATAG SAOLUIS_MUNICIPIO_TAG SAOLUIS_ISS_TAG SAOLUIS_SERVICO_TAG //token para caso Sao Luis
%token CIDADES_MUNICIPIO_ABRETAG CIDADES_MUNICIPIO_FECHATAG CIDADES_SERVICO_TAG CIDADES_ISS_TAG // token para as cidades CORUMBA, JOAO MONLEVADE, NOVA LIMA, RIO DE JANEIRO
%token CIDADES_GERADOR_ABRETAG CIDADES_GERADOR_FECHATAG CIDADES_PRESTADOR_ABRETAG CIDADES_PRESTADOR_FECHATAG // token para as cidades CORUMBA, JOAO MONLEVADE, NOVA LIMA, RIO DE JANEIRO

%union
{
    char* string;
    //float number;
}

%token <string> STRING
%token <string> NUMERO
%%

PROGRAMA:
        PROGRAMA TAG
        {
          printf("=====================================\n");
          printf("[%s;%s;%s;%s]\n", municipio_gerador, municipio_prestador, valor_servico, valor_iss);
        }
        |
        ;

ELEMENTO:
        STRING
        | NUMERO
        | TAG
        | ELEMENTO ELEMENTO
        |
        ;
TAG:
    ABRETAG ELEMENTO FECHATAG
    | GERADOR_BELEM
    | PRESTADOR_BELEM
    | SERVICO_BELEM
    | ISS_BELEM
    | PRESTADOR_PARAUAPEBAS
    | GERADOR_PARAUAPEBAS
    | SERVICO_PARAUAPEBAS
    | ISS_PARAUAPEBAS
    | PRESTADOR_SAOLUIS
    | GERADOR_SAOLUIS
    | MUNICIPIO_SAOLUIS
    | SERVICO_SAOLUIS
    | ISS_SAOLUIS
    | PRESTADOR_CIDADES
    | GERADOR_CIDADES
    | MUNICIPIO_CIDADES
    | SERVICO_CIDADES
    | ISS_CIDADES
    ;

// Regras para padrão BELEM
PRESTADOR_BELEM:
             BELEM_PRESTADOR_TAG STRING BELEM_PRESTADOR_TAG {
               municipio_prestador = malloc(sizeof(char));
               strcpy(municipio_prestador, $2);
             };
GERADOR_BELEM:
            BELEM_GERADOR_TAG STRING BELEM_GERADOR_TAG {
              municipio_gerador = malloc(sizeof(char));
              strcpy(municipio_gerador, $2);
            };
SERVICO_BELEM:
            BELEM_SERVICO_TAG NUMERO BELEM_SERVICO_TAG {
              valor_servico = malloc(sizeof(char));
              strcpy(valor_servico, $2);
            };

ISS_BELEM:
        BELEM_ISS_TAG NUMERO BELEM_ISS_TAG {
          valor_iss = malloc(sizeof(char));
          strcpy(valor_iss, $2);
        };

// Regras para padrão Parauapebas

PRESTADOR_PARAUAPEBAS:
        PARAUAPEBAS_PRESTADOR_TAG STRING PARAUAPEBAS_PRESTADOR_TAG {
          municipio_prestador = malloc(sizeof(char));
          strcpy(municipio_prestador, $2);
        };
GERADOR_PARAUAPEBAS:
        PARAUAPEBAS_GERADOR_TAG STRING PARAUAPEBAS_GERADOR_TAG {
            municipio_gerador = malloc(sizeof(char));
            strcpy(municipio_gerador, $2);
        };

SERVICO_PARAUAPEBAS:
        PARAUAPEBAS_SERVICO_TAG NUMERO PARAUAPEBAS_SERVICO_TAG {
          valor_servico = malloc(sizeof(char));
          strcpy(valor_servico, $2);
        };

ISS_PARAUAPEBAS:
        PARAUAPEBAS_ISS_TAG NUMERO PARAUAPEBAS_ISS_TAG {
          valor_iss = malloc(sizeof(char));
          strcpy(valor_iss, $2);
        };

// Regras para padrão São Luis

PRESTADOR_SAOLUIS:
        SAOLUIS_PRESTADOR_ABRETAG ELEMENTO SAOLUIS_PRESTADOR_FECHATAG {
          if(cont > 0) {
            cont--;
            municipio_prestador = malloc(sizeof(char));
            strcpy(municipio_prestador, pilha[cont]);
            free(pilha[cont]);
            //printf("Desempilhei e guardei o municipio prestador: %s\n", municipio_prestador);
          }
        }

GERADOR_SAOLUIS:
        SAOLUIS_GERADOR_ABRETAG ELEMENTO SAOLUIS_GERADOR_FECHATAG {
          //printf("FINALMENTE Entrei em tomador SAO LUIS!! cont = %d\n", cont);
          if(cont > 0) {
            cont--;
            municipio_gerador = malloc(sizeof(char));
            strcpy(municipio_gerador, pilha[cont]);
            free(pilha[cont]);
            //printf("Desempilhei e guardei o municipio gerador: %s\n", municipio_gerador);
          }
        }

MUNICIPIO_SAOLUIS:
        SAOLUIS_MUNICIPIO_TAG STRING SAOLUIS_MUNICIPIO_TAG {
          pilha[cont] = malloc(sizeof(char));
          strcpy(pilha[cont], $2);
          //printf("Empilhei o municipio: %s\n", pilha[cont]);
          cont++;
        }

SERVICO_SAOLUIS:
        SAOLUIS_SERVICO_TAG NUMERO SAOLUIS_SERVICO_TAG{
          valor_servico = malloc(sizeof(char));
          strcpy(valor_servico, $2);
        };

ISS_SAOLUIS:
          SAOLUIS_ISS_TAG NUMERO SAOLUIS_ISS_TAG {
            valor_iss = malloc(sizeof(char));
            strcpy(valor_iss, $2);
          };

// Regras para as cidades: CORUMBA, JOAO MONLEVADE, NOVA LIMA, RIO DE JANEIRO

PRESTADOR_CIDADES:
        CIDADES_PRESTADOR_ABRETAG ELEMENTO CIDADES_PRESTADOR_FECHATAG {
          //printf("FINALMENTE Entrei em tomador SAO LUIS!! cont = %d\n", cont);
          if(cont > 0) {
            cont--;
            municipio_prestador = malloc(sizeof(char));
            strcpy(municipio_prestador, pilha[cont]);
            free(pilha[cont]);
            //printf("Desempilhei e guardei o municipio gerador: %s\n", municipio_gerador);
          }
        }

GERADOR_CIDADES:
        CIDADES_GERADOR_ABRETAG ELEMENTO CIDADES_GERADOR_FECHATAG {
          //printf("FINALMENTE Entrei em tomador SAO LUIS!! cont = %d\n", cont);
          if(cont > 0) {
            cont--;
            municipio_gerador = malloc(sizeof(char));
            strcpy(municipio_gerador, pilha[cont]);
            free(pilha[cont]);
            //printf("Desempilhei e guardei o municipio gerador: %s\n", municipio_gerador);
          }
        }

MUNICIPIO_CIDADES:
        CIDADES_MUNICIPIO_ABRETAG NUMERO CIDADES_MUNICIPIO_FECHATAG {
          pilha[cont] = malloc(sizeof(char));
          strcpy(pilha[cont], $2);
          printf("Empilhei o municipio: %s\n", pilha[cont]);
          cont++;
        }
        | CIDADES_MUNICIPIO_ABRETAG STRING CIDADES_MUNICIPIO_FECHATAG {
          pilha[cont] = malloc(sizeof(char));
          strcpy(pilha[cont], $2);
          printf("Empilhei o municipio: %s\n", pilha[cont]);
          cont++;
        }

SERVICO_CIDADES:
        CIDADES_SERVICO_TAG NUMERO CIDADES_SERVICO_TAG{
          valor_servico = malloc(sizeof(char));
          strcpy(valor_servico, $2);
        };

ISS_CIDADES:
          CIDADES_ISS_TAG NUMERO CIDADES_ISS_TAG {
            valor_iss = malloc(sizeof(char));
            strcpy(valor_iss, $2);
          };



%%
//OLAR EU COMITO?
//OLAR PQ VOCE N ESTA COMITANDO???
//PQ????
void yyerror(char *s)
{
    printf("ERRO\n");
}

int main()
{
    yyparse();
    free(municipio_gerador);
    free(municipio_prestador);
    free(valor_iss);
    free(valor_servico);
    while(cont >= 0) {
      free(pilha[cont]);
      cont--;
    }

    return 0;
}
