# Academic Pipeline

Pipeline MoA (Mixture of Agents) para investigacion academica en ciencias sociales.

## Flujo

```
1. scout.mjs     → Analiza actualidad, propone lineas de investigacion
2. research.mjs  → Pipeline MoA: busca datos → redacta paper → revisa → edita → QA
3. translate.mjs → Convierte el paper en articulo divulgativo
```

## Uso

### 1. Explorar lineas de investigacion (fase consejero)

```powershell
node scripts/scout.mjs
node scripts/scout.mjs "pensiones y jovenes"
```

Output: `output/proposals/proposals.txt`

### 2. Generar paper academico

```powershell
node scripts/research.mjs "linea de investigacion elegida"
node scripts/research.mjs "pensiones y jovenes sin empleo" @angle.txt
```

Output: `output/papers/paper.txt`

### 3. Generar articulo divulgativo

```powershell
node scripts/translate.mjs
```

Output: `output/articles/article.txt`

## Configuracion

Copiar `.env.example` a `.env` y setear:

```
GROQ_API_KEY=gsk_tu_key
```

## Dominios de investigacion

- D1: Economia y mercados laborales
- D2: Politica publica y reformas
- D3: Demografia y envejecimiento
- D4: Tecnologia, IA y futuro del trabajo

## Arquitectura

Pipeline de 5 agentes (MoA) con feedback loops:

```
SEARCH → WRITE → REVIEW → EDIT → APPROVE → END
           ↑        |          |        |
           ← REESCRIBIR       ← RECHAZADO
← BUSCAR_MAS ─────┘
```

- Agente 1: Groq Compound (web search en fuentes autorizadas)
- Agente 2: GPT-OSS 120B (redacta paper academico)
- Agente 3: GPT-OSS 120B (revisa rigor academico)
- Agente 4: GPT-OSS 120B (edita y pule)
- Agente 5: GPT-OSS 20B (QA final)

## Fuentes confiables

OECD, ILO, World Bank, IMF, CEPAL, UN, EU, NBER, SSRN, RePEc, INEC, BCCR, ScienceDirect, Springer, JSTOR, Scielo, Reuters, Bloomberg, FT, El Pais, entre otras.
