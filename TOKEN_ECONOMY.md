# TOKEN ECONOMY DOCTRINE

**Version 1.0** | Date: April 18, 2026  
**Scope**: Claude API integration with COSMO ecosystem  
**Owner**: Donnie Langford | **Classification**: UNCLASSIFIED

---

## PURPOSE

Operational framework for minimizing wasted tokens during iterative development. Covers when to regenerate vs. patch, how to structure prompts for reusability, and decision thresholds for different iteration scenarios.

Token efficiency is a **cost and quality metric**. Wasted tokens = slower feedback loops + higher costs + worse user experience. This document operationalizes lean iteration.

---

## 1. CORE PRINCIPLES

### The Anti-Pattern: Full Regeneration

**Inefficient**: User requests one-line fix → AI regenerates entire artifact (prompt, code, document)

**Cost**: 
- Full context re-read (tokens in)
- Full artifact re-written (tokens out)
- 90% redundant output

**Loss**: Context window burned, feedback loop slowed, cost tripled

### The Pattern: Surgical Fixes

**Efficient**: User requests one-line fix → AI identifies exact location → uses `str_replace` or isolated patch

**Cost**:
- Surgical fix explanation (minimal tokens)
- Patch code only (10-20% of original)
- Instant validation

**Gain**: Faster iteration, lower cost, cleaner history

---

## 2. ITERATION THRESHOLDS

When to patch vs. regenerate, by change type:

| Change Type | % of Content Affected | Action | Example |
|---|---|---|---|
| **Single line/phrase** | < 5% | `str_replace` | Fix typo, adjust one variable name |
| **One function/section** | 5–25% | Isolated rewrite + context | Rewrite one function, fix one paragraph |
| **Multiple sections** | 25–50% | Patch framework, regenerate fills | Update three functions, rebuild structure |
| **Structural redesign** | > 50% | Full regeneration | Complete refactor, new architecture |

**Decision Rule**: If change ≤ 25% of content, always patch. If > 50%, regenerate.  
**Gray zone (25–50%)**: Ask Donnie or default to patching if patch-friendly.

---

## 3. SURGICAL TECHNIQUES

### 3.1 str_replace (Code, Markdown, Plain Text)

**When**: Single phrase/line/function in self-contained artifacts

**Format**:
```
old_str: [EXACT match from artifact, must be unique]
new_str: [Replacement text]
```

**Token cost**: ~5–10% of full regeneration

**Example**:
```
old_str: const result = apiCall(data);
new_str: const result = await apiCall(data);
```

### 3.2 Isolated Rewrite (Code Blocks)

**When**: One function/method needs rewrite, rest of artifact stays same

**Method**:
1. Quote the old function
2. Provide new function with surrounding context
3. Explain the why
4. User copy-pastes or I patch via str_replace

**Token cost**: ~15–25% of full regeneration

**Example**:
```
OLD:
function parseData(raw) {
  return JSON.parse(raw);
}

NEW:
function parseData(raw) {
  try {
    return JSON.parse(raw);
  } catch (e) {
    console.error('Parse failed:', e);
    return null;
  }
}
```

### 3.3 Context Patch (Multi-File or Complex)

**When**: Multiple files or sections need changes, structure stays same

**Method**:
1. List changes required (file + line ranges)
2. Provide diff-style changes
3. Explain integration points

**Token cost**: ~20–35% of full regeneration

---

## 4. PROMPT REGENERATION RULES

Prompts and system messages are special — they're read every session, so efficiency compounds.

### When to Regenerate a Prompt

- **Structural change**: Add new sections, remove old ones, reorganize hierarchy
- **Concept drift**: Core behavioral instruction changed (e.g., new decision filter)
- **Version bump**: Expiration cycle hit, comprehensive refresh planned

**Cost**: Full context burn. Only do if value > 50% overhaul.

### When to Patch a Prompt

- **Clarification**: Existing section needs wording adjustment
- **Update fact**: Change date, project status, contact info
- **Add constraint**: New guardrail without restructuring

**Cost**: Minimal. Use `str_replace` on the exact section.

### Example

**Donnie asks**: "Add token economy note to Section 9"

**Efficient path**: 
- Use `str_replace` on the "Token Economy Note" subsection in the prompt
- Minimal context re-read, minimal output

**Inefficient path**:
- Regenerate entire prompt (all 10k tokens) because one sentence changed

---

## 5. ARTIFACT REUSABILITY PATTERNS

### Design for Patching

Artifacts should be structured to enable surgical fixes:

1. **Modular code**: Functions separated, not monolithic
2. **Clear sections**: Headers, comments marking boundaries
3. **Self-contained logic**: Minimize dependencies across sections
4. **Named constants/config**: Group at top for easy updates

**Example**:
```javascript
// ✓ GOOD: Easy to patch one function
const API_URL = "https://...";
function fetchData() { ... }
function parseData() { ... }
function renderUI() { ... }

// ✗ BAD: Monolithic, harder to patch
function main() { const API_URL = "..."; ... }
```

### Reusable Prompts

Prompts should have:
- **Clear sections** (numbered, titled)
- **Isolated constraints** (one per section, not interwoven)
- **Comments** marking update points
- **Versioning** (date, expiration, revision cycle)

---

## 6. DECISION FLOW

**Donnie requests a change:**

```
1. How big is the change?
   ├─ < 5% of content → str_replace
   ├─ 5–25% → Isolated rewrite
   ├─ 25–50% → Ask Donnie, default patch
   └─ > 50% → Full regeneration

2. Is artifact designed for patching?
   ├─ Yes → Patch (lower token cost)
   └─ No → Note for next redesign, regenerate if necessary

3. Is this a prompt or code artifact?
   ├─ Prompt + structural change → Regenerate
   ├─ Prompt + fact/clarification → str_replace
   └─ Code → Use threshold above

4. Execute & validate
   ├─ Show change (patch) or new artifact (regeneration)
   └─ Confirm before moving forward
```

---

## 7. COST MODELING

### Token Budgets by Task Type

Estimate full-context cost before deciding patch vs. regenerate:

| Artifact Type | Typical Size | Full Regen Cost | Patch Cost | Ratio |
|---|---|---|---|---|
| Short code (< 100 lines) | ~500 tokens | ~1K tokens | ~100 tokens | 10:1 |
| Medium artifact (100–500 lines) | ~2.5K tokens | ~5K tokens | ~300 tokens | 15:1 |
| Large artifact (500+ lines) | ~5K+ tokens | ~10K+ tokens | ~500 tokens | 20:1 |
| System prompt | ~8K–12K tokens | ~20K tokens | ~500 tokens | 40:1 |

**Implication**: Patching system prompts saves **~19.5K tokens** per change. This compounds over six-week revision cycles.

---

## 8. ANTI-PATTERNS TO AVOID

❌ **Full regeneration for cosmetic fixes**  
Replace typo → regenerate 5K-line artifact. (Use `str_replace`.)

❌ **Accumulating small patches**  
After 5+ patches to same artifact, refactor once rather than 6 small fixes. (Monitor patch count; regenerate at ~5–7 patches.)

❌ **Ignoring artifact design**  
Create monolithic code, then complain patching is hard. (Structure for reuse from the start.)

❌ **Regenerating prompts on every clarification**  
Change one word → regenerate 12K-token prompt. (Patch via `str_replace`.)

❌ **Burning context on obvious changes**  
User: "Change the color from blue to red."  
AI: Regenerates entire UI artifact.  
(Use `str_replace`: find color constant, replace value.)

---

## 9. DONNIE'S TOKEN ECONOMY CONTRACT

**I will**:
- Default to `str_replace` for < 5% changes
- Propose isolated rewrites for < 25% changes
- Flag when > 3 patches accumulate (time to regenerate)
- Estimate token cost before large operations
- Never regenerate a prompt for a single-line clarification
- Show the patch, not the full artifact (unless new context needed)

**You**:
- Override if you want full visibility (I'll regenerate if asked)
- Flag if patch feels clunky or insufficient
- Let me know if artifact structure makes patching hard (I'll redesign next iteration)

---

**Created**: April 18, 2026  
**GitHub SSOT**: github.com/COSMOAGNOSTIC/COSMO-AI-Ecosystem  
**Related**: COSMO_PERSONAL_PROMPT_v1.0.md (Section 9)  
**Author**: Donnie Langford, with Claude Opus 4.6 (Anthropic)
