#ifndef p01lex_h
#define p01lex_h 
//--------------------------------------------------------------------
// File p02lex.h defines class Lexer.  
//--------------------------------------------------------------------
// Author 1:    George Dosher                                           
// Student ID:  *20431693
// E-Mail:      gdosher@uco.edu
// Author 2:    Jon Hyde 
// Student ID:  *20450725
// E-mail:      jhyde4@uco.edu	                                        
// Course:      CMSC 4023 - Programming Languages
// CRN:         22057
// Project:     p01
// Due:         February 20, 2019 
// Account:     tt073
//--------------------------------------------------------------------
//C++ Standard include files
//--------------------------------------------------------------------
//--------------------------------------------------------------------
// Standard C and C++ include files                                        
//--------------------------------------------------------------------
#include <cstdio>
#include <fstream>
#include <iostream>
//--------------------------------------------------------------------
// Token Definitions
//--------------------------------------------------------------------
//#include "p02tkn.h"
//--------------------------------------------------------------------
//Namespaces
//--------------------------------------------------------------------
using namespace std;
//--------------------------------------------------------------------
//Function: yylex                                                     
//Function yylex is the expner.  Function yylex returns an integer   
//token code as defined above or 0 if end-of-file has been     
//reached.                                                            
//--------------------------------------------------------------------
#ifdef __cplusplus
extern "C" 
#endif
int yylex (void);
//--------------------------------------------------------------------
//Class Lexer defines the attributes of a Scanner
//--------------------------------------------------------------------
class Lexer {
public:
  Lexer(FILE* i);                //Constructor used to redirect the keyboard
                                 //(stdin) to file i.
  int Scan(void);
};
#endif
