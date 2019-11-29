#!/bin/bash

SEP=:           # defina aqui o separador, padrão é :
TEMP=temp.$$    #arquivo temporario
MASCARA=§       #caractere exótico para mascarar o separador

[ "$BANCO" ] || {
    echo "Base de dados não informada. Use a váriavel BANCO"
    return 1
}

[ -r "$BANCO" -a -w "$BANCO" ] || {
    echo "Base travada, confira as permissões de leitura e escrita"
    return 1
}


# apaga o registro da chave $1 do banco
apaga_registro() {

    tem_chave "$1" || return #se nao tem, nem tenta

    grep -i -v "^$1$SEP" "$BANCO" > "$TEMP" #apaga a chave
    mv "$TEMP" "$BANCO" #regrava o banco
    
    echo "O registro $1 foi apagado"
}

# insere o registro $* no banco
insere_registro() {

    local chave=$(echo "$1" | cut -d $SEP -f1) # pega o primeiro campo
    
    if tem_chave "$chave"; then
        echo "A chave $chave já está cadastrada no banco"
        return 1
    else
        echo "$*" >> "$BANCO" # grava o registro
        echo "REgistro de $chave cadastrado com sucesso"
    fi

    return 0
    
}

tem_chave() {
    grep -i -q "$1$SEP" "$BANCO"
}

campos() {
    head -n 1 "$BANCO" | tr $SEP \\n
}

mostra_registro() {
    local dados=$(grep -i "^$1$SEP" "$BANCO")
    local i=0
    
    [ "$dados" ] || return # não achei
    
    campos | while read campo; do # para cada campo
    
        i=$((i+1)) #indice do campo
        echo -n "$campo: " # nome do campo
        echo "$dados" | cut -d $SEP -f $i | desmascara #conteudo do campo
    done
}

# mostra o valor do campo número $1 do registro de chave $2 (opcional)
pega_campo() {
    local chave=${2:-.*}
    grep -i "^$chave$SEP" "$BANCO" | cut -d $SEP -f $1 | desmascara
}

mascara() { tr $SEP $MASCARA ;  } 
desmascara() { tr $MASCARA $SEP ; }
