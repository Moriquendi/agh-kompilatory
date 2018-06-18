/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     CLASS = 258,
     END = 259,
     CLASSNAME = 260,
     BEGIN_SCOPE = 261,
     OPEN_BRACKET = 262,
     CLOSE_BRACKET = 263,
     COLABRATION = 264,
     STRING = 265,
     INT = 266,
     CHAR = 267,
     PTR = 268,
     VARIABLE = 269,
     METHODNAME = 270,
     USING = 271,
     HAS_A = 272,
     KIND_OF = 273
   };
#endif
/* Tokens.  */
#define CLASS 258
#define END 259
#define CLASSNAME 260
#define BEGIN_SCOPE 261
#define OPEN_BRACKET 262
#define CLOSE_BRACKET 263
#define COLABRATION 264
#define STRING 265
#define INT 266
#define CHAR 267
#define PTR 268
#define VARIABLE 269
#define METHODNAME 270
#define USING 271
#define HAS_A 272
#define KIND_OF 273




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 13 "crc.y"
{
    char stval[100];
    char* ptr;
    COLABR *colbr;
    ATTR *attr;
    RESPONS *resp;
    CLASS_DETAILS *card;
}
/* Line 1529 of yacc.c.  */
#line 94 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

