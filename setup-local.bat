@echo off
REM Script de Setup Automático - Elevare-FullStack (Windows)
REM Uso: Clique duas vezes neste arquivo ou execute "setup-local.bat" no terminal

echo ========================================
echo   ELEVARE SETUP - SEM DOCKER
echo ========================================
echo.

REM Verificar se Node.js está instalado
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Node.js nao encontrado!
    echo Por favor, instale Node.js: https://nodejs.org
    pause
    exit /b 1
)

echo [OK] Node.js encontrado: 
node -v
echo.

REM Instalar dependências do backend
echo [1/3] Instalando dependencias do backend...
cd backend
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao instalar dependencias do backend
    pause
    exit /b 1
)
echo [OK] Dependencias do backend instaladas
echo.

REM Verificar se .env existe
if not exist ".env" (
    echo [AVISO] Arquivo .env nao encontrado!
    echo Copiando config.example.env para .env...
    copy config.example.env .env
    echo.
    echo [IMPORTANTE] Edite o arquivo backend\.env e preencha suas keys do Supabase!
    echo Pressione qualquer tecla para abrir o arquivo .env no Notepad...
    pause >nul
    notepad .env
)

REM Voltar para a raiz
cd ..

REM Instalar dependências do frontend (se houver)
echo [2/3] Verificando frontend...
cd frontend-landing
if exist "package.json" (
    echo Instalando dependencias do frontend...
    call npm install
)
cd ..
echo [OK] Frontend verificado
echo.

REM Instalar dependências da raiz
echo [3/3] Instalando dependencias da raiz...
call npm install
echo [OK] Dependencias da raiz instaladas
echo.

echo ========================================
echo   SETUP CONCLUIDO!
echo ========================================
echo.
echo Proximos passos:
echo 1. Edite o arquivo backend\.env com suas keys do Supabase
echo 2. Execute "npm run start:dev" no backend para iniciar a API
echo 3. Abra frontend-landing\index.html no navegador
echo.
echo Pressione qualquer tecla para sair...
pause >nul
