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
          printf("=====================================\n");
          printf("%s,%s,%.2f,%.2f\n", municipio_gerador, municipio_prestador, valor_servico, valor_iss); }
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
    GERADOR_BELEM
    | PRESTADOR_BELEM
    | SERVICO_BELEM
    | ISS_BELEM
    | ABRETAG ELEMENTO FECHATAG
    |
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
