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
-- COMENTÁRIOS (Documentação)
-- ========================================
COMMENT ON TABLE leads IS 'Tabela de leads capturados na landing page';
COMMENT ON COLUMN leads.id IS 'ID único do lead (UUID)';
COMMENT ON COLUMN leads.email IS 'E-mail do lead (único)';
COMMENT ON COLUMN leads.name IS 'Nome do lead';
COMMENT ON COLUMN leads.metadata IS 'Dados adicionais do lead (score, milestones, etc.)';
COMMENT ON COLUMN leads.user_agent IS 'User agent do navegador';
COMMENT ON COLUMN leads.referrer IS 'URL de origem do lead';
COMMENT ON COLUMN leads.screen_resolution IS 'Resolução da tela';
COMMENT ON COLUMN leads.language IS 'Idioma do navegador';
COMMENT ON COLUMN leads.timezone IS 'Fuso horário do lead';
COMMENT ON COLUMN leads.created_at IS 'Data de criação do lead';
COMMENT ON COLUMN leads.updated_at IS 'Data da última atualização';

-- ========================================
-- VERIFICAÇÃO
-- ========================================
-- Verificar se a tabela foi criada
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

-- ========================================
-- LIMPEZA (Opcional)
-- ========================================
-- Descomentar para deletar lead de teste
-- DELETE FROM leads WHERE email = 'teste@elevare.com';
