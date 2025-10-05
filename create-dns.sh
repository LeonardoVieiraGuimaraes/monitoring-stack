#!/bin/bash

# Script para criar DNS record no Cloudflare via API
# Uso: ./create-dns.sh [SUBDOMINIO] [TOKEN_API] [ZONE_ID]

SUBDOMAIN=$1
API_TOKEN=$2
ZONE_ID=$3
TUNNEL_ID="7637938c-e1ee-4090-af2f-5769aa7aa580"

if [ $# -ne 3 ]; then
    echo "❌ Uso: $0 [SUBDOMINIO] [API_TOKEN] [ZONE_ID]"
    echo ""
    echo "🔍 Para obter o ZONE_ID:"
    echo "   curl -X GET \"https://api.cloudflare.com/client/v4/zones\" \\"
    echo "        -H \"Authorization: Bearer YOUR_API_TOKEN\" \\"
    echo "        -H \"Content-Type: application/json\" | jq '.result[] | select(.name==\"leoproti.com.br\") | .id'"
    echo ""
    echo "📋 Exemplo:"
    echo "   $0 grafana cf_api_token_aqui zone_id_aqui"
    exit 1
fi

echo "🚀 Criando DNS record: ${SUBDOMAIN}.leoproti.com.br"
echo "🎯 Target: ${TUNNEL_ID}.cfargotunnel.com"

# Criar o record DNS
RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records" \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -H "Content-Type: application/json" \
  --data '{
    "type": "CNAME",
    "name": "'${SUBDOMAIN}'",
    "content": "'${TUNNEL_ID}'.cfargotunnel.com",
    "proxied": true,
    "ttl": 1
  }')

# Verificar resultado
SUCCESS=$(echo $RESPONSE | jq -r '.success')
if [ "$SUCCESS" = "true" ]; then
    echo "✅ DNS record criado com sucesso!"
    echo "🌐 URL: https://${SUBDOMAIN}.leoproti.com.br"
    echo "⏱️ Aguarde 1-5 minutos para propagação"
else
    echo "❌ Erro ao criar DNS record:"
    echo $RESPONSE | jq -r '.errors[0].message'
fi