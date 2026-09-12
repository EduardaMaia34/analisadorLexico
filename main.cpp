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
    if (argc > 1) {
        FILE* file = fopen(argv[1], "r");
        if (!file) {
            std::cerr << "Erro: Nao foi possivel abrir o arquivo \"" << argv[1] << "\"\n";
            return 1;
        }
        yyin = file;
    } else {
        std::cout << "Aviso: Nenhum arquivo fornecido. Lendo da entrada padrao (digite o codigo e use Ctrl+D para encerrar):\n";
    }

    // execucao
    yylex();

    // todos os tokens
    std::cout << "\n" << std::string(80, '=') << "\n";
    std::cout << std::setw(52) << "VISAO ANALITICA DOS TOKENS" << "\n";
    std::cout << std::string(80, '=') << "\n";
    std::cout << std::left 
              << std::setw(8)  << "LINHA" 
              << std::setw(8)  << "COLUNA" 
              << std::setw(28) << "TIPO DO TOKEN" 
              << "LEXEMA" << "\n";
    std::cout << std::string(80, '-') << "\n";

    for (const auto& tok : tokensList) {
        std::cout << std::left 
                  << std::setw(8)  << tok.line 
                  << std::setw(8)  << tok.col 
                  << std::setw(28) << tok.type 
                  << tok.lexeme << "\n";
    }

    // tabela de sintese
    std::cout << "\n" << std::string(80, '=') << "\n";
    std::cout << std::setw(48) << "TABELA DE SINTESE" << "\n";
    std::cout << std::string(80, '=') << "\n";
    std::cout << std::left << std::setw(45) << "CATEGORIA" << "QUANTIDADE" << "\n";
    std::cout << std::string(80, '-') << "\n";

    for (const auto& pair : summaryCounts) {
        std::cout << std::left << std::setw(45) << pair.first << pair.second << "\n";
    }

    // diagnostico de erros e tratamento
    std::cout << "\n" << std::string(80, '=') << "\n";
    std::cout << std::setw(49) << "DIAGNOSTICO DE ERROS" << "\n";
    std::cout << std::string(80, '=') << "\n";

    if (errorsList.empty()) {
        std::cout << "Nenhum erro lexico encontrado no codigo-fonte.\n";
    } else {
        for (const auto& err : errorsList) {
            std::cout << "[Linha " << err.line << ", Coluna " << err.col << "] "
                      << "Lexema Invalido: \"" << err.lexeme << "\"\n"
                      << " -> Sugestao: " << err.suggestion << "\n\n";
        }
    }

    if (argc > 1 && yyin) {
        fclose(yyin);
    }

    return 0;
}