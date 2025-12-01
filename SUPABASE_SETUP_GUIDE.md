# 🚀 Guia de Configuração do Supabase - Elevare

**Data:** 28/11/2025  
**Objetivo:** Configurar banco de dados para captura de leads da landing page

---

## 📋 Passo a Passo

### 1️⃣ Acessar o Dashboard do Supabase

1. Acesse: [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Faça login com suas credenciais
3. Selecione seu projeto Elevare (ou crie um novo se não existir)

---

### 2️⃣ Abrir o SQL Editor

1. No menu lateral esquerdo, clique em **"SQL Editor"**
2. Clique em **"New query"** (ou use Ctrl+Enter)

---

### 3️⃣ Executar o Script SQL

**Copie e cole o seguinte SQL no editor:**

```sql
-- ========================================
-- ELEVARE - SETUP SUPABASE
-- ========================================
-- Execute este SQL no Supabase SQL Editor
-- Data: 28/11/2025

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
CREATE INDEX IF NOT EXISTS idx_leads_metadata ON leads USING GIN (metadata);

-- ========================================
-- RLS (Row Level Security)
-- ========================================
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;

-- Política: Permitir inserção pública de leads
CREATE POLICY "Permitir inserção pública de leads"
    ON leads FOR INSERT
    WITH CHECK (true);

-- Política: Permitir leitura pública de leads
CREATE POLICY "Permitir leitura pública de leads"
    ON leads FOR SELECT
    USING (true);

-- Política: Permitir atualização pública de leads
CREATE POLICY "Permitir atualização pública de leads"
    ON leads FOR UPDATE
    USING (true)
    WITH CHECK (true);

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

-- Trigger para atualizar updated_at automaticamente
CREATE TRIGGER update_leads_updated_at
    BEFORE UPDATE ON leads
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ========================================
-- TESTE
-- ========================================
-- Inserir lead de teste
INSERT INTO leads (email, name, metadata)
VALUES (
    'teste@elevare.com',
    'Lead de Teste',
    '{"score": 50, "source": "landing_page"}'::jsonb
)
ON CONFLICT (email) DO UPDATE
SET 
    name = EXCLUDED.name,
    metadata = EXCLUDED.metadata,
    updated_at = NOW();

-- Verificar lead de teste
SELECT * FROM leads WHERE email = 'teste@elevare.com';
```

---

### 4️⃣ Executar e Verificar

1. Clique em **"Run"** (ou pressione Ctrl+Enter)
2. Aguarde a execução (deve levar ~2 segundos)
3. Verifique se aparece:
   - ✅ "Success. No rows returned"
   - ✅ Tabela com 1 linha (lead de teste)

---

### 5️⃣ Obter Credenciais da API

1. No menu lateral, clique em **"Settings"** → **"API"**
2. Copie as seguintes informações:

**Project URL:**
```
https://[seu-projeto].supabase.co
```

**API Key (anon/public):**
```
***REMOVED***CI6IkpXVCJ9...
```

---

### 6️⃣ Configurar Variáveis de Ambiente

**Crie um arquivo `.env` na raiz do projeto:**

```bash
# Supabase Configuration
SUPABASE_URL=https://[seu-projeto].supabase.co
SUPABASE_ANON_KEY=***REMOVED***CI6IkpXVCJ9...
```

**⚠️ IMPORTANTE:** Substitua `[seu-projeto]` pela URL real do seu projeto!

---

## ✅ Verificação Final

Execute no SQL Editor:

```sql
-- Verificar estrutura da tabela
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'leads'
ORDER BY ordinal_position;

-- Verificar políticas RLS
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd
FROM pg_policies
WHERE tablename = 'leads';

-- Contar leads
SELECT COUNT(*) as total_leads FROM leads;
```

**Resultado esperado:**
- ✅ 11 colunas na tabela `leads`
- ✅ 3 políticas RLS ativas
- ✅ 1 lead de teste

---

## 🎯 Próximos Passos

Após configurar o Supabase:

1. ✅ Atualizar arquivo `.env` com credenciais
2. ✅ Testar captura de leads localmente
3. ✅ Fazer deploy da landing page
4. ✅ Validar captura de leads em produção

---

## 🆘 Problemas Comuns

### Erro: "relation 'leads' already exists"
**Solução:** A tabela já existe. Pule para o passo 5.

### Erro: "permission denied for schema public"
**Solução:** Verifique se você é o owner do projeto no Supabase.

### Políticas RLS não funcionam
**Solução:** Execute:
```sql
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
```

---

## 📞 Suporte

Se encontrar problemas, envie:
1. Screenshot do erro no SQL Editor
2. Resultado da query de verificação
3. URL do projeto Supabase (sem credenciais)

---

**Criado por:** Manus AI  
**Versão:** 1.0  
**Última atualização:** 28/11/2025
