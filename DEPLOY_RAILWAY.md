# 🚀 Guia de Deploy no Railway - Elevare SaaS CRM

## 📋 Pré-requisitos

- Conta no [Railway.app](https://railway.app) (gratuita)
- Repositório GitHub conectado
- 15-20 minutos

## 🎯 Passo a Passo Completo

### **1. Criar Projeto no Railway**

1. Acesse [railway.app](https://railway.app)
2. Faça login com GitHub
3. Clique em **"New Project"**
4. Selecione **"Deploy from GitHub repo"**
5. Escolha o repositório: `iaraelevare-source/Elevare-FullStack`
6. Selecione a branch: `master`

### **2. Adicionar PostgreSQL Database**

1. No dashboard do projeto, clique em **"+ New"**
2. Selecione **"Database"** → **"PostgreSQL"**
3. Railway criará automaticamente:
   - Container PostgreSQL
   - Variável `DATABASE_URL` (auto-configurada)
4. Aguarde ~30 segundos para o database ficar pronto

### **3. Configurar Backend Service**

#### 3.1 Configurar Build Settings

1. Clique no serviço **backend** (ou no card principal do projeto)
2. Vá em **"Settings"**
3. Configure:
   - **Root Directory:** `backend`
   - **Build Command:** 
     ```bash
     npm install && npx prisma generate && npm run build
     ```
   - **Start Command:**
     ```bash
     npx prisma migrate deploy && npm run start:prod
     ```
   - **Watch Paths:** `backend/**`

#### 3.2 Adicionar Variáveis de Ambiente

1. Ainda em **"Settings"**, vá em **"Variables"**
2. Clique em **"+ New Variable"**
3. Adicione **UMA POR UMA** as seguintes variáveis:

```bash
NODE_ENV=production
PORT=3000
TZ=America/Sao_Paulo
LOG_LEVEL=info

# JWT Secrets
JWT_SECRET=8f8721bcc38e2a9d3470be71704e2334f992ba828d886e2a1ce730e4786c44d8
JWT_REFRESH_SECRET=6d2e41d3efac828684e37867c6ce44b15c85d95d5a39622ac3d645aceccc1299
JWT_EXPIRATION=24h
JWT_REFRESH_EXPIRATION=7d

# Webhook Secret
ELEVARE_WEBHOOK_SECRET=7e1b811b4c36e9dade33cc38cc96760360f8e801ff34cf1ce0b2164553190f6f

# Redis (opcional - se adicionar serviço Redis)
REDIS_URL=redis://redis:6379
REDIS_HOST=redis
REDIS_PORT=6379
```

**⚠️ IMPORTANTE:** A variável `DATABASE_URL` será **automaticamente injetada** pelo Railway quando você conectar o PostgreSQL ao backend.

#### 3.3 Conectar PostgreSQL ao Backend

1. No dashboard, clique no serviço **backend**
2. Vá em **"Settings"** → **"Service Variables"**
3. Procure por **"Reference Variables"**
4. Clique em **"+ Add Reference"**
5. Selecione o serviço **PostgreSQL**
6. Selecione a variável **`DATABASE_URL`**
7. Confirme

### **4. Deploy**

1. Clique em **"Deploy"** (ou aguarde deploy automático)
2. Acompanhe os logs em **"Deployments"**
3. Aguarde ~3-5 minutos para o build completar

### **5. Verificar Deploy**

#### 5.1 Obter URL Pública

1. No serviço backend, vá em **"Settings"** → **"Networking"**
2. Clique em **"Generate Domain"**
3. Railway gerará uma URL como:
   ```
   https://elevare-backend-production.up.railway.app
   ```

#### 5.2 Testar Endpoints

```bash
# Health check (se configurado)
curl https://sua-url.railway.app/health

# API Docs (Swagger)
https://sua-url.railway.app/api

# Teste de autenticação
curl -X POST https://sua-url.railway.app/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"test123"}'
```

## 🔧 Configurações Opcionais

### Adicionar Redis (para Filas/Bull)

1. Clique em **"+ New"** → **"Database"** → **"Redis"**
2. Conecte ao backend via **Reference Variables**
3. Railway criará `REDIS_URL` automaticamente

### Configurar Domínio Customizado

1. Vá em **"Settings"** → **"Networking"**
2. Clique em **"Custom Domain"**
3. Adicione seu domínio (ex: `api.elevare.com`)
4. Configure DNS conforme instruções do Railway

### Configurar CI/CD Automático

✅ **Já configurado!** Railway faz deploy automático a cada push na branch `master`.

Para desabilitar:
1. **"Settings"** → **"Deploys"**
2. Desmarque **"Auto Deploy"**

## 🐛 Troubleshooting

### Build falha com erro de Prisma

**Solução:** Certifique-se de que o `prisma/schema.prisma` existe e está correto.

```bash
# No build command, adicione:
npx prisma generate
```

### Migrations não rodam

**Solução:** Verifique se o start command inclui:

```bash
npx prisma migrate deploy && npm run start:prod
```

### Erro "Cannot find module 'dist/main'"

**Solução:** Verifique se o build command inclui:

```bash
npm run build
```

### DATABASE_URL não encontrada

**Solução:** 
1. Verifique se PostgreSQL está conectado ao backend
2. Vá em **"Settings"** → **"Service Variables"**
3. Confirme que `DATABASE_URL` aparece na lista

## 📊 Monitoramento

### Logs em Tempo Real

1. Clique no serviço backend
2. Vá em **"Deployments"**
3. Clique no deployment ativo
4. Visualize logs em tempo real

### Métricas

1. **"Metrics"** mostra:
   - CPU usage
   - Memory usage
   - Network traffic

### Alertas

Configure em **"Settings"** → **"Alerts"** para receber notificações de:
- Deploy failures
- High resource usage
- Downtime

## 💰 Custos

### Free Tier (Hobby Plan)
- **$5/mês de crédito gratuito**
- Suficiente para:
  - 1 backend service
  - 1 PostgreSQL database
  - Tráfego moderado (~100k requests/mês)

### Upgrade para Pro ($20/mês)
- Créditos ilimitados
- Mais recursos (CPU/RAM)
- Suporte prioritário

## 🔒 Segurança

### Boas Práticas

1. **Nunca commite secrets no Git**
   - Use variáveis de ambiente no Railway
   - Adicione `.env` ao `.gitignore`

2. **Rotacione secrets regularmente**
   ```bash
   # Gere novos secrets
   openssl rand -hex 32
   ```

3. **Configure CORS adequadamente**
   - Em `backend/src/main.ts`, configure origins permitidas

4. **Ative HTTPS**
   - ✅ Railway fornece SSL/TLS automaticamente

## 🎯 Próximos Passos Pós-Deploy

1. ✅ Testar todos os endpoints críticos
2. ✅ Configurar domínio customizado
3. ✅ Implementar testes E2E contra staging
4. ✅ Configurar monitoring (Sentry, LogRocket)
5. ✅ Documentar API com Swagger
6. ✅ Configurar backups automáticos do PostgreSQL

## 📞 Suporte

- **Railway Docs:** https://docs.railway.app
- **Railway Discord:** https://discord.gg/railway
- **Issues do Projeto:** GitHub Issues

---

**🎉 Parabéns! Seu Elevare SaaS CRM está no ar!**
