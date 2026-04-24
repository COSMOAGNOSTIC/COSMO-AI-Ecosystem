# Archive Structure & Indexing Protocol

## Purpose
The `/archive/` directory is the **long-term knowledge store** for COSMO. It holds:
1. **Reconstructed patterns** from 10 years of ChatGPT work (memory-based extraction)
2. **Proven doctrines** from active COSMO deployments
3. **Case studies** documenting architectural decisions
4. **Meta-patterns** applicable across multiple domains

All content is version-controlled in GitHub for audit trail and rollback.

---

## Directory Structure

```
/archive/
├── INDEX.md                                    # Master index (read this first)
├── RECONSTRUCTED_PATTERNS.md                   # Tier 1 priority patterns
│
├── reconstructed/
│   ├── sales-tracking-reconstructed.md         # "Sales Tracking/Customer Loyalty" pattern
│   ├── nothing-manacles-reconstructed.md       # "Nothing Manacles" build insights
│   └── general-meta-patterns.md                # Abstract AI patterns from ChatGPT
│
├── doctrines/
│   ├── email-analysis-doctrine.md              # How to triage email
│   ├── meeting-summary-doctrine.md             # How to summarize meetings
│   ├── cvn-maintenance-doctrine.md             # CVN log analysis (COSMO-CVN72)
│   ├── data-transformation-doctrine.md         # CSV/data cleaning
│   └── knowledge-graph-extraction-doctrine.md  # How to build relationships
│
├── case-studies/
│   ├── source-of-truth-protocol.md             # Why GitHub as SSOT works
│   ├── helpful-assistant-bias.md               # How to avoid it
│   ├── cosmo-a-standard-format.md              # Why this structure matters
│   └── meeting-summarizer-iteration.md         # Lessons from v1.0 → v2.0
│
└── legacy-ref/
    └── README.md                               # Pointer to any legacy data
```

---

## File Naming Convention

**All files follow kebab-case (lowercase, hyphens):**
- ✓ `sales-tracking-reconstructed.md`
- ✓ `email-analysis-doctrine.md`
- ✗ `SalesTrackingReconstructed.md` (wrong)
- ✗ `email_analysis_doctrine.md` (wrong)

**All files must be Markdown (`.md`)** with:
- H1 header (`# Title`)
- Clear sections (H2, H3)
- Inline code examples where relevant
- Links to related files in `/archive/` or `/prompts/`

---

## Archive Index Format (`/archive/INDEX.md`)

### Master Index Template

```markdown
# Archive Index

Central catalog of all archived knowledge and patterns.

## Reconstructed Patterns (Tier 1 Priority)

| Pattern | File | Status | Extracted | Purpose |
|---------|------|--------|-----------|----------|
| Sales Tracking / Customer Loyalty | `reconstructed/sales-tracking-reconstructed.md` | [ ] TODO | TBD | Core pattern from 10yrs ChatGPT; needed for new specialists |
| Nothing Manacles Build Insights | `reconstructed/nothing-manacles-reconstructed.md` | [ ] TODO | TBD | Build methodology; feeds into architecture decisions |
| General Meta-Patterns | `reconstructed/general-meta-patterns.md` | [~] IN PROGRESS | TBD | Abstract AI patterns; shared across specialists |

## Doctrines (Operational Standards)

| Doctrine | File | Status | Last Updated | Owner |
|----------|------|--------|--------------|-------|
| Email Analysis | `doctrines/email-analysis-doctrine.md` | [x] ACTIVE | 2026-04-20 | Donnie |
| Meeting Summary | `doctrines/meeting-summary-doctrine.md` | [x] ACTIVE | 2026-04-20 | Donnie |
| CVN Maintenance | `doctrines/cvn-maintenance-doctrine.md` | [x] ACTIVE | 2026-04-23 | Donnie |
| Data Transformation | `doctrines/data-transformation-doctrine.md` | [ ] TODO | — | TBD |
| Knowledge Graph Extraction | `doctrines/knowledge-graph-extraction-doctrine.md` | [ ] TODO | — | TBD |

## Case Studies

| Case Study | File | Topic | Key Lesson |
|------------|------|-------|----------|
| Source of Truth Protocol | `case-studies/source-of-truth-protocol.md` | Why GitHub as SSOT | Versioning prevents architectural drift |
| Helpful Assistant Bias | `case-studies/helpful-assistant-bias.md` | Anti-pattern | Structure output trumps helpfulness |
| COSMO-A Standard Format | `case-studies/cosmo-a-standard-format.md` | Consistency | All agents must follow same structure |
| Meeting Summarizer Iteration | `case-studies/meeting-summarizer-iteration.md` | Refinement | v1.0 → v2.0 lessons |

## How to Use This Archive

### If you're building a new specialist:
1. Read `/archive/INDEX.md` (this file)
2. Check `/archive/reconstructed/general-meta-patterns.md` — find analogous pattern
3. If not found, check `/archive/doctrines/` for applicable domain
4. Read relevant `/archive/case-studies/` to understand pitfalls
5. Write specialist prompt in `/prompts/` following COSMO-A Standard Format
6. Update `/archive/INDEX.md` with link to new specialist

### If you're integrating with a new platform (e.g., Govini Ark):
1. Read `/archive/case-studies/source-of-truth-protocol.md` — understand GitHub SSOT
2. Check `/archive/doctrines/` for any similar integrations
3. Document lessons learned in `/archive/case-studies/` post-deployment
4. Update this index

### If you're adding to reconstructed patterns:
1. Create new file in `/archive/reconstructed/`
2. Follow template: H1 header + clear sections + examples
3. Add entry to `INDEX.md`
4. Commit with message: `Add: [pattern name] reconstructed from memory`

---

## Reconstruction Protocol (Q2 2026)

Since OpenAI denied export, we reconstruct from memory and active use:

### Phase 1: Externalize Core Patterns
**Target:** `sales-tracking-reconstructed.md`, `nothing-manacles-reconstructed.md`

**Method:**
1. In Claude, describe the pattern step-by-step (structure, logic, output)
2. Claude writes it out in Markdown
3. Review and polish
4. Commit to GitHub

**Timeline:** Week 1-2 of April 2026

### Phase 2: Extract Active Patterns
**Target:** Meta-patterns from working COSMO-A, COSMO-CVN72, other specialists

**Method:**
1. Review `/prompts/` directory
2. Identify patterns repeated across multiple specialists
3. Extract to `/archive/reconstructed/general-meta-patterns.md`
4. Link from INDEX.md

**Timeline:** Week 2-3 of April 2026

### Phase 3: Document Doctrines
**Target:** Doctrines for each operational domain

**Method:**
1. Review specialist prompts
2. Extract "Processing Directive" section
3. Expand into full doctrine (why, not just how)
4. Save to `/archive/doctrines/`

**Timeline:** Week 3-4 of April 2026

---

## Governance Rules

### Before adding to `/archive/`:
1. **Markdown compliant** — Check with `markdownlint`
2. **Linked from INDEX.md** — Not searchable = not useful
3. **Versioned in GitHub** — Not in GitHub = not part of SSOT
4. **Named correctly** — kebab-case, descriptive

### Before updating a reconstructed pattern:
1. **Notify in commit message** — What changed and why
2. **Update INDEX.md** — Reflect new status/date
3. **Test impact** — Confirm downstream specialists still work

### Before marking a pattern "COMPLETE":
1. **Reviewed by Donnie** — Original author sign-off
2. **Tested in at least 1 specialist** — Proof of use
3. **Linked from `/prompts/`** — Actively referenced

---

## Cross-References

**Related GitHub files:**
- `/CLAUDE.md` — Persona standards (read first)
- `/MIGRATION.md` — Status of reconstruction effort
- `/OPERATIONS.md` — How specialists are built
- `/prompts/` — Active specialist implementations

**External references:**
- Govini Ark: See `GOVINI_INTEGRATION.md`
- COSMO-CVN72: See `COSMO 72 working copy` + `/archive/doctrines/cvn-maintenance-doctrine.md`
- MCP Roadmap: See `COSMO_ARCHITECTURE_SUMMARY_MCP_STRATEGY.md`

---

**Last Updated:** 2026-04-24
**Version:** 1.0
**Status:** Initialization in progress
