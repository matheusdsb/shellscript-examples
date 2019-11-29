#!/bin/bash

Debug() {
    [ "$DEBUG" = 1 ] && echo -e "\033[33;1m-------------------( $*\033[m"
}

DEBUG=1

TXT="gritaria"

TXT="     $TXT     "

Debug "TXT com espaços  : [$TXT]"

#troca os espaços por exclamaçoes
TXT=$(echo  "$TXT" | tr ' '  '!')

Debug "TXT com exclamaçoes: [$TXT]"


TXT=$(echo $TXT | tr a-z A-Z)

echo "$TXT"



