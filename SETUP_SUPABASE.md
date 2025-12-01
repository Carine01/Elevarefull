# 🚀 SETUP SUPABASE - Guia Completo

**Tempo estimado:** 10-15 minutos  
**Custo:** $0/mês (Free Tier)

---

## 📋 PRÉ-REQUISITOS

- [ ] Conta no GitHub (para login no Supabase)
- [ ] Node.js instalado (v18+)
- [ ] npm ou yarn

---

## 🎯 PASSO 1: CRIAR CONTA NO SUPABASE

### 1.1. Acessar Supabase

```
https://supabase.com
```

### 1.2. Fazer Login

- Clicar em "Start your project"
- Fazer login com GitHub

---

## 🏗️ PASSO 2: CRIAR PROJETO

### 2.1. Criar Novo Projeto

- Clicar em "New Project"
- Preencher:
  - **Name:** `elevare-prod`
  - **Database Password:** Gerar senha forte (salvar!)
  - **Region:** South America (São Paulo) - para menor latência
  - **Pricing Plan:** Free

- Clicar em "Create new project"

**Aguardar:** 2-3 minutos para provisionamento

---

## 🔑 PASSO 3: OBTER CREDENCIAIS

### 3.1. Acessar Settings

- No menu lateral, clicar em ⚙️ **Settings**
- Clicar em **API**

### 3.2. Copiar Credenciais

Você verá duas informações importantes:

**Project URL:**
```
https://abcdefghijklmnop.supabase.co
```

**API Keys:**
- `anon` `public` (esta é a que vamos usar)
```
***REMOVED***CI6IkpXVCJ9...
```

**⚠️ IMPORTANTE:**
- A chave `anon public` é segura para usar no frontend
- NUNCA use a chave `service_role` no frontend!

---

## 📝 PASSO 4: CONFIGURAR VARIÁVEIS DE AMBIENTE

### 4.1. Criar arquivo .env

```bash
cd frontend-landing

# Copiar template
cp .env.example .env

# Editar .env
nano .env  # ou use seu editor preferido
```

### 4.2. Preencher credenciais

```env
VITE_SUPABASE_URL=https://abcdefghijklmnop.supabase.co
VITE_SUPABASE_ANON_KEY=***REMOVED***CI6IkpXVCJ9...
```

**Substituir:**
- `abcdefghijklmnop` pelo seu Project URL
- `eyJhbGci...` pela sua Anon Key

---

## 🗄️ PASSO 5: CRIAR TABELAS

### 5.1. Acessar SQL Editor

- No menu lateral, clicar em 🔧 **SQL Editor**
- Clicar em "+ New query"

### 5.2. Executar SQL

Copiar e colar este SQL:

```sql
-- ========================================
-- TABELA DE LEADS
-- ========================================
CREATE TABLE IF NOT EXISTS leads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT UNIQUE NOT NULL,
    name TEXT,
    metadata JSONB DEFAULT '{}'::jsonb,
    user_agent TEXT,
    referrer TEXT,
    screen_resolution TEXT,
    language TEXT,
    timezone TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_leads_email ON leads(email);
CREATE INDEX IF NOT EXISTS idx_leads_created_at ON leads(created_at DESC);

-- RLS (Row Level Security) - Permite leitura/escrita pública
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Permitir inserção pública de leads"
    ON leads FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Permitir leitura pública de leads"
    ON leads FOR SELECT
    USING (true);

-- ========================================
-- FUNÇÃO DE ATUALIZAÇÃO AUTOMÁTICA
-- ========================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_leads_updated_at
    BEFORE UPDATE ON leads
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ========================================
-- COMENTÁRIOS
-- ========================================
COMMENT ON TABLE leads IS 'Tabela de leads capturados na landing page';
COMMENT ON COLUMN leads.metadata IS 'Dados adicionais do lead (score, milestones, etc.)';
```

- Clicar em "Run" (ou Ctrl+Enter)

**Resultado esperado:**
```
Success. No rows returned
```

---

## 🧪 PASSO 6: TESTAR CONEXÃO

### 6.1. Instalar Supabase JS

```bash
cd frontend-landing
npm install @supabase/supabase-js
```

### 6.2. Testar API

```bash
# Testar criação de lead
curl -X POST https://SEU_PROJETO.supabase.co/rest/v1/leads \
  -H "apikey: SUA_ANON_KEY" \
  -H "Content-Type: application/json" \
  -H "Prefer: return=representation" \
  -d '{
    "email": "teste@elevare.com",
    "name": "Teste",
    "metadata": {"score": 50}
  }'
```

**Resposta esperada:**
```json
[
  {
    "id": "uuid-aqui",
    "email": "teste@elevare.com",
    "name": "Teste",
    "metadata": {"score": 50},
    "created_at": "2025-11-28T..."
  }
]
```

---

## ✅ PASSO 7: VERIFICAR NO DASHBOARD

### 7.1. Acessar Table Editor

- No menu lateral, clicar em 📊 **Table Editor**
- Selecionar tabela `leads`

### 7.2. Verificar Dados

Você deve ver o lead de teste criado!

---

## 🔐 PASSO 8: CONFIGURAR AUTENTICAÇÃO (Opcional)

### 8.1. Acessar Authentication

- No menu lateral, clicar em 🔐 **Authentication**
- Clicar em **Settings**

### 8.2. Configurar Providers

**Email (já vem ativado):**
- ✅ Enable Email provider
- ✅ Confirm email: Desabilitado (para desenvolvimento)

**Google (opcional):**
- Clicar em "Google"
- Preencher Client ID e Secret
- Salvar

---

## 📊 PASSO 9: MONITORAMENTO

### 9.1. Acessar Logs

- No menu lateral, clicar em 📈 **Logs**
- Selecionar **API Logs**

Aqui você verá todas as requisições em tempo real!

---

## 🎯 CHECKLIST FINAL

- [ ] Projeto criado no Supabase
- [ ] Credenciais copiadas (URL + Anon Key)
- [ ] Arquivo `.env` criado e preenchido
- [ ] Tabela `leads` criada
- [ ] Teste de API executado com sucesso
- [ ] Lead de teste aparece no dashboard
- [ ] Supabase JS instalado (`@supabase/supabase-js`)

**Se todos os itens estão ✅, você está pronto para a Fase 1!**

---

## 🐛 TROUBLESHOOTING

### Erro: "Invalid API key"

**Causa:** Chave API incorreta

**Solução:**
1. Verificar se copiou a chave `anon public` (não a `service_role`)
2. Verificar se não há espaços extras no `.env`
3. Reiniciar servidor de desenvolvimento (`npm run dev`)

---

### Erro: "relation 'leads' does not exist"

**Causa:** Tabela não foi criada

**Solução:**
1. Ir para SQL Editor
2. Executar o SQL do Passo 5.2 novamente
3. Verificar se não há erros no console

---

### Erro: "CORS policy"

**Causa:** Configuração de CORS no Supabase

**Solução:**
1. Ir para Settings → API
2. Verificar se "CORS Allowed Origins" inclui `http://localhost:5173`
3. Adicionar se necessário

---

## 📚 RECURSOS ADICIONAIS

**Documentação Oficial:**
- https://supabase.com/docs

**Guias:**
- https://supabase.com/docs/guides/getting-started
- https://supabase.com/docs/guides/auth

**Comunidade:**
- Discord: https://discord.supabase.com
- GitHub: https://github.com/supabase/supabase

---

## 🎉 PRÓXIMOS PASSOS

Agora que o Supabase está configurado, você pode:

1. ✅ Implementar Fase 1 (API + Auth)
2. ✅ Testar captura de leads
3. ✅ Testar autenticação

**Veja:** `GUIA_FASE_1.md` para instruções detalhadas

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** ✅ **PRONTO PARA USO**
