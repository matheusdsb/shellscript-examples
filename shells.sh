#!/bin/bash

#mostra os shells dos usuariso sem repetir e ordenado

cat /etc/passwd | cut -d : -f 7 | sort | uniq
