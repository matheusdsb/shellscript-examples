#!/bin/bash

echo "Vou exibir os dados, posso continuar? [sn]"
read RESPOSTA

echo "vouce respondeu :$RESPOSTA"

test $RESPOSTA = "n" && exit

echo "exibindo data"

date

echo "exibndo uso do disco"

df

echo "exibindo usuarios logados"

w
