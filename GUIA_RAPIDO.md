# ⚡ GUIA RÁPIDO - Elevare

**Para desenvolvedores que precisam de referência rápida**

---

## 🚀 COMANDOS ESSENCIAIS

### Desenvolvimento Local

```bash
# Iniciar servidor local
cd frontend-landing
npm run dev
# Acesse: http://localhost:3000
```

### Testes

```bash
# Executar todos os testes
npm test

# Executar testes com UI
npm run test:ui

# Executar testes em modo debug
npm run test:debug

# Ver relatório de testes
npm run test:report
```

### Validação Pré-Deploy

```bash
# Executar script de validação
cd frontend-landing
./scripts/pre-deploy-check.sh
```

---

## ✅ CHECKLIST RÁPIDO

Antes de criar PR, confirme:

- [ ] `./scripts/pre-deploy-check.sh` passou
- [ ] `npm test` passou (100%)
- [ ] Testado em desktop, mobile, tablet
- [ ] Nenhum erro de console
- [ ] Modais abrem/fecham
- [ ] Login/logout funciona
- [ ] Menu mobile funciona
- [ ] Ícones aparecem

---

## 📁 ARQUIVOS CRÍTICOS

### Obrigatórios

```
frontend-landing/
├── index.html           # Landing page principal
├── js/
│   ├── app.js          # Funções principais ⚠️ CRÍTICO
│   ├── api.js          # Chamadas API ⚠️ CRÍTICO
│   └── auth.js         # Autenticação ⚠️ CRÍTICO
└── images/             # Imagens otimizadas
```

### Funções Obrigatórias em app.js

```javascript
function updateAuthUI()        // Atualizar UI conforme login
function openLoginModal()      // Abrir modal de login
function closeLoginModal()     // Fechar modal de login
function openRegisterModal()   // Abrir modal de registro
function closeRegisterModal()  // Fechar modal de registro
function logout()              // Fazer logout
```

---

## 🧪 TESTES RÁPIDOS

### Teste Manual Rápido (5 minutos)

1. **Abrir página** → Sem erros de console
2. **Clicar "Entrar"** → Modal abre
3. **Fechar modal** → Modal fecha
4. **Menu mobile** → Abre/fecha (mobile)
5. **Fazer login** → Botões alternam
6. **Fazer logout** → Botões voltam

---

## 🚫 BLOQUEADORES

**NÃO fazer deploy se:**

- ❌ Testes falhando
- ❌ Erros de console
- ❌ Modais não funcionam
- ❌ Menu mobile quebrado
- ❌ Ícones não aparecem

---

## 📊 MÉTRICAS MÍNIMAS

| Métrica | Mínimo |
|---------|--------|
| Testes | 100% passando |
| Performance | 90 |
| Accessibility | 95 |
| Console Errors | 0 |

---

## 🔗 LINKS ÚTEIS

- **Checklist Completo:** `CHECKLIST.md`
- **Processo:** `PROCESSO_DESENVOLVIMENTO.md`
- **Arquitetura:** `ARQUITETURA_V1.0.md`
- **Testes:** `frontend-landing/tests/`

---

## 🆘 PROBLEMAS COMUNS

### Testes falhando?
```bash
# Limpar cache e reinstalar
rm -rf node_modules package-lock.json
npm install
npx playwright install
npm test
```

### Ícones não aparecem?
```javascript
// Adicionar após alterações dinâmicas
if (typeof lucide !== 'undefined') {
    lucide.createIcons();
}
```

### Modal não fecha?
```javascript
// Verificar se classe hidden está sendo alternada
modal.classList.toggle('hidden');
document.body.style.overflow = modal.classList.contains('hidden') ? '' : 'hidden';
```

---

## 💡 DICAS

1. **Sempre execute validação local antes de push**
2. **Teste em pelo menos 3 dispositivos**
3. **Commits pequenos e frequentes**
4. **Mensagens de commit descritivas**
5. **Documente código complexo**

---

**Última atualização:** 28/11/2025
