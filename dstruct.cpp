#include "dstruct.h"

COLABR *getNewColbr()
{
  COLABR *col=(COLABR*)malloc(sizeof(COLABR));
  col->relation=NONE;
  col->next=NULL;
  return col;
}

ATTR *getNewAttr()
{
  ATTR* attr=(ATTR*)malloc(sizeof(ATTR));
  attr->attribute=(char*)malloc(50*sizeof(char));
  strcpy(attr->attribute,"");
  attr->next=NULL;
  return attr;
}

RESPONS *getNewResp()
{
  RESPONS *res=(RESPONS*)malloc(sizeof(RESPONS));
  res->attribute=NULL;
  res->next=NULL;
  return res;
}

CLASS_DETAILS *getNewClassDetails()
{
  CLASS_DETAILS *crc=(CLASS_DETAILS*)malloc(sizeof(CLASS_DETAILS));
  crc->responsibility=NULL;
  crc->colabration=NULL;
  crc->next=NULL;
  return crc;
}

void displayDataStruct(CLASS_DETAILS *detailsList)
{
 /* Display DS for Debugging */
 while(detailsList)
 {
   printf(" CLASS %s\n",detailsList->className);
   RESPONS *tempResp=detailsList->responsibility;
   while(tempResp)
   {
   printf(" RESPONSIBILITY\n");
    printf(" Method %s\n",tempResp->methodName);
    printf(" Attributes\n");
    ATTR *tempAttr=tempResp->attribute;
    while(tempAttr)
     {printf("   %s\n",tempAttr->attribute);
      tempAttr=tempAttr->next;
     }
    tempResp=tempResp->next;
  }
  COLABR *tempColbr=detailsList->colabration;
  if(tempColbr)
    printf("  COLABRATORS\n");
  while(tempColbr)
    {
     switch(tempColbr->relation)
      {
         case NONE: printf("This Class has no relation specified with ");
                    break;
         case USING_R: printf("This Class USES class ");
                    break;
         case HAS_A_R:printf("This Class HAS A class ");
                    break;
         case KIND_OF_R: printf("This Class is a KIND OF class ");
                    break;
         default: break;
       }
     printf(" %s\n",tempColbr->className);
     tempColbr=tempColbr->next;
    }
   detailsList=detailsList->next;
 }
}

void generatePseudoCode(CLASS_DETAILS *detailsList,FILE *outFile_p)
{
 while(detailsList)
 {
//   fprintf(outFile_p,"// Class Name: %s\n",detailsList->className);
   RESPONS *tempResp=detailsList->responsibility;
/*
   while(tempResp)

   {
    fprintf(outFile_p,"// Functions:\n");
    fprintf(outFile_p,"//   %s",tempResp->methodName);
    ATTR *tempAttr=tempResp->attribute;
    while(tempAttr)
     {
      fprintf(outFile_p," %s",tempAttr->attribute);
      tempAttr=tempAttr->next;
     }
     fprintf(outFile_p,"\n");
    tempResp=tempResp->next;
  }
  COLABR *tempColbr=detailsList->colabration;
  fprintf(outFile_p,"// Class Relations :\n");
  while(tempColbr)
    {
     switch(tempColbr->relation)
      {
         case NONE: fprintf(outFile_p,"// This Class has no relation specified\n ");
                    break;
         case USING_R: fprintf(outFile_p,"// This Class USES class %s\n",tempColbr->className);
                    break;
         case HAS_A_R:fprintf(outFile_p,"// This Class HAS A class%s\n",tempColbr->className);
                      break;
         case KIND_OF_R: fprintf(outFile_p,"// This Class is a KIND OF class%s\n",tempColbr->className);
                          break;
         default: break;
       }
     tempColbr=tempColbr->next;
    }

    fprintf(outFile_p,"//\n");
    */



   fprintf(outFile_p,"<class name=\"%s\">\n",detailsList->className);
   fprintf(outFile_p,"    <public>\n");
   tempResp=detailsList->responsibility;

   while(tempResp)
    {
      fprintf(outFile_p,"      <method name=\"%s\" args=\"",tempResp->methodName);
      ATTR *tempAttr=tempResp->attribute;
      while(tempAttr)
       {
        if(tempAttr->next)
         fprintf(outFile_p,"[%s],",tempAttr->attribute); // with coma
        else
         fprintf(outFile_p,"{%s}",tempAttr->attribute);

         tempAttr=tempAttr->next;
       }
      fprintf(outFile_p,"\"></method>\n");
    tempResp=tempResp->next;
    }
    fprintf(outFile_p,"    </public>\n");
    fprintf(outFile_p,"    <protected></protected>\n");
    fprintf(outFile_p,"    <private></private>\n");
    fprintf(outFile_p,"</class>\n");

   detailsList=detailsList->next;
 }

}
