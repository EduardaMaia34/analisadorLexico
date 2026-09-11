#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <vector>
#include <map>

extern int yylex();
extern FILE* yyin;

struct TokenInfo {
    std::string type;
    std::string lexeme;
    int line;
    int col;
};

struct ErrorInfo {
    int line;
    int col;
    std::string lexeme;
    std::string suggestion;
};

extern std::vector<TokenInfo> tokensList;
extern std::vector<ErrorInfo> errorsList;
extern std::map<std::string, int> summaryCounts;

int main(int argc, char** argv){
    
}