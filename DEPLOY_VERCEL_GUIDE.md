# 🚀 Guia de Deploy no Vercel - Elevare Landing Page

**Data:** 28/11/2025  
**Objetivo:** Deploy da landing page no Vercel com integração Supabase

---

## 📋 Pré-requisitos

- ✅ Conta no Vercel ([https://vercel.com](https://vercel.com))
- ✅ Repositório GitHub conectado
- ✅ Supabase configurado (URL e API Key)

---

## 🎯 Método 1: Deploy via Dashboard Vercel (Recomendado)

### 1️⃣ Importar Projeto

1. Acesse: [https://vercel.com/new](https://vercel.com/new)
2. Clique em **"Import Git Repository"**
3. Selecione: `iaraelevare-source/Elevare-FullStack`
4. Clique em **"Import"**

---

### 2️⃣ Configurar Projeto

**Root Directory:**
```
frontend-landing
```

**Framework Preset:**
```
Other (Static HTML)
```

**Build Command:**
```
echo "No build needed"
```

**Output Directory:**
```
.
```

---

### 3️⃣ Configurar Variáveis de Ambiente

Clique em **"Environment Variables"** e adicione:

| Nome | Valor | Ambiente |
|------|-------|----------|
| `VITE_SUPABASE_URL` | `https://[seu-projeto].supabase.co` | Production |
| `VITE_SUPABASE_ANON_KEY` | `***REMOVED***CI6IkpXVCJ9...` | Production |

**⚠️ IMPORTANTE:** Substitua pelos valores reais obtidos no Supabase!

---

### 4️⃣ Deploy

1. Clique em **"Deploy"**
2. Aguarde ~1-2 minutos
3. ✅ Deploy concluído!

**URL de Produção:**
```
https://elevare-fullstack-[hash].vercel.app
```

---

## 🎯 Método 2: Deploy via CLI Vercel

### 1️⃣ Login no Vercel

```bash
vercel login
```

Siga as instruções no navegador.

---

### 2️⃣ Configurar Variáveis de Ambiente

```bash
cd /home/ubuntu/Elevare-FullStack/frontend-landing

# Adicionar variáveis de ambiente
vercel env add VITE_SUPABASE_URL production
# Cole: https://[seu-projeto].supabase.co

vercel env add VITE_SUPABASE_ANON_KEY production
# Cole: ***REMOVED***CI6IkpXVCJ9...
```

---

### 3️⃣ Deploy para Produção

```bash
# Deploy de produção
vercel --prod
```

**Output esperado:**
```
✅ Production: https://elevare-fullstack-[hash].vercel.app
```

---

## 🔍 Verificação Pós-Deploy

### 1️⃣ Testar Landing Page

Acesse a URL de produção e verifique:

- ✅ Página carrega corretamente
- ✅ Imagens aparecem
- ✅ Menu funciona
- ✅ Modais abrem/fecham
- ✅ Formulários aparecem

---

### 2️⃣ Testar Integração Supabase

**Abra o Console do Navegador (F12)** e verifique:

```
✅ Supabase API inicializada
📍 URL: https://[seu-projeto].supabase.co
```

**Se aparecer erro:**
```
❌ Credenciais Supabase não encontradas no .env
```

**Solução:** Verifique se as variáveis de ambiente foram configuradas corretamente no Vercel.

---

### 3️⃣ Testar Captura de Lead

1. Preencha o formulário de contato
2. Envie os dados
3. Acesse o Supabase Dashboard → Table Editor → `leads`
4. ✅ Verifique se o lead foi capturado

---

## 🛠️ Configurações Avançadas

### Custom Domain

1. No dashboard do Vercel, vá em **"Settings"** → **"Domains"**
2. Adicione seu domínio personalizado
3. Configure os DNS conforme instruções

---

### Configurar Redirects

Edite `vercel.json`:

```json
{
  "version": 2,
  "buildCommand": "echo 'No build needed'",
  "outputDirectory": ".",
  "rewrites": [
    { "source": "/(.*)", "destination": "/$1" }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        }
      ]
    }
  ]
}
```

---

### Analytics e Monitoring

**Vercel Analytics:**
1. Vá em **"Analytics"** no dashboard
2. Ative o Vercel Analytics
3. Monitore pageviews, performance, etc.

**Vercel Speed Insights:**
1. Vá em **"Speed Insights"** no dashboard
2. Ative o Speed Insights
3. Monitore Core Web Vitals

---

## 🐛 Troubleshooting

### Erro: "Build failed"

**Causa:** Build command incorreto.

**Solução:**
```bash
# Build Command
echo "No build needed"

# Output Directory
.
```

---

### Erro: "Supabase credentials not found"

**Causa:** Variáveis de ambiente não configuradas.

**Solução:**
1. Vá em **"Settings"** → **"Environment Variables"**
2. Adicione `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY`
3. Redeploy: **"Deployments"** → **"..."** → **"Redeploy"**

---

### Erro: "404 Not Found"

**Causa:** Root directory incorreto.

**Solução:**
1. Vá em **"Settings"** → **"General"**
2. Configure **"Root Directory"** para `frontend-landing`
3. Salve e redeploy

---

### Imagens não carregam

**Causa:** Caminhos relativos incorretos.

**Solução:** Verifique se as imagens estão em `frontend-landing/images/`

---

## 📊 Métricas de Sucesso

Após deploy, verifique:

- ✅ **Uptime:** 99.9%+
- ✅ **Load Time:** < 2s
- ✅ **Lighthouse Score:** 90+
- ✅ **Core Web Vitals:** Todos verdes

---

## 🔄 Atualizações Futuras

**Deploy Automático:**
- Todo push para `master` → Deploy automático
- Pull Requests → Preview deployments

**Rollback:**
1. Vá em **"Deployments"**
2. Selecione deployment anterior
3. Clique em **"Promote to Production"**

---

## 📞 Suporte

**Problemas com Deploy:**
- Vercel Status: [https://vercel-status.com](https://vercel-status.com)
- Vercel Docs: [https://vercel.com/docs](https://vercel.com/docs)

**Problemas com Supabase:**
- Supabase Status: [https://status.supabase.com](https://status.supabase.com)
- Supabase Docs: [https://supabase.com/docs](https://supabase.com/docs)

---

## ✅ Checklist Final

- [ ] Repositório conectado ao Vercel
- [ ] Root directory configurado (`frontend-landing`)
- [ ] Variáveis de ambiente configuradas
- [ ] Deploy concluído com sucesso
- [ ] Landing page acessível
- [ ] Console sem erros
- [ ] Supabase integrado
- [ ] Lead de teste capturado
- [ ] Custom domain configurado (opcional)
- [ ] Analytics ativado (opcional)

---

**Criado por:** Manus AI  
**Versão:** 1.0  
**Última atualização:** 28/11/2025
