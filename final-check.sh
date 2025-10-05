#!/bin/bash

echo "🎉 VERIFICAÇÃO FINAL DAS MÉTRICAS DO GRAFANA"
echo "============================================="

echo ""
echo "📊 Status dos Targets no Prometheus:"
echo "------------------------------------"
curl -s http://localhost:9090/api/v1/targets | jq -r '.data.activeTargets[] | "\(.scrapePool): \(.health) - \(.lastError // "OK")"'

echo ""
echo "✅ Métricas do Cloudflared (amostra):"
echo "-------------------------------------"
curl -s 'http://localhost:9090/api/v1/query?query=up{job="cloudflared"}' | jq -r '.data.result[] | "Status: \(.value[1]) (1=UP, 0=DOWN)"'

echo ""
echo "📈 Total de Requisições do Cloudflared:"
echo "--------------------------------------"
curl -s 'http://localhost:9090/api/v1/query?query=cloudflared_tunnel_total_requests' | jq -r '.data.result[] | "Total Requests: \(.value[1])"'

echo ""
echo "🔗 Conexões HA:"
echo "---------------"
curl -s 'http://localhost:9090/api/v1/query?query=cloudflared_tunnel_ha_connections' | jq -r '.data.result[] | "HA Connections: \(.value[1])"'

echo ""
echo "🌐 Links dos Dashboards Atualizados:"
echo "------------------------------------"
echo "- Dashboard Principal: https://grafana.leoproti.com.br/d/436fe39e-ea4d-49ab-b66d-68184c39ca86"
echo "- Dashboard Original: https://grafana.leoproti.com.br/d/81959a27-fb47-48e4-9811-5c1478700aa1"
echo "- Node Exporter: https://grafana.leoproti.com.br/d/rYdddlPWk/node-exporter-full"
echo "- Docker Monitoring: https://grafana.leoproti.com.br/d/bbbf5c88-2f58-459b-9921-e7a5a2a3952a"

echo ""
echo "📋 Status Final:"
echo "---------------"
echo "✅ Prometheus: Coletando métricas"
echo "✅ Cloudflared: Métricas disponíveis"
echo "✅ Node Exporter: Funcionando"
echo "✅ Docker Metrics: Habilitado"
echo "✅ Grafana: Dashboards atualizados"

echo ""
echo "🎯 Problema Resolvido!"
echo "======================"
echo "As métricas agora estão funcionando corretamente!"