# 🔄 Processo de Desenvolvimento - Elevare

**Versão:** 1.0  
**Data:** 28/11/2025  
**Status:** Ativo e Obrigatório

---

## 📋 VISÃO GERAL

Este documento define o processo obrigatório de desenvolvimento para o projeto Elevare. Todos os desenvolvedores, incluindo o Sistema Manus, devem seguir este processo para garantir qualidade e consistência nas entregas.

---

## 🎯 PRINCÍPIOS FUNDAMENTAIS

### 1. Qualidade Acima de Velocidade
Nunca sacrifique qualidade por velocidade. É melhor entregar menos funcionalidades bem testadas do que muitas funcionalidades quebradas.

### 2. Testes São Obrigatórios
Nenhum código deve ser mergeado sem testes automatizados e manuais passando.

### 3. Documentação é Parte do Código
Código sem documentação é código incompleto.

### 4. Revisão de Código é Essencial
Todo código deve ser revisado antes do merge, mesmo em projetos individuais.

### 5. Deploy Seguro
Apenas código validado e testado deve ir para produção.

---

## 🔄 FLUXO DE TRABALHO

### Fase 1: Planejamento

**Antes de escrever qualquer código:**

1. **Entender o Requisito**
   - Ler completamente a solicitação
   - Identificar funcionalidades críticas
   - Listar dependências

2. **Consultar Checklist**
   - Abrir `CHECKLIST.md`
   - Identificar itens relevantes
   - Planejar como atender cada item

3. **Verificar Documentação Existente**
   - Ler arquitetura (`ARQUITETURA_V1.0.md`)
   - Consultar roadmap (`DOCUMENTACAO_ROADMAP_120DIAS.md`)
   - Verificar padrões estabelecidos

---

### Fase 2: Desenvolvimento

**Durante o desenvolvimento:**

1. **Criar Branch**
   ```bash
   git checkout -b feature/nome-da-funcionalidade
   ```

2. **Desenvolver com Testes**
   - Escrever código
   - Escrever testes simultaneamente
   - Testar localmente

3. **Seguir Padrões**
   - Usar nomenclatura consistente
   - Seguir estrutura de pastas
   - Manter código limpo e documentado

4. **Commits Granulares**
   ```bash
   git add arquivo-especifico.js
   git commit -m "feat: adiciona função de autenticação"
   ```

---

### Fase 3: Validação

**Antes de criar Pull Request:**

1. **Executar Checklist Completo**
   ```bash
   # Abrir CHECKLIST.md e marcar cada item
   ```

2. **Executar Script de Validação**
   ```bash
   cd frontend-landing
   ./scripts/pre-deploy-check.sh
   ```

3. **Executar Testes Automatizados**
   ```bash
   npm test
   ```

4. **Testes Manuais**
   - Desktop (Chrome, Firefox, Safari)
   - Mobile (iPhone, Android)
   - Tablet (iPad)

5. **Verificar Performance**
   ```bash
   npm run lighthouse
   ```

---

### Fase 4: Pull Request

**Ao criar Pull Request:**

1. **Usar Template Obrigatório**
   - Template é carregado automaticamente
   - Preencher TODOS os campos
   - Marcar TODOS os checkboxes

2. **Adicionar Evidências**
   - Screenshots antes/depois
   - Vídeos de funcionalidades
   - Output dos testes

3. **Confirmar Validação**
   - Confirmar que checklist foi seguido
   - Confirmar que testes passaram
   - Confirmar que não há regressões

---

### Fase 5: Revisão de Código

**Durante a revisão:**

1. **Revisor Verifica**
   - Checklist foi seguido
   - Testes estão passando
   - Código está limpo e documentado
   - Não há regressões

2. **Feedback Construtivo**
   - Apontar problemas claramente
   - Sugerir melhorias
   - Aprovar quando adequado

3. **Iteração**
   - Desenvolvedor corrige issues
   - Atualiza PR
   - Solicita nova revisão

---

### Fase 6: Merge e Deploy

**Após aprovação:**

1. **Merge para Main/Master**
   ```bash
   git checkout master
   git merge feature/nome-da-funcionalidade
   git push origin master
   ```

2. **CI/CD Automático**
   - GitHub Actions executa pipeline
   - Testes são executados novamente
   - Deploy automático (se testes passarem)

3. **Verificação Pós-Deploy**
   - Acessar URL de produção
   - Verificar funcionalidades críticas
   - Monitorar logs de erro

---

## 🚫 BLOQUEADORES DE DEPLOY

**NÃO fazer deploy se:**

- ❌ Qualquer teste automatizado falhar
- ❌ Script de validação falhar
- ❌ Checklist não estiver completo
- ❌ Houver erros de console
- ❌ Funcionalidades críticas não funcionarem
- ❌ Performance Lighthouse < 90
- ❌ Não houver aprovação de revisor

---

## 📊 MÉTRICAS DE QUALIDADE

### Requisitos Mínimos

| Métrica | Valor Mínimo | Como Verificar |
|---------|--------------|----------------|
| Cobertura de Testes | 80% | `npm run test:coverage` |
| Lighthouse Performance | 90 | `npm run lighthouse` |
| Lighthouse Accessibility | 95 | `npm run lighthouse` |
| Lighthouse Best Practices | 90 | `npm run lighthouse` |
| Lighthouse SEO | 95 | `npm run lighthouse` |
| Erros de Console | 0 | DevTools Console |
| Warnings Críticos | 0 | DevTools Console |

---

## 🧪 ESTRATÉGIA DE TESTES

### 1. Testes Automatizados (Obrigatório)

**Testes E2E com Playwright:**
- Modais de autenticação
- Formulários de login/registro
- Menu mobile
- Navegação
- Ícones Lucide

**Executar:**
```bash
npm test
```

### 2. Testes Manuais (Obrigatório)

**Desktop:**
- Chrome (última versão)
- Firefox (última versão)
- Safari (última versão)

**Mobile:**
- iPhone (iOS 15+)
- Android (Android 11+)

**Tablet:**
- iPad Pro
- Android Tablet

### 3. Testes de Regressão (Obrigatório)

**Verificar que funcionalidades existentes não quebraram:**
- Login/logout
- Modais
- Menu mobile
- Navegação
- Formulários

---

## 📝 PADRÕES DE CÓDIGO

### Nomenclatura

**Funções:**
```javascript
// ✅ Bom
function updateAuthUI() { }
function openLoginModal() { }

// ❌ Ruim
function update() { }
function open() { }
```

**Variáveis:**
```javascript
// ✅ Bom
const isUserLoggedIn = true;
const loginModal = document.getElementById('loginModal');

// ❌ Ruim
const flag = true;
const modal = document.getElementById('loginModal');
```

**Classes CSS:**
```css
/* ✅ Bom */
.auth-button { }
.dashboard-button { }

/* ❌ Ruim */
.btn { }
.btn2 { }
```

### Estrutura de Arquivos

```
frontend-landing/
├── index.html
├── dashboard.html
├── js/
│   ├── app.js       # Funções principais
│   ├── api.js       # Chamadas API
│   └── auth.js      # Autenticação
├── images/
│   └── *.jpg/png    # Imagens otimizadas
├── tests/
│   └── *.spec.js    # Testes E2E
└── scripts/
    └── *.sh         # Scripts de automação
```

---

## 🔄 PROCESSO DE ATUALIZAÇÃO

### Quando Atualizar Este Documento

Este documento deve ser atualizado quando:

1. Novos requisitos de qualidade forem estabelecidos
2. Novas ferramentas de teste forem adotadas
3. Processo de deploy mudar
4. Métricas de qualidade mudarem
5. Novos bloqueadores forem identificados

### Como Atualizar

1. Criar branch `docs/update-processo`
2. Atualizar documento
3. Incrementar versão
4. Criar PR com justificativa
5. Obter aprovação da equipe
6. Merge e comunicar mudanças

---

## 🎓 TREINAMENTO

### Para Novos Desenvolvedores

**Checklist de Onboarding:**

- [ ] Ler `README.md`
- [ ] Ler `ARQUITETURA_V1.0.md`
- [ ] Ler `CHECKLIST.md`
- [ ] Ler este documento (`PROCESSO_DESENVOLVIMENTO.md`)
- [ ] Configurar ambiente local
- [ ] Executar testes localmente
- [ ] Fazer primeiro PR (pequeno)
- [ ] Receber feedback e iterar

### Para o Sistema Manus

**Antes de cada entrega:**

1. Consultar `CHECKLIST.md`
2. Seguir este processo rigorosamente
3. Executar script de validação
4. Executar testes automatizados
5. Confirmar no PR que tudo foi seguido

---

## 📞 SUPORTE

### Dúvidas sobre o Processo

- Consultar documentação em `/docs/`
- Revisar PRs anteriores aprovados
- Perguntar ao time de desenvolvimento

### Problemas com Testes

- Verificar logs de erro
- Consultar documentação do Playwright
- Revisar testes existentes como exemplo

### Problemas com Deploy

- Verificar logs do GitHub Actions
- Verificar logs do Vercel/Railway
- Executar validação local primeiro

---

## 🎯 RESUMO RÁPIDO

**Antes de QUALQUER entrega:**

1. ✅ Consultar `CHECKLIST.md`
2. ✅ Executar `./scripts/pre-deploy-check.sh`
3. ✅ Executar `npm test`
4. ✅ Testar manualmente em 3 dispositivos
5. ✅ Criar PR usando template
6. ✅ Marcar TODOS os checkboxes
7. ✅ Aguardar aprovação
8. ✅ Merge e deploy

**Se TODOS os passos estiverem ✅, pode fazer deploy!**

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** Ativo e Obrigatório
