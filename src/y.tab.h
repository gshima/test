/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SRC_Y_TAB_H_INCLUDED
# define YY_YY_SRC_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ABRETAG = 258,
    FECHATAG = 259,
    BELEM_PRESTADOR_TAG = 260,
    BELEM_GERADOR_TAG = 261,
    BELEM_SERVICO_TAG = 262,
    BELEM_ISS_TAG = 263,
    PARAUAPEBAS_PRESTADOR_TAG = 264,
    PARAUAPEBAS_GERADOR_TAG = 265,
    PARAUAPEBAS_SERVICO_TAG = 266,
    PARAUAPEBAS_ISS_TAG = 267,
    STRING = 268,
    NUMERO = 269
  };
#endif
/* Tokens.  */
#define ABRETAG 258
#define FECHATAG 259
#define BELEM_PRESTADOR_TAG 260
#define BELEM_GERADOR_TAG 261
#define BELEM_SERVICO_TAG 262
#define BELEM_ISS_TAG 263
#define PARAUAPEBAS_PRESTADOR_TAG 264
#define PARAUAPEBAS_GERADOR_TAG 265
#define PARAUAPEBAS_SERVICO_TAG 266
#define PARAUAPEBAS_ISS_TAG 267
#define STRING 268
#define NUMERO 269

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 22 "src/main.y" /* yacc.c:1909  */

    char* string;
    //float number;

#line 87 "src/y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SRC_Y_TAB_H_INCLUDED  */
