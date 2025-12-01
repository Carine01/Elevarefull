# 📚 Guia de Imports - LeadsService

**Problema Comum:** Erro ao importar `LeadService` (singular) quando o correto é `LeadsService` (plural).

---

## ✅ Imports Corretos

### Backend Principal (`/backend/`)

```typescript
// ✅ CORRETO - Importar do módulo leads
import { LeadsService } from '../modules/leads/leads.service';

// ✅ CORRETO - Caminho relativo
import { LeadsService } from './modules/leads/leads.service';

// ✅ CORRETO - Caminho absoluto (se configurado no tsconfig.json)
import { LeadsService } from '@/modules/leads/leads.service';
```

### Backend do Frontend-Landing (`/frontend-landing/backend/`)

```typescript
// ✅ CORRETO - Importar do módulo leads
import { LeadsService } from '../modules/leads/leads.service';

// ✅ CORRETO - Caminho relativo
import { LeadsService } from './modules/leads/leads.service';
```

---

## ❌ Imports Incorretos (Causam Erro)

```typescript
// ❌ ERRADO - Nome singular
import { LeadService } from '../services/LeadService';

// ❌ ERRADO - Caminho services/ não existe
import { LeadsService } from '../services/LeadsService';

// ❌ ERRADO - Extensão .ts explícita
import { LeadsService } from '../modules/leads/leads.service.ts';
```

---

## 🔧 Como Corrigir

### 1. Verificar o nome do arquivo

```bash
# Backend principal
ls /backend/src/modules/leads/
# Deve mostrar: leads.service.ts (plural)

# Backend frontend-landing
ls /frontend-landing/backend/src/modules/leads/
# Deve mostrar: leads.service.ts (plural)
```

### 2. Corrigir o import

**Antes (ERRADO):**
```typescript
import { LeadService } from '../services/LeadService';
```

**Depois (CORRETO):**
```typescript
import { LeadsService } from '../modules/leads/leads.service';
```

### 3. Verificar a injeção de dependência

```typescript
// ✅ CORRETO - No constructor
constructor(
  private readonly leadsService: LeadsService,
) {}

// ✅ CORRETO - No módulo
@Module({
  imports: [LeadsModule],
  providers: [LeadsService],
  controllers: [MyController],
})
export class MyModule {}
```

---

## 📁 Estrutura de Diretórios

### Backend Principal

```
/backend/src/
├── modules/
│   ├── leads/
│   │   ├── leads.service.ts       ✅ Arquivo correto
│   │   ├── leads.controller.ts
│   │   ├── leads.module.ts
│   │   └── dto/
│   │       └── lead.dto.ts
│   └── ...
└── ...
```

### Backend Frontend-Landing

```
/frontend-landing/backend/src/
├── modules/
│   ├── leads/
│   │   ├── leads.service.ts       ✅ Arquivo correto
│   │   ├── leads.controller.ts
│   │   ├── leads.module.ts
│   │   └── dto/
│   │       └── lead.dto.ts
│   └── ...
└── ...
```

---

## 🚀 Exemplo Completo de Uso

### Criar um webhook que usa LeadsService

```typescript
// webhooks/leads.webhook.ts
import { Controller, Post, Body } from '@nestjs/common';
import { LeadsService } from '../modules/leads/leads.service';
import { CreateLeadDto } from '../modules/leads/dto/lead.dto';

@Controller('webhooks')
export class LeadsWebhookController {
  constructor(
    private readonly leadsService: LeadsService,
  ) {}

  @Post('leads')
  async handleLeadWebhook(@Body() leadData: CreateLeadDto) {
    // Criar lead usando o serviço
    const lead = await this.leadsService.create(leadData);
    return { success: true, leadId: lead.id };
  }
}
```

### Registrar no módulo

```typescript
// webhooks/webhooks.module.ts
import { Module } from '@nestjs/common';
import { LeadsModule } from '../modules/leads/leads.module';
import { LeadsWebhookController } from './leads.webhook';

@Module({
  imports: [LeadsModule],  // ✅ Importar o módulo completo
  controllers: [LeadsWebhookController],
})
export class WebhooksModule {}
```

---

## 🔍 Troubleshooting

### Erro: "Cannot find module '../services/LeadService'"

**Solução:**
1. Verifique se o arquivo existe: `ls backend/src/modules/leads/leads.service.ts`
2. Corrija o caminho do import: `../modules/leads/leads.service`
3. Corrija o nome da classe: `LeadsService` (plural)

### Erro: "LeadsService is not a constructor"

**Solução:**
1. Verifique se o módulo `LeadsModule` está importado
2. Verifique se `LeadsService` está no array `providers` do módulo
3. Certifique-se de que o decorator `@Injectable()` está presente

### Erro: "Circular dependency detected"

**Solução:**
1. Use `forwardRef()` para resolver dependências circulares:
```typescript
constructor(
  @Inject(forwardRef(() => LeadsService))
  private readonly leadsService: LeadsService,
) {}
```

---

**Desenvolvido por:** Manus AI  
**Data:** 30/11/2025
