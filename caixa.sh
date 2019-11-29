#!/bin/bash

caixa_largura=60
caixa_coluna_inicio=5
caixa_linha_inicio=5
texto_max_linhas=20
distancia_borda_texto=1
caixa_cor='33;1'
texto_cor='32'

#caixa_cor='33;43'

caixa_coluna_fim=$((caixa_coluna_inicio+caixa_largura-1))
texto_coluna_inicio=$((caixa_coluna_inicio+distancia_borda_texto+1 ))
texto_largura=$((caixa_largura-distancia_borda_texto ))
texto=$(fmt -sw $texto_largura)
num_linhas=$( echo "$texto" | wc -l )
total_linhas=$((num_linhas+2)) # texto + bordas horizontais


#checagem do tamanho do texto
if [ $num_linhas -gt $texto_max_linhas ]; then
    echo "Texto muito extenso, nao vai caber na tela"
    exit 1
fi

##compoe a linha horizontal da caixa 
#eh caixa_largura-2 porque os cantos serao feitos com o +

for i in $(seq $((caixa_largura-2))); do
    linha_caixa="$linha_caixa-"
done

#limpa a tela
echo -ne "\033c"

#desenha a caixa
echo -ne "\033[$caixa_linha_inicio;0H" #pula para a linha inicial
echo -ne "\033[${caixa_cor}m" #liga a cor da caixa

for i in $(seq $total_linhas); do #para cada linha
    echo -ne "\033[${caixa_coluna_inicio}G"  #vai para coluna inicial
    if [ $i -eq 1 -o $i -eq $total_linhas ]; then  #1a ou ultima linha
        echo +$linha_caixa+ #borda horizontal
    else 
        echo -e "|\033[${caixa_coluna_fim}G|" #bordas verticais
    fi
done

echo -e "\033[m" #desliga as cores

#coloca o texto dentro da caixa
echo -ne "\033[$((caixa_linha_inicio+1));0H" #pula para a linha inicial
echo -ne "\033[${texto_cor}m" #liga a cor do texto
echo "$texto" | while read LINHA; do #para cada linha...
    echo -e "\033[${texto_coluna_inicio}G$LINHA" #posiciona e mostra
done

echo -e "\033[m" #desliga as cores

echo



