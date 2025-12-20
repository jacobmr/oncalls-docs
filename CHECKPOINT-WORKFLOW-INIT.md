# OncallsV31 - Workflow Init Checkpoint
**Date:** 2025-12-19
**Session:** BMM Workflow Initialization

---

## Current Progress

### Completed Steps:
1. **Step 1: Scan for existing work** - DONE
   - Found: LEGACY/BROWNFIELD state
   - 3 servers identified (Production, Staging, V3)
   - Multiple repos mapped

2. **Step 2: Choose setup path** - DONE
   - Choice: **1 (Continue)** - Work with existing oncalls-main

3. **Step 3: Express/Guided setup** - DONE
   - field_type: **brownfield**
   - selected_track: **method** (BMad Method)

### Pending Step:
4. **Step 6: Discovery workflows selection**
   - Awaiting choice: 1 (Brainstorm), 2 (Research), 1,2, or none

---

## Project Configuration

```yaml
project_name: OncallsV31
field_type: brownfield
selected_track: method
base_repo: /Users/jmr/dev/oncalls-main/
github_remote: jacobmr/oncalls25_react_Back
```

---

## Server Landscape (Documented)

| Server | IP | Role | Uptime | Git |
|--------|-----|------|--------|-----|
| Production | 45.55.92.178 | LIVE | 429 days | NO GIT |
| Staging | 159.203.167.125 | Staging | 142 days | Yes |

---

## Repository Landscape (Documented)

| Repo | Status | Purpose |
|------|--------|---------|
| oncalls-main | PRIMARY | Active v3 development |
| oncalls25_react_Back (local) | Snapshot | Production v2.0 |
| oncalls2025 | ARCHIVED | Flutter experiment |
| oncallsreact | ARCHIVED | Early React |

---

## Goals Confirmed

a) Stabilize production
b) Understand all server statuses
c) Consolidate to ONE functional repo (staging + prod branches)
d) Document with epics, stories, architecture

---

## Resume Instructions

```
1. Start new Claude session (stop hook now fixed)
2. Run: /bmad:bmm:workflows:workflow-init
3. Or just say: "Resume OncallsV31 workflow init - we were at Step 6 (discovery workflows)"
4. Answer discovery workflow question: 1, 2, 1,2, or none
5. Continue to Step 8-9 to create workflow status file
```

---

## Stop Hook Fix Applied

The problematic grep hook was removed from `~/.claude/settings.json`.
New session should not have the "All tests passed" blocking issue.
