#!/bin/bash

echo "🔍 Verificando Status das Métricas do Grafana"
echo "=============================================="

echo ""
echo "📊 Status dos Targets no Prometheus:"
curl -s http://localhost:9090/api/v1/targets | jq -r '.data.activeTargets[] | "\(.scrapePool): \(.health) - \(.lastError // "OK")"'

echo ""
echo "📈 Métricas Disponíveis do Cloudflared:"
curl -s 'http://localhost:9090/api/v1/label/__name__/values' | jq -r '.data[]' | grep cloudflared | head -5

echo ""
echo "🌐 Testando Acesso ao Grafana:"
if curl -s -u "admin:CloudflaredGrafana2025" http://localhost:3000/api/health | grep -q "ok"; then
    echo "✅ Grafana: Funcionando"
else
    echo "❌ Grafana: Problema de acesso"
fi

echo ""
echo "🔗 Links Importantes:"
echo "- Grafana: https://grafana.leoproti.com.br"
echo "- Prometheus: http://localhost:9090"
echo "- Dashboard Cloudflared: https://grafana.leoproti.com.br/d/81959a27-fb47-48e4-9811-5c1478700aa1"

echo ""
echo "📋 Dashboards Disponíveis:"
curl -s -u "admin:CloudflaredGrafana2025" http://localhost:3000/api/search | jq -r '.[] | "- \(.title): \(.url)"'