/**
 * Script de Obfuscação de Código JavaScript
 * Elevare Landing Page
 * 
 * ⚠️ IMPORTANTE: Este script NÃO sobrescreve arquivos originais!
 * - Lê de: frontend-landing/js/
 * - Grava em: frontend-landing/dist/js/
 * 
 * Uso: npm run obfuscate (APENAS antes de deploy)
 */

const JavaScriptObfuscator = require("javascript-obfuscator");
const fs = require("fs");
const path = require("path");

// Pastas de entrada e saída (SEPARADAS!)
const inputFolder = "./frontend-landing/js";
const outputFolder = "./frontend-landing/dist/js";

// Criar pasta de saída se não existir
if (!fs.existsSync(outputFolder)) {
  fs.mkdirSync(outputFolder, { recursive: true });
  console.log(`✅ Pasta criada: ${outputFolder}`);
}

// Configuração de obfuscação
const obfuscationConfig = {
  compact: true,
  controlFlowFlattening: true,
  controlFlowFlatteningThreshold: 0.75,
  deadCodeInjection: true,
  deadCodeInjectionThreshold: 0.4,
  debugProtection: false,
  debugProtectionInterval: 0,
  disableConsoleOutput: false,
  identifierNamesGenerator: "hexadecimal",
  log: false,
  numbersToExpressions: true,
  renameGlobals: false,
  selfDefending: true,
  simplify: true,
  splitStrings: true,
  splitStringsChunkLength: 10,
  stringArray: true,
  stringArrayCallsTransform: true,
  stringArrayEncoding: ["base64"],
  stringArrayIndexShift: true,
  stringArrayRotate: true,
  stringArrayShuffle: true,
  stringArrayWrappersCount: 2,
  stringArrayWrappersChainedCalls: true,
  stringArrayWrappersParametersMaxCount: 4,
  stringArrayWrappersType: "function",
  stringArrayThreshold: 0.75,
  transformObjectKeys: true,
  unicodeEscapeSequence: false
};

// Função para obfuscar arquivo
function obfuscateFile(filePath) {
  try {
    // Ler arquivo original
    const code = fs.readFileSync(filePath, "utf8");
    
    // Obfuscar
    const obfuscatedCode = JavaScriptObfuscator.obfuscate(code, obfuscationConfig).getObfuscatedCode();
    
    // Calcular caminho de saída
    const relativePath = path.relative(inputFolder, filePath);
    const outputPath = path.join(outputFolder, relativePath);
    
    // Criar subpastas se necessário
    const outputDir = path.dirname(outputPath);
    if (!fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true });
    }
    
    // Gravar arquivo obfuscado
    fs.writeFileSync(outputPath, obfuscatedCode);
    
    console.log(`✅ Obfuscado: ${filePath} → ${outputPath}`);
    
    // Deletar .map se existir
    const mapPath = `${outputPath}.map`;
    if (fs.existsSync(mapPath)) {
      fs.unlinkSync(mapPath);
      console.log(`🗑️  Deletado: ${mapPath}`);
    }
  } catch (error) {
    console.error(`❌ Erro ao obfuscar ${filePath}:`, error.message);
  }
}

// Função para obfuscar pasta recursivamente
function obfuscateFolder(folderPath) {
  const files = fs.readdirSync(folderPath);
  
  files.forEach((file) => {
    const filePath = path.join(folderPath, file);
    const stat = fs.statSync(filePath);
    
    if (stat.isDirectory()) {
      obfuscateFolder(filePath);
    } else if (file.endsWith(".js") && !file.endsWith(".min.js")) {
      obfuscateFile(filePath);
    }
  });
}

// Executar obfuscação
console.log("🔐 Iniciando obfuscação...");
console.log(`📂 Entrada: ${inputFolder}`);
console.log(`📂 Saída: ${outputFolder}`);
console.log("");

obfuscateFolder(inputFolder);

console.log("");
console.log("✅ Obfuscação concluída!");
console.log(`📦 Arquivos obfuscados em: ${outputFolder}`);
console.log(`⚠️  IMPORTANTE: Arquivos originais preservados em: ${inputFolder}`);
