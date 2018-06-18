#ifndef DSTRUCT_H
#define DSTRUCT_H

#include <stdio.h>
#include <string.h>
// #include <malloc.h>
#include <stdlib.h>

enum RELATION {NONE, USING_R,HAS_A_R, KIND_OF_R };
enum BOOL {FALSE,TRUE };

typedef struct COLABR {
                 char* className;
                 enum RELATION relation;
                 struct COLABR *next;
               }COLABR ;

typedef struct  ATTR {
               char *attribute;
               struct ATTR *next;
             } ATTR;

typedef struct RESPONS{
               char *methodName;
               ATTR *attribute;
               struct RESPONS *next;
               }RESPONS;

typedef struct CLASS_DETAILS {
               char *className;
               RESPONS *responsibility;
               COLABR  *colabration;
               struct CLASS_DETAILS *next;
               } CLASS_DETAILS;

COLABR *getNewColbr();
RESPONS *getNewResp();
CLASS_DETAILS *getNewClassDetails();
ATTR *getNewAttr();
void generatePseudoCode(CLASS_DETAILS *detailsList,FILE* fp);
void displayDataStruct(CLASS_DETAILS *detailsList);
#endif
