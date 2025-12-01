# Instruções de Execução do Frontend Elevare (React/Vite/TypeScript)

Este arquivo contém as instruções para rodar o frontend do Elevare localmente.

## 1. Pré-requisitos

*   Node.js (versão 18+)
*   npm (gerenciador de pacotes)

## 2. Configuração Inicial

1.  **Navegue até o diretório do projeto:**
    \`\`\`bash
    cd /caminho/para/elevare_project/frontend
    \`\`\`

2.  **Instale as dependências:**
    \`\`\`bash
    npm install
    \`\`\`

## 3. Execução Local

Para rodar o projeto em modo de desenvolvimento:

\`\`\`bash
npm run dev
\`\`\`

O aplicativo estará disponível em \`http://localhost:5173\` (ou outra porta disponível).

## 4. Funcionalidades Implementadas (Frontend)

O frontend foi migrado do HTML estático para React/TypeScript e inclui as seguintes páginas:

*   **/**: Landing Page (Migrada e Implantada no GitHub Pages)
*   **/login**: Página de Login (Pronta para integração com o backend)
*   **/dashboard**: Dashboard Principal (Pronta para receber métricas do backend)
*   **/leads**: Listagem de Leads/Clientes (Pronta para receber dados do LeadsService)
*   **/agendamentos**: Agendamentos (Pronta para receber dados do AgendamentosService)
*   **/campanhas**: Automação de Campanhas (Pronta para receber dados do MensagensService)
*   **/relatorios**: Relatórios e Métricas (Pronta para receber dados do RelatoriosService)

**Próximos Passos (Integração com Backend):**

O próximo passo no desenvolvimento é a integração real de cada uma dessas páginas com os respectivos serviços do backend (AuthModule, LeadsService, AgendamentosService, etc.).
