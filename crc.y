%{
    int yylex (void);
    void yyerror (char *s);
    #include "dstruct.h"
    #ifndef debug
    #define debug 1
    #endif
    extern int  yylineno;
    extern char* yytext[];
    extern FILE* outFile_p;
    int noerror=1;
    %}
%union{
    char stval[100];
    char* ptr;
    COLABR *colbr;
    ATTR *attr;
    RESPONS *resp;
    CLASS_DETAILS *card;
}
%token CLASS  END
%token <stval> CLASSNAME
%token BEGIN_SCOPE

%token OPEN_BRACKET
%token CLOSE_BRACKET

  /* %token RESPONSIBILITY */
%token COLABRATION STRING
%token INT CHAR PTR
%token <stval> VARIABLE
%token <stval> METHODNAME
%token USING HAS_A KIND_OF
%type <ptr> className
// %type <ptr> class
  /* %type <ptr> methodName */
  /* %type <colbr> colabrationType colabration colabrations */
  /* %type <attr> attributes attribute */
  /* %type <resp> responsibility responsibilities */
%type <card> class cards
%start data
%%
data:cards  {
    if(noerror)
    generatePseudoCode($1,outFile_p);
    if(debug)
    displayDataStruct($1);
    printf("Complete\n");
}

cards:class {
    if(noerror)
    { $$=$1;
        if(debug)
        printf("Assigned Ist Card\n");
    }
}
|cards class {
    if(noerror)
    {
        int no=2;
        CLASS_DETAILS *temp=$$;
        while(temp->next)
        { temp=temp->next;
            no++;
        }
        temp->next=$2;
        if(debug)
        printf("Assigned %dth Card\n",no);
    }
}
|error {
    yyerror("error in input file");
}

// crc:CRC class responsibilities colabrations END  {
// crc:CRC class END  {
//     if(noerror)
//     {
//         CLASS_DETAILS* crc=getNewClassDetails();
//         crc->className=$2;
//         // crc->responsibility=$3;
//         // crc->colabration=$4;
//         $$=crc;
//     }
// }

class:CLASS className BEGIN_SCOPE class_content END {
    if(noerror)
    {
        CLASS_DETAILS* crc=getNewClassDetails();
        crc->className = $2;
        $$ = crc;

        // $$=$2;
        printf("Assigned class name:%s\n",$2);
    }
}
|CLASS className BEGIN_SCOPE error END {
  printf("Class content invalid\n");
}
|CLASS error  {
    yyerror("Class Name not specified");
}

className:CLASSNAME  {
    if(noerror)
    {
        char *name=(char*)malloc(strlen($1)*sizeof(char));
        strcpy(name,$1);
        $$=name;
    }
}

/*
responsibilities:responsibility  {
    if(noerror)
    {
        $$=$1;
        if(debug)
        printf("Assigned Ist Responsibility:%s\n",$1->methodName);
    }
}
|responsibilities responsibility {
    if(noerror)
    {
        int no=2;
        RESPONS *temp=$$;
        while(temp->next)
        {temp=temp->next;
            no++;
        }
        temp->next=$2;
        if(debug)
        printf("Assigned %dth Responsibility:%s\n",no,$2->methodName);
    }
}
|error {
    yyerror("error in responsibility");
}

responsibility: RESPONSIBILITY methodName attributes END
{
    if(noerror)
    {
        RESPONS *res=getNewResp();
        res->methodName=$2;
        res->attribute=$3;
        $$=res;
    }
}
| RESPONSIBILITY error attributes END  {
    yyerror("Method name not specified");
}
*/




type: INT|CHAR

class_content: methods class_content|properties class_content|


methods: methodName|methods methodName

properties: property|properties property

methodName: type VARIABLE OPEN_BRACKET CLOSE_BRACKET ';' {
    if(noerror)
    {
        printf("Found method [%s]\n", $2);
          /*
        char *name=(char*)malloc(strlen($1)*sizeof(char));
        strcpy(name,$1);
        $$=name;
        */

    }
    else {
        printf("MMMMMmmm?\n");
    }
}

property: type VARIABLE ';' {
    printf("Found property named [%s]\n", $2);
}
|type VARIABLE {
    printf("Zmienna bez; [%s]\n", $2);
}

  /*
attribute :INT VARIABLE {
    if(noerror)
    {
        ATTR* attr=getNewAttr();
        strcpy(attr->attribute,"int ");
        strcat(attr->attribute,$2);
        $$=attr;
    }
}
|CHAR VARIABLE {
    if(noerror)
    {
        ATTR* attr=getNewAttr();
        strcpy(attr->attribute,"char ");
        $$=attr;
        strcat(attr->attribute,$2);
    }
}
|INT PTR VARIABLE {
    if(noerror)
    {
        ATTR* attr=getNewAttr();
        strcpy(attr->attribute,"int *");
        strcat(attr->attribute,$3);
        $$=attr;
    }
}
|CHAR PTR VARIABLE {

    if(noerror)
    {
        ATTR* attr=getNewAttr();
        strcpy(attr->attribute,"char *");
        strcat(attr->attribute,$3);
        $$=attr;
    }
}
| error STRING {yyerror("Missing Type for Variable"); }
| error PTR STRING
{ yyerror("Missing Type for Variable"); }
| INT error { yyerror("Missing Variable"); }
| CHAR error { yyerror("Missing Variable"); }
| INT PTR error { yyerror("Missing Variable"); }
| CHAR PTR error { yyerror("Missing Variable"); }
  */

  /*
colabrations: {
    if(noerror)
    $$=NULL;

}
|colabrations colabration {
    if(noerror)
    {
        if($$)
        {
            int no=2;
            COLABR *temp=$$;
            while(temp->next)
            { temp=temp->next;
                no++;
            }
            temp->next=$2;
            if(debug)
            printf("Assigned %dth Colabration\n",no);
        }
        else
        {
            $$=$2;
            if(debug)
            printf("Assigned Ist Colabration\n");
        }
    }
}
colabration:COLABRATION colabrationType END {
    if(noerror)
    $$=$2 ;
}
|COLABRATION error END {
    yyerror("Colabration defined but is empty");
}
colabrationType:USING class {
    if(noerror)
    {
        COLABR* col=getNewColbr();
        col->relation=USING_R;
        col->className=$2;
        $$=col;
    }
}
|HAS_A class {
    if(noerror)
    {
        COLABR* col=getNewColbr();
        col->relation=HAS_A_R;
        col->className=$2;
        $$=col;
    }
}
|KIND_OF class {
    if(noerror)
    {
        COLABR* col=getNewColbr();
        col->relation=KIND_OF_R;
        col->className=$2;
        $$=col;
    }
}
|error class {yyerror("Missing Relation"); }
|USING error {yyerror("Missing Class"); }
|HAS_A error {yyerror("Missing Class"); }
|KIND_OF error {yyerror("Missing Class"); }
  */


  /*
attributes: {
    $$=NULL;
}
|attributes attribute {
    if(noerror)
    {
        if($$)
        {
            int no=2;
            ATTR *temp=$$;
            while(temp->next)
            {temp=temp->next;
                no++;
            }
            temp->next=$2;
            if(debug)
            printf("Assigned %dth Attribute:%s\n",no,
            $2->attribute);
        }
        else
        {
            $$=$2;
            if(debug)
            printf("Assigned Ist Attribute:%s\n",
            $2->attribute);
        }
    }
}
  */

%%
#include<stdio.h>
#include <iostream>
#include <string.h>
extern void yyerror(char* msg)
{
    noerror=0;
    if(strcmp(msg,"syntax error"))
    printf(" Syntax Error in Line : %d : %s\n",yylineno,msg);
}
