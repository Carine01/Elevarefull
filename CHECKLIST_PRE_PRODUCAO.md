# ✅ CHECKLIST PRÉ-PRODUÇÃO - ELEVARE

**Data de criação:** 28/11/2025  
**Tempo estimado:** 2-4 horas  
**Responsável:** Programador

---

## 📋 INSTRUÇÕES

Este checklist deve ser executado **na ordem** antes do deploy em produção.

**Legenda:**
- ✅ Concluído
- ⚠️ Pendente
- ❌ Bloqueador (não pode prosseguir sem resolver)

---

## FASE 1: CONFIGURAÇÃO INICIAL (30 minutos)

### 1.1 Clonar Repositório

```bash
# Clone o repositório
git clone https://github.com/iaraelevare-source/Elevare-FullStack.git
cd Elevare-FullStack

# Verifique a branch
git branch
# Deve estar em: master

# Verifique último commit
git log --oneline -1
# Deve ser: 373f668 ou mais recente
```

**Status:** [ ] ✅ Concluído

---

### 1.2 Configurar Variáveis de Ambiente (Backend)

```bash
cd backend
cp .env.example .env
```

**Edite `.env` com suas credenciais:**

```env
# OBRIGATÓRIOS (❌ Bloqueadores)
DATABASE_URL="postgresql://user:pass@host:5432/elevare_db"
JWT_SECRET="min_32_caracteres_aleatorios_aqui"
SUPABASE_URL="https://seu-projeto.supabase.co"
SUPABASE_ANON_KEY="***REMOVED***CI6IkpXVCJ9..."

# OPCIONAIS (⚠️ Recomendados)
WHATSAPP_MODE="link"  # ou "api" se tiver token
RATE_LIMIT_ENABLED="true"
RATE_LIMIT_MAX_REQUESTS=100
PORT=3000
NODE_ENV="production"
```

**Validação:**

```bash
# Teste se .env está correto
node -e "require('dotenv').config(); console.log('DATABASE_URL:', process.env.DATABASE_URL ? '✅ OK' : '❌ FALTANDO')"
```

**Status:** [ ] ✅ Concluído

---

### 1.3 Instalar Dependências

```bash
# Backend
cd backend
npm install

# Frontend
cd ../frontend-landing
npm install

# Raiz (se houver)
cd ..
npm install
```

**Validação:**

```bash
# Verificar se node_modules foi criado
ls -la backend/node_modules | head -5
ls -la frontend-landing/node_modules | head -5
```

**Status:** [ ] ✅ Concluído

---

## FASE 2: BANCO DE DADOS (15 minutos)

### 2.1 Executar Schema SQL

**Opção A: PostgreSQL Local**

```bash
psql -h localhost -U seu_usuario -d elevare_db < backend/prisma/schema.sql
```

**Opção B: Supabase**

1. Acesse: https://supabase.com/dashboard
2. Selecione seu projeto
3. Vá em **SQL Editor**
4. Cole o conteúdo de `backend/prisma/schema.sql`
5. Clique em **Run**

**Validação:**

```bash
# Verificar tabelas criadas
psql -h localhost -U seu_usuario -d elevare_db -c "\dt"

# Deve listar:
# - leads
# - lead_interactions
# - lead_scores
# - gamification_achievements
# - analytics_events
```

**Status:** [ ] ✅ Concluído

---

### 2.2 Verificar Triggers e Functions

```bash
# Verificar triggers
psql -h localhost -U seu_usuario -d elevare_db -c "SELECT tgname FROM pg_trigger WHERE tgname LIKE 'update_%';"

# Deve listar:
# - update_lead_score
# - update_updated_at
```

**Status:** [ ] ✅ Concluído

---

## FASE 3: AJUSTES DE CÓDIGO (30 minutos)

### 3.1 Ajustar Formato JWT

**Verifique seu JWT atual:**

```bash
# Decodifique um token seu
node -e "const jwt = require('jsonwebtoken'); const decoded = jwt.decode('SEU_TOKEN_AQUI'); console.log(JSON.stringify(decoded, null, 2));"
```

**Exemplo de saída:**

```json
{
  "sub": "user_123",
  "tenant": "clinic_456",  // ← Verifique este campo
  "permissions": ["read", "write"],
  "iat": 1234567890,
  "exp": 1234567890
}
```

**Se seu JWT usar `tenantId` ao invés de `tenant`:**

O código já está preparado! Suporta:
- `decoded.tenant`
- `decoded.tenantId`
- `decoded.sub.tenant`
- `decoded.clinic_id`

**Não precisa alterar nada!**

**Status:** [ ] ✅ Concluído

---

### 3.2 Configurar Rate Limiting

**Se seu SaaS já tem rate limit:**

```env
# No .env, desabilite o rate limit do backend:
RATE_LIMIT_ENABLED="false"
```

**Se quiser ajustar limites:**

```env
RATE_LIMIT_MAX_REQUESTS=200  # Aumentar para 200 req/15min
RATE_LIMIT_WINDOW_MS=600000  # Reduzir janela para 10min
```

**Status:** [ ] ✅ Concluído

---

### 3.3 Escolher Modo WhatsApp

**Modo Link (Gratuito, Manual):**

```env
WHATSAPP_MODE="link"
```

**Modo API (Pago, Automático):**

```env
WHATSAPP_MODE="api"
WHATSAPP_API_TOKEN="seu_token_aqui"
WHATSAPP_PHONE_NUMBER_ID="seu_phone_id"
WHATSAPP_BUSINESS_ACCOUNT_ID="seu_account_id"
```

**Modo Auto (Gratuito, Semi-Automático):**

```env
WHATSAPP_MODE="auto"
```

**Status:** [ ] ✅ Concluído

---

## FASE 4: TESTES LOCAIS (30 minutos)

### 4.1 Iniciar Backend

```bash
cd backend
npm run dev

# Deve exibir:
# ✅ Servidor rodando na porta 3000
# ✅ Banco de dados conectado
```

**Validação:**

```bash
# Teste endpoint de health
curl http://localhost:3000/health

# Deve retornar:
# {"status":"ok","timestamp":"2025-11-28T23:00:00Z"}
```

**Status:** [ ] ✅ Concluído

---

### 4.2 Testar Endpoint de Leads

**Criar token JWT de teste:**

```bash
node -e "const jwt = require('jsonwebtoken'); const token = jwt.sign({ sub: 'user_test', tenant: 'clinic_test' }, process.env.JWT_SECRET || 'test_secret'); console.log(token);"
```

**Testar criação de lead:**

```bash
curl -X POST http://localhost:3000/api/v1/leads \
  -H "Authorization: Bearer SEU_TOKEN_AQUI" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Teste Silva",
    "phone": "5511999999999",
    "email": "teste@example.com",
    "source": "landing_page"
  }'

# Deve retornar:
# {"id":"uuid","name":"Teste Silva","status":"novo","score":50}
```

**Status:** [ ] ✅ Concluído

---

### 4.3 Testar WhatsApp

**Modo Link:**

```bash
curl -X POST http://localhost:3000/api/v1/whatsapp/send \
  -H "Authorization: Bearer SEU_TOKEN_AQUI" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "5511999999999",
    "message": "Teste de mensagem"
  }'

# Deve retornar:
# {"success":true,"link":"https://wa.me/5511999999999?text=..."}
```

**Abra o link no navegador e envie manualmente.**

**Status:** [ ] ✅ Concluído

---

### 4.4 Testar Frontend

```bash
cd frontend-landing

# Servir arquivos estáticos
npx http-server -p 8080 -c-1

# Acesse:
# http://localhost:8080/index.html (landing atual)
# http://localhost:8080/templates/landing-alt.html (landing profissional)
# http://localhost:8080/templates/dashboard.html (dashboard)
# http://localhost:8080/templates/form-test.html (formulário)
```

**Validação:**

1. Abra cada página
2. Verifique se carrega sem erros
3. Preencha formulário de teste
4. Verifique se mensagem de sucesso aparece

**Status:** [ ] ✅ Concluído

---

## FASE 5: DEPLOY (1 hora)

### 5.1 Configurar Secrets no GitHub

1. Acesse: https://github.com/iaraelevare-source/Elevare-FullStack/settings/secrets/actions
2. Adicione secrets:

| Nome | Valor |
|------|-------|
| `DATABASE_URL` | Sua URL do PostgreSQL |
| `JWT_SECRET` | Seu secret JWT |
| `VERCEL_TOKEN` | Token do Vercel |
| `VERCEL_ORG_ID` | ID da org no Vercel |
| `VERCEL_PROJECT_ID` | ID do projeto no Vercel |

**Status:** [ ] ✅ Concluído

---

### 5.2 Adicionar Workflows ao GitHub

```bash
# Os workflows já estão em .github/workflows/
# Apenas commite:
git add .github/workflows/
git commit -m "ci: adiciona workflows de CI/CD"
git push origin master
```

**Validação:**

1. Acesse: https://github.com/iaraelevare-source/Elevare-FullStack/actions
2. Verifique se workflow "CI/CD Pipeline" aparece
3. Aguarde execução (5-10 minutos)
4. Verifique se todos os jobs passaram ✅

**Status:** [ ] ✅ Concluído

---

### 5.3 Deploy Frontend no Vercel

```bash
cd frontend-landing

# Login no Vercel
vercel login

# Deploy
vercel --prod

# Anote a URL de produção
```

**Validação:**

1. Acesse a URL fornecida
2. Verifique se landing page carrega
3. Teste formulário
4. Verifique se leads são capturados

**Status:** [ ] ✅ Concluído

---

### 5.4 Deploy Backend (Railway/Heroku)

**Opção A: Railway**

```bash
# Instalar Railway CLI
npm i -g @railway/cli

# Login
railway login

# Deploy
cd backend
railway up
```

**Opção B: Heroku**

```bash
# Login
heroku login

# Criar app
heroku create elevare-backend

# Deploy
git push heroku master
```

**Validação:**

```bash
# Teste endpoint de produção
curl https://sua-url-backend.com/health
```

**Status:** [ ] ✅ Concluído

---

## FASE 6: VALIDAÇÃO E2E (30 minutos)

### 6.1 Fluxo Completo

1. **Acesse landing page em produção**
2. **Preencha formulário com dados reais**
3. **Clique em "Enviar"**
4. **Verifique se lead aparece no banco:**

```bash
psql -h seu_host -U seu_user -d elevare_db -c "SELECT * FROM leads ORDER BY created_at DESC LIMIT 1;"
```

5. **Verifique se mensagem WhatsApp foi gerada**
6. **Envie mensagem manualmente (se modo link)**
7. **Acesse dashboard e verifique métricas**

**Status:** [ ] ✅ Concluído

---

### 6.2 Performance Test

```bash
# Instalar Apache Bench
sudo apt-get install apache2-utils

# Teste de carga (100 requisições)
ab -n 100 -c 10 -H "Authorization: Bearer SEU_TOKEN" https://sua-url-backend.com/api/v1/leads

# Verifique:
# - Requests per second > 50
# - Time per request < 200ms
# - Failed requests = 0
```

**Status:** [ ] ✅ Concluído

---

### 6.3 Monitoramento

**Configurar Sentry (Opcional):**

```bash
# Instalar Sentry
npm install @sentry/node

# Adicionar ao .env
SENTRY_DSN="https://seu_dsn@sentry.io/projeto"
```

**Configurar Logs:**

```bash
# Verificar logs em produção
railway logs  # ou heroku logs --tail
```

**Status:** [ ] ✅ Concluído

---

## FASE 7: DOCUMENTAÇÃO (15 minutos)

### 7.1 Atualizar README

```bash
# Edite README.md com:
# - URL de produção
# - Credenciais de acesso (se aplicável)
# - Status de deploy
```

**Status:** [ ] ✅ Concluído

---

### 7.2 Criar Runbook

Documente:
- URLs de produção
- Comandos de rollback
- Contatos de emergência
- Procedimentos de backup

**Status:** [ ] ✅ Concluído

---

## ✅ CHECKLIST FINAL

Antes de marcar como CONCLUÍDO, verifique:

- [ ] ✅ Backend rodando em produção
- [ ] ✅ Frontend deployado no Vercel
- [ ] ✅ Banco de dados configurado
- [ ] ✅ Leads sendo capturados
- [ ] ✅ WhatsApp funcionando (link ou API)
- [ ] ✅ Workflows do GitHub ativos
- [ ] ✅ Secrets configurados
- [ ] ✅ Testes E2E passando
- [ ] ✅ Performance > 50 req/s
- [ ] ✅ Monitoramento ativo
- [ ] ✅ Documentação atualizada

---

## 🎉 PRODUÇÃO APROVADA

**Data de conclusão:** __/__/____  
**Responsável:** ________________  
**URL de produção:** ________________

**Assinatura:** ________________

---

## 📞 SUPORTE

Se encontrar problemas:

1. Consulte [INDICE_DOCUMENTACAO.md](INDICE_DOCUMENTACAO.md)
2. Veja [backend/README.md](backend/README.md#troubleshooting)
3. Consulte [HANDOFF_PROGRAMADOR.md](HANDOFF_PROGRAMADOR.md)
4. Abra issue no GitHub

---

**Criado por:** Manus AI  
**Versão:** 1.0  
**Data:** 28/11/2025 23:45 GMT-3
