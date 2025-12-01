# CHANGELOG - Projeto Elevare Backend

Este arquivo registra todas as mudanças significativas e otimizações realizadas no backend do Projeto Elevare.

## [1.3.0] - 2025-11-26 - Otimização de Campanhas (Escalabilidade)

### 🚀 Otimizações Críticas de Performance e Escalabilidade

- **Módulo de Campanhas:**
  - Implementado processamento assíncrono em lotes (`CampanhasProcessor` e `addBulk`).
  - Endpoint de envio de campanha agora retorna `202 Accepted` (Assíncrono).
  - Adicionada tolerância a falhas (retry) no envio de mensagens.

## [1.2.0] - 2025-11-26 - Otimização de Agendamentos (Confiabilidade)

### 🚀 Otimizações Críticas de Performance e Escalabilidade

- **Módulo de Agendamentos:**
  - Implementada **Validação de Conflitos de Horário** (`ConflictException`).
  - Implementado processamento assíncrono para **Lembretes** (enfileiramento com `delay` preciso).

## [1.1.0] - 2025-11-26 - Otimização de Leads e Integração n8n

### 🚀 Otimizações Críticas de Performance e Escalabilidade

- **Módulo de Leads:**
  - Implementada **Paginação** (`Limit/Offset`) e lógica de **Filtros Otimizados**.
  - Implementado processamento assíncrono para **Importação em Massa** (`LeadsProcessor`).

### 🛡️ Segurança e Arquitetura

- **Integrações:**
  - Lógica de fluxo n8n (Webhook de Pagamento) refatorada e integrada ao `IntegrationsModule` com idempotência.
  - Criação dos artefatos de documentação `n8n-mapping.md` e `n8n-decisions.md`.
- **Segurança:**
  - Implementado `WebhookSecretGuard` para proteger endpoints críticos de webhook.

## [1.0.0] - 2025-11-26 - Estrutura Base e Validação Funcional

### 🏗️ Estrutura e Validação

- **Estrutura:** Criação da estrutura básica (Module, Service, Controller) para todos os módulos declarados (`Clinics`, `Mensagens`, `Fila`, `Webhooks`, `Relatorios`).
- **Base:** Projeto base em NestJS, com estrutura modular e padrões de código estabelecidos.
