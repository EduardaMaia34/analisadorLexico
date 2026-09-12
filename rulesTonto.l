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

/*palavras reservadas*/

"genset"            {addToken("KEYWORD", "Palavras Reservadas");}
"disjoint"            {addToken("KEYWORD", "Palavras Reservadas");}
"complete"            {addToken("KEYWORD", "Palavras Reservadas");}
"general"            {addToken("KEYWORD", "Palavras Reservadas");}
"specifics"            {addToken("KEYWORD", "Palavras Reservadas");}
"where"            {addToken("KEYWORD", "Palavras Reservadas");}
"package"            {addToken("KEYWORD", "Palavras Reservadas");}
"import"            {addToken("KEYWORD", "Palavras Reservadas");}
"functional-complexes"            {addToken("KEYWORD", "Palavras Reservadas");}

    /* esteriotipos de classes*/

"kind"                 { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"phase"                { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"role"                 { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"subkind"              { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"category"             { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"event"                { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"situation"            { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"process"              { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"mixin"                { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"phaseMixin"           { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"roleMixin"            { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"collective"           { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"quantity"             { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"intrisicMode"         { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"quality"              { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"historicalRole"       { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"historicalRoleMixin"  { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"mode"                 { addToken("CLASS_STEREO", "Estereotipos de Classe"); }
"extrinsicMode"        { addToken("CLASS_STEREO", "Estereotipos de Classe"); }

    /* esteriotipos de relacoes*/

"aggregation"          { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"material"             { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"derivation"           { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"comparative"          { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"composition"          { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"inherence"            { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"constitution"         { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"mediation"            { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"characterization"     { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"subCollectionOf"      { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"subQualityOf"         { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"instantiation"        { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"externalDependence"   { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"componentOf"          { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"memberOf"             { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"termination"          { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"participational"      { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"participation"        { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"historicalDependence" { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"creation"             { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"manifestation"        { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"bringsAbout"          { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"triggers"             { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"value"                { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }
"formal"               { addToken("RELATION_STEREO", "Estereotipos de Relacao"); }

    /*tipos nativos*/

"number"               { addToken("NATIVE_TYPE", "Tipos Nativos"); }
"string"               { addToken("NATIVE_TYPE", "Tipos Nativos"); }
"boolean"              { addToken("NATIVE_TYPE", "Tipos Nativos"); }
"time"                 { addToken("NATIVE_TYPE", "Tipos Nativos"); }
"date"                 { addToken("NATIVE_TYPE", "Tipos Nativos"); }
"datetime"             { addToken("NATIVE_TYPE", "Tipos Nativos"); }

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