# Archive Structure & Indexing Protocol

## Purpose
The `/archive/` directory is the **long-term knowledge store** for COSMO. It holds:
1. **Active doctrines** from COSMO deployments
2. **Case studies** documenting architectural decisions
3. **Meta-patterns** applicable across multiple domains
4. **Extracted patterns** from CVN and other operational domains (as they emerge)

All content is version-controlled in GitHub for audit trail and rollback.

---

## Directory Structure

```
/archive/
├── INDEX.md                                    # Master index (read this first)
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
- ✓ `email-analysis-doctrine.md`
- ✗ `EmailAnalysisDoctrine.md` (wrong)
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
|------------|------|-------|-----------| 
| Source of Truth Protocol | `case-studies/source-of-truth-protocol.md` | Why GitHub as SSOT | Versioning prevents architectural drift |
| Helpful Assistant Bias | `case-studies/helpful-assistant-bias.md` | Anti-pattern | Structure output trumps helpfulness |
| COSMO-A Standard Format | `case-studies/cosmo-a-standard-format.md` | Consistency | All agents must follow same structure |
| Meeting Summarizer Iteration | `case-studies/meeting-summarizer-iteration.md` | Refinement | v1.0 → v2.0 lessons |

## Operational Patterns (Emerging)

| Pattern | Domain | Status | Extracted | Purpose |
|---------|--------|--------|-----------|---------|
| TBD | CVN-72 | [ ] PENDING | — | To be identified from active work |
| TBD | Financial Dashboard | [ ] PENDING | — | To be identified from active work |
| TBD | Family Ecosystem | [ ] PENDING | — | To be identified from active work |
```

---

## How to Use This Archive

### If you're building a new specialist:
1. Read `/archive/INDEX.md` (this file)
2. Check `/archive/doctrines/` for applicable domain
3. Read relevant `/archive/case-studies/` to understand pitfalls
4. Write specialist prompt in `/prompts/` following COSMO-A Standard Format
5. Update `/archive/INDEX.md` with link to new specialist

### If you're integrating with a new platform or domain:
1. Read `/archive/case-studies/source-of-truth-protocol.md` — understand GitHub SSOT
2. Check `/archive/doctrines/` for any similar integrations
3. Document lessons learned in `/archive/case-studies/` post-deployment
4. Update this index

### If you're adding new operational patterns:
1. Create new file in `/archive/` (in appropriate subdirectory)
2. Follow template: H1 header + clear sections + examples
3. Add entry to `INDEX.md`
4. Commit with message: `Add: [pattern name] from [source]`

---

## Governance Rules

### Before adding to `/archive/`:
1. **Markdown compliant** — Check with `markdownlint`
2. **Linked from INDEX.md** — Not searchable = not useful
3. **Versioned in GitHub** — Not in GitHub = not part of SSOT
4. **Named correctly** — kebab-case, descriptive

### Before updating an existing pattern:
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
- `/MIGRATION.md` — Status of work
- `/OPERATIONS.md` — How specialists are built
- `/prompts/` — Active specialist implementations

**External references:**
- COSMO-CVN72: See `COSMO 72 working copy` + `/archive/doctrines/cvn-maintenance-doctrine.md`
- MCP Roadmap: See `COSMO_ARCHITECTURE_SUMMARY_MCP_STRATEGY.md`

---

**Last Updated:** 2026-04-25
**Version:** 1.0
**Status:** Initialization in progress
