/* Nome: Mariane Tiemi Iguti RA: 147279
   EA876 - Laboratório 3 - PythonListParser */
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *c);
int yylex(void);

char* municipio_gerador, *municipio_prestador, *municipio_aux, *valor_servico, *valor_iss;
//float valor_servico, valor_iss;

%}

%token ABRETAG FECHATAG
%token BELEM_PRESTADOR_TAG BELEM_GERADOR_TAG BELEM_SERVICO_TAG BELEM_ISS_TAG // tokens para caso Belem
%token PARAUAPEBAS_PRESTADOR_TAG PARAUAPEBAS_GERADOR_TAG PARAUAPEBAS_SERVICO_TAG PARAUAPEBAS_ISS_TAG //token para caso Parauapebas


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
          free(municipio_gerador);
          free(municipio_prestador);
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
    |
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
        PARAUAPEBAS_SERVICO_TAG NUMERO PARAUAPEBAS_SERVICO_TAG { valor_servico = malloc(sizeof(char));
        strcpy(valor_servico, $2); };

ISS_PARAUAPEBAS:
        PARAUAPEBAS_ISS_TAG NUMERO PARAUAPEBAS_ISS_TAG { valor_iss = malloc(sizeof(char));
        strcpy(valor_iss, $2); };




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

    return 0;
}
