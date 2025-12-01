# 🚨 AÇÕES MANUAIS CRÍTICAS - EXECUTE AGORA

**Status:** O histórico Git foi parcialmente limpo, mas **as keys antigas ainda estão ativas e expostas**. Você **DEVE** executar estas ações manualmente **AGORA**.

---

## ⚠️ PASSO 1: Revogar Keys no Supabase Dashboard

1. **Acesse:** https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/settings/api
2. **Clique em "Reset" ao lado de "anon/public key"**
3. **Copie a nova key** (começa com `eyJhbGciOi...`)
4. **Salve em local seguro** (não commite no Git!)

---

## ⚠️ PASSO 2: Configurar RLS Seguro

1. **Acesse:** https://supabase.com/dashboard/project/gpebqonriekmthxxuezf/editor
2. **Execute este SQL:**

```sql
-- Remove políticas antigas (inseguras)
DROP POLICY IF EXISTS "Permitir SELECT público" ON leads;
DROP POLICY IF EXISTS "Permitir UPDATE público" ON leads;

-- Mantém INSERT público (para captura de leads)
CREATE POLICY "Permitir INSERT leads público" ON leads 
FOR INSERT TO public 
WITH CHECK (true);

-- Adiciona autenticação para SELECT/UPDATE
CREATE POLICY "Permitir SELECT leads autenticado" ON leads 
FOR SELECT TO authenticated 
USING (true);

CREATE POLICY "Permitir UPDATE leads autenticado" ON leads 
FOR UPDATE TO authenticated 
USING (auth.uid() = user_id);
```

3. **Valide:** Tente acessar `https://gpebqonriekmthxxuezf.supabase.co/rest/v1/leads` sem autenticação. Deve retornar **401 Unauthorized**.

---

## ⚠️ PASSO 3: Atualizar Keys no Vercel/Produção

1. **Acesse:** https://vercel.com/iaraelevare-source/elevare-fullstack/settings/environment-variables
2. **Atualize:**
   - `VITE_SUPABASE_ANON_KEY` = [nova key do Passo 1]
   - `VITE_SUPABASE_URL` = `https://gpebqonriekmthxxuezf.supabase.co`
3. **Redeploy:** Clique em "Redeploy" para aplicar as mudanças

---

## ⚠️ PASSO 4: Testar em Produção

1. **Acesse seu site em produção**
2. **Preencha o formulário de leads**
3. **Verifique no Supabase Dashboard** se o lead foi capturado

---

## 📊 Checklist de Validação

- [ ] Key antiga revogada no Supabase
- [ ] Nova key copiada e salva
- [ ] RLS configurado (SELECT/UPDATE bloqueados para anônimos)
- [ ] Validação manual (401 ao acessar /leads sem auth)
- [ ] Keys atualizadas no Vercel
- [ ] Redeploy realizado
- [ ] Teste em produção (formulário funcionando)

---

**⏰ TEMPO ESTIMADO:** 10-15 minutos

**🚨 PRIORIDADE:** P0 - CRÍTICO

**❌ NÃO PULE ESTE PASSO!** Sem revogar as keys, o projeto continua vulnerável mesmo com o histórico limpo.
