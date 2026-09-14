# Analisador Léxico para a Linguagem TONTO

Este projeto implementa um analisador léxico para a linguagem TONTO, utilizando **C++17** e a ferramenta geradora **Flex (Fast Lexical Analyzer)**. O objetivo é reconhecer e classificar os elementos dessa linguagem, produzindo uma visão analítica indexada por linha e coluna, uma tabela de síntese com contagem de tokens e um relatório de diagnóstico de erros léxicos com sugestões de correção.

---

## 📋 Tabela de Conteúdos

- [A Linguagem TONTO](#-a-linguagem-tonto)
- [Sobre o Projeto](#-sobre-o-projeto)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Estrutura de Pastas](#-estrutura-de-pastas)
- [Funcionalidades](#-funcionalidades)
- [Especificação dos Tokens](#-especificação-dos-tokens)
- [Como Usar](#-como-usar)
- [Exemplos](#-exemplos)
---

## 🧩 A Linguagem TONTO

A **TONTO** (*Textual Ontology Language*) é uma linguagem textual para modelagem e especificação formal de ontologias conceituais fundamentadas no OntoUML. Criada para superar as limitações das ferramentas estritamente visuais, permite versionamento facilitado com Git, modularização e interoperabilidade por meio da geração de saídas como:

- **OntoUML** (Modelos conceituais bem fundados)
- **gUFO / OWL** (Serialização ontológica para a Web Semântica / W3C)
- **JSON** (Meta-modelo intermediário serializável)

A linguagem conta com suporte a módulos, orquestração via *Tonto Package Manager* e integração com ambientes como Visual Paradigm e Protégé.

---

## 📖 Sobre o Projeto

O **Analisador Léxico para a Linguagem TONTO** foi desenvolvido para a disciplina de Compiladores (UFERSA)[cite: 1]. Seu objetivo é analisar o fluxo de caracteres de códigos `.tonto`, isolando e categorizando os seguintes elementos:

- **Palavras reservadas**: `genset`, `disjoint`, `complete`, `general`, `specifics`, `where`, `package`, `import`, `functional-complexes`;
- **Estereótipos de classe**: `kind`, `subkind`, `role`, `phase`, `category`, `mixin`, `collective`, `quantity`, `mode`, `quality`, etc.;
- **Estereótipos de relações**: `material`, `derivation`, `comparative`, `mediation`, `characterization`, `componentOf`, `memberOf`, etc.;
- **Nomes de classes**: Iniciando com maiúscula, apenas letras e sublinhado;
- **Nomes de relações**: Iniciando com minúscula, apenas letras e sublinhado;
- **Nomes de instâncias / indivíduos**: Iniciando com letra e obrigatoriamente terminando com dígitos;
- **Tipos de dados nativos**: `number`, `string`, `boolean`, `date`, `time`, `datetime`;
- **Novos tipos de dados**: Apenas letras, terminando estritamente com o sufixo `DataType`;
- **Meta-atributos**: `ordered`, `const`, `derived`, `subsets`, `redefines`;
- **Símbolos especiais e operadores**: `<>--`, `--<>`, `..`, `{`, `}`, `(`, `)`, `[`, `]`, `*`, `@`, `.`, `:`, `,`.

O analisador também realiza o descarte de comentários (`//` e `/* ... */`) e computa com exatidão a coordenada (linha e coluna) de cada lexema casado no texto-fonte.

---

## 🛠 Tecnologias Utilizadas

- **C++17** (Compilador GCC / G++)
- **Flex (Fast Lexical Analyzer 2.6+)**
- **CMake 3.10+** (Gerenciamento e automação de builds)
- **GNU Make**

---

## 📂 Estrutura de Pastas

```text
analisadorLexico/
├── .vscode/                  # Tarefas de automação (tasks.json e launch.json)
├── Debug/                    # Artefatos da compilação em modo de depuração
├── Release/                  # Artefatos da compilação otimizada
├── testes/                   # Arquivos de ontologia (.tonto) para validação
│   └── Universidade.tonto
├── CMakeLists.txt            # Script de configuração do CMake e pipeline do Flex
├── main.cpp                  # Programa principal (orquestrador de fluxo e saída)
├── rulesTonto.l              # Especificação léxica (regras, expressões e ações Flex)
├── .gitignore                # Arquivos e diretórios ignorados no controle de versão
├── LICENSE                   # Licença de uso do código
└── README.md                 # Documentação principal do projeto
```

## ✨ Funcionalidades

- **Reconhecimento de Tokens**: reconhece e categoriza os tokens válidos da linguagem TONTO (citados na seção Sobre o Projeto);
- **Geração de Tabela de Símbolos / Visão Analítica**: organiza e exibe todos os tokens identificados, indexados por linha e coluna;
- **Contador de Tokens**: gera uma tabela de síntese com a contagem agregada de cada categoria léxica processada;
- **Registro de Erros Léxicos**: detecta e lista tokens ou caracteres inválidos encontrados durante o processamento, fornecendo sugestões de correção;
- **Automação de Build**: compilação modular via CMake e Make com alvos para Debug e Release.

---

## 🔤 Especificação dos Tokens

Os elementos léxicos reconhecidos seguem as regras de formação da especificação TONTO:

- **Estereótipos de Classe**: `event`, `situation`, `process`, `category`, `mixin`, `phaseMixin`, `roleMixin`, `historicalRoleMixin`, `kind`, `collective`, `quantity`, `quality`, `mode`, `intrisicMode`, `extrinsicMode`, `subkind`, `phase`, `role`, `historicalRole`.
- **Estereótipos de Relação**: `material`, `derivation`, `comparative`, `mediation`, `characterization`, `subCollectionOf`, `subQualityOf`, `instantiation`, `externalDependence`, `componentOf`, `memberOf`, `termination`, `participational`, `participation`, `historicalDependence`, `creation`, `manifestation`, `bringsAbout`, `triggers`, `composition`, `aggregation`, `inherence`, `value`, `formal`, `constitution`.
- **Palavras Reservadas**: `genset`, `disjoint`, `complete`, `general`, `specifics`, `where`, `package`, `import`, `functional-complexes`.
- **Símbolos Especiais e Operadores**: `{`, `}`, `(`, `)`, `[`, `]`, `..`, `<>--`, `--<>`, `*`, `@`, `.`, `:`, `,`.
- **Convenção para Nomes de Classes**: iniciam com letra maiúscula, seguidas por qualquer combinação de letras ou sublinhado como subcadeia própria, sem números (`[A-Z][a-zA-Z_]*`).
- **Convenção para Nomes de Relações**: iniciam com letra minúscula, seguidas por qualquer combinação de letras ou sublinhado como subcadeia própria, sem números (`[a-z][a-zA-Z_]*`).
- **Convenção para Nomes de Instâncias**: iniciam com qualquer letra, podem ter sublinhado e terminam obrigatoriamente com algum número inteiro (`[a-zA-Z][a-zA-Z_]*[0-9]+`).
- **Tipos de Dados Nativos**: `number`, `string`, `boolean`, `date`, `time`, `datetime`.
- **Novos Tipos (DataTypes)**: iniciam com letra, sem números nem sublinhado, e terminam com a subcadeia `"DataType"` (`[a-zA-Z]+"DataType"`).
- **Meta-atributos**: `ordered`, `const`, `derived`, `subsets`, `redefines`.

---

## 🚀 Como Usar

### Pré-requisitos

No ambiente Linux (Debian, Ubuntu ou Mint), instale os pacotes de compilação e o Flex:

```bash
sudo apt update
sudo apt install -y g++ flex cmake make gdb
```

### Instalação

1. Clone o repositório ou baixe o código-fonte:
```bash
git clone [https://github.com/EduardaMaia34/analisadorLexico.git](https://github.com/EduardaMaia34/analisadorLexico.git)
```

2. Acesse o diretório do projeto:
```bash
cd analisadorLexico
```

### Execução pelo VS Code (Tasks e Launch)

O projeto possui automação completa configurada em `.vscode/tasks.json` e `.vscode/launch.json`.

#### 1. Como Compilar via Tasks
* **Compilação padrão direta**: Pressione o atalho **`Ctrl + Shift + B`**. O VS Code acionará a tarefa padrão `Build Debug` (executando `cmake debug` e `make debug` em cadeia).
* **Executar tasks específicas via menu**:
  1. Pressione **`Ctrl + Shift + P`** (ou abra o menu **Terminal > Executar Tarefa...**).
  2. Selecione **`Tasks: Run Task`** (ou **`Executar Tarefa`**).
  3. Escolha a ação desejada:
     * **`make debug`** (ou **`Build Debug`**): constrói o binário na pasta `Debug` com suporte a depuração.
     * **`make release`** (ou **`Build Release`**): gera o binário otimizado na pasta `Release`.
     * **`clean`**: limpa os diretórios de compilação e o arquivo intermediário `lex.yy.cpp`.

#### 2. Como Rodar e Depurar
* Pressione **`F5`** (ou abra a aba lateral **Executar e Depurar** e clique no ícone de Play verde em **Executar/Depurar Tonto Lexer**).
* O projeto compilará as alterações pendentes e executará a análise léxica passando o arquivo `testes/Universidade.tonto` como parâmetro.
* A saída completa será exibida no **Terminal Integrado** ou no **Console de Depuração**.

### Compilação e Execução Manual via Terminal

Caso prefira operar via linha de comando no shell:

#### 1. Compilação
Na raiz da pasta `analisadorLexico`, execute:
```bash
# Configura o CMake no diretório Debug
cmake -B Debug -DCMAKE_BUILD_TYPE=Debug

# Compila o executável rulesTonto
make -C Debug
```

#### 2. Execução
Execute o binário gerado informando o caminho do arquivo `.tonto`:
```bash
# Executando sobre o arquivo de teste padrão
./Debug/rulesTonto testes/Universidade.tonto

# Executando sobre qualquer outro arquivo .tonto
./Debug/rulesTonto caminho/para/seu_arquivo.tonto
```

Para redirecionar e salvar o relatório diretamente em um arquivo de texto:
```bash
./Debug/rulesTonto testes/Universidade.tonto > saida.txt
```

---

## 💻 Exemplos

### Arquivo de Entrada (`testes/Universidade.tonto`)

```text
package UniversidadeModel {

    // Novos tipos de dados
    CPFDataType
    MatriculaDataType

    // Estereótipos de Classe e Atributos
    kind Person {
        cpf: CPFDataType
        birthDate: date
        name: string
    }

    subkind Student
    subkind Professor

    phase UndergraduateStudent
    phase GraduateStudent

    // Generalização
    genset StudentPhases {
        general Student
        specifics UndergraduateStudent, GraduateStudent
        disjoint
        complete
    }

    // Estereótipos de Relação e Meta-atributos
    material enrolledIn [1..*] (Student) <>-- (UndergraduateStudent) {
        ordered
        derived
    }

    mediation teaches [1..*] (Professor) --<> (Student)

    // Instâncias
    Aluno01
    Docente2026

    // Erros intencionais para teste de diagnóstico
    123Invalido
    $
}
