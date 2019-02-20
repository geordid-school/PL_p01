//-------------------------------------------------------------------
//File pas.cpp contains functions that process command line arguments
//and interface with the lex-generated scanner 
//--------------------------------------------------------------------
//Author: Thomas R. Turner
//E-Mail: trturner@ucok.edu
//Date:   November, 2006
//--------------------------------------------------------------------
//Copyright November, 2006 by Thomas R. Turner
//Do not reproduce without permission from Thomas R. Turner
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
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdio>
#include <string>
#include <cstring>
#include <cstdlib>
//--------------------------------------------------------------------
//Application include files
//--------------------------------------------------------------------
#include "p01lex.h"
using namespace std;
//--------------------------------------------------------------------
//Externals
//--------------------------------------------------------------------
ofstream tfs;                     //trace file stream 
//--------------------------------------------------------------------
//BadSuffixException
//--------------------------------------------------------------------
struct BadSuffixException {
    BadSuffixException(char* fn)
    {   cout << endl;
        cout << "Input file \"" << fn << "\" does not have a .pas suffix.";
    }
};
//--------------------------------------------------------------------
//--------------------------------------------------------------------
class FileNameSuffix {
    char* prefix;
public:
    FileNameSuffix(char* fn)
    {   char* p=strstr(fn,".pas");
        if (!p) throw BadSuffixException(fn);
        int n=p-fn;
        if (n+4!=strlen(fn)) throw BadSuffixException(fn);
        prefix=new char[strlen(fn)+1];
        strncpy(prefix,fn,n);
        prefix[n]=0;
    }
    ~FileNameSuffix(){if (prefix) delete[] prefix;}
    void Suffix(char* fn,const char* suffix)
    {   strcpy(fn,prefix);
        strcat(fn,suffix);
    }
};
//--------------------------------------------------------------------
//CommandLineException
//--------------------------------------------------------------------
struct CommandLineException {
    CommandLineException(int m,int a)
    {   cout << endl;
        cout << "Too many arguments on the command line.";
        cout << endl;
        cout << m << " argument(s) are permitted on the command line.";
        cout << endl;
        cout << a << " argument(s) appeared on the command line.";
        cout << endl;
    }
};
//--------------------------------------------------------------------
//FileException
//--------------------------------------------------------------------
struct FileException {
   FileException(char* fn)
   {   cout << endl;
       cout << "File " << fn << " could not be opened.";
       cout << endl;
   }
};
//--------------------------------------------------------------------
//Function main processes command line arguments
//--------------------------------------------------------------------
int main(int argc,char* argv[])
{   try {
        char ifn[255];
        switch (argc) {
            case 1:               //Prompt for the input file name
                cout << "Enter the input file name. ";
                cin >> ifn;
                break;
            case 2:               //Read the input file name
                strcpy(ifn,argv[1]);
                break;
            default:
                throw CommandLineException(1,argc-1);
                break;
    }
    FileNameSuffix F(ifn);        //Find the prefix of the input file name
    char tfn[255];
    F.Suffix(tfn,".trc");         //Create the trace file name
    FILE* i=fopen(ifn,"r");       //Open the input file
    if (!i) throw FileException(ifn);
    tfs.open(tfn); if (!tfs) throw FileException(tfn);
    Lexer L(i);                   //Redirect the lexer to read the input
                                  //file
    int t=L.Scan();                //Read the first token;

    while (t>0) {                 //Stop on end of file
       t=L.Scan();                 //Read remaining tokens
     }
     tfs << endl;
     tfs.close();
     fclose(i);
    } catch (...) {
        cout << endl;
        cout << "Program terminated!";
        cout << endl;
        cout << "I won't be back!";
        cout << endl;
        exit(EXIT_FAILURE);
    }
    return 0;
}


