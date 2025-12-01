# 🚀 GUIA FASE 1 - Backend Mínimo + Autenticação

**Status:** ✅ Implementado  
**Data:** 28/11/2025  
**Tempo estimado para setup:** 30 minutos

---

## 📋 O QUE FOI IMPLEMENTADO

### Arquivos Criados

1. ✅ `frontend-landing/.env` - Variáveis de ambiente (com suas credenciais)
2. ✅ `supabase-setup.sql` - Script SQL para criar tabelas
3. ✅ `frontend-landing/js/api-supabase.js` - API Supabase completa
4. ✅ `frontend-landing/js/auth-supabase.js` - Sistema de autenticação

---

## 🎯 PASSO A PASSO PARA ATIVAR

### PASSO 1: Executar SQL no Supabase (5 minutos)

1. **Acessar SQL Editor:**
   ```
   https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/sql/new
   ```

2. **Copiar conteúdo do arquivo:**
   ```bash
   cat supabase-setup.sql
   ```

3. **Colar no SQL Editor e executar** (Run ou Ctrl+Enter)

4. **Verificar resultado:**
   - Deve mostrar: "Success. No rows returned"
   - Ir para Table Editor e verificar tabela `leads`

---

### PASSO 2: Instalar Dependências (2 minutos)

```bash
cd frontend-landing

# Instalar Supabase JS
npm install @supabase/supabase-js

# Verificar instalação
npm list @supabase/supabase-js
```

---

### PASSO 3: Adicionar Scripts ao index.html (2 minutos)

Adicione estas linhas no `<head>` do `index.html`:

```html
<!-- Supabase Integration -->
<script type="module" src="/js/api-supabase.js"></script>
<script type="module" src="/js/auth-supabase.js"></script>
```

**Localização:** Antes do `</head>`

---

### PASSO 4: Testar Localmente (5 minutos)

```bash
cd frontend-landing

# Iniciar servidor de desenvolvimento
npm run dev

# Abrir navegador
# http://localhost:5173
```

**Testes a realizar:**

1. **Abrir Console do Navegador** (F12)
   - Deve ver: "✅ Supabase API inicializada"
   - Deve ver: "🔐 Inicializando sistema de autenticação..."

2. **Clicar em "Começar Grátis"**
   - Modal de autenticação deve abrir

3. **Criar conta de teste:**
   - Nome: Seu Nome
   - Email: teste+1@elevare.com
   - Senha: teste123

4. **Verificar no Console:**
   - Deve ver: "✅ Registro bem-sucedido"
   - Deve ver: "✅ Lead criado com sucesso"

5. **Verificar no Supabase:**
   - Ir para: Authentication → Users
   - Deve ver o usuário criado
   - Ir para: Table Editor → leads
   - Deve ver o lead criado

---

## 🧪 TESTES DE VALIDAÇÃO

### Teste 1: Captura de Lead via API

```bash
curl -X POST https://gpebqonriekmthxxuezf.supabase.co/rest/v1/leads \
  -H "apikey: ***REMOVED***CI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdwZWJxb25yaWVrbXRoeHh1ZXpmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzNTM4MjAsImV4cCI6MjA3OTkyOTgyMH0.bBTl-Zs55_4S-lXVXo2mirhSs05z789L5tkZoiFnmBE" \
  -H "Content-Type: application/json" \
  -H "Prefer: return=representation" \
  -d '{
    "email": "teste-api@elevare.com",
    "name": "Teste API",
    "metadata": {"score": 75, "source": "api_test"}
  }'
```

**Resposta esperada:**
```json
[
  {
    "id": "uuid-aqui",
    "email": "teste-api@elevare.com",
    "name": "Teste API",
    "metadata": {"score": 75, "source": "api_test"},
    "created_at": "2025-11-28T..."
  }
]
```

---

### Teste 2: Registro de Usuário via API

```bash
curl -X POST https://gpebqonriekmthxxuezf.supabase.co/auth/v1/signup \
  -H "apikey: ***REMOVED***CI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdwZWJxb25yaWVrbXRoeHh1ZXpmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzNTM4MjAsImV4cCI6MjA3OTkyOTgyMH0.bBTl-Zs55_4S-lXVXo2mirhSs05z789L5tkZoiFnmBE" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "teste-auth@elevare.com",
    "password": "senha123",
    "data": {"name": "Teste Auth"}
  }'
```

**Resposta esperada:**
```json
{
  "access_token": "eyJhbGci...",
  "user": {
    "id": "uuid-aqui",
    "email": "teste-auth@elevare.com",
    ...
  }
}
```

---

## ✅ CHECKLIST DE VALIDAÇÃO

- [ ] SQL executado no Supabase sem erros
- [ ] Tabela `leads` criada com sucesso
- [ ] Dependências instaladas (`@supabase/supabase-js`)
- [ ] Scripts adicionados ao `index.html`
- [ ] Servidor de desenvolvimento rodando
- [ ] Console mostra "✅ Supabase API inicializada"
- [ ] Modal de autenticação abre corretamente
- [ ] Registro de usuário funciona
- [ ] Lead é criado automaticamente no registro
- [ ] Usuário aparece em Authentication → Users
- [ ] Lead aparece em Table Editor → leads
- [ ] Teste de API (curl) retorna 201 Created

**Se todos os itens estão ✅, a Fase 1 está completa!**

---

## 🐛 TROUBLESHOOTING

### Erro: "Credenciais Supabase não encontradas"

**Causa:** Arquivo `.env` não foi carregado

**Solução:**
1. Verificar se `.env` existe em `frontend-landing/`
2. Reiniciar servidor de desenvolvimento (`npm run dev`)
3. Verificar se Vite está configurado para carregar `.env`

---

### Erro: "relation 'leads' does not exist"

**Causa:** Tabela não foi criada no Supabase

**Solução:**
1. Ir para SQL Editor
2. Executar `supabase-setup.sql` novamente
3. Verificar em Table Editor se tabela aparece

---

### Erro: "Invalid API key"

**Causa:** Chave API incorreta no `.env`

**Solução:**
1. Ir para: Settings → API
2. Copiar chave `anon public` novamente
3. Atualizar `.env`
4. Reiniciar servidor

---

### Erro: "CORS policy"

**Causa:** Configuração de CORS no Supabase

**Solução:**
1. Ir para: Settings → API
2. Verificar "CORS Allowed Origins"
3. Adicionar `http://localhost:5173`

---

### Modal não abre

**Causa:** Scripts não foram carregados

**Solução:**
1. Verificar se scripts estão no `<head>` do `index.html`
2. Abrir Console (F12) e verificar erros
3. Verificar se arquivos existem em `js/`

---

## 📊 MÉTRICAS DE SUCESSO

**Após Fase 1 completa, você terá:**

- ✅ Backend serverless funcionando (Supabase)
- ✅ Autenticação completa (registro + login)
- ✅ Captura de leads automática
- ✅ Dados persistidos no PostgreSQL
- ✅ RLS (Row Level Security) configurado
- ✅ API REST pronta para uso

---

## 🎯 PRÓXIMOS PASSOS

### Imediato (Hoje)

1. Executar todos os testes de validação
2. Criar 3 contas de teste consecutivas
3. Verificar dados no Supabase Dashboard

### Amanhã (Fase 2)

4. Instalar Jest e Playwright
5. Executar suite de testes
6. Atingir 90% de coverage

### Fim de Semana (Fase 3)

7. Implementar Dashboard MVP
8. Proteger rotas com JWT
9. Mostrar dados do usuário logado

---

## 📚 DOCUMENTAÇÃO ADICIONAL

**API Supabase:**
- `window.elevareAPI.createLead(email, name, metadata)` - Cria lead
- `window.elevareAPI.register(email, password, name)` - Registra usuário
- `window.elevareAPI.login(email, password)` - Faz login
- `window.elevareAPI.getUser()` - Retorna usuário autenticado
- `window.elevareAPI.logout()` - Faz logout

**Auth Supabase:**
- `window.elevareAuth.open()` - Abre modal de autenticação
- `window.elevareAuth.close()` - Fecha modal
- `window.elevareAuth.logout()` - Faz logout
- `window.elevareAuth.isAuthenticated()` - Verifica se está autenticado

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** ✅ **FASE 1 IMPLEMENTADA - PRONTA PARA TESTE**
