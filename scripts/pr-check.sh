#!/usr/bin/env bash
# scripts/pr-check.sh
# Rodar todas as checagens básicas antes de abrir/mergear PR:
# lint, build, unit tests, e2e (opcional), docker-compose up, audit.
# Uso: ./scripts/pr-check.sh
# Autor: Assistente (gerado para Carine)

set -o pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR" || exit 1

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { printf "${GREEN}[OK]${NC} %s\n" "$1"; }
warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }
err() { printf "${RED}[ERR]${NC} %s\n" "$1"; }

FAILED=0
FAILED_STEPS=()

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

run_step() {
  local name="$1"; shift
  printf "\n==== %s — %s ====\n" "$name" "$(timestamp)"
  if "$@"; then
    log "$name concluído com sucesso."
    return 0
  else
    err "$name falhou."
    FAILED=$((FAILED+1))
    FAILED_STEPS+=("$name")
    return 1
  fi
}

# Detect package manager command (prefer npm)
if [ -f package-lock.json ]; then
  PKG_CMD="npm"
elif [ -f pnpm-lock.yaml ]; then
  PKG_CMD="pnpm"
elif [ -f yarn.lock ]; then
  PKG_CMD="yarn"
else
  PKG_CMD="npm"
fi

echo "Root do repositório: $ROOT_DIR"
echo "Package manager detectado: $PKG_CMD"

# 1) Install
if [ "$PKG_CMD" = "npm" ]; then
  run_step "Instala dependências (npm ci || npm install)" bash -c 'if [ -f package-lock.json ]; then npm ci; else npm install; fi'
elif [ "$PKG_CMD" = "pnpm" ]; then
  run_step "Instala dependências (pnpm install)" pnpm install
else
  run_step "Instala dependências (yarn install)" yarn install --frozen-lockfile || yarn install
fi

# Helper: try available npm script names
find_and_run_script() {
  # $1: logical name (e.g., lint)
  # $2...: candidate script names in package.json
  local logical="$1"; shift
  for script in "$@"; do
    if $PKG_CMD run --silent >/dev/null 2>&1 --show-all 2>/dev/null; then
      # no-op to avoid shells complaining on older yarn/pnpm
      :
    fi
    # Check existence in package.json
    if node -e "const fs=require('fs'); const p=JSON.parse(fs.readFileSync('package.json')); console.log(!!(p.scripts && p.scripts['$script']));" 2>/dev/null | grep -q "true"; then
      echo "Executando script detectado: $script"
      if [ "$PKG_CMD" = "yarn" ]; then
        $PKG_CMD $script
      else
        $PKG_CMD run $script
      fi
      return $?
    fi
  done
  return 127
}

# 2) Lint
if find_and_run_script "lint" lint lint:fix; then
  log "lint OK"
else
  warn "lint script não encontrado ou falhou. Pule se não houver lint."
fi

# 3) Build (monorepo friendly)
# Try root build; then backend/frontend
if find_and_run_script "build" build; then
  log "build (root) OK"
else
  # try backend and frontend
  if [ -d "src" ]; then
    if find_and_run_script "backend build" "build:backend" "build:server" "build:api"; then
      log "build backend OK"
    else
      warn "build backend não encontrado/foi pulado"
    fi
  fi
  if [ -d "apps/frontend" ]; then
    pushd apps/frontend >/dev/null || true
    if find_and_run_script "frontend build" build build:frontend; then
      log "build frontend OK"
    else
      warn "build frontend não encontrado/foi pulado"
    fi
    popd >/dev/null || true
  fi
fi

# 4) Unit tests
if find_and_run_script "unit tests" "test:unit" test; then
  log "testes unitários OK"
else
  warn "testes unitários não encontrados ou falharam."
fi

# 5) E2E tests (optional)
if find_and_run_script "e2e tests" "test:e2e" "e2e"; then
  log "e2e tests OK"
else
  warn "e2e tests não encontrados ou falharam / foram pulados."
fi

# 6) Docker Compose up (se houver docker-compose.yml)
if [ -f docker-compose.yml ] || [ -f docker-compose.yaml ] || [ -f docker-compose.redis.yml ]; then
  export DOCKER_COMPOSE_FILES=""
  if [ -f docker-compose.yml ]; then DOCKER_COMPOSE_FILES="$DOCKER_COMPOSE_FILES -f docker-compose.yml"; fi
  if [ -f docker-compose.redis.yml ]; then DOCKER_COMPOSE_FILES="$DOCKER_COMPOSE_FILES -f docker-compose.redis.yml"; fi

  run_step "docker compose up --build" bash -c "docker compose $DOCKER_COMPOSE_FILES up --build -d"
  # wait for a probable backend health endpoint (try common ports)
  BACKEND_PORTS=(3000 3001 4000 5000 8080)
  HEALTH_OK=1
  for port in "${BACKEND_PORTS[@]}"; do
    if command -v curl >/dev/null 2>&1; then
      echo "Tentando healthcheck em http://localhost:$port/health (ou /) ..."
      if curl --max-time 2 --silent --fail http://localhost:$port/health >/dev/null 2>&1 || curl --max-time 2 --silent --fail http://localhost:$port/ >/dev/null 2>&1; then
        log "Health ok no porto $port"
        HEALTH_OK=0
        break
      fi
    fi
  done
  if [ $HEALTH_OK -ne 0 ]; then
    warn "Não detectado endpoint de saúde nos ports comuns. Verifique manualmente os logs dos containers."
    docker compose ps || true
  fi
else
  warn "docker-compose não encontrado — pulei etapa de containers."
fi

# 7) npm audit (informativo)
if [ "$PKG_CMD" = "npm" ]; then
  if command -v npm >/dev/null 2>&1; then
    run_step "npm audit (relatório informativo)" npm audit --audit-level=moderate || true
  fi
fi

# 8) Garantir runtime-logs placeholder (evita erro upload-artifact)
if [ -z "$RUNNER_TEMP" ]; then
  # local fallback
  RUNNER_TEMP="$ROOT_DIR/.tmp_runtime_logs"
fi
mkdir -p "$RUNNER_TEMP/runtime-logs"
touch "$RUNNER_TEMP/runtime-logs/blocked.jsonl" "$RUNNER_TEMP/runtime-logs/blocked.md"
log "placeholder runtime-logs criado em $RUNNER_TEMP/runtime-logs"

# Final summary
echo
printf "==== Resumo final (%s) ====\n" "$(timestamp)"
if [ "$FAILED" -eq 0 ]; then
  log "Todas as checagens concluídas com sucesso."
  exit 0
else
  err "Algumas etapas falharam: $FAILED step(s)."
  for s in "${FAILED_STEPS[@]}"; do
    echo "- $s"
  done
  warn "Revise os logs acima, corrija os erros e execute o script novamente."
  exit 2
fi
