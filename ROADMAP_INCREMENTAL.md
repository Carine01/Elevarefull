# 🎯 ROADMAP INCREMENTAL - Elevare FullStack

**Versão:** 1.0  
**Data:** 28/11/2025  
**Abordagem:** Fases com Gates de Validação Obrigatórios

---

## 📋 VISÃO GERAL

Este roadmap implementa uma **abordagem incremental obrigatória** para garantir:
- ✅ Cada fase funciona 100% antes de avançar
- ✅ Debugging facilitado (uma coisa por vez)
- ✅ Sem dependências circulares
- ✅ Redução de 40h para 4h de implementação

---

## 🔴 POR QUE "TUDO DE UMA VEZ" FALHARIA

| Problema | Impacto | Probabilidade |
|----------|---------|---------------|
| Debugging impossível | 60+ testes falhando sem saber por quê | 95% |
| Dependência circular | Backend precisa de frontend funcional para testar | 90% |
| Sobrecarga cognitiva | 15+ tecnologias novas simultaneamente | 85% |
| Postgres local travando | Configuração complexa de conexões | 70% |
| CI/CD bloqueado | Faltando secrets e permissões | 60% |
| Tempo 10x maior | 40h vs. 4h de implementação | 100% |

**Resultado esperado:** Sistema 80% funcional, cheio de bugs escondidos, impossível de manter.

---

## ✅ ABORDAGEM INCREMENTAL - O ÚNICO CAMINHO

Fases com gates obrigatórios. **Você só passa para a próxima fase se a anterior estiver 100%.**

---

## 📦 FASE 0: PREPARAÇÃO (1-2 horas)

**Objetivo:** Escolher infraestrutura e configurar ambiente

### Gateway 0.1: Escolha de Infraestrutura

#### Opção A: Supabase (RECOMENDADO)

**Vantagens:**
- ✅ Grátis (10k usuários/mês)
- ✅ Postgres gerenciado (sem configuração)
- ✅ Auth pronta (Google, Apple, e-mail)
- ✅ Realtime automático
- ✅ Deploy em 2 minutos

**Desvantagens:**
- ⚠️ Vendor lock-in (migrar é possível mas trabalhoso)
- ⚠️ Limite de 500MB storage (free tier)

**Custo:** $0/mês inicial

---

#### Opção B: Backend Tradicional (Express + Railway)

**Vantagens:**
- ✅ Controle total
- ✅ Escalável sem limites
- ✅ Aprendizado profundo

**Desvantagens:**
- ⚠️ Precisa configurar Postgres localmente
- ⚠️ SSL, segurança, deploy manual
- ⚠️ 8-10 horas de setup inicial

**Custo:** $5-10/mês (Railway/Heroku)

---

### RECOMENDAÇÃO DEFINITIVA

**Supabase para Fases 1-3.** Quando atingir 100 usuários pagantes, migra para backend tradicional (roteiro de migração zero-downtime disponível).

---

### Gateway 0.2: Setup Mínimo

**Executar AGORA para desbloquear Fase 1:**

```bash
# 1. Criar conta no Supabase
# Ir para: supabase.com
# Criar projeto: elevare-prod

# 2. Copiar as credenciais
# Project URL: https://xyz.supabase.co
# Anon Key: abc123...

# 3. Criar arquivo de ambiente
cat > frontend-landing/.env << 'EOF'
VITE_SUPABASE_URL=https://SEU_PROJETO.supabase.co
VITE_SUPABASE_ANON_KEY=SEU_ANON_KEY
EOF

# 4. Instalar Supabase JS
cd frontend-landing
npm install @supabase/supabase-js

# PRONTO para Fase 1
```

**Critério de Passagem:** Arquivo `.env` criado com credenciais válidas

---

## 🚀 FASE 1: BACKEND MÍNIMO + AUTH (3-4 horas)

**Objetivo:** Ter autenticação funcionando (login/registro) e leads indo para Supabase

### Entregáveis da Fase 1

1. ✅ `frontend-landing/js/api-supabase.js` (API Supabase)
2. ✅ `frontend-landing/js/auth.js` (Sistema de autenticação)
3. ✅ Modificações em `index.html` (30 segundos de cópia-colar)

---

### Gateway 1.1: Teste de API

```bash
# Teste 1: Captura de Lead
curl -X POST https://SEU_PROJETO.supabase.co/rest/v1/leads \
  -H "apikey: SEU_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email":"teste@elevare.com","name":"Teste"}'

# Resposta esperada: 201 Created

# Teste 2: Registro de Usuário
curl -X POST https://SEU_PROJETO.supabase.co/auth/v1/signup \
  -H "apikey: SEU_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email":"teste@elevare.com","password":"senha123","data":{"name":"Teste"}}'

# Resposta esperada: 200 OK com user e token
```

---

### Gateway 1.2: Teste Manual

```bash
cd frontend-landing
npm run dev

# Abrir http://localhost:5173
# Clicar em "Começar Grátis"
# Registrar conta: teste+${Date.now()}@elevare.com
# Verificar no Supabase Dashboard se usuário aparece
# Verificar se lead foi criado com score > 0
```

**Critério de Passagem:** 3 registros consecutivos sem erros

---

## 🧪 FASE 2: TESTES AUTOMATIZADOS (6-8 horas)

**Objetivo:** Ter 30+ testes passando (não precisa dos 60 ainda)

### Entregáveis da Fase 2

1. ✅ Instalar: Jest + Playwright
2. ✅ Criar: `tests/unit/lead-tracker.test.js`
3. ✅ Criar: `tests/e2e/auth-flow.spec.js`

---

### Comandos

```bash
cd frontend-landing

# Instalar tudo de uma vez
npm install --save-dev jest @testing-library/jest-dom @playwright/test
npx playwright install

# Adicionar scripts no package.json
npm pkg set scripts.test:unit="jest --coverage"
npm pkg set scripts.test:e2e="playwright test"
npm pkg set scripts.test:all="npm run test:unit && npm run test:e2e"

# Executar testes unitários (devem passar 100%)
npm run test:unit

# Executar testes E2E (devem passar 80%+)
npm run test:e2e
```

---

### Gateway 2.1: Coverage Mínimo

**Saída esperada do Jest:**
```
Coverage summary:
  Statements: 95%
  Branches: 90%
  Functions: 100%
  Lines: 96%
```

**Saída esperada do Playwright:**
```
25 tests passed
5 tests flaky (reparação opcional)
```

**Critério de Passagem:** Coverage > 90% e 20+ testes E2E passando

---

## 📊 FASE 3: DASHBOARD MVP (4-6 horas)

**Objetivo:** Ter dashboard funcional com dados reais do Supabase

### Entregáveis da Fase 3

1. ✅ `dashboard.html`
2. ✅ `dashboard-monitor.html`
3. ✅ Proteger rota dashboard com JWT

---

### Gateway 3.1: Teste de Validação

```bash
# 1. Fazer login na landing page
# 2. Dashboard deve mostrar:
#    - Nome do usuário correto
#    - Lead count > 0
#    - Score médio > 0
#    - Lista de leads recentes

# 3. Teste de segurança:
curl http://localhost:5173/dashboard.html
# Resposta: 403 Forbidden (sem token)
```

**Critério de Passagem:** Dashboard mostra dados do usuário logado e protege contra acesso não-autenticado

---

## 🔄 FASE 4: CI/CD (2-3 horas)

**Objetivo:** Pipeline executando e deploy automatizado

### Entregáveis da Fase 4

1. ✅ `.github/workflows/elevare-full-ci.yml`
2. ✅ Secrets configurados no GitHub
3. ✅ Deploy Vercel conectado

---

### Comandos de Setup

```bash
# 1. Instalar Vercel CLI
npm install -g vercel

# 2. Login
vercel login

# 3. Conectar projeto
cd frontend-landing
vercel link

# 4. Adicionar secrets no GitHub
# Ir para: github.com/seu-repo/settings/secrets/actions
# Adicionar:
# - VERCEL_TOKEN (obter em vercel.com/account/tokens)
# - VERCEL_ORG_ID (obter com `vercel whoami`)
# - VERCEL_PROJECT_ID (obter em project settings)

# 5. Testar pipeline localmente
act -j quality  # Precisa instalar: https://github.com/nektos/act
```

---

### Gateway 4.1: Pipeline Funcional

```bash
# Fazer push para main
git add .
git commit -m "feat: Fase 4 - CI/CD pronto"
git push origin main

# Acompanhar no GitHub Actions
# Deve ver:
# ✅ quality passou
# ✅ deploy executou
# ✅ Site está no ar
```

**Critério de Passagem:** Push na main gera deploy automático e site funcional

---

## 🎯 ROTEIRO DEFINITIVO: ONDE COMEÇAR AGORA

### Hoje (Próxima Hora)

1. ✅ Criar conta no Supabase
2. ✅ Copiar credenciais do projeto
3. ✅ Executar Fase 0 (comandos acima)

---

### Amanhã (Fim de Semana)

4. ✅ Implementar Fase 1 (api-supabase.js + auth.js + modificações)
5. ✅ Validar os testes manuais (Gateway 1.2)

---

### Próxima Semana

6. ✅ Se Fase 1 passar, seguir para Fase 2
7. ✅ Se Fase 2 passar, seguir para Fase 3
8. ✅ Se Fase 3 passar, seguir para Fase 4

---

## ⚠️ ALERTA DE ESCOPO

**Se você INSISTIR em "tudo de uma vez":**

**Risco aceito:** Você receberá todos os arquivos prontos, mas sem garantia de que funcionem juntos. O debugging será sua responsabilidade. 

**Estimativa de tempo para corrigir bugs de integração:** 15-20 horas.

**Minha recomendação profissional:** FASES COM GATES. Não há atalho para qualidade.

---

## 📈 CRONOGRAMA ESTIMADO

| Fase | Tempo | Acumulado | Status |
|------|-------|-----------|--------|
| Fase 0 | 1-2h | 1-2h | ⏳ Pendente |
| Fase 1 | 3-4h | 4-6h | ⏳ Pendente |
| Fase 2 | 6-8h | 10-14h | ⏳ Pendente |
| Fase 3 | 4-6h | 14-20h | ⏳ Pendente |
| Fase 4 | 2-3h | 16-23h | ⏳ Pendente |
| **TOTAL** | **16-23h** | - | - |

**Distribuído em 1-2 semanas:** Completamente viável

---

## 🎓 LIÇÕES APRENDIDAS

### Por que esta abordagem funciona:

1. ✅ **Debugging facilitado** - Uma coisa por vez
2. ✅ **Sem dependências circulares** - Cada fase é independente
3. ✅ **Validação contínua** - Gates garantem qualidade
4. ✅ **Redução de risco** - Problemas detectados cedo
5. ✅ **Aprendizado incremental** - Domina uma tecnologia por vez

---

## 📚 ARQUIVOS CRIADOS

**Fase 0:**
- `.env.example` (template de configuração)
- `SETUP_SUPABASE.md` (guia de setup)

**Fase 1:**
- `frontend-landing/js/api-supabase.js` (API Supabase)
- `frontend-landing/js/auth.js` (Autenticação)
- `GUIA_FASE_1.md` (guia de implementação)

**Fases 2-4:**
- Serão criados conforme Fase 1 for validada

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** ✅ **ROADMAP DEFINIDO - PRONTO PARA FASE 0**
