#!/bin/bash

while getopts ":sb:a:" opcao
do
    case $opcao in
        s) echo "OK, opçao simples (-s)";;
        b) echo "OK, opçao com argumentos (-b), recebeu: $OPTARG";;
        a) echo "OK, opçao com argumentos (-a), recebeu: $OPTARG";;
        \?) echo "ERRO, opcao invalida: $OPTARG";;
        :) echo "ERRO, faltou argumento para $OPTARG";;
    esac
done

#echo "\$OPTIND antes do shift: $OPTIND"

echo
shift $((OPTIND-1))
echo "Indice: $OPTIND"
echo "Resto $*"
echo


