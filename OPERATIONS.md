# COSMO Operational Command Stack

## Core Principle
All COSMO agents follow a **Main Controller + Specialist** model. The Main Controller (COSMO-A) interprets intent and routes to domain-specific specialists. No specialist has full context; control is distributed by design.

---

## Agent Development Hierarchy

### Tier 1: Main Controller (COSMO-A)
**Role:** Central nervous system. Interprets user intent, validates classification, routes to specialists.

**Deployment:** 
- Claude (Sonnet for daily ops, Opus for heavy analysis)
- Gemini (Google ecosystem integration)
- Local Gemma 4 e4b (lightweight iteration, rapid prototyping)

**Key Constraints:**
- Never give a specialist the full context; always use Bucket Brigade pattern
- All specialists reference GitHub SSOT before making decisions
- Audit every data access; log classification/CUI handling

**Reference:** `COSMO_A v1.1 WORKING COPY` (GitHub SSOT)

---

### Tier 2: Operational Specialists
Each specialist handles **ONE domain** and ONE domain only.

**Current Deployments:**
- **Meeting Summarizer:** Minutes → structured output
- **Email Triage Agent:** Inbox → categorized/prioritized list
- **Domain Doctrine Specialist:** Maintenance logs → failure analysis + KG relationships
- **Data Normalizer:** Messy CSVs → clean structured data

**Required Structure (COSMO-A Standard Format):**
Every specialist prompt must contain:

```
## CORE IDENTITY
- Agent name
- Single responsibility
- Non-negotiable constraints

## PROCESSING DIRECTIVE
- Input format expected
- Step-by-step processing logic
- Error handling rules

## OUTPUT FORMAT
- Structure (JSON, Markdown, etc.)
- Example output
- Validation rules
```

**Pattern: Bucket Brigade**
1. Main Controller receives raw input from user
2. Main Controller validates and cleans (basic scrubbing)
3. Main Controller passes cleaned data to specialist
4. Specialist processes without needing file access
5. Main Controller formats and audits output

**Versioning:**
- Each specialist prompt lives in `/prompts/` with semantic version tags
- Example: `/prompts/email-triage-v2.1.md`
- Git history allows rollback if a version underperforms

---

### Tier 3: Deployment Variants
Each variant is a **specialized assembly** of Main Controller + curated specialists.

**COSMO-A (Baseline)**
- Model-agnostic foundation
- Runs on any LLM platform
- Specialist agents loaded dynamically
- No hard-coded domain logic

**COSMO-DELTA (Operational)**
- Specialized for complex domain maintenance and log analysis
- Deployed and shared with operational engineers
- Focus: Technical log analysis, failure pattern detection, predictive insights
- Incorporates Knowledge Graph Pipeline logic for relationship extraction
- Reference: `COSMO-DELTA working copy` (GitHub SSOT)

**COSMO-Gemini (Family Ecosystem)**
- Google ecosystem variant
- Calendar integration, task management, shared family hub
- Lighter-weight reasoning for household finances/scheduling
- Reference: `GEMMA4_OPERATIONAL_CONSTRAINTS.md` (GitHub SSOT)

**COSMO-Local (Gemma 4 e4b)**
- Standalone local instance
- 80% solutions at minimal cost
- Used for rapid iteration and testing
- Compact prompt to fit limited context window
- Future: Deep integration with full COSMO ecosystem via MCP

---

## Data Flow Architecture

```
User Input
    ↓
[Main Controller / COSMO-A]
    ├─ Interprets intent
    ├─ Checks classification/CUI status
    ├─ Validates data source access
    ├─ Routes to appropriate specialist
    ↓
[Specialist Sub-Agent]
    ├─ Applies operational doctrine
    ├─ Processes via Bucket Brigade pattern
    ├─ Applies NLP/NER/transformation logic
    ↓
[Storage/Output Layer]
    ├─ Vector Store (semantic search, Phase 2)
    ├─ Structured Database (relational queries, Phase 3)
    ├─ Knowledge Graph (relationship queries via MCP, Phase 3)
    ├─ GitHub Archive (version-controlled audit trail)
    ↓
[User Output]
```

---

## MCP as the Spinal Cord (Phases 1-5 Roadmap)

**Current Status:** Phase 1 ✓ (GitHub SSOT + prompt library versioned)

**Phase 2 (Q2 2026):** Google Drive + File Ingestion
- MCP fetches uploaded logs from Google Drive
- OCR layer for scanned PDFs
- Specialist agents process via Bucket Brigade

**Phase 3 (Q3 2026):** Knowledge Graph (Neo4j or TigerGraph)
- MCP writes relationship triples: `[COMPONENT] -- [CAUSED] --> [FAILURE]`
- Main Controller queries: "What systems depend on Actuator X?"
- Enables causality analysis

**Phase 4 (Q4 2026):** Vector Store (Pinecone or Weaviate)
- Reconstructed ChatGPT patterns → embeddings
- Specialist agents find "similar past solutions"
- Reduce reinvention, accelerate analysis

**Phase 5 (2027+):** Enterprise Integration
- MCP bridges COSMO to external platforms
- Real-time data syncing
- Audit trails and compliance reporting

---

## Governance Rules

### Single Source of Truth (SSOT)
- **Location:** GitHub `COSMOAGNOSTIC/COSMO-AI-Ecosystem`
- **Contents:** All prompts, doctrines, configurations, deployment docs
- **Authority:** No agent deploys without GitHub version
- **Audit Trail:** All changes versioned; rollback always possible

### Mandatory Checks Before Architectural Changes
1. **Read `CLAUDE.md`** — Persona, tone, communication constraints
2. **Read `MIGRATION.md`** — Current work status and reconstruction strategy
3. **Read `OPERATIONS.md`** (this file) — Development hierarchy and patterns

### Cross-Model Compatibility
- Any prompt must work on Claude, Gemini, local Gemma without rewrites
- If a prompt only works on one model, it's not production-ready
- Use model-agnostic language; avoid model-specific APIs in the prompt

### Deployment Checklist
Before deploying a new specialist:
- [ ] Prompt follows COSMO-A Standard Format
- [ ] Tested on at least 2 LLM platforms
- [ ] GitHub version documented with semantic version tag
- [ ] Bucket Brigade pattern validated (no file I/O in specialist)
- [ ] Output format matches specification
- [ ] Audit trail implemented (log classification/CUI handling)

---

## Common Mistakes (Anti-Patterns)

❌ **Mistake:** A specialist agent has "full context" and can make routing decisions.
- **Fix:** Only Main Controller makes routing decisions. Specialists execute only.

❌ **Mistake:** A specialist reads files directly from disk or makes API calls.
- **Fix:** Main Controller cleans data → Specialist processes clean data (Bucket Brigade).

❌ **Mistake:** Prompt works on Claude but breaks on Gemini.
- **Fix:** Test on both before committing. Use model-agnostic language only.

❌ **Mistake:** "We'll document it later."
- **Fix:** Document as you build. Prompts without docs don't deploy.

❌ **Mistake:** Specialist agent has access to classified/CUI data without audit.
- **Fix:** Main Controller logs all CUI access before passing to specialist.

---

## Next Actions

1. **Reconstruction Phase (Q2 2026)**
   - Extract "Sales Tracking/Customer Loyalty" pattern from memory → `/archive/sales-tracking-reconstructed.md`
   - Extract "Nothing Manacles" insights from memory → `/archive/nothing-manacles-reconstructed.md`
   - Document reconstructed patterns in `/archive/INDEX.md`

2. **Specialist Development (Q2-Q3 2026)**
   - Build new specialists using reconstructed patterns
   - Test on Claude, Gemini, Gemma 4 e4b
   - Commit to GitHub with semantic version tags

3. **MCP Integration (Q2-Q4 2026)**
   - Phase 2: Google Drive ingestion
   - Phase 3: Knowledge Graph for COSMO-DELTA
   - Phase 4: Vector store for semantic search

4. **Industry Transition (Q4 2026+)**
   - Build credentials and experience
   - Track deployment success metrics
   - Document lessons learned

---

**GitHub SSOT:** `COSMOAGNOSTIC/COSMO-AI-Ecosystem`
**Last Updated:** 2026-04-25
**Version:** 1.0
