#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuario do sistema
# OBS: Le dados do arquivo /etc/passwd
#
# Versao 1: Mostra usuarios e nomes separados por TAB
# Versao 2: Adicionado suporte a opcao -h
# Versao 3: Adicionado suporte a opcao -V e opcoes invalidas
# Versao 4: arrumando bug quando nao tem opçoes  e etc
# Versao 5: ordenacao
#
# Aurelio, Novembro de 2007
#

ordenar=0

MENSAGEM_USO="
Uso: $(basename "$0") [-h | -V]

-h, --help	Mostra esta tela de ajuda e sai!
-V, --version	Mostra a versao do programa e sai!
-s, --sort	Ordena a lsita de forma alfabetica
"

#if test "$1" = "-h" 
#then
#	echo "$MENSAGEM_USO" 
#	exit 0
#fi

case "$1" in
	-h | --help)
		echo "$MENSAGEM_USO"
		exit 0
	;;

	-V | --version)
		echo -n $(basename "$0")
		grep '^# Versao' usuarios.sh | tail -1 | cut -d : -f 1 | tr -d \#
		exit 0
	;;

	-s | --sort)
		ordenar=1
	;;

	*)
		if test -n "$1"
		then
			echo Opcao Invalida: $1
			exit 1
		fi
	;;
esac

lista=$(cut -d : -f 1,5 /etc/passwd)

if test "$ordenar" = 1
then
	lista=$(echo "$lista" | sort)
fi

echo "$lista" | tr : \\t

#cut -d : -f 1,5 /etc/passwd | tr : \\t
