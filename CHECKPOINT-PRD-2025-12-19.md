# OnCalls V3.1 PRD Workflow Checkpoint

**Date:** 2025-12-19
**Session:** PRD Creation via BMM Workflow
**Status:** Step 2 of 11 COMPLETE - Ready for Step 3

---

## Resume Instructions

```
1. Start new Claude session
2. Say: "Resume OnCalls PRD workflow - we completed Step 2 (Executive Summary), ready for Step 3 (Success Criteria)"
3. Or run: /bmad:bmm:workflows:create-prd
   - The workflow will detect existing prd.md with stepsCompleted: [1, 2]
   - It will load step-01b-continue.md and resume from Step 3
```

---

## Session Accomplishments

### Infrastructure Work (Before PRD)
1. **Identified all 3 servers** via DigitalOcean CLI:
   - Production: 45.55.92.178 (oncallsprod) - DB: oncalls_live
   - Staging: 159.203.167.125 (TempDropOncalls)
   - Debug: 159.203.131.40 (oncallsprod2025082000debug) - DB: oncalls_stage

2. **Initialized git on Production** - Was running 429 days without version control!
   - Commit: 914109d - 9,150 files tracked

3. **Committed debug server changes** - 53 uncommitted files saved
   - Commit: 5cfc6802 - 211 files

4. **Key Finding:** Debug server has OLDER code with bugs, NOT fixes
   - Production/Staging have `data.get()` fix
   - Debug still has `data.fget()` bug

5. **Created documentation:**
   - `_bmad-output/server-infrastructure-audit.md`
   - `_bmad-output/code-delta-analysis.md`

6. **Added SSH aliases:**
   - `oncalls-direct` → Production
   - `oncalls-staging` → Staging
   - `oncalls-debug` → Debug

7. **Updated context warning threshold:** 5000 → 20000 tokens

---

## PRD Progress

### Completed Steps
- **Step 1:** Initialization - Created prd.md, discovered input documents
- **Step 2:** Project Discovery - Executive Summary written

### PRD Content Written
```
## Executive Summary
- Vision Alignment (V3.1 goals + V4 future)
- What Makes This Special (AI scheduling partner vision)
- Project Classification (SaaS B2B, Healthcare, HIGH complexity)
```

### User's Stated Priorities
| Priority | Focus | Description |
|----------|-------|-------------|
| #1 | Production Stability | User creation bugs, duplicates, schedule edge cases |
| #2 | UX Completion | Finish V2→V3 modernization (klunky workflows) |
| #3 (V4) | AI Scheduling | Conversational onboarding, intelligent equity-based scheduling |

### Key User Insights
- Current UX is "klunky" - especially account creation, shifts, services
- AI vision: Conversational interface for onboarding AND schedule creation
- AI should ensure "intelligence and equity" in scheduling
- No PHI in system - HIPAA less relevant than initially noted

---

## Files Created/Modified This Session

| File | Purpose |
|------|---------|
| `_bmad-output/prd.md` | PRD document (Steps 1-2 complete) |
| `_bmad-output/server-infrastructure-audit.md` | Server inventory and git status |
| `_bmad-output/code-delta-analysis.md` | Code comparison across servers |
| `_bmad-output/bmm-workflow-status.yaml` | Updated with server info and delta analysis |
| `~/.ssh/config` | Added oncalls-debug alias |
| `~/.claude/settings.json` | contextLeftThreshold: 20000 |

---

## Workflow Status

From `bmm-workflow-status.yaml`:

```yaml
next_workflow: "create-prd"
next_agent: "pm"
# Currently IN this workflow at Step 3

Completed:
- document-project: ✓
- research: ✓
- prd: IN PROGRESS (Step 2 of 11 done)

Pending:
- create-ux-design: conditional
- create-architecture: recommended
- create-epics-and-stories: required
- implementation-readiness: required
- sprint-planning: required
```

---

## Next Step Preview

**Step 3: Success Criteria Definition** will cover:
- Business metrics (revenue, users, retention)
- Technical metrics (uptime, performance, error rates)
- User experience metrics (task completion, satisfaction)
- Definition of "done" for V3.1 release

---

## Server Quick Reference

```bash
# SSH Access
ssh oncalls-direct    # Production (45.55.92.178)
ssh oncalls-staging   # Staging (159.203.167.125)
ssh oncalls-debug     # Debug (159.203.131.40) - OBSOLETE CODE

# Git Status
Production: Initialized 2025-12-19, commit 914109d
Staging: Has git, deployment via GitHub Actions
Debug: OBSOLETE - older buggy code, do not use
```

---

**Checkpoint Created:** 2025-12-19
