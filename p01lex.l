%{
//--------------------------------------------------------------------
// File p02lex.l defines a prototype scanner for expressions.
// The scanner definition is a lex specification.                        
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
//--------------------------------------------------------------------
// Standard C and C++ Library Include Files                                     
//--------------------------------------------------------------------
#include <string>                          
#include <iostream>
#include <iomanip>
#include <fstream>
#include <cstdio>
using namespace std;
//--------------------------------------------------------------------
// Application Includes                                               
//--------------------------------------------------------------------
#include "p01lex.h"
#include "p01tkn.h"

extern ofstream tfs;
//--------------------------------------------------------------------
//Function prototypes and variable definitions
//--------------------------------------------------------------------
int lineNo = 1;
int colNo = 1;
int TokenMgr(int t);
void TokenPrint(ostream& o,int t);
//--------------------------------------------------------------------
//Global Variables                                                    
//--------------------------------------------------------------------
static string spelling[]=
  {"NOTOKEN","AND","ARRAY","BEGAN","DIV","DO","ELSE","END","FOR",
	"FUNCTION","IF","INTEGER","MOD","NOT","OF","OR","PROCEDURE",
	"PROGRAM","REAL","REPEAT","THEN","TO","UNTIL","VAR","WHILE",
	"INTLIT","REALIT","CHRLIT","ID","PLUS","MINUS","STAR","SLASH",
	"LPAREN","RPAREN","LBRACKET","RBRACKET","COLON","SEMICOLON",
	"COMMA","PERIOD","RANGE","ASSIGNOP","EQU","NEQ","LES","LEQ",
	"GRT","GEQ","ERROR" 
  };
%}
punctuation ("+"|"-"|"*"|"/"|"("|")"|"["|"]"|":"|";"|","|".."|":="|"="|"<>"|"<"|"<="|">"|">=")
emptySpace [ \t\n]+ 
%%
\n					{lineNo++; colNo = 1;/*allow proper counting of lines/reset columns*/}
[ \t]+                                	{colNo++;/* allow proper counting of columns*/}
[{][^{]*[}]				;//allow for scanner to ignore comments
[aA][nN][dD]				return TokenMgr(AND);
[aA][rR][rR][aA][yY]			return TokenMgr(ARRAY);
[bB][eE][gG][iI][nN]			return TokenMgr(BEGAN);
[dD][iI][vV]				return TokenMgr(DIV);
[dD][oO]				return TokenMgr(DO);
[eE][lL][sS][eE]			return TokenMgr(ELSE);
[eE][nN][dD]				return TokenMgr(END);
[fF][oO][rR]				return TokenMgr(FOR);
[fF][uU][nN][cC][tT][iI][oO][nN]	return TokenMgr(FUNCTION);
[iI][fF]				return TokenMgr(IF);
[iI][nN][tT][eE][gG][eE][rR]		return TokenMgr(INTEGER);
[mM][oO][dD]				return TokenMgr(MOD);
[nN][oO][tT]				return TokenMgr(NOT);
[oO][fF]				return TokenMgr(OF);
[pP][rR][oO][cC][eE][dD][uU][rR][eE]	return TokenMgr(PROCEDURE);
[pP][rR][oO][gG][rR][aA][mM]		return TokenMgr(PROGRAM);
[rR][eE][aA][lL]			return TokenMgr(REAL);
[rR][eE][pP][eE][aA][tT]		return TokenMgr(REPEAT);
[tT][hH][eE][nN]			return TokenMgr(THEN);
[uU][nN][tT][iI][lL]			return TokenMgr(UNTIL);
[vV][aA][rR]				return TokenMgr(VAR);
[wW][hH][iI][lL][eE]			return TokenMgr(WHILE);
[0-9]+                                  return TokenMgr(INTLIT);
[0-9]+\.[0-9]*([Ee][+-]?[0-9]+)?/{punctuation}|{emptySpace}	return TokenMgr(REALIT);
[0-9]*\.[0-9]+([Ee][+-]?[0-9]+)?/{punctuation}|{emptySpace}	return TokenMgr(REALIT);
[0-9]+[Ee][+-]?[0-9]+/{punctuation}|{emptySpace}		return TokenMgr(REALIT);
\'[^{\n]\'|''''				return TokenMgr(CHRLIT);//ask turner about this
 [a-zA-Z_][a-zA-Z0-9_]* 		return TokenMgr(ID);
"+"                                     return TokenMgr(PLUS);
"-"                                     return TokenMgr(MINUS);
"*"                                     return TokenMgr(STAR);
"/"                                     return TokenMgr(SLASH);
"("                                     return TokenMgr(LPAREN);
")"                                     return TokenMgr(RPAREN);
"["					return TokenMgr(LBRACKET);
"]"					return TokenMgr(RBRACKET);
":"					return TokenMgr(COLON);
";"					return TokenMgr(SEMICOLON);
","					return TokenMgr(COMMA);
"."					return TokenMgr(PERIOD);
".."					return TokenMgr(RANGE);
":="					return TokenMgr(ASSIGNOP);
"="					return TokenMgr(EQU);
"<>"					return TokenMgr(NEQ);
"<"					return TokenMgr(LES);
"<="					return TokenMgr(LEQ);
">"					return TokenMgr(GRT);
">="					return TokenMgr(GEQ);
.                                       return TokenMgr(ERROR);
%%
//--------------------------------------------------------------------
//Class Lexer implementation
//--------------------------------------------------------------------
int yywrap(){return 1;}
int TokenMgr(int t)
{
  TokenPrint(tfs,t);
  colNo+= strlen(yytext); 
  return t;
}
string textToLower() {
	string toPrint = "";
	char txt[strlen(yytext)];
	strcpy(txt, yytext);
	char uppers[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
					'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
	char lowers[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
					'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
	for (int i = 0; i < strlen(txt); i++) {
		toPrint += txt[i];
		for (int j = 0; j < 26; j++) {
			if (txt[i]==uppers[j]) {
				toPrint.at(i) = lowers[j];
				break;
			}	
		}
	}
	return toPrint;
}
void TokenPrint(ostream& o,int t) {   
	string toPrint = textToLower();
	o << endl;
    o << "Token:Code="<< t << " " 
      << "Name= "<<setw(10)<< right << spelling[t-NOTOKEN]<< " " 
      << " line= "<<lineNo << " "
      << "col= " << setw(3) << right << colNo << " ";
    o << "Spelling= \"" << toPrint << "\"";
}
//--------------------------------------------------------------------
//Constructor Lexer is used to redirect the input file stream from the
//keyboard to input file stream i.
//--------------------------------------------------------------------
Lexer::Lexer(FILE* i){yyin=i;}
int Lexer::Scan(void){return yylex();}
//-----------------------End of Lex Definition------------------------
     



