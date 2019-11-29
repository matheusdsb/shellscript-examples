#!/bin/bash

#mostra o usuario e o nome completo de cada usuario (campos 1 e 5) de passwd

cat /etc/passwd | cut -d : -f 1,5 | tr : '\t'
