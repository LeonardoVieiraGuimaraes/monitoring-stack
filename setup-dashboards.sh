#!/bin/bash

# Script para configurar dashboards no Grafana automaticamente
GRAFANA_URL="https://grafana.leoproti.com.br"
GRAFANA_USER="admin"
GRAFANA_PASS="CloudflaredGrafana2025"

echo "🚀 Configurando dashboards no Grafana..."
echo "🌐 URL: $GRAFANA_URL"

# Função para importar dashboard
import_dashboard() {
    local dashboard_id=$1
    local dashboard_name=$2
    
    echo "📊 Importando dashboard $dashboard_id ($dashboard_name)..."
    
    # Buscar dashboard da grafana.com
    DASHBOARD_JSON=$(curl -s "https://grafana.com/api/dashboards/$dashboard_id" | jq '.json')
    
    if [ "$DASHBOARD_JSON" = "null" ]; then
        echo "❌ Erro ao buscar dashboard $dashboard_id"
        return 1
    fi
    
    # Preparar payload para importação
    IMPORT_PAYLOAD=$(echo "$DASHBOARD_JSON" | jq '{
        dashboard: (. | .id = null),
        folderId: 0,
        overwrite: true,
        inputs: [{
            name: "DS_PROMETHEUS",
            type: "datasource",
            pluginId: "prometheus",
            value: "Prometheus"
        }]
    }')
    
    # Importar no Grafana
    RESPONSE=$(curl -s -X POST \
        -H "Content-Type: application/json" \
        -u "$GRAFANA_USER:$GRAFANA_PASS" \
        -d "$IMPORT_PAYLOAD" \
        "$GRAFANA_URL/api/dashboards/import")
    
    if echo "$RESPONSE" | jq -e '.id' > /dev/null; then
        echo "✅ Dashboard $dashboard_name importado com sucesso!"
        DASHBOARD_URL=$(echo "$RESPONSE" | jq -r '.url')
        echo "🔗 URL: $GRAFANA_URL$DASHBOARD_URL"
    else
        echo "❌ Erro ao importar dashboard $dashboard_name:"
        echo "$RESPONSE" | jq -r '.message // .error // .'
    fi
    
    echo ""
}

# Aguardar Grafana estar pronto
echo "⏳ Aguardando Grafana estar pronto..."
until curl -s "$GRAFANA_URL/api/health" > /dev/null; do
    echo "   Tentando conectar..."
    sleep 2
done
echo "✅ Grafana está online!"
echo ""

# Importar dashboards principais
import_dashboard "17798" "Cloudflare Tunnel Dashboard"
import_dashboard "1860" "Node Exporter Full"
import_dashboard "193" "Docker Host & Container Overview"

echo "🎯 Dashboards configurados!"
echo "🌐 Acesse: $GRAFANA_URL"
echo "🔐 Login: $GRAFANA_USER / $GRAFANA_PASS"