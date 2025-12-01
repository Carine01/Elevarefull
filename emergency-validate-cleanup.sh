#!/bin/bash
# emergency-validate-cleanup.sh
# Uso: chmod +x emergency-validate-cleanup.sh && ./emergency-validate-cleanup.sh

set -e

echo "🚨 VALIDANDO LIMPEZA DO HISTÓRICO REMOTO"
echo "========================================="

# Clone fresh do remoto (não use cache local)
cd /home/ubuntu
rm -rf temp-check.git 2>/dev/null || true

git clone --mirror https://github.com/iaraelevare-source/Elevare-FullStack.git temp-check.git
cd temp-check.git

# Busca por qualquer vestígio da key
SECRETS=$(git log --all -p -S "eyJhbGciOiJIUzI1NiIsInR5c" --oneline | wc -l)

if [ "$SECRETS" -eq 0 ]; then
  echo "✅ SUCESSO: Histórico limpo no remoto!"
  cd ..
  rm -rf temp-check.git
  exit 0
else
  echo "❌ CRÍTICO: $SECRETS commits ainda contêm secrets!"
  echo ""
  echo "Commits problemáticos:"
  git log --all -S "eyJhbGciOiJIUzI1NiIsInR5c" --oneline
  cd ..
  rm -rf temp-check.git
  echo ""
  echo "👉 AÇÃO: Execute 'git push --force' no repositório original"
  exit 1
fi
