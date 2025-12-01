# Instruções de Execução do Projeto Elevare (Frontend + Backend)

Este arquivo contém as instruções para rodar o projeto Elevare completo (Frontend em React e Backend em NestJS) localmente.

## 1. Pré-requisitos

*   Node.js (versão 18+)
*   npm (gerenciador de pacotes)
*   Docker (para o banco de dados PostgreSQL)

## 2. Configuração do Backend (NestJS)

1.  **Navegue até o diretório do backend:**
    \`\`\`bash
    cd /caminho/para/elevare_project/backend
    \`\`\`

2.  **Instale as dependências:**
    \`\`\`bash
    npm install
    \`\`\`

3.  **Configure o Banco de Dados (Docker):**
    O projeto utiliza PostgreSQL. Você precisará de um arquivo \`.env\` no diretório \`backend\` com as configurações do banco de dados.

    Exemplo de \`.env\` (crie este arquivo):
    \`\`\`
    DATABASE_URL="postgresql://user:password@localhost:5432/elevare_db"
    JWT_SECRET="sua_chave_secreta_aqui"
    # Outras variáveis de ambiente do NestJS
    \`\`\`

4.  **Execute as Migrações do Prisma:**
    \`\`\`bash
    npx prisma migrate dev --name init
    \`\`\`

5.  **Inicie o Backend:**
    \`\`\`bash
    npm run start:dev
    \`\`\`
    O backend estará rodando em \`http://localhost:3000\`.

## 3. Configuração do Frontend (React/Vite)

1.  **Navegue até o diretório do frontend:**
    \`\`\`bash
    cd /caminho/para/elevare_project/frontend
    \`\`\`

2.  **Instale as dependências:**
    \`\`\`bash
    npm install
    \`\`\`

3.  **Configure a URL da API:**
    O arquivo \`.env.development\` já está configurado para \`VITE_API_URL=http://localhost:3000/api\`.

4.  **Inicie o Frontend:**
    \`\`\`bash
    npm run dev
    \`\`\`
    O frontend estará rodando em \`http://localhost:5173\`.

## 4. Teste de Autenticação

*   **URL de Login:** Acesse \`http://localhost:5173/login\`.
*   **Credenciais de Teste:** Use as credenciais de um usuário que você cadastrou no banco de dados via seed ou API.

## 5. Funcionalidades Integradas

Todas as páginas do CRM estão conectadas aos respectivos serviços do backend:

*   **Login:** Conectado ao \`AuthModule\`.
*   **Dashboard:** Conectado ao \`ReportsModule\`, \`LeadsModule\` e \`AgendamentosModule\`.
*   **Leads:** Conectado ao \`LeadsModule\`.
*   **Agendamentos:** Conectado ao \`AgendamentosModule\`.
*   **Campanhas:** Conectado ao \`CampanhasModule\`.
*   **Relatórios:** Conectado ao \`ReportsModule\`.

O projeto Elevare está agora completo em termos de estrutura e integração de API.
