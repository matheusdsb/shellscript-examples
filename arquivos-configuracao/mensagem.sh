#!/bin/bash

CONFIG="mensagem.conf"

USAR_CORES=0                    # config:   UsarCores
COR_LETRA=                      # config:   CorLetra
COR_FUNDO=                      # config:   CirFundo
MENSAGEM="Mensagem padrao"      # config:   Mensagem

while read LINHA; do
    
    #echo com aspas: "$LINHA"
    #echo sem asps: $LINHA
    
    #ignorando linhas de comentario
    [ "$(echo $LINHA | cut -c1)" = "#" ] && continue
    
    #ignorando linhas em branco
    [ "$LINHA" ] || continue
    
    #transforma tudo em variaveis separadas por espaço: ex
    #joao eh metaleiro: $1=joao $2=eh $3=metaleiro
    set - $LINHA
    
    #primeira variavel eh a chave
    chave=$(echo $1 | tr A-Z a-z)
    #remove a primeira
    shift
    #junta o valor de todas variaveis numa so
    valor=$*
    
    #echo "+++ $chave --> $valor"
    
    case "$chave" in 
        
        usarcores)
            [ "$(echo $valor | tr A-Z a-z)" = "on" ] && USAR_CORES=1 ;;
            
        corfundo)
            COR_FUNDO=$(echo $valor | tr -d -c 0-9) ;; #so numeros
            
        corletra)
            COR_LETRA=$(echo $valor | tr -d -c 0-9) ;; #so numeros
            
        mensagem)
            [ "$valor" ] && MENSAGEM=$valor ;;
            
        *)
            echo "Erro no arquivo de configuracao"
            echo "opcao desconhecida: $chave"
            exit 1
        ;;
    esac
    
    
done < "$CONFIG"

if [ $USAR_CORES -eq 1 ]; then
    echo -e "\033[$COR_FUNDO;${COR_LETRA}m$MENSAGEM\033[m"
else 
    echo "$MENSAGEM"
fi


