#!/bin/bash
# Script de Setup Automático - Elevare-FullStack (Linux/Mac)
# Uso: chmod +x setup-local.sh && ./setup-local.sh

set -e

echo "========================================"
echo "  ELEVARE SETUP - SEM DOCKER"
echo "========================================"
echo ""

# Verificar se Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "[ERRO] Node.js não encontrado!"
    echo "Por favor, instale Node.js: https://nodejs.org"
    exit 1
fi

echo "[OK] Node.js encontrado: $(node -v)"
echo ""

# Instalar dependências do backend
echo "[1/3] Instalando dependências do backend..."
cd backend
npm install
echo "[OK] Dependências do backend instaladas"
echo ""

# Verificar se .env existe
if [ ! -f ".env" ]; then
    echo "[AVISO] Arquivo .env não encontrado!"
    echo "Copiando config.example.env para .env..."
    cp config.example.env .env
    echo ""
    echo "[IMPORTANTE] Edite o arquivo backend/.env e preencha suas keys do Supabase!"
    echo "Pressione Enter para continuar..."
    read
fi

# Voltar para a raiz
cd ..

# Instalar dependências do frontend (se houver)
echo "[2/3] Verificando frontend..."
cd frontend-landing
if [ -f "package.json" ]; then
    echo "Instalando dependências do frontend..."
    npm install
fi
cd ..
echo "[OK] Frontend verificado"
echo ""

# Instalar dependências da raiz
echo "[3/3] Instalando dependências da raiz..."
npm install
echo "[OK] Dependências da raiz instaladas"
echo ""

echo "========================================"
echo "  SETUP CONCLUÍDO!"
echo "========================================"
echo ""
echo "Próximos passos:"
echo "1. Edite o arquivo backend/.env com suas keys do Supabase"
echo "2. Execute 'cd backend && npm run start:dev' para iniciar a API"
echo "3. Abra frontend-landing/index.html no navegador"
echo ""
