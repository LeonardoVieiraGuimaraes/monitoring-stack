# 📊 Monitoramento Leo Profi - Dashboards Configurados

## ✅ Dashboards Importados com Sucesso

### 1. 🚀 Leo Profi - Cloudflared Monitoring (CUSTOM)
- **URL**: https://grafana.leoproti.com.br/d/81959a27-fb47-48e4-9811-5c1478700aa1
- **Descrição**: Dashboard customizado para monitoramento específico do Cloudflared
- **Métricas**:
  - Status do Tunnel (UP/DOWN)
  - Taxa de requisições por segundo
  - Conexões ativas
  - Tempo de resposta (95º percentil)

### 2. 🐳 Docker Monitoring
- **URL**: https://grafana.leoproti.com.br/d/bbbf5c88-2f58-459b-9921-e7a5a2a3952a
- **Descrição**: Monitoramento completo dos containers Docker
- **Métricas**: CPU, memória, rede, storage dos containers

### 3. 🖥️ Node Exporter Full
- **URL**: https://grafana.leoproti.com.br/d/rYdddlPWk/node-exporter-full
- **Descrição**: Monitoramento completo do sistema (CPU, RAM, disco, rede)
- **Métricas**: Sistema operacional e hardware

### 4. 📈 VictoriaMetrics - backupmanager
- **URL**: https://grafana.leoproti.com.br/d/gF-lxRdVz/victoriametrics-backupmanager
- **Descrição**: Monitoramento de backups (se aplicável)

## 🌐 Acesso

- **URL Principal**: https://grafana.leoproti.com.br
- **Usuário**: admin
- **Senha**: admin123

## 🔧 Configuração Técnica

- **Prometheus**: http://localhost:9090
- **Node Exporter**: http://localhost:9100
- **Grafana**: http://localhost:3000 (interno) / https://grafana.leoproti.com.br (externo)
- **Cloudflared Metrics**: http://localhost:metrics (via tunnel)

## ⚡ Métricas Principais do Cloudflared

O dashboard principal monitora:
- `up{job="cloudflared"}` - Status do serviço
- `rate(cloudflared_tunnel_request_total[5m])` - Taxa de requisições
- `cloudflared_tunnel_active_streams` - Conexões ativas
- `histogram_quantile(0.95, rate(cloudflared_tunnel_request_duration_seconds_bucket[5m]))` - Latência

## 🚨 Próximos Passos (Opcional)

1. Configurar alertas para quando o tunnel ficar offline
2. Adicionar métricas personalizadas para outros serviços
3. Configurar retenção de dados no Prometheus
4. Backup automático das configurações do Grafana