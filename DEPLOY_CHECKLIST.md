# 🚀 CHECKLIST DE DEPLOY - ELEVARE

**Versão:** 1.0  
**Data:** 28/11/2025  
**Ambiente:** Produção (Vercel + Supabase)

---

## 📋 PRÉ-REQUISITOS

- [ ] Conta Vercel ativa
- [ ] Projeto Supabase configurado (gpebqonriekmthxxuezf)
- [ ] Repositório GitHub atualizado
- [ ] Credenciais de acesso (API keys, tokens)
- [ ] Domínio customizado (opcional)

---

## 1️⃣ CONFIGURAÇÃO DO SUPABASE

### 1.1 Executar SQL de Setup

```bash
# Acessar SQL Editor
https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/sql/new
```

- [ ] Copiar conteúdo de `supabase-setup.sql`
- [ ] Colar no SQL Editor
- [ ] Executar (Run ou Ctrl+Enter)
- [ ] Verificar resultado: "Success. No rows returned"

### 1.2 Verificar Tabelas

```bash
# Acessar Table Editor
https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/editor
```

- [ ] Tabela `leads` criada
- [ ] Colunas corretas (id, email, name, metadata, etc.)
- [ ] Índices criados (idx_leads_email, idx_leads_created_at, idx_leads_metadata)

### 1.3 Configurar RLS (Row Level Security)

- [ ] RLS habilitado na tabela `leads`
- [ ] Políticas criadas:
  - [ ] "Permitir inserção pública de leads"
  - [ ] "Permitir leitura pública de leads"
  - [ ] "Permitir atualização pública de leads"

### 1.4 Configurar Autenticação

```bash
# Acessar Authentication Settings
https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/auth/users
```

- [ ] Email auth habilitado
- [ ] Confirmação de email configurada (opcional)
- [ ] Redirect URLs configurados:
  - [ ] `http://localhost:5173` (dev)
  - [ ] `https://seu-dominio.com` (prod)

### 1.5 Configurar CORS

```bash
# Acessar API Settings
https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/settings/api
```

- [ ] CORS Allowed Origins:
  - [ ] `http://localhost:5173`
  - [ ] `https://elevare-landing.vercel.app`
  - [ ] `https://seu-dominio.com` (se aplicável)

---

## 2️⃣ CONFIGURAÇÃO DO VERCEL

### 2.1 Criar Projeto no Vercel

```bash
# Via CLI (recomendado)
cd frontend-landing
npx vercel

# Ou via Dashboard
https://vercel.com/new
```

- [ ] Conectar repositório GitHub
- [ ] Selecionar branch `master`
- [ ] Configurar root directory: `frontend-landing`
- [ ] Framework preset: `Vite` (ou `Other`)

### 2.2 Configurar Variáveis de Ambiente

```bash
# Via Vercel Dashboard
https://vercel.com/seu-usuario/elevare-landing/settings/environment-variables
```

Adicionar variáveis:

- [ ] `VITE_SUPABASE_URL` = `https://gpebqonriekmthxxuezf.supabase.co`
- [ ] `VITE_SUPABASE_ANON_KEY` = `***REMOVED***CI6IkpXVCJ9...`
- [ ] `VITE_ENV` = `production`
- [ ] `VITE_APP_URL` = `https://elevare-landing.vercel.app`

**Importante:** Marcar todas como disponíveis para `Production`, `Preview` e `Development`

### 2.3 Configurar Build Settings

- [ ] Build Command: `npm run build`
- [ ] Output Directory: `dist`
- [ ] Install Command: `npm install`
- [ ] Node.js Version: `18.x` ou `20.x`

### 2.4 Configurar Domínio (Opcional)

```bash
# Via Vercel Dashboard
https://vercel.com/seu-usuario/elevare-landing/settings/domains
```

- [ ] Adicionar domínio customizado
- [ ] Configurar DNS (A record ou CNAME)
- [ ] Aguardar propagação (até 48h)
- [ ] Verificar SSL/HTTPS automático

---

## 3️⃣ DEPLOY INICIAL

### 3.1 Preparar Código

```bash
cd /home/ubuntu/Elevare-FullStack/frontend-landing

# Verificar dependências
npm install

# Testar build local
npm run build

# Verificar dist/
ls -lh dist/
```

- [ ] Build executado sem erros
- [ ] Pasta `dist/` criada
- [ ] Arquivos HTML, CSS, JS presentes

### 3.2 Adicionar Scripts ao index.html

Editar `frontend-landing/index.html` e adicionar antes do `</head>`:

```html
<!-- Supabase Integration -->
<script type="module" src="/js/api-supabase.js"></script>
<script type="module" src="/js/auth-supabase.js"></script>
```

- [ ] Scripts adicionados ao `index.html`
- [ ] Commit e push para GitHub

### 3.3 Deploy via Vercel

```bash
# Via CLI
cd frontend-landing
npx vercel --prod

# Ou via GitHub (automático)
git push origin master
```

- [ ] Deploy iniciado
- [ ] Build concluído sem erros
- [ ] URL de produção gerada

### 3.4 Verificar Deploy

```bash
# Acessar URL de produção
https://elevare-landing.vercel.app
```

- [ ] Página carrega corretamente
- [ ] Console sem erros (F12)
- [ ] Mensagem "✅ Supabase API inicializada" no console
- [ ] Mensagem "🔐 Inicializando sistema de autenticação..." no console

---

## 4️⃣ VALIDAÇÃO FUNCIONAL

### 4.1 Testar Captura de Lead

- [ ] Preencher formulário de lead
- [ ] Submeter formulário
- [ ] Verificar no Supabase Table Editor → leads
- [ ] Lead aparece com dados corretos

### 4.2 Testar Registro de Usuário

- [ ] Clicar em "Começar Grátis"
- [ ] Modal de autenticação abre
- [ ] Alternar para "Criar Conta"
- [ ] Preencher dados (nome, email, senha)
- [ ] Submeter formulário
- [ ] Verificar mensagem de sucesso
- [ ] Verificar no Supabase Authentication → Users
- [ ] Usuário aparece na lista

### 4.3 Testar Login

- [ ] Abrir modal de autenticação
- [ ] Alternar para "Entrar"
- [ ] Preencher email e senha
- [ ] Submeter formulário
- [ ] Verificar mensagem de sucesso
- [ ] Verificar redirecionamento (se aplicável)

### 4.4 Testar Responsividade

- [ ] Desktop (1920x1080)
- [ ] Tablet (1024x768)
- [ ] Mobile (375x667)
- [ ] Todos os elementos visíveis e funcionais

### 4.5 Testar Performance

```bash
# Lighthouse via Chrome DevTools
1. Abrir DevTools (F12)
2. Ir para aba "Lighthouse"
3. Selecionar "Performance", "Accessibility", "Best Practices", "SEO"
4. Clicar em "Analyze page load"
```

- [ ] Performance: ≥ 90
- [ ] Accessibility: ≥ 90
- [ ] Best Practices: ≥ 90
- [ ] SEO: ≥ 90

---

## 5️⃣ TESTES AUTOMATIZADOS

### 5.1 Instalar Dependências de Teste

```bash
cd frontend-landing

# Jest
npm install --save-dev jest @testing-library/jest-dom babel-jest @babel/core @babel/preset-env

# Playwright
npm install --save-dev @playwright/test
npx playwright install
```

- [ ] Dependências instaladas sem erros

### 5.2 Executar Testes Unitários

```bash
npm test
```

- [ ] 23 testes executados
- [ ] Todos passando (ou identificar falhas)

### 5.3 Executar Testes E2E

```bash
npm run test:e2e
```

- [ ] 24 testes executados
- [ ] Todos passando (ou identificar falhas)

### 5.4 Gerar Relatório de Cobertura

```bash
npm test -- --coverage
```

- [ ] Relatório gerado
- [ ] Cobertura ≥ 80%

---

## 6️⃣ SEGURANÇA E CONFORMIDADE

### 6.1 Revisar Variáveis de Ambiente

- [ ] `.env` NÃO commitado no Git
- [ ] `.gitignore` inclui `.env`
- [ ] Variáveis sensíveis apenas no Vercel Dashboard

### 6.2 Revisar Políticas RLS

```bash
# Acessar Supabase SQL Editor
https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/sql/new
```

Executar:

```sql
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd
FROM pg_policies
WHERE tablename = 'leads';
```

- [ ] Políticas corretas
- [ ] Apenas operações públicas permitidas (INSERT, SELECT, UPDATE)
- [ ] DELETE bloqueado (se aplicável)

### 6.3 Revisar Headers de Segurança

```bash
# Via Vercel Dashboard
https://vercel.com/seu-usuario/elevare-landing/settings/headers
```

Adicionar headers:

```json
[
  {
    "source": "/(.*)",
    "headers": [
      {
        "key": "X-Content-Type-Options",
        "value": "nosniff"
      },
      {
        "key": "X-Frame-Options",
        "value": "DENY"
      },
      {
        "key": "X-XSS-Protection",
        "value": "1; mode=block"
      },
      {
        "key": "Referrer-Policy",
        "value": "strict-origin-when-cross-origin"
      }
    ]
  }
]
```

- [ ] Headers configurados
- [ ] Deploy realizado para aplicar headers

---

## 7️⃣ MONITORAMENTO E LOGS

### 7.1 Configurar Logs do Vercel

```bash
# Via Vercel Dashboard
https://vercel.com/seu-usuario/elevare-landing/logs
```

- [ ] Logs de runtime habilitados
- [ ] Logs de build habilitados

### 7.2 Configurar Logs do Supabase

```bash
# Via Supabase Dashboard
https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/logs/explorer
```

- [ ] Logs de API habilitados
- [ ] Logs de Auth habilitados
- [ ] Logs de Database habilitados

### 7.3 Configurar Alertas (Opcional)

- [ ] Alertas de erro (Vercel)
- [ ] Alertas de downtime (UptimeRobot, Pingdom)
- [ ] Alertas de uso (Supabase quotas)

---

## 8️⃣ DOCUMENTAÇÃO

### 8.1 Atualizar README.md

- [ ] Instruções de instalação
- [ ] Instruções de deploy
- [ ] Variáveis de ambiente documentadas
- [ ] Comandos de teste documentados

### 8.2 Criar CHANGELOG.md

- [ ] Versão 1.0 documentada
- [ ] Features implementadas listadas
- [ ] Breaking changes (se aplicável)

### 8.3 Criar API_DOCS.md

- [ ] Endpoints documentados
- [ ] Exemplos de request/response
- [ ] Códigos de erro

---

## 9️⃣ COMUNICAÇÃO E HANDOFF

### 9.1 Apresentar Resultados

- [ ] Preparar demo ao vivo
- [ ] Preparar slides/apresentação
- [ ] Agendar reunião com stakeholders

### 9.2 Coletar Feedbacks

- [ ] Criar formulário de feedback
- [ ] Enviar para usuários beta/testadores
- [ ] Documentar sugestões e bugs

### 9.3 Planejar Próximas Sprints

- [ ] Revisar backlog
- [ ] Priorizar features
- [ ] Criar issues no GitHub

---

## 🔟 PÓS-DEPLOY

### 10.1 Monitorar Primeiras 24h

- [ ] Verificar logs a cada 2-4 horas
- [ ] Monitorar erros no console
- [ ] Verificar performance (Lighthouse)

### 10.2 Ajustes Rápidos

- [ ] Corrigir bugs críticos imediatamente
- [ ] Fazer hotfixes se necessário
- [ ] Comunicar mudanças ao time

### 10.3 Documentar Lições Aprendidas

- [ ] O que funcionou bem?
- [ ] O que pode melhorar?
- [ ] Ações para próximo deploy

---

## ✅ CHECKLIST FINAL

- [ ] Supabase configurado (tabelas, RLS, auth, CORS)
- [ ] Vercel configurado (variáveis, build, domínio)
- [ ] Deploy realizado com sucesso
- [ ] Validação funcional completa (leads, registro, login)
- [ ] Testes automatizados executados (47 testes)
- [ ] Segurança revisada (RLS, headers, .env)
- [ ] Monitoramento configurado (logs, alertas)
- [ ] Documentação atualizada (README, CHANGELOG, API_DOCS)
- [ ] Feedbacks coletados
- [ ] Próximas sprints planejadas

**Se todos os itens estão ✅, o deploy está COMPLETO!**

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** ✅ **PRONTO PARA DEPLOY**
