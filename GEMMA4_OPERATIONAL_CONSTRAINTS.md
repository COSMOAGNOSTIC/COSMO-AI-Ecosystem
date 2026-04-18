GEMMA4 OPERATIONAL CONSTRAINTS & SESSION MANAGEMENT

Version 1.0 | April 18, 2026
Owner: Donnie Langford | GitHub SSOT: COSMOAGNOSTIC/COSMO-AI-Ecosystem

---

## CONTEXT WINDOW MANAGEMENT

**Critical Threshold**: Token usage meter in LM Studio reaches **300%**

**What This Means**:
- Context window is exhausted
- Remaining reasoning space is negligible
- Hallucination risk escalates sharply
- Model degradation is imminent

**Required Action**:
When token meter hits 300%:
1. **STOP** current task immediately
2. **Note** where you were (last coherent output, final question/task)
3. **Start new chat session** in LM Studio
4. **Reload** GEMMA4_PERSONAL_PROMPT_COMPACT_v1.0c from GitHub
5. **Resume** from checkpoint with brief context: "Continuing from [previous task]. Last state: [X]."

---

## SESSION LIFECYCLE

### Pre-Session
- Load compact prompt fresh
- Verify token meter starts at 0%
- Confirm vision icon is present (multimodal enabled)

### During Session
- Monitor token meter continuously
- If meter approaches 250%, begin wrapping up task
- At 300%, initiate new session protocol

### Post-Session
- Document what was accomplished
- Note any hallucinations or uncertainty flags
- Archive key outputs to GitHub

---

## HALLUCINATION DETECTION CHECKLIST

Before trusting Gemma's output, verify:

✓ **Source Attribution**: Did Gemma cite specific GitHub files, user inputs, or explicitly flag as "inferred"?
✓ **Uncertainty Flags**: Did Gemma acknowledge gaps in knowledge ("I do not have access to X")?
✓ **Token Meter**: Was output generated at <250% token usage?
✓ **Verification**: Can you ask Gemma "What file documents this?" and get a specific path back?

If any of these fail → output is suspect. Retest or discard.

---

## KNOWN GEMMA LIMITATIONS

1. **No internet access** - Cannot fetch URLs or real-time data
2. **Finite context window** - 300% threshold is hard limit
3. **Text output only** - Vision input yes, image output no
4. **No file persistence** - Each session is isolated; previous chat history does not carry over
5. **Model-specific reasoning** - Smaller context window than Claude/Gemini; less able to hold complex multi-layer reasoning

---

## RECOVERY PROTOCOL

If a hallucination is detected mid-task:

1. **Flag it**: "You stated [X] but cannot cite the source. This appears to be inferred/hallucinated."
2. **Correct it**: Provide accurate information or the specific source (GitHub file/user input)
3. **Restart**: Load fresh session, reload prompt, continue with corrected context
4. **Log it**: Document the hallucination type (false source attribution, invented detail, confidence error) for prompt refinement

---

**Implementation Date**: April 18, 2026
**Next Review**: May 29, 2026 (six-week revision cycle)
