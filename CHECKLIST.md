# ✅ CHECKLIST OBRIGATÓRIO DE ATUALIZAÇÃO - Elevare

**Versão:** 1.0  
**Data de Criação:** 28/11/2025  
**Última Atualização:** 28/11/2025  

---

## 📋 OBJETIVO

Este checklist deve ser **obrigatoriamente** revisado e marcado antes de cada entrega, deploy ou merge de código no projeto Elevare. Garante que todas as funcionalidades críticas estejam funcionando corretamente.

---

## 🔴 CHECKLIST CRÍTICO (Obrigatório em TODA entrega)

### 📁 1. ARQUIVOS JAVASCRIPT

- [ ] **js/app.js** existe e está atualizado
- [ ] **js/api.js** existe e está atualizado
- [ ] **js/auth.js** existe e está atualizado
- [ ] Todos os scripts estão referenciados corretamente no HTML
- [ ] Não há erros de console no navegador
- [ ] Todos os arquivos JS estão minificados para produção (se aplicável)

**Como Verificar:**
```bash
# Verificar existência dos arquivos
ls -la frontend-landing/js/

# Verificar referências no HTML
grep -n "src=\"js/" frontend-landing/index.html

# Testar no navegador
# Abrir DevTools → Console → Verificar erros
```

---

### 🔐 2. AUTENTICAÇÃO E SESSÃO

- [ ] Função `updateAuthUI()` implementada e funcionando
- [ ] Detecção de usuário logado via `localStorage.getItem('token')` funciona
- [ ] Alternância de botões `.auth-button`, `.dashboard-button`, `.logout-button` funciona
- [ ] Redirecionamento para dashboard funciona quando usuário está logado
- [ ] Função `logout()` limpa sessão e atualiza UI corretamente
- [ ] Token JWT é armazenado de forma segura
- [ ] Sessão expira corretamente após timeout

**Como Verificar:**
```javascript
// No console do navegador
localStorage.setItem('token', 'test-token');
updateAuthUI(); // Botões devem alternar

localStorage.removeItem('token');
updateAuthUI(); // Botões devem voltar ao estado original
```

---

### 🪟 3. MODAIS DE LOGIN/REGISTRO

- [ ] Modal de login abre corretamente (`openLoginModal()`)
- [ ] Modal de login fecha corretamente (`closeLoginModal()`)
- [ ] Modal de registro abre corretamente (`openRegisterModal()`)
- [ ] Modal de registro fecha corretamente (`closeRegisterModal()`)
- [ ] Classe `.hidden` é adicionada/removida corretamente
- [ ] Scroll do `body` é bloqueado ao abrir modal
- [ ] Scroll do `body` é restaurado ao fechar modal
- [ ] Foco é direcionado ao primeiro campo ao abrir modal
- [ ] Modal fecha ao pressionar tecla `ESC`
- [ ] Modal fecha ao clicar fora da área do modal

**Como Verificar:**
```javascript
// No console do navegador
openLoginModal(); // Modal deve aparecer, scroll bloqueado
closeLoginModal(); // Modal deve sumir, scroll restaurado

openRegisterModal(); // Modal de registro deve aparecer
closeRegisterModal(); // Modal de registro deve sumir
```

---

### 📝 4. FORMULÁRIOS E VALIDAÇÃO

- [ ] Formulário de login intercepta submit corretamente
- [ ] Formulário de registro intercepta submit corretamente
- [ ] Validação de campos funciona (email, senha, nome)
- [ ] Mensagens de erro aparecem em `.error-container`
- [ ] Requisição AJAX para API de login funciona
- [ ] Requisição AJAX para API de registro funciona
- [ ] Token é salvo no `localStorage` após login bem-sucedido
- [ ] Redirecionamento para dashboard após login funciona
- [ ] Feedback visual durante loading (spinner/botão desabilitado)

**Como Verificar:**
```javascript
// Testar validação
document.getElementById('loginForm').onsubmit(new Event('submit'));

// Verificar se preventDefault() está funcionando
// Página não deve recarregar ao submeter formulário
```

---

### 📱 5. MENU MOBILE

- [ ] Botão de toggle do menu mobile funciona
- [ ] Menu mobile abre corretamente em dispositivos pequenos
- [ ] Menu mobile fecha corretamente
- [ ] Classe `.hidden` é alternada corretamente
- [ ] Navegação funciona em todos os links do menu mobile
- [ ] Layout responsivo funciona em todas as resoluções
- [ ] Breakpoints Tailwind (sm, md, lg) estão corretos

**Como Verificar:**
```bash
# Testar em diferentes resoluções
# DevTools → Toggle device toolbar → Testar em iPhone, iPad, etc.
```

---

### 🎨 6. ÍCONES LUCIDE

- [ ] Script Lucide está carregado corretamente
- [ ] `lucide.createIcons()` é chamado no `DOMContentLoaded`
- [ ] `lucide.createIcons()` é chamado após alterações dinâmicas no DOM
- [ ] Todos os ícones aparecem corretamente após abrir modais
- [ ] Ícones aparecem corretamente no menu mobile
- [ ] Não há ícones quebrados ou faltando

**Como Verificar:**
```javascript
// No console do navegador
if (typeof lucide !== 'undefined') {
    console.log('Lucide carregado ✅');
    lucide.createIcons();
} else {
    console.error('Lucide NÃO carregado ❌');
}
```

---

### 🔗 7. LINKS E NAVEGAÇÃO

- [ ] Todos os links internos funcionam
- [ ] `dashboard.html` existe e está acessível
- [ ] `status.html` existe e está acessível
- [ ] Todas as seções com IDs existem (#beneficios, #planos, etc.)
- [ ] Navegação suave (smooth scroll) funciona
- [ ] Links externos abrem em nova aba (`target="_blank"`)
- [ ] Não há links quebrados (404)

**Como Verificar:**
```bash
# Verificar existência de páginas
ls -la frontend-landing/*.html

# Verificar links no HTML
grep -n "href=" frontend-landing/index.html
```

---

### 🧪 8. TESTES MANUAIS

- [ ] **Desktop (1920x1080):** Todas as funcionalidades testadas
- [ ] **Tablet (768x1024):** Todas as funcionalidades testadas
- [ ] **Mobile (375x667):** Todas as funcionalidades testadas
- [ ] Login funciona em todos os dispositivos
- [ ] Logout funciona em todos os dispositivos
- [ ] Registro funciona em todos os dispositivos
- [ ] Modais funcionam em todos os dispositivos
- [ ] Menu mobile funciona em todos os dispositivos
- [ ] Ícones aparecem em todos os dispositivos

**Como Verificar:**
```bash
# Abrir em diferentes navegadores
# Chrome, Firefox, Safari, Edge
# Testar em cada um
```

---

### 🔒 9. SEGURANÇA

- [ ] Nenhum segredo (API keys, tokens) está exposto no frontend
- [ ] Validação de campos no frontend implementada
- [ ] Validação de campos no backend implementada
- [ ] HTTPS está configurado (produção)
- [ ] CORS está configurado corretamente
- [ ] Proteção contra XSS implementada
- [ ] Proteção contra CSRF implementada
- [ ] Senhas nunca são logadas ou expostas

**Como Verificar:**
```bash
# Verificar se não há segredos no código
grep -r "API_KEY\|SECRET\|PASSWORD" frontend-landing/js/

# Verificar HTTPS
curl -I https://elevare-landing.vercel.app | grep -i "strict-transport-security"
```

---

### 🚀 10. DEPLOY E PRODUÇÃO

- [ ] Build de produção funciona sem erros
- [ ] Todos os assets (imagens, CSS, JS) carregam corretamente
- [ ] Performance está otimizada (Lighthouse score > 90)
- [ ] SEO está otimizado (meta tags, alt text)
- [ ] Favicon está configurado
- [ ] Analytics está configurado (se aplicável)
- [ ] Monitoramento de erros está ativo (Sentry, etc.)

**Como Verificar:**
```bash
# Rodar Lighthouse
# DevTools → Lighthouse → Generate report

# Verificar assets
curl -I https://elevare-landing.vercel.app/images/elevare_logo_opt.png
```

---

## 🤖 TESTES AUTOMATIZADOS

### ✅ Testes que DEVEM passar antes do deploy

- [ ] Teste E2E: Abertura/fechamento de modais
- [ ] Teste E2E: Login completo
- [ ] Teste E2E: Logout completo
- [ ] Teste E2E: Registro completo
- [ ] Teste E2E: Alternância de botões conforme login
- [ ] Teste E2E: Navegação entre páginas
- [ ] Teste E2E: Menu mobile
- [ ] Teste de Unidade: Funções de autenticação
- [ ] Teste de Integração: API de login/registro

**Como Executar:**
```bash
# Rodar todos os testes
npm run test

# Rodar testes E2E
npm run test:e2e

# Rodar testes de unidade
npm run test:unit
```

---

## 📊 MÉTRICAS DE QUALIDADE

### Critérios de Aprovação

- [ ] **Cobertura de Testes:** ≥ 80%
- [ ] **Lighthouse Performance:** ≥ 90
- [ ] **Lighthouse Accessibility:** ≥ 95
- [ ] **Lighthouse Best Practices:** ≥ 90
- [ ] **Lighthouse SEO:** ≥ 95
- [ ] **Erros de Console:** 0
- [ ] **Warnings de Console:** ≤ 5
- [ ] **Tempo de Carregamento:** ≤ 3s

---

## 📝 PROCESSO DE REVISÃO

### Antes de Criar Pull Request

1. [ ] Executar checklist completo
2. [ ] Rodar todos os testes automatizados
3. [ ] Testar manualmente em 3 dispositivos diferentes
4. [ ] Verificar que não há regressões
5. [ ] Atualizar documentação (se necessário)
6. [ ] Adicionar screenshots/vídeos no PR (se aplicável)

### Template de Confirmação no PR

```markdown
## ✅ Checklist de Validação

- [x] Todos os itens do CHECKLIST.md foram verificados
- [x] Testes automatizados passaram (100%)
- [x] Testes manuais realizados em desktop, tablet e mobile
- [x] Nenhuma regressão identificada
- [x] Documentação atualizada

## 🧪 Testes Realizados

- Desktop (Chrome 120): ✅
- Mobile (iPhone 12): ✅
- Tablet (iPad Pro): ✅

## 📸 Screenshots

[Adicionar screenshots aqui]
```

---

## 🚨 BLOQUEADORES DE DEPLOY

**NÃO fazer deploy se:**

- ❌ Qualquer item do checklist crítico não estiver marcado
- ❌ Testes automatizados estiverem falhando
- ❌ Houver erros de console no navegador
- ❌ Modais não abrirem/fecharem corretamente
- ❌ Login/logout não funcionarem
- ❌ Menu mobile não funcionar
- ❌ Ícones Lucide não aparecerem
- ❌ Links estiverem quebrados

---

## 📞 SUPORTE

**Dúvidas sobre o checklist?**
- Consulte a documentação em `/docs/`
- Revise os testes automatizados em `/tests/`
- Entre em contato com a equipe de desenvolvimento

---

## 📅 HISTÓRICO DE VERSÕES

| Versão | Data | Autor | Mudanças |
|--------|------|-------|----------|
| 1.0 | 28/11/2025 | Sistema Manus | Versão inicial do checklist |

---

## 🎯 RESUMO RÁPIDO

**Antes de QUALQUER entrega, confirme:**

1. ✅ Todos os arquivos JS existem e funcionam
2. ✅ Autenticação, modais e UI funcionam
3. ✅ Testes automatizados passaram
4. ✅ Testes manuais em 3 dispositivos
5. ✅ Nenhum bloqueador de deploy ativo

**Se TODOS os itens estiverem ✅, pode fazer deploy!**

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** Ativo e Obrigatório
