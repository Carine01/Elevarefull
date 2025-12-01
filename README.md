# Projeto Elevare - Backend (NestJS)

Este repositório contém o código-fonte do backend do Projeto Elevare, construído com NestJS, TypeScript e arquitetura modular. O projeto foi refatorado e otimizado para garantir **alta performance, segurança e escalabilidade**.

## 🚀 Status do Projeto (Backend)

O backend está **100% estruturado e otimizado** nos módulos críticos.

| Módulo | Status de Otimização | Foco Principal |
| :--- | :--- | :--- |
| **Segurança** | ✅ Completo | Implementação de `CsrfGuard`, `WebhookSecretGuard` e padrões de segurança. |
| **Integrações** | ✅ Completo | Lógica de Webhook (n8n/WhaTicket) refatorada com segurança e idempotência. |
| **Leads** | ✅ Otimizado | Paginação, Filtros Otimizados e Processamento Assíncrono (Filas/Bull). |
| **Agendamentos** | ✅ Otimizado | Validação de Conflitos de Horário e Notificações Assíncronas (Lembretes). |
| **Campanhas** | ✅ Otimizado | Envio de Mensagens em Massa com Processamento em Lotes (Escalabilidade). |
| **Outros Módulos** | ✅ Estrutura Básica | `Clinics`, `Mensagens`, `Fila`, `Relatorios` estão estruturados e prontos para receber a lógica de negócio. |

## 🛠️ Setup e Instalação

### Pré-requisitos

*   Node.js (v18+)
*   Docker e Docker Compose (para Banco de Dados e Redis)
*   Redis (Necessário para o Bull Queue)

### Passos

1.  **Clone o Repositório:**
    ```bash
    git clone [URL_DO_REPOSITORIO]
    cd elevare_project/backend
    ```

2.  **Instale as Dependências:**
    ```bash
    npm install
    ```

3.  **Configuração de Ambiente:**
    Crie um arquivo `.env` na pasta `backend` e copie o conteúdo de `config.example.env`. **Preencha as variáveis críticas:**
    ```bash
    # Exemplo de variáveis críticas
    DATABASE_URL=...
    REDIS_HOST=...
    ELEVARE_WEBHOOK_SECRET=SUA_CHAVE_SECRETA_AQUI
    ```

4.  **Inicie o Banco de Dados e Redis (via Docker Compose):**
    ```bash
    # Comando de exemplo, assumindo que você tem um docker-compose.yml
    docker-compose up -d postgres redis
    ```

5.  **Execute a Aplicação:**
    ```bash
    npm run start:dev
    ```

## 🧪 Testes e Qualidade

Todos os módulos otimizados possuem testes unitários e de integração.

*   **Rodar Todos os Testes:** `npm run test`
*   **Rodar Testes de Cobertura:** `npm run test:cov`

### Scripts de QA (Qualidade Assegurada)

Scripts de validação rápida para as novas funcionalidades:

*   **Validação da Integração n8n:** `sh scripts/qa/run-n8n-adapt-tests.sh`

## 🔗 Estrutura de Endpoints (Exemplos)

| Módulo | Endpoint | Método | Descrição |
| :--- | :--- | :--- | :--- |
| **Auth** | `/auth/login` | `POST` | Autenticação de usuário. |
| **Leads** | `/leads` | `GET` | Listagem paginada e filtrada de leads. |
| **Leads** | `/leads/import` | `POST` | Inicia importação de leads em segundo plano (assíncrono). |
| **Agendamentos** | `/agendamentos` | `POST` | Cria agendamento com validação de conflito. |
| **Campanhas** | `/campanhas` | `POST` | Inicia envio de campanha em massa (assíncrono). |
| **Webhooks** | `/webhooks/whaticket/payment` | `PATCH` | Webhook de pagamento seguro (protegido por `WebhookSecretGuard`). |
