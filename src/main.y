/* Nome: Mariane Tiemi Iguti RA: 147279
   EA876 - Laboratório 3 - PythonListParser */
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *c);
int yylex(void);

char* municipio_gerador, *municipio_prestador, *municipio_aux, *municipio_gerador_rj, *municipio_prestador_rj;
float valor_servico, valor_iss;
int codigo[4], flag = 0, flag1 = 0, i = 0;

%}

%token ABRETAG FECHATAG
%token BELEM_PRESTADOR_TAG BELEM_GERADOR_TAG BELEM_SERVICO_TAG BELEM_ISS_TAG // tokens para caso Belem
%token CORUMBA_JOAOMON_PRESTADOR_ABRETAG CORUMBA_JOAOMON_PRESTADOR_FECHATAG CORUMBA_JOAOMON_RJ_GERADOR_ABRETAG CORUMBA_JOAOMON_RJ_GERADOR_FECHATAG // tokens caso Corumba e Joao Monlevade
%token CORUMBA_JOAOMON_RJ_CODIGO_ABRETAG CORUMBA_JOAOMON_RJ_CODIGO_FECHATAG CORUMBA_JOAOMON_RJ_PARAUAPEBAS_SERVICO_TAG CORUMBA_JOAOMON_RJ_NOVALIMA_ISS_TAG
%token SAOLUIS_PRESTADOR_ABRETAG SAOLUIS_PRESTADOR_FECHATAG SAOLUIS_GERADOR_ABRETAG SAOLUIS_GERADOR_FECHATAG SAOLUIS_MUNICIPIO_ABRETAG SAOLUIS_MUNICIPIO_FECHATAG SAOLUIS_SERVICO_TAG // tokens caso Sao Luis
%token RIO_PRESTADOR_ABRETAG RIO_PRESTADOR_FECHATAG // tokens caso Rio de janeiro
%token PARAUAPEBAS_PRESTADOR_TAG PARAUAPEBAS_GERADOR_TAG PARAUAPEBAS_SERVICO_TAG PARAUAPEBAS_ISS_TAG //tokens caso Paraupebas


%union
{
    char* string;
    float number;
}

%token <string> STRING
%token <number> NUMERO
%%

PROGRAMA:
        PROGRAMA TAG
        {
            if(flag == 0 && flag1 == 0)// padrao belem, corumba, joao monlevade
            {
                printf("%s,%s,%.2f,%.2f\n", municipio_gerador, municipio_prestador, valor_servico, valor_iss);

            }else if(flag == 1 && flag1 == 0) // caso seja padrao Sao Luis, nao tem o valor de iss retido
            {
                printf("%s,%s,%.2f,ISS Retido desconhecido\n", municipio_gerador, municipio_prestador, valor_servico);

            }else if(flag1 == 1) // padrao rio de janeiro
            {
                printf("%s,%s,%.2f,%.2f\n", municipio_gerador_rj, municipio_prestador_rj, valor_servico, valor_iss);
            };
        }
        |
        ;

ELEMENTO:
        STRING
        | NUMERO
        | ELEMENTO ELEMENTO
        |
        ;
TAG:
    GERADOR_BELEM
    | PRESTADOR_BELEM
    | SERVICO_BELEM
    | ISS_BELEM
    | GERADOR_PARAUAPEBAS
    | PRESTADOR_PARAUAPEBAS
    | SERVICO_PARAUAPEBAS
    | ISS_PARAUAPEBAS
    | GERADOR_SAOLUIS
    | PRESTADOR_SAOLUIS
    | SERVICO_SAOLUIS
    | MUNICIPIO_SAOLUIS
    | PRESTADOR_RIO
    | CODIGO_CORUMBA_JOAOMON_RJ
    | SERVICO_CORUMBA_JOAOMON_RJ
    | ISS_CORUMBA_JOAOMON_RJ_NOVALIMA
    | PRESTADOR_CORUMBA_JOAOMON
    | GERADOR_CORUMBA_JOAOMON_RJ
    | ABRETAG ELEMENTO FECHATAG
    ;

// Regras para padrão Belem
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
            BELEM_SERVICO_TAG NUMERO BELEM_SERVICO_TAG { valor_servico = $2; };

ISS_BELEM:
        BELEM_ISS_TAG NUMERO BELEM_ISS_TAG { valor_iss = $2; };

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
          PARAUAPEBAS_SERVICO_TAG NUMERO PARAUAPEBAS_SERVICO_TAG { valor_servico = $2; };

ISS_PARAUAPEBAS:
          PARAUAPEBAS_ISS_TAG NUMERO PARAUAPEBAS_ISS_TAG { valor_iss = $2; };

// Regras para padrão Corumba/Joao Monlevade/Rio de janeiro
CODIGO_CORUMBA_JOAOMON_RJ:
                    CORUMBA_JOAOMON_RJ_CODIGO_ABRETAG NUMERO CORUMBA_JOAOMON_RJ_CODIGO_FECHATAG
                    {
                        codigo[i]= $2;
                        if(i == 0)
                        {
                            municipio_prestador = malloc(sizeof(char));
                            // printf("codigo:%d\n", codigo_corumba);
                            sprintf(municipio_prestador, "%d", codigo[0]);
                        }else if(i == 1)
                        {
                            municipio_prestador_rj = malloc(sizeof(char));
                            sprintf(municipio_prestador_rj, "%d", codigo[1]);
                        }else if(i == 2)
                        {
                            municipio_gerador_rj = malloc(sizeof(char));
                            sprintf(municipio_gerador_rj, "%d", codigo[2]);

                        }else if(i == 3)
                        {
                            municipio_gerador = malloc(sizeof(char));
                            sprintf(municipio_gerador, "%d", codigo[3]);
                        }

                        i++;
                    };

PRESTADOR_CORUMBA_JOAOMON:
                        CORUMBA_JOAOMON_PRESTADOR_ABRETAG ELEMENTO CORUMBA_JOAOMON_PRESTADOR_FECHATAG
                        ;
GERADOR_CORUMBA_JOAOMON_RJ:
                    CORUMBA_JOAOMON_RJ_GERADOR_ABRETAG ELEMENTO CORUMBA_JOAOMON_RJ_GERADOR_FECHATAG
                    ;

SERVICO_CORUMBA_JOAOMON_RJ:
                    CORUMBA_JOAOMON_RJ_PARAUAPEBAS_SERVICO_TAG NUMERO CORUMBA_JOAOMON_RJ_PARAUAPEBAS_SERVICO_TAG { valor_servico = $2; };

ISS_CORUMBA_JOAOMON_RJ_NOVALIMA:
                CORUMBA_JOAOMON_RJ_NOVALIMA_ISS_TAG NUMERO CORUMBA_JOAOMON_RJ_NOVALIMA_ISS_TAG { valor_iss = $2; };

PRESTADOR_RIO:
            RIO_PRESTADOR_ABRETAG ELEMENTO RIO_PRESTADOR_FECHATAG { flag1 = 1; };

// Regras para padrão Sao Luis
MUNICIPIO_SAOLUIS:
                SAOLUIS_MUNICIPIO_ABRETAG STRING SAOLUIS_MUNICIPIO_FECHATAG {
                                                                                municipio_aux = malloc(sizeof(char));
                                                                                strcpy(municipio_aux, $2);
                                                                            };
PRESTADOR_SAOLUIS:
                SAOLUIS_PRESTADOR_ABRETAG ELEMENTO SAOLUIS_PRESTADOR_FECHATAG {
                                                                                municipio_prestador = malloc(sizeof(char));
                                                                                strcpy(municipio_prestador, municipio_aux);
                                                                              };
GERADOR_SAOLUIS:
            SAOLUIS_GERADOR_ABRETAG ELEMENTO SAOLUIS_GERADOR_FECHATAG {
                                                                        municipio_gerador = malloc(sizeof(char));
                                                                        strcpy(municipio_gerador, municipio_aux);
                                                                      };
SERVICO_SAOLUIS:
            SAOLUIS_SERVICO_TAG NUMERO SAOLUIS_SERVICO_TAG {
                                                            valor_servico = $2;
                                                            flag = 1;
                                                           };




%%
//OLAR EU COMITO?
void yyerror(char *s)
{
    printf("ERRO\n"); // em caso de lista invalida, print ERRO
}

int main()
{
    yyparse();
    free(municipio_gerador);
    free(municipio_prestador);

    return 0;
}
