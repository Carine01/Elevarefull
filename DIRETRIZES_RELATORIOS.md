# 📊 DIRETRIZES PARA RELATÓRIOS TÉCNICOS SEM ALUCINAÇÃO

**Versão:** 1.0  
**Data:** 28/11/2025  
**Status:** Obrigatório para Sistema Manus e Desenvolvedores

---

## 🎯 OBJETIVO

Garantir que todos os relatórios técnicos sejam **comprováveis**, **rastreáveis** e **livres de suposições** ou dados inventados ("alucinações"). Cada afirmação deve ser baseada em evidências objetivas e verificáveis.

---

## 📋 PRINCÍPIOS FUNDAMENTAIS

### 1. Evidenciar Tudo que For Afirmado

**Regra:** Sempre cite arquivos, commits, prints, comandos ou links reais.

**✅ Exemplo Correto:**
```markdown
O arquivo index.html foi atualizado no commit 80861af.
Verificação: `git show 80861af:frontend-landing/index.html`
```

**❌ Exemplo Incorreto:**
```markdown
O arquivo index.html foi atualizado recentemente.
```

**Como Aplicar:**
- Use `git log` para verificar commits
- Use `ls -la` para confirmar existência de arquivos
- Use `grep` para confirmar presença de código
- Inclua comandos de verificação no relatório

---

### 2. Evitar Métricas Sem Fonte Clara

**Regra:** Só utilize taxas, notas ou percentuais se houver cálculo/documentação explícita.

**✅ Exemplo Correto:**
```markdown
Dos 13 itens auditados, 10 estavam corretos (76,9%).
Cálculo: 10 ÷ 13 × 100 = 76,92%
Fonte: Planilha de auditoria em /docs/auditoria.xlsx
```

**❌ Exemplo Incorreto:**
```markdown
A precisão aumentou para 80%.
```

**Como Aplicar:**
- Sempre mostre o cálculo
- Cite a fonte dos dados
- Use tabelas para transparência
- Evite números "redondos" sem justificativa

---

### 3. Confirmar Existência de Arquivos/Documentos

**Regra:** Antes de citar backups, roadmaps ou documentos técnicos, verifique se realmente existem.

**✅ Exemplo Correto:**
```markdown
O backup landing_page_production.html está salvo em /backups/.
Verificação: `ls -lh /backups/landing_page_production.html`
Tamanho: 49.688 bytes
Data: 28/11/2025 14:32
```

**❌ Exemplo Incorreto:**
```markdown
O backup foi criado e está seguro.
```

**Como Aplicar:**
- Execute `ls`, `find` ou `file` antes de citar
- Inclua metadados (tamanho, data, permissões)
- Use caminhos absolutos
- Verifique hash MD5/SHA256 para arquivos críticos

---

### 4. Explicar Critérios de Avaliação

**Regra:** Se atribuir notas ou avaliações, explique o critério utilizado.

**✅ Exemplo Correto:**
```markdown
Nota: 8,5/10

Critério de Avaliação:
- Funcionalidade (3/3 pontos) - Todos os recursos funcionam
- Performance (2,5/3 pontos) - Lighthouse 92/100
- Segurança (2/2 pontos) - Sem vulnerabilidades
- Documentação (1/2 pontos) - Parcialmente documentado

Total: 8,5/10
```

**❌ Exemplo Incorreto:**
```markdown
O projeto está muito bom, nota 8,5/10.
```

**Como Aplicar:**
- Defina critérios antes de avaliar
- Use escala numérica clara
- Justifique cada nota parcial
- Documente o sistema de pontuação

---

### 5. Usar Linguagem Condicional Quando Necessário

**Regra:** Se não for possível confirmar algum dado, use termos como "segundo registro", "conforme informado", ou "caso exista".

**✅ Exemplo Correto:**
```markdown
Segundo o roadmap documentado em /docs/roadmap.md (verificado em 28/11/2025),
as próximas etapas são: implementação de autenticação e dashboard.

Nota: Arquivo roadmap.md existe e foi modificado em 15/11/2025.
```

**❌ Exemplo Incorreto:**
```markdown
As próximas etapas são implementação de autenticação e dashboard.
```

**Como Aplicar:**
- Use "segundo", "conforme", "de acordo com"
- Cite fonte e data de verificação
- Indique quando não há certeza absoluta
- Diferencie fatos de interpretações

---

### 6. Evitar Generalizações

**Regra:** Não afirme que algo está "pronto", "completo" ou "funcional" sem evidência objetiva.

**✅ Exemplo Correto:**
```markdown
Status da Landing Page:

Funcionalidades Implementadas (Verificadas em 28/11/2025):
- ✅ Formulário de captura de leads (testado manualmente)
- ✅ Modal de planos (abre/fecha corretamente)
- ✅ Animações WebGL (shader.js carregando)

Funcionalidades Documentadas mas NÃO Implementadas:
- ❌ Sistema de autenticação (arquivos auth.js, api.js não existem)
- ❌ Dashboard do cliente (dashboard.html existe mas sem funcionalidade)

Verificação: `ls -la frontend-landing/js/`
Resultado: Apenas main.js e modal-pricing.js presentes
```

**❌ Exemplo Incorreto:**
```markdown
A landing page está pronta e funcional.
```

**Como Aplicar:**
- Liste itens específicos
- Use checkboxes (✅/❌)
- Inclua comandos de verificação
- Diferencie "implementado" de "documentado"

---

## ✅ CHECKLIST OBRIGATÓRIO ANTES DE ENVIAR RELATÓRIO

Antes de finalizar qualquer relatório técnico, verifique:

- [ ] **Todos os dados citados têm fonte comprovável?**
  - Commits, arquivos, comandos estão documentados?
  
- [ ] **Métricas e notas têm cálculo/documentação?**
  - Percentuais mostram o cálculo?
  - Notas explicam critérios?
  
- [ ] **Arquivos/documentos citados realmente existem?**
  - Executei `ls`, `find` ou `git log` para confirmar?
  - Inclui metadados (tamanho, data)?
  
- [ ] **Critérios de avaliação estão claros?**
  - Sistema de pontuação está explicado?
  - Cada nota parcial está justificada?
  
- [ ] **Linguagem é precisa e rastreável?**
  - Usei "segundo", "conforme" quando apropriado?
  - Diferenciei fatos de interpretações?
  
- [ ] **Evitei generalizações?**
  - Não usei "pronto", "completo" sem evidência?
  - Listei itens específicos com status claro?

---

## 📝 TEMPLATE DE RELATÓRIO TÉCNICO

Use este template para garantir conformidade:

```markdown
# [TÍTULO DO RELATÓRIO]

**Data:** [DD/MM/AAAA]  
**Responsável:** [Nome]  
**Versão:** [X.Y]

---

## 1. CONTEXTO

[Descreva o contexto do relatório]

---

## 2. METODOLOGIA

**Comandos Executados:**
```bash
[Liste comandos usados para coleta de dados]
```

**Arquivos Analisados:**
- [arquivo1] (verificado em DD/MM/AAAA)
- [arquivo2] (verificado em DD/MM/AAAA)

---

## 3. RESULTADOS

### 3.1 Funcionalidades Implementadas

| Item | Status | Evidência | Verificação |
|------|--------|-----------|-------------|
| [Nome] | ✅ | [Descrição] | `[comando]` |

### 3.2 Funcionalidades Documentadas mas NÃO Implementadas

| Item | Status | Evidência | Verificação |
|------|--------|-----------|-------------|
| [Nome] | ❌ | [Descrição] | `[comando]` |

---

## 4. MÉTRICAS

**[Métrica 1]:** [Valor]
- Cálculo: [Fórmula]
- Fonte: [Arquivo/Comando]

---

## 5. AVALIAÇÃO

**Nota Geral:** [X.Y]/10

**Critérios:**
- [Critério 1]: [X]/[Y] pontos - [Justificativa]
- [Critério 2]: [X]/[Y] pontos - [Justificativa]

---

## 6. RECOMENDAÇÕES

[Liste recomendações baseadas em evidências]

---

## 7. ANEXOS

**Comandos de Verificação:**
```bash
[Comandos para reproduzir análise]
```

**Arquivos de Evidência:**
- [arquivo1.txt]
- [screenshot1.png]

---

**Última atualização:** [DD/MM/AAAA]
```

---

## 🔍 EXEMPLOS PRÁTICOS

### Exemplo 1: Relatório de Status de Funcionalidade

**❌ VERSÃO COM ALUCINAÇÃO:**
```markdown
O sistema de autenticação está implementado e funcionando perfeitamente.
Os usuários podem fazer login e logout sem problemas.
```

**✅ VERSÃO SEM ALUCINAÇÃO:**
```markdown
Status do Sistema de Autenticação (Verificado em 28/11/2025):

Arquivos Esperados:
- js/auth.js - ❌ NÃO EXISTE
- js/api.js - ❌ NÃO EXISTE
- js/app.js - ✅ EXISTE (mas sem funções de auth)

Verificação:
```bash
$ ls -la frontend-landing/js/
total 24
-rw-r--r-- 1 user user 8234 Nov 28 14:32 main.js
-rw-r--r-- 1 user user 3456 Nov 28 14:32 modal-pricing.js
```

Funções de Autenticação Esperadas em app.js:
```bash
$ grep -n "function.*auth\|function.*login\|function.*logout" frontend-landing/js/app.js
[Nenhum resultado]
```

**Conclusão:** Sistema de autenticação NÃO está implementado.
Apenas documentado em CHECKLIST.md e testes automatizados.
```

### Exemplo 2: Relatório de Performance

**❌ VERSÃO COM ALUCINAÇÃO:**
```markdown
A performance da landing page melhorou significativamente.
Agora está muito mais rápida.
```

**✅ VERSÃO SEM ALUCINAÇÃO:**
```markdown
Performance da Landing Page (Medida em 28/11/2025):

Ferramenta: Google Lighthouse (Chrome DevTools)
URL Testada: https://elevare-landing.vercel.app
Condições: Desktop, 4G simulado

Resultados:
- Performance: 92/100
- Accessibility: 98/100
- Best Practices: 95/100
- SEO: 100/100

Métricas Principais:
- First Contentful Paint: 1.2s
- Largest Contentful Paint: 2.1s
- Total Blocking Time: 150ms
- Cumulative Layout Shift: 0.05

Comparação com Baseline (15/11/2025):
- Performance: 88/100 → 92/100 (+4 pontos)
- LCP: 2.5s → 2.1s (-0.4s)

Evidência: Screenshot do Lighthouse em /evidencias/lighthouse-28-11-2025.png
```

---

## 🎓 TREINAMENTO

### Para o Sistema Manus

**Antes de gerar QUALQUER relatório:**

1. Execute comandos de verificação
2. Salve outputs em arquivos temporários
3. Use apenas dados desses outputs
4. Cite comandos e arquivos no relatório
5. Revise usando checklist acima

### Para Desenvolvedores

**Ao revisar relatórios do Manus:**

1. Verifique se há citações de arquivos
2. Execute comandos mencionados para confirmar
3. Questione métricas sem fonte
4. Exija evidências para afirmações
5. Aprove apenas relatórios conformes

---

## 🔄 PROCESSO DE REVISÃO

### Revisão de Relatório (3 Níveis)

**Nível 1: Auto-Revisão (Manus)**
- Executar checklist acima
- Confirmar existência de arquivos citados
- Verificar cálculos de métricas

**Nível 2: Revisão Técnica (Desenvolvedor)**
- Reproduzir comandos de verificação
- Validar evidências
- Confirmar interpretações

**Nível 3: Aprovação Final (Usuário)**
- Revisar conclusões
- Validar recomendações
- Aprovar para uso

---

## 📊 MÉTRICAS DE QUALIDADE DE RELATÓRIOS

### Indicadores de Relatório de Alta Qualidade

- **Taxa de Citações:** > 80% das afirmações têm fonte
- **Taxa de Verificação:** 100% dos arquivos citados existem
- **Taxa de Cálculo:** 100% das métricas mostram cálculo
- **Taxa de Evidência:** > 90% das conclusões têm evidência
- **Taxa de Reprodutibilidade:** 100% dos comandos são reproduzíveis

### Como Medir

```bash
# Contar afirmações com citação
grep -c "\`\`\`" relatorio.md

# Verificar arquivos citados
grep -o "/[a-zA-Z0-9/_.-]*\.(js|md|html|json)" relatorio.md | while read f; do
    [ -f "$f" ] && echo "✅ $f" || echo "❌ $f"
done
```

---

## 🚫 ANTI-PADRÕES COMUNS

### Anti-Padrão 1: "Tudo Está Pronto"

**❌ Problema:**
```markdown
O projeto está completo e pronto para produção.
```

**✅ Solução:**
```markdown
Status do Projeto (28/11/2025):

Módulos Implementados: 3/7 (42,9%)
- ✅ Landing page
- ✅ Captura de leads
- ✅ Modal de planos
- ❌ Autenticação
- ❌ Dashboard
- ❌ API backend
- ❌ Pagamentos

Bloqueadores para Produção:
1. Sistema de autenticação não implementado
2. Backend não configurado
3. Testes automatizados falhando (0/60 passando)
```

### Anti-Padrão 2: "Performance Melhorou"

**❌ Problema:**
```markdown
A performance melhorou muito.
```

**✅ Solução:**
```markdown
Performance (Comparação):

Baseline (15/11/2025):
- Lighthouse: 88/100
- LCP: 2.5s

Atual (28/11/2025):
- Lighthouse: 92/100
- LCP: 2.1s

Melhoria:
- Score: +4 pontos (+4,5%)
- LCP: -0,4s (-16%)

Evidência: 
- lighthouse-baseline.json
- lighthouse-atual.json
```

### Anti-Padrão 3: "Testes Passando"

**❌ Problema:**
```markdown
Todos os testes estão passando.
```

**✅ Solução:**
```markdown
Status dos Testes (28/11/2025):

Testes Criados: 60
Testes Executados: 0
Testes Passando: 0

Motivo: Playwright não instalado ainda

Comando de Verificação:
```bash
$ cd frontend-landing && npm test
npm ERR! Missing script: "test"
```

**Conclusão:** Testes foram CRIADOS mas nunca EXECUTADOS.
```

---

## 📞 SUPORTE

### Dúvidas sobre Diretrizes

- Consultar este documento
- Revisar exemplos práticos
- Usar template fornecido

### Problemas com Verificação

- Executar comandos manualmente
- Salvar outputs em arquivos
- Incluir evidências no relatório

---

## 🎯 RESUMO EXECUTIVO

**Para o Sistema Manus:**

1. ✅ Sempre execute comandos de verificação
2. ✅ Cite arquivos, commits, comandos
3. ✅ Mostre cálculos de métricas
4. ✅ Use linguagem condicional quando apropriado
5. ✅ Evite generalizações sem evidência
6. ✅ Revise usando checklist antes de enviar

**Se seguir estas diretrizes, seus relatórios serão 100% confiáveis e livres de alucinação.**

---

**Última atualização:** 28/11/2025  
**Responsável:** Sistema Manus  
**Status:** ✅ Ativo e Obrigatório
