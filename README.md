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
- [Autores](#-autores)
- [Licença](#-licença)

---

## 🧩 A Linguagem TONTO

A **TONTO** (*Textual Ontology Language*) é uma linguagem textual para modelagem e especificação formal de ontologias conceituais fundamentadas no OntoUML. Criada para superar as limitações das ferramentas estritamente visuais, permite versionamento facilitado com Git, modularização e interoperabilidade por meio da geração de saídas como:

- **OntoUML** (Modelos conceituais bem fundados)
- **gUFO / OWL** (Serialização ontológica para a Web Semântica / W3C)[cite: 1]
- **JSON** (Meta-modelo intermediário serializável)[cite: 1]

A linguagem conta com suporte a módulos, orquestração via *Tonto Package Manager* e integração com ambientes como Visual Paradigm e Protégé[cite: 1].

---

## 📖 Sobre o Projeto

O **Analisador Léxico para a Linguagem TONTO** foi desenvolvido para a disciplina de Compiladores (UFERSA)[cite: 1]. Seu objetivo é analisar o fluxo de caracteres de códigos `.tonto`, isolando e categorizando os seguintes elementos[cite: 1]:

- **Palavras reservadas**: `genset`, `disjoint`, `complete`, `general`, `specifics`, `where`, `package`, `import`, `functional-complexes`[cite: 1];
- **Estereótipos de classe**: `kind`, `subkind`, `role`, `phase`, `category`, `mixin`, `collective`, `quantity`, `mode`, `quality`, etc.[cite: 1];
- **Estereótipos de relações**: `material`, `derivation`, `comparative`, `mediation`, `characterization`, `componentOf`, `memberOf`, etc.[cite: 1];
- **Nomes de classes**: Iniciando com maiúscula, apenas letras e sublinhado[cite: 1];
- **Nomes de relações**: Iniciando com minúscula, apenas letras e sublinhado[cite: 1];
- **Nomes de instâncias / indivíduos**: Iniciando com letra e obrigatoriamente terminando com dígitos[cite: 1];
- **Tipos de dados nativos**: `number`, `string`, `boolean`, `date`, `time`, `datetime`[cite: 1];
- **Novos tipos de dados**: Apenas letras, terminando estritamente com o sufixo `DataType`[cite: 1];
- **Meta-atributos**: `ordered`, `const`, `derived`, `subsets`, `redefines`[cite: 1];
- **Símbolos especiais e operadores**: `<>--`, `--<>`, `..`, `{`, `}`, `(`, `)`, `[`, `]`, `*`, `@`, `.`, `:`, `,`[cite: 1].

O analisador também realiza o descarte de comentários (`//` e `/* ... */`) e computa com exatidão a coordenada (linha e coluna) de cada lexema casado no texto-fonte[cite: 1].

---

## 🛠 Tecnologias Utilizadas

- **C++17** (Compilador GCC / G++)[cite: 1]
- **Flex (Fast Lexical Analyzer 2.6+)**[cite: 1]
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
