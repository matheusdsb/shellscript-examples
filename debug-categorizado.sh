#!/bin/bash

DEBUG=${1:-0}

Debug() {
    [ $1 -le $DEBUG ] || return
    
    local prefixo
    
    case "$1" in 
    
        1) prefixo="-- "  ;;
        2) prefixo="---- "  ;;
        3) prefixo="-------- "  ;;
        *)  echo "Mensagem nao categorizada $*"; return;;
        
    esac
    
    shift 
    
    echo $prefixo$*
    
    #[ $1 -le $DEBUG ] && echo "---- DEBUG $*"
}

Debug 1 "Iniciando o programa"

i=0
max=5

echo "Contando ate $max"

Debug 2 "Vou entrar no WHILE"

while [ $i -ne $max ]; do
    
    Debug 3 "Valor de \$i antes de incrementar: $i"
    
    let i=$i+1
    
    Debug 3 "Valor de \$i depois de incrementar: $i"
    
    echo "$i..."
    
done

Debug 2 "Sai do WHILE"

echo "Terminei!!"


