# ✅ CHECKLIST LANDING PAGE MVP - Elevare

**Versão:** 1.0 (Simplificada)  
**Data:** 28/11/2025  
**Foco:** Landing Page como MVP (sem backend)

---

## 🎯 OBJETIVO

Este checklist é focado na **realidade atual** do projeto: uma landing page funcional sem backend. Use este checklist antes de cada entrega relacionada à landing page.

**Diferença do CHECKLIST.md original:**
- ❌ CHECKLIST.md → Baseado em sistema completo (frontend + backend)
- ✅ CHECKLIST-LANDING-MVP.md → Baseado apenas na landing page

---

## 📋 CHECKLIST OBRIGATÓRIO

### 1. ✅ ARQUIVOS ESSENCIAIS

#### Arquivos HTML
- [ ] `index.html` existe e está atualizado
- [ ] `index.html` carrega sem erros 404
- [ ] Todas as imagens referenciadas existem

**Verificação:**
```bash
ls -lh frontend-landing/index.html
find frontend-landing/images -type f | wc -l
```

#### Arquivos JavaScript Básicos
- [ ] `js/lead-tracker.js` existe (novo)
- [ ] `js/onboarding-progress.js` existe (novo)
- [ ] Scripts estão incluídos no index.html

**Verificação:**
```bash
ls -lh frontend-landing/js/*.js
grep -c "lead-tracker.js\|onboarding-progress.js" frontend-landing/index.html
```

---

### 2. 🎨 INTERFACE E DESIGN

#### Elementos Visuais
- [ ] Logo da Elevare aparece
- [ ] Gradiente/shader de background carrega
- [ ] Ícones Lucide são renderizados
- [ ] Barra de progresso de onboarding aparece (3px no topo)

**Verificação:**
Abrir `tests/visual-check.html` e verificar:
- ✅ Logo da Elevare aparece
- ✅ Gradiente ou shader de background
- ✅ Ícones Lucide carregam

#### Responsividade
- [ ] Layout funciona em desktop (1920x1080)
- [ ] Layout funciona em tablet (1024x768)
- [ ] Layout funciona em mobile (375x667)
- [ ] Menu mobile toggle aparece em telas pequenas

**Verificação:**
```
Chrome DevTools → Toggle Device Toolbar
Testar: Desktop, iPad Pro, iPhone 12
```

---

### 3. 📝 FORMULÁRIOS E CAPTURA

#### Formulário de Leads
- [ ] Campo de email existe e é visível
- [ ] Campo tem validação HTML5 (type="email")
- [ ] Formulário pode ser submetido
- [ ] Não há erros de console ao submeter

**Verificação:**
1. Abrir index.html
2. Localizar formulário de captura
3. Tentar submeter sem email → Deve mostrar erro
4. Submeter com email válido → Sem erros de console

#### Tracking de Leads
- [ ] Lead Tracker inicializa automaticamente
- [ ] Lead ID é criado no localStorage
- [ ] Milestones são rastreados (scroll, focus, tempo)
- [ ] Lead score é calculado corretamente

**Verificação:**
```javascript
// No console do navegador:
window.leadTracker.getLeadScore() // Deve retornar 0-100
window.leadTracker.getLeadData()  // Deve retornar objeto completo
```

---

### 4. 🪟 MODAIS E INTERAÇÕES

#### Modal de Planos
- [ ] Modal existe no DOM
- [ ] Modal abre ao clicar em CTA
- [ ] Modal fecha ao clicar em fechar/ESC
- [ ] Scroll do body é bloqueado quando modal aberto

**Verificação:**
1. Clicar em botão "Ver Planos"
2. Modal deve abrir
3. Pressionar ESC → Modal fecha
4. Body não deve rolar quando modal aberto

#### Navegação
- [ ] Links de navegação interna funcionam (#beneficios, #planos)
- [ ] Scroll suave funciona
- [ ] Não há links quebrados (404)

**Verificação:**
```bash
# Verificar links no HTML
grep -o 'href="#[^"]*"' frontend-landing/index.html
```

---

### 5. 📱 MENU MOBILE

#### Funcionalidade
- [ ] Botão toggle existe
- [ ] Menu abre ao clicar no toggle
- [ ] Menu fecha ao clicar novamente
- [ ] Links do menu funcionam

**Verificação:**
1. Redimensionar janela para mobile (< 768px)
2. Clicar no ícone de menu (☰)
3. Menu deve abrir
4. Clicar novamente → Menu fecha

---

### 6. 🎯 TRACKING E ANALYTICS

#### Lead Tracker
- [ ] LeadTracker class está definida
- [ ] window.leadTracker está inicializado
- [ ] localStorage contém 'leadId'
- [ ] Milestones são salvos no localStorage

**Verificação:**
```javascript
// Console do navegador
typeof window.LeadTracker        // "function"
typeof window.leadTracker         // "object"
localStorage.getItem('leadId')    // "lead_..."
localStorage.getItem('milestones') // "{...}"
```

#### Barra de Progresso
- [ ] Barra aparece no topo da página
- [ ] Barra atualiza conforme milestones
- [ ] Barra chega a 100% quando todos milestones alcançados

**Verificação:**
```javascript
// Console do navegador
document.getElementById('onboarding-progress').style.width // "0%" → "100%"
```

---

### 7. 🧪 VALIDAÇÃO VISUAL

#### Checklist Automatizado
- [ ] `tests/visual-check.html` existe
- [ ] Todos os checks críticos passam (✅)
- [ ] Nenhum check crítico falha (❌)
- [ ] Warnings (⚠️) são aceitáveis

**Verificação:**
```
Abrir: http://localhost:5173/tests/visual-check.html
Resultado esperado: 12+ checks passando, 0 falhas críticas
```

---

### 8. 🔒 CONSOLE E ERROS

#### Console do Navegador
- [ ] Nenhum erro crítico (vermelho)
- [ ] Warnings aceitáveis (amarelo)
- [ ] Mensagens de sucesso do LeadTracker aparecem

**Verificação:**
```
F12 → Console
Deve aparecer: "🎯 Lead Tracker inicializado: lead_..."
Não deve ter: Erros em vermelho
```

---

### 9. ⚡ PERFORMANCE

#### Lighthouse
- [ ] Performance > 90
- [ ] Accessibility > 95
- [ ] Best Practices > 90
- [ ] SEO > 95

**Verificação:**
```
Chrome DevTools → Lighthouse → Generate Report
```

#### Carregamento
- [ ] Página carrega em < 3 segundos
- [ ] Imagens estão otimizadas
- [ ] Não há recursos bloqueando renderização

---

### 10. 🚀 PRÉ-DEPLOY

#### Validação Final
- [ ] Visual check passou (tests/visual-check.html)
- [ ] Testado em 3 dispositivos diferentes
- [ ] Console sem erros críticos
- [ ] Todos os links funcionam
- [ ] Formulário de captura funciona

#### Deploy
- [ ] Commit feito com mensagem descritiva
- [ ] Push para repositório Git
- [ ] Deploy para Vercel bem-sucedido
- [ ] URL de produção acessível

**Verificação:**
```bash
git status                    # Nada pendente
git log -1                    # Último commit
curl -I https://elevare-landing.vercel.app  # Status 200
```

---

## 📊 RESUMO RÁPIDO

### Checklist de 5 Minutos (Pré-Deploy)

```bash
# 1. Visual Check
open tests/visual-check.html
# Resultado: 12+ ✅, 0 ❌

# 2. Console Check
# Abrir index.html e verificar console
# Resultado: Sem erros vermelhos

# 3. Lead Tracker Check
# Console: window.leadTracker.getLeadScore()
# Resultado: Número entre 0-100

# 4. Mobile Check
# DevTools → iPhone 12
# Resultado: Menu mobile funciona

# 5. Deploy Check
git status && git log -1
# Resultado: Tudo commitado
```

---

## 🎯 DIFERENÇAS DO CHECKLIST ORIGINAL

| Item | CHECKLIST.md (Original) | CHECKLIST-LANDING-MVP.md (Este) |
|------|------------------------|----------------------------------|
| Foco | Sistema completo | Landing page MVP |
| Backend | ✅ Requerido | ❌ Não aplicável |
| Testes E2E | ✅ 60 testes | ⚠️ Opcional (futuro) |
| API | ✅ Endpoints funcionando | ❌ Não aplicável |
| Auth | ✅ Login/registro | ❌ Não aplicável |
| Dashboard | ✅ Funcional | ❌ Não aplicável |
| Lead Tracking | ❌ Não mencionado | ✅ Obrigatório |
| Visual Check | ❌ Não mencionado | ✅ Obrigatório |

---

## 🚫 ITENS REMOVIDOS (Não Aplicáveis ao MVP)

Estes itens estão no CHECKLIST.md original mas **NÃO** se aplicam à landing page MVP:

- ❌ Sistema de autenticação (auth.js, api.js)
- ❌ Backend API funcionando
- ❌ Testes E2E executados (60 testes)
- ❌ CI/CD pipeline ativo
- ❌ Dashboard com dados reais
- ❌ Integração Railway
- ❌ Variáveis de ambiente de produção
- ❌ PostgreSQL configurado

**Estes itens serão aplicáveis no futuro quando backend for implementado.**

---

## ✅ ITENS ADICIONADOS (Específicos do MVP)

Estes itens são **NOVOS** e específicos para a landing page MVP:

- ✅ Lead Tracker inicializado
- ✅ Barra de progresso de onboarding
- ✅ Visual check automatizado
- ✅ Lead scoring funcional
- ✅ Milestones rastreados
- ✅ LocalStorage funcional

---

## 📝 QUANDO USAR CADA CHECKLIST

### Use CHECKLIST-LANDING-MVP.md quando:
- ✅ Trabalhando apenas na landing page
- ✅ Fazendo deploy da landing page
- ✅ Testando funcionalidades de frontend
- ✅ Implementando tracking e analytics
- ✅ Validando antes de commit

### Use CHECKLIST.md quando:
- ⏳ Backend estiver implementado
- ⏳ Sistema completo estiver funcional
- ⏳ Testes E2E estiverem rodando
- ⏳ CI/CD estiver configurado
- ⏳ Produto final estiver pronto

---

## 🎯 PRÓXIMOS PASSOS

### Quando Este Checklist Estiver 100% ✅

1. **Integrar com Supabase** (Backend Serverless)
   - Criar tabela `leads`
   - Configurar API
   - Persistir dados de tracking

2. **Implementar Testes E2E**
   - Instalar Playwright
   - Executar testes criados
   - Atingir 100% de testes passando

3. **Migrar para CHECKLIST.md Completo**
   - Quando backend estiver pronto
   - Quando testes estiverem rodando
   - Quando CI/CD estiver ativo

---

## 📞 SUPORTE

### Dúvidas sobre Este Checklist

- Consultar `IMPLEMENTACOES_ESTRATEGICAS.md`
- Consultar `GAP_ANALYSIS.md`
- Revisar `DIRETRIZES_RELATORIOS.md`

### Problemas com Validação

- Executar `tests/visual-check.html`
- Verificar console do navegador
- Testar em modo incógnito

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** ✅ Ativo e Focado na Realidade Atual
