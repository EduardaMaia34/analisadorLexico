%{
#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <map>

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

std::vector<TokenInfo> tokensList;
std::vector<ErrorInfo> errorsList;

std::map<std::string, int> summaryCounts = {
    {"Classes", 0},
    {"Relacoes", 0},
    {"Instancias", 0},
    {"Palavras Reservadas", 0},
    {"Estereotipos de Classe", 0},
    {"Estereotipos de Relacao", 0},
    {"Tipos Nativos", 0},
    {"Novos Tipos (DataTypes)", 0},
    {"Meta-atributos", 0}
};

int current_col = 1;

#define YY_USER_ACTION \
    yylloc.first_line = yylineno; \
    yylloc.first_column = current_col; \
    current_col += yyleng;

struct YYLTYPE {
    int first_line;
    int first_column;
} yylloc;

void addToken(const std::string& type, const std::string& category = "") {
    tokensList.push_back({type, yytext, yylloc.first_line, yylloc.first_column});
    if (!category.empty()) {
        summaryCounts[category]++;
    }
}

void reportError(const std::string& lexeme, const std::string& suggestion) {
    errorsList.push_back({yylloc.first_line, yylloc.first_column, lexeme, suggestion});
}
%}