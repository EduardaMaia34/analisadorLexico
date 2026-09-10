cmake_minimum_required(VERSION 3.10)
project(TontoLexer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(FLEX REQUIRED)

FLEX_TARGET(TontoScanner rulesTonto.l ${CMAKE_CURRENT_SOURCE_DIR}/lex.yy.cpp)

add_executable(rulesTonto main.cpp ${FLEX_TontoScanner_OUTPUTS})