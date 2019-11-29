#!/bin/bash

CONFIG=$1

if [ -z "$CONFIG" ]; then
    echo Uso: parser arquivo.conf 
    exit 1
elif [ ! -r "$CONFIG" ]; then
    echo Erro: Não consigo ler o arquivo $CONFIG
    exit 1
fi

while read LINHA; do
    
    #ignorando linhas de comentário
    [ "$(echo $LINHA | cut -c1)" = "#" ] && continue
    
    #ignorando linhas em branco
    [ "$LINHA" ] || continue
    
    #guardando cada palavra  da linha em $1,  $2,...
    set - $LINHA
    
    #extraindo os dados
    chave=$(echo $1 | tr a-z A-Z)
    shift
    valor=$*
    
    # mostrando chave="valor"
    echo "CONF_$chave=\"$valor\""
    
done < "$CONFIG"

