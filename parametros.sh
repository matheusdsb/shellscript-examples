#!/bin/bash

#mostra todos parametros com suas contagens

contador=1

while [ -n "$1" ]; 
do
    echo "parametro $contador: $1"
    contador=$((contador+1))
    shift
done



