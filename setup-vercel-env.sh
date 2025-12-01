#!/bin/bash

# Script para configurar variáveis de ambiente no Vercel
# Projeto: elevare-landing
# Data: 28/11/2025

PROJECT_ID="prj_5FJvieLTebY8QYVkfTt6TIxBmBZB"
TEAM_ID="team_FSsTadUj3sUky4qsEwuAmqfF"

# Variáveis de ambiente
SUPABASE_URL="https://gpebqonriekmthxxuezf.supabase.co"
SUPABASE_KEY="***REMOVED***CI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdwZWJxb25yaWVrbXRoeHh1ZXpmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzNTM4MjAsImV4cCI6MjA3OTkyOTgyMH0.bBTl-Zs55_4S-lXVXo2mirhSs05z789L5tkZoiFnmBE"

echo "⚠️  INSTRUÇÕES MANUAIS"
echo ""
echo "Acesse: https://vercel.com/carine-s-projects-cfb1ce2d/elevare-landing/settings/environment-variables"
echo ""
echo "Adicione as seguintes variáveis:"
echo ""
echo "1. VITE_SUPABASE_URL"
echo "   Valor: $SUPABASE_URL"
echo "   Ambiente: Production"
echo ""
echo "2. VITE_SUPABASE_ANON_KEY"
echo "   Valor: $SUPABASE_KEY"
echo "   Ambiente: Production"
echo ""
echo "Após adicionar, faça Redeploy em:"
echo "https://vercel.com/carine-s-projects-cfb1ce2d/elevare-landing"
