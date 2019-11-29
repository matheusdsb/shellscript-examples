#!/bin/bash
#se não passar argumento, mostra a mensagem de ajuda

BANCO=usuarios.txt

#inclui o gerenciador de banco
source bantex.sh || {
    echo "ocorreu algum erro no gerenciador de banco"
    exit 1
}

#lida com os comandos recebidos
while : 
do

    acao=$( dialog --stdout \
        --title "Aplicativo Zuserd - interface amigável" \
        --menu "" \
        0 0 0 \
        lista "Lista todos usuários do sistema" \
        adiciona "Adiciona um usuário novo ao sistema" \
        remove "Remove um usuário do sistema"
    )
    [ $? -ne 0 ] && exit

    case "$acao" in
        
        lista)
            #lista os logins 
            temp=$(mktemp -t lixoXXX)
            pega_campo 1 | sed 1d > "$temp"        
            dialog --title "Usuários" --textbox "$temp" 13 30
            rm $temp
        ;;
        
        adiciona)
            login=$(dialog --stdout --inputbox "Digite o login:" 0 0)
            
            [ $? -ne 0 ] && continue
            [ "$login" ] || continue
            
            tem_chave "$login" && {
                msg="o usuário $login já foi cadastrado "
                dialog --msgbox "$msg" 6 40
                continue
            }
            
            nome=$(dialog --stdout --inputbox "Nome completo:" 0 0)
            [ $? -ne 0 ] && continue
            
            idade=$(dialog --stdout --inputbox "Idade:" 0 0)
            [ $? -ne 0 ] && continue
            
            sexo=$(dialog --stdout --radiolist "Sexo:" 0 0 3 Feminino "" on Masculino "" off)
            [ $? -ne 0 ] && continue
            
            sexo=$(echo  $sexo | cut -c1)

            #mascarar eventais dois-pontos        
            nome=$(echo $nome | mascara) 
            msg=$(insere_registro "$login:$nome:$idade:$sexo")
            dialog --title "Resultado" --msgbox "$msg" 6 40        
        ;;
        
        remove)
            
            usuarios=$(pega_campo 1,2 | sed 1d)
            usuarios=$(echo "$usuarios" | sed 's/:/ "/;s/$/"/')
            
            login=$(eval dialog --stdout --menu \"Escolha o usuário a remover\" 0 0 0 $usuarios)
            [ $? -ne 0 ] && continue
            
            msg=$(apaga_registro "$login")
            dialog --title "Resultado" --msgbox "$msg" 6 40
        ;;
        
        *)
            echo "opção inválida $1"
            exit 1
        ;;
    esac
done

