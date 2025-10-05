# Monitoring Stack - Grafana + Prometheus

Stack de monitoramento completa para Leo Profi.

## 📊 Componentes:
- **Grafana**: Dashboard de visualização (porta 3000)
- **Prometheus**: Coleta de métricas (porta 9090)  
- **Node Exporter**: Métricas do sistema (porta 9100)

## 🚀 Iniciar:
```bash
cd /home/leonardovieiraxy/projetos/monitoring-stack
docker-compose up -d
```

## 🌐 Acesso:
- **Grafana**: https://grafana.leoproti.com.br
- **Local Grafana**: http://localhost:3000
- **Prometheus**: http://localhost:9090

## 🔐 Credenciais:
- **User**: admin
- **Password**: CloudflaredGrafana2025

## 📈 Métricas Coletadas:
- ☁️ **Cloudflared**: Conexões, latência, throughput
- 🖥️ **Sistema**: CPU, RAM, Disk, Network
- 🐳 **Docker**: Container stats
- 🌐 **Prometheus**: Self-monitoring

## 🎯 Dashboards Recomendados:
1. **Cloudflared Tunnel Monitoring**
2. **Node Exporter Full**
3. **Docker Container Monitoring**

## 📋 Para adicionar no Cloudflare DNS:
```
Name: grafana
Target: 7637938c-e1ee-4090-af2f-5769aa7aa580.cfargotunnel.com
Proxy: Enabled
```

## 🔧 Comandos úteis:
```bash
# Parar tudo
docker-compose down

# Ver logs
docker-compose logs -f

# Restart specific service
docker-compose restart grafana
```