#!/bin/bash

# Variáveis
URL="http://SeuIPlocal"
ARQUIVO_LOG="/var/log/monitoramento/monitoramento.log"
URL_WEBHOOK="URLdoSeuWebhook"

# Marca a data e o hora atual para registro de status no log de monitoramento 
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$ARQUIVO_LOG"
}

# Configuração para envio de mensagem de alerta no Discord
alerta_discord() {
    MESSAGE=$1
    # Corpo do JSON para a mensagem no Discord
    JSON_PAYLOAD="{\"content\": \"$MESSAGE\"}"

    curl -s -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$URL_WEBHOOK"
}

# Verifica stautus do site(online/offline) e resgistra no log de monitoramento
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ "$HTTP_STATUS" -eq 200 ]; then
    log "SUCESSO: Site online!"
else
    log "FALHA: Site indisponível!"
	# Envia notificação para o Discord através do webhook
    alerta_discord " **‼️ATENÇÃO‼️** O site está indisponível!"                
fi
