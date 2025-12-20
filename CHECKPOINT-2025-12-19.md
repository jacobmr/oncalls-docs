# OnCalls v3 Revision - Session Checkpoint
**Date:** December 19, 2025 (Final Update)
**Session Goal:** Debug production issues and plan v3 completion

---

## Server Architecture Discovered

| Server | IP | Role | Codebase | Git Status |
|--------|-----|------|----------|------------|
| **Production** | 45.55.92.178 | LIVE | oncall_backend (old structure) | NO GIT! |
| **Staging** | 159.203.167.125 | STAGING | oncalls-main (modern) | Clean, on main |

**SSH Access:**
- `ssh root@45.55.92.178` - Production
- `ssh root@159.203.167.125` - Staging
- `oncalls` alias goes through hub (unreliable)

---

## Completed This Session

### 0. Critical Bug Fix - data.fget()
- **Bug:** Line 56 in MemberService.py: `data.fget('blockstart')` → `data.get('blockstart')`
- **Impact:** Prevented admin users from creating new members
- **Fixed in:**
  - ✅ oncalls-main (local) - committed & pushed (a88bb10)
  - ✅ Staging server - patched & restarted
  - ✅ Production server - patched & restarted
- **Note:** This bug existed EVERYWHERE and was never actually fixed before

### 1. Production Database Fix
- **Issue:** Lee Stetzer couldn't add McPhillips as baby rounder on Dec 13
- **Resolution:** Inserted schedule entry directly into production DB
- **ScheduleID:** 610588
- **Details:** Amy McPhillips (docid 2859) added to BABY shift (GroupCallID 1845) on 2025-12-13

### 2. Documentation & Skill Created
- `/docs/schedule-entry-insert.md` - Manual procedure for schedule inserts
- `/.claude/commands/add-schedule-entry.md` - Skill for `/add-schedule-entry` command
- `/docs/schedule-audit-log.md` - Audit trail for manual DB changes

### 3. Stop Hook Fix
- **Problem:** Hook searching for "All tests passed" created infinite loop
- **Fix:** Changed output message in `~/.claude/settings.json` to "Tests completed successfully"
- **Note:** Takes effect on next Claude session

### 4. Codebase Analysis
Comprehensive comparison of all OnCalls repositories completed. Key finding:
- **oncalls-main** is the target v3 codebase (Vite, modern components, testing)
- **Production** is significantly behind and has NO git version control
- **Staging** is running oncalls-main

---

## Next Session Plan

### A. Backend Sync Analysis
- Compare requirements.txt between oncalls-main and production
- Identify missing Python packages and version differences
- Document services and models that differ
- Plan sync strategy

### B. Version Control Review & Planning
- Audit git state across all local repos
- Document which repos are active vs archived
- Plan consolidation strategy
- Address production's lack of git (CRITICAL)

### C. GitHub Sync Review
- Ensure GitHub repos match what's deployed on staging
- Verify production deployment process
- Check for any commits on servers not pushed to GitHub
- Review GitHub Actions workflows

### D. Error Review - Duplicate Users
- Investigate reported issue: users existing twice in database
- Check for duplicate entries in `passwords` table
- Review account management code for race conditions
- Document and fix any data integrity issues

### E. Architecture State Review & Planning
- Document which UX components have been migrated to new design
- Identify incomplete modernization work
- Map the current state of BMad Stream 2 work
- Create prioritized plan for remaining work

---

## Key Files & Locations

### Local Repositories
| Repo | Location | Status |
|------|----------|--------|
| oncalls-main | `/Users/jmr/dev/oncalls-main/` | PRIMARY - Active development |
| oncalls25_react_Back | `/Users/jmr/dev/Oncalls-debug_prod/oncalls25_react_Back/` | Production snapshot v2.0 |
| oncalls2025 | `/Users/jmr/dev/Oncalls-debug_prod/oncalls2025/` | ARCHIVED - Flutter experiment |
| oncallsreact | `/Users/jmr/dev/Oncalls-debug_prod/oncallsreact/` | ARCHIVED - Early React |

### Server Paths
- **Production Backend:** `/var/www/oncalls/oncall_backend/`
- **Production Frontend:** `/var/www/oncalls/oncalls_react/` (built files)
- **Staging:** `/var/www/oncalls/current/`

### Database
```
Host: db-mysql-oncalls-do-user-4885460-0.e.db.ondigitalocean.com
Port: 25060
Database: oncalls_live
Credentials: In /Users/jmr/dev/Oncalls-debug_prod/backend_prod/.env
```

---

## Known Issues to Address

1. **Production has no git** - High risk for tracking changes
2. **9 GitHub dependency vulnerabilities** - 1 critical, 3 high
3. **Duplicate user accounts** - Reported by users
4. **UX migration incomplete** - Need to map current state

---

## Resume Instructions

When resuming this work:
```
Read the checkpoint at /Users/jmr/dev/Oncalls-debug_prod/CHECKPOINT-2025-12-19.md
```

Then work through items A-E in the Next Session Plan.

---

## Session Statistics
- **Duration:** ~2 hours
- **Bug fixes:** 1 critical (data.fget)
- **Database operations:** 1 insert
- **Files created:** 4 (docs, skills)
- **Commits:** 1 (a88bb10)
