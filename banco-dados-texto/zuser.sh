#!/bin/bash

#se não passar argumento, mostra a mensagem de ajuda
[ "$1" ] || { 
    echo
    echo "Uso: zuser [ lista | adiciona | remove]"
    echo
    exit 0
}

BANCO=usuarios.txt

#inclui o gerenciador de banco
source bantex.sh || {
    echo "ocorreu algum erro no gerenciador de banco"
    exit 1
}

#lida com os comandos recebidos
case "$1" in
    
    lista)
        #lista os logins 
        pega_campo 1 | sed 1d
    ;;
    
    adiciona)
        echo -n "Digite o login do usuario novo: "
        read login
        
        [ "$login" ] || {
            echo "o login não pode ser vazio, tente novamente "
        }
        
        tem_chave "$login" && {
            echo "o usuário $login já foi cadastrado "
            exit 1
        }
        
        echo -n "digite o nome completo: "
        read nome
        echo -n "digite a idade "
        read idade 
        echo -n "sexo masculino ou feminino? [MF]: "
        read sexo        
        echo
        
        nome=$(echo $nome | mascara)
        
        insere_registro "$login:$nome:$idade:$sexo"
        echo
        
    ;;
    
    remove)
        echo "lista dos usuários do sistema:"
        pega_campo 1 | sed 1d | tr \\n ' '
        echo
        echo
        echo -n "qual usuario voce quer remover? "
        read login
        echo
        
        if tem_chave "$login"; then
            apaga_registro "$login"
        else 
            echo "usuário não encontrado"
        fi
        echo
    ;;
    
    *)
        echo "opção inválida $1"
        exit 1
    ;;
esac

