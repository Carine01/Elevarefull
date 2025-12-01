# 🚀 Guia de Setup Local - Elevare-FullStack (Sem Docker)

**Objetivo:** Configurar e rodar o projeto completo (backend e frontend) na sua máquina local sem precisar de Docker.

**Tempo Estimado:** 15-20 minutos

---

## 📋 Pré-requisitos

Antes de começar, você precisa ter instalado:

1.  **Node.js (versão 18 ou superior):**
    -   **Download:** https://nodejs.org/en/download/
    -   **Verificar versão:** `node -v`

2.  **Git:**
    -   **Download:** https://git-scm.com/downloads
    -   **Verificar versão:** `git --version`

3.  **Um editor de código (recomendado):**
    -   **VS Code:** https://code.visualstudio.com/download

---

## ⚙️ PASSO 1: Clonar o Repositório

Abra seu terminal (ou Git Bash no Windows) e clone o projeto:

```bash
# Clone o repositório
git clone https://github.com/iaraelevare-source/Elevare-FullStack.git

# Entre na pasta do projeto
cd Elevare-FullStack
```

---

## ⚙️ PASSO 2: Configurar o Backend

O backend é responsável pela API e lógica de negócio.

```bash
# 1. Entre na pasta do backend
cd backend

# 2. Instale as dependências
npm install

# 3. Crie o arquivo de variáveis de ambiente
# Copie o arquivo de exemplo
cp config.example.env .env
```

**Agora, edite o arquivo `.env`** e preencha com suas keys do Supabase:

```env
# .env (no backend)

# Supabase
SUPABASE_URL=https://gpebqonriekmthxxuezf.supabase.co
SUPABASE_ANON_KEY=SUA_NOVA_ANON_KEY_AQUI
SUPABASE_SERVICE_ROLE_KEY=SUA_SERVICE_ROLE_KEY_AQUI

# JWT
JWT_SECRET=SEGREDO_ALEATORIO_PARA_JWT
JWT_EXPIRATION_TIME=3600

# Database (já configurado para Supabase)
DB_TYPE=postgres
DB_HOST=db.gpebqonriekmthxxuezf.supabase.co
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=SUA_SENHA_DO_BANCO_SUPABASE
DB_DATABASE=postgres
```

**Para rodar o backend:**

```bash
# Inicie o backend em modo de desenvolvimento
npm run start:dev
```

O backend estará rodando em `http://localhost:3000`.

---

## ⚙️ PASSO 3: Configurar o Frontend

O frontend é a landing page que o usuário vê.

```bash
# 1. Volte para a raiz do projeto
cd ..

# 2. Entre na pasta do frontend
cd frontend-landing

# 3. Instale as dependências (se houver)
# (Este frontend não tem dependências, então este passo é opcional)

# 4. Crie o arquivo de variáveis de ambiente
# (Este frontend não precisa de .env, ele se conecta ao backend)
```

**Para rodar o frontend:**

Simplesmente abra o arquivo `index.html` no seu navegador!

- **Clique duas vezes** no arquivo `frontend-landing/index.html`
- Ou arraste o arquivo para uma aba do seu navegador

O frontend se conectará automaticamente ao backend rodando em `http://localhost:3000`.

---

## ✅ PASSO 4: Testar a Aplicação

1.  **Abra o backend** em um terminal (`cd backend && npm run start:dev`)
2.  **Abra o frontend** em outro terminal (ou abra o `index.html`)
3.  **Preencha o formulário de leads** na landing page
4.  **Verifique no Supabase Dashboard** se o lead foi capturado

---

## Troubleshooting

- **Erro `nest: command not found`:**
  -   Execute `npm install -g @nestjs/cli`

- **Erro de CORS:**
  -   Verifique se o backend está rodando
  -   Verifique se o frontend está se conectando ao endereço correto (`http://localhost:3000`)

- **Erro de dependência:**
  -   Apague a pasta `node_modules` e o arquivo `package-lock.json`
  -   Execute `npm install` novamente

---

Pronto! Com esses passos, você terá o ambiente completo rodando na sua máquina local. 💪
