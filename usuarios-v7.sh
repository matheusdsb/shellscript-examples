#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuario do sistema
# OBS: Le dados do arquivo /etc/passwd
#
# Versao 1: Mostra usuarios e nomes separados por TAB
# Versao 2: Adicionado suporte a opcao -h
# Versao 3: Adicionado suporte a opcao -V e opcoes invalidas
# Versao 4: arrumando bug quando nao tem opçoes  e etc
# Versao 5: Adicionada ordenacao
# Versao 6: Adicionado reverse, uppercase e muitiplas opçoes
# Versao 7: Adicionado delimiter com argumento
#
# Aurelio, Novembro de 2007
#

ordenar=0
inverter=0
maiusculas=0
delim='\t'

MENSAGEM_USO="
Uso: $(basename "$0") [OPCOES]

OPCOES

-r, --reverse   Inverte a listagem
-u, --uppercase Mostra a listagem em MAIUSCULAS
-s, --sort	Ordena a lsita de forma alfabetica
-d, --delimiter C   Usa o caracter C como delimitador

-h, --help	Mostra esta tela de ajuda e sai!
-V, --version	Mostra a versao do programa e sai!
"

while test -n "$1"
do

    case "$1" in
    
        -s | --sort) ordenar=1 ;;        
        -r | --reverse) inverter=1 ;;        
        -u | --uppercase) maiusculas=1 ;;
        
        -d | --delimiter)
            
            shift
            delim="$1"
            
            if test -z "$delim"
            then
                echo "Faltou o arugmento para -d"
                exit 1
            fi
        ;;
    
        -h | --help)
            echo "$MENSAGEM_USO"
            exit 0
        ;;

        -V | --version)
            echo -n $(basename "$0")
            grep '^# Versao' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
            exit 0
        ;;

        *)
            if test -n "$1"
            then
                echo Opcao Invalida: $1
                exit 1
            fi
        ;;
    esac
    
    # Remove a opcao 1
    shift
done

lista=$(cut -d : -f 1,5 /etc/passwd)

test "$ordenar" = 1 &&  lista=$(echo "$lista" | sort)

test "$inverter" = 1 && lista=$(echo "$lista" | tac)

test "$maiusculas" = 1 && lista=$(echo "$lista" | tr a-z A-Z)

echo "$lista" | tr : "$delim"

