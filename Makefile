# Macros para compilacao
CC = gcc
CFLAGS = -Wextra -lfl
DIR = src
FILENAME = $(DIR)/main.c
YYTABH = $(DIR)/y.tab.h
YYTABC = $(DIR)/y.tab.c
LEXOUT = $(DIR)/lex.yy.c
YACCFILE = $(DIR)/main.y
LEXFILE = $(DIR)/main.l
TARGET = ./main
BJS = $(SRCS:.c=.o)
YACC = bison
LEX = flex

.PHONY: depend clean

all:$(TARGET)

$(TARGET):$(LEXOUT) $(YYTABC)
	$(CC) -o$(TARGET) $(LEXOUT) $(YYTABC) $(CFLAGS)

$(LEXOUT):$(LEXFILE) $(YYTABC)
	$(LEX) -o$(LEXOUT) $(LEXFILE)

$(YYTABC):$(YACCFILE)
	$(YACC) -o$(YYTABC) -dy $(YACCFILE)


clean:
	$(RM) $(YYTABC)
	$(RM) $(YYTABH)
	$(RM) $(LEXOUT)
	$(RM) ./$(TARGET)
	$(RM) $(DIR)/*.o
	$(RM) ./$(ZIPFILE)# Macros para compilacao

