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

%option noyywrap
%option yylineno

/* comentar */
LINE_COMMENT       "//".*
BLOCK_COMMENT      "/"([^]|\+[^/])\+"/"

/* padroes especificos */
CUSTOM_DATATYPE    [a-zA-Z]+"DataType"
INSTANCE_NAME      [a-zA-Z][a-zA-Z_]*[0-9]+
CLASS_NAME         [A-Z][a-zA-Z_]*
RELATION_NAME      [a-z][a-zA-Z_]*

%%

[ \t]+             { }
\r?\n              { current_col = 1; }
{LINE_COMMENT}     { }
{BLOCK_COMMENT}    {
    for (int i = 0; yytext[i] != '\0'; ++i) {
        if (yytext[i] == '\n') current_col = 1;
    }
}

/* operadores compostos e simbolos */
"<>--"              { addToken("COMP_AGG_LEFT"); }
"--<>"              { addToken("COMP_AGG_RIGHT"); }
".."                { addToken("RANGE"); }
"{"                 { addToken("LBRACE"); }
"}"                 { addToken("RBRACE"); }
"("                 { addToken("LPAREN"); }
")"                 { addToken("RPAREN"); }
"["                 { addToken("LBRACKET"); }
"]"                 { addToken("RBRACKET"); }
"*"                 { addToken("STAR"); }
"@"                 { addToken("AT"); }
"."                 { addToken("DOT"); }
","                 { addToken("COMMA"); }
":"                 { addToken("COLON"); }

    /*KEYWORD*/


    /* CLASS_STEREOTYPE*/


    /* RELATION STEREOTYPE*/


    /*NATIVE TYPE*/

    /* Meta-atributos */


    /* Identificadores e Novos Tipos */

/* tratamento de erros com sugestao */
[0-9]+                 { 
    reportError(yytext, "Numeros isolados nao sao permitidos sem identificador ou contexto de multiplicidade."); 
}
[0-9]+[a-zA-Z_]+       { 
    reportError(yytext, "Identificadores nao podem comecar com digitos."); 
}
.                      { 
    std::string s(yytext);
    std::string tip = "Caractere desconhecido. Verifique espacamento, fechamento de operadores ou remova o simbolo.";
    if (s == "\"" || s == "'") tip = "Strings literais entre aspas nao sao suportadas na sintaxe base de identificadores.";
    reportError(s, tip); 
}

%%