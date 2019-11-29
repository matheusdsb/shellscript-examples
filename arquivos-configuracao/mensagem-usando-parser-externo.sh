#!/bin/bash

CONFIG="mensagem.conf"

USAR_CORES=0                    # config:   UsarCores
COR_LETRA=                      # config:   CorLetra
COR_FUNDO=                      # config:   CirFundo
MENSAGEM="Mensagem padrao"      # config:   Mensagem

#carregando configuração do arquivo externo
eval $(./parser.sh $CONFIG)

#processando os valores

[ "$(echo $CONF_USARCORES | tr A-Z a-z)" = "on" ] && USAR_CORES=1
COR_FUNDO=$(echo $CONF_CORFUNDO | tr -d -c 0-9) # só numeros
COR_LETRA=$(echo $CONF_CORLETRA | tr -d -c 0-9) # só numeros
[ "$CONF_MENSAGEM" ] && MENSAGEM=$CONF_MENSAGEM

if [ $USAR_CORES -eq 1 ]; then
    echo -e "\033[$COR_FUNDO;${COR_LETRA}m$MENSAGEM\033[m"
else 
    echo "$MENSAGEM"
fi


