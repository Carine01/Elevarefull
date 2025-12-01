# 🚀 QUICK START - Elevare SaaS CRM

## 🎯 PRIORIDADES ESTRATÉGICAS

**Objetivo:** URL pública funcionando HOJE + validar fluxos de pagamento/agendamento esta semana.

---

## 🔥 CRÍTICO - FAÇA AGORA (próximas 4 horas)

### 1. Deploy funcional no Railway

```bash
# Na raiz do projeto
git add .
git commit -m "chore: configuração Docker para deploy Railway"
git push origin master
```

Depois:
1. Acesse [railway.app](https://railway.app)
2. Login com GitHub
3. **"+ New Project"** → **"Deploy from GitHub repo"**
4. Selecione **"Elevare-FullStack"**

### 2. Variáveis de ambiente de produção

```bash
# Gere os secrets agora no terminal
openssl rand -hex 32  # JWT_SECRET
openssl rand -hex 32  # JWT_REFRESH_SECRET
```

No Railway, adicione em **"Variables"**:

| Key | Value |
|-----|-------|
| `JWT_SECRET` | [cole o primeiro resultado] |
| `JWT_REFRESH_SECRET` | [cole o segundo resultado] |
| `NODE_ENV` | `production` |
| `PORT` | `3000` |
| `TZ` | `America/Sao_Paulo` |

**Conectar PostgreSQL:**
1. Clique em **"+ New"** → **Database** → **PostgreSQL**
2. Railway criará e injetará `DATABASE_URL` automaticamente

### 3. Teste manual dos 3 endpoints core

```bash
# Substitua $RAILWAY_URL pela URL gerada pelo Railway

# 1. Health check
curl $RAILWAY_URL/health

# 2. Criar lead (teste de conversão)
curl -X POST $RAILWAY_URL/leads \
  -H "Content-Type: application/json" \
  -d '{"name":"Teste","email":"test@clinica.com","phone":"11999999999"}'

# 3. Webhook Iara (simulação)
curl -X POST $RAILWAY_URL/webhooks/iara \
  -H "x-api-key: ${IARA_API_KEY}" \
  -d '{"event":"message.received"}'
```

✅ **Sucesso = 200 OK em todos**

---

## ⚡ ALTA - ESTA SEMANA (até sexta-feira)

### 4. Proteger dados (backup manual)

Railway faz snapshots automáticos a cada 24h. Hoje, faça dump manual:

```bash
# Instale Railway CLI
npm install -g @railway/cli

# Login
railway login

# Conecte ao projeto
railway link

# Backup manual
railway run pg_dump $DATABASE_URL > backup_$(date +%Y%m%d).sql
```

### 5. Frontend funcional

Deploy frontend no Vercel (grátis, 2 min):

```bash
cd frontend
npm install -g vercel
vercel --prod
```

Configure variável de ambiente:
- `VITE_API_URL` = sua URL do Railway

### 6. 3 testes E2E mínimos

Crie `backend/test/e2e/critical-flows.spec.ts`:

```typescript
describe('Fluxos Críticos', () => {
  test('Deve criar lead via API pública', async () => {
    const response = await request(app.getHttpServer())
      .post('/leads')
      .send({
        name: 'Teste E2E',
        email: 'teste@clinica.com',
        phone: '11999999999'
      });
    expect(response.status).toBe(201);
  });
  
  test('Deve autenticar usuário', async () => {
    const response = await request(app.getHttpServer())
      .post('/auth/login')
      .send({
        email: 'admin@elevare.com',
        password: 'admin123'
      });
    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty('access_token');
  });
  
  test('Deve agendar consulta', async () => {
    const response = await request(app.getHttpServer())
      .post('/agendamentos')
      .set('Authorization', `Bearer ${token}`)
      .send({
        professionalId: 1,
        clientId: 1,
        startTime: '2024-12-01T10:00:00Z',
        endTime: '2024-12-01T11:00:00Z'
      });
    expect(response.status).toBe(201);
  });
});
```

Rode:
```bash
npm run test:e2e
```

---

## 🛡️ MÉDIA - PRÓXIMA SEMANA

### 7. Monitoring mínimo

Add Sentry (grátis, 5 min):

```bash
npm install @sentry/nestjs
```

No `main.ts`:
```typescript
import * as Sentry from '@sentry/nestjs';

Sentry.init({ 
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV 
});
```

### 8. Rate limiting

Proteja `/webhooks` e `/leads` contra spam:

```typescript
// Em main.ts
import rateLimit from 'express-rate-limit';

app.use(
  rateLimit({
    windowMs: 60 * 1000, // 1 minuto
    max: 100, // 100 requisições
  })
);
```

### 9. Migrations automatizadas

✅ **Já configurado no `railway.json`!**

---

## 📊 BAIXA - DEPOIS DO PRIMEIRO CLIENTE

10. Testes E2E completos
11. CI/CD otimizado
12. Autoscaling
13. LGPD automática
14. Dashboard Analytics

---

## 🎬 PLANO DE AÇÃO DIÁRIO

### HOJE (4 horas):
- [ ] Deploy Railway ✓
- [ ] Testar 3 endpoints ✓
- [ ] Backup manual ✓

### AMANHÃ (2 horas):
- [ ] Deploy frontend Vercel
- [ ] Integração URL → Railway
- [ ] Teste E2E #1

### SEXTA (2 horas):
- [ ] 2 testes E2E restantes
- [ ] Sentry configurado
- [ ] Rate limiting

**🎉 Pronto para vender na segunda-feira!**

---

## 📞 Suporte

- **Railway Docs:** https://docs.railway.app
- **Prisma Docs:** https://www.prisma.io/docs
- **NestJS Docs:** https://docs.nestjs.com

**Dúvidas? Consulte `DEPLOY_RAILWAY.md` para guia detalhado.**
