#!/bin/bash

#tudo=

#while [ -n "$1" ]; 
#do
#    tudo="${tudo}$1"
#    shift
#done

#echo "$tudo"

#forma mais simples
echo $* | tr -d ' ' 


