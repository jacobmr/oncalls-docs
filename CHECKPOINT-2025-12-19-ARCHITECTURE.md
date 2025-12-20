# OnCalls Architecture Checkpoint

**Date:** 2025-12-19
**Session:** PRD + Architecture Complete
**Status:** Ready for Epics & Stories

---

## Resume Instructions

```
1. Start new Claude session
2. Say: "Resume OnCalls - PRD and Architecture complete, ready for Epics & Stories"
3. Or run: /bmad:bmm:workflows:create-epics-and-stories
```

---

## Session Accomplishments

### Repository Reorganization
1. **Created `oncalls-docs` repo** - github.com/jacobmr/oncalls-docs
   - All BMAD framework, PRD, architecture docs
   - Separated from code repo

2. **Cleaned up code repo** - github.com/jacobmr/oncalls25_react_Back
   - Removed 546 documentation files
   - Updated .gitignore
   - Code-only now

3. **Created `production` branch**
   - `main` → deploys to staging
   - `production` → deploys to production
   - GitHub Actions workflows configured
   - All secrets set (PRODUCTION_HOST, PRODUCTION_USER, PRODUCTION_SSH_KEY)

### PRD Complete (11 Steps)
- Executive Summary
- Success Criteria (V3.1: stability, V4: AI scheduling)
- User Journeys (6 personas)
- Domain Requirements (healthcare-light)
- Innovation Focus (conversational AI)
- SaaS B2B Requirements
- **Release Scoping:**
  - V3.1: User creation bugs + last-day-of-month bug
  - V3.2: UX polish
  - V3.3: Calendar sync
  - V4: AI-powered scheduling
- Functional Requirements (FR-1, FR-2)
- Non-Functional Requirements (performance, reliability, security)

### Architecture Document
- Server inventory and analysis
- **Decision: Repurpose debug server as V2-Test**

---

## Server Architecture (Updated Plan)

| Server | IP | New Purpose | Code |
|--------|-----|-------------|------|
| **Production** | 45.55.92.178 | Live users | V2 |
| **V2-Test** | 159.203.131.40 | Test prod bug fixes | V2 (snapshot of prod) |
| **Staging** | 159.203.167.125 | V3 migration | V3 |

### Setup V2-Test Server

```bash
# In DigitalOcean:
1. Create snapshot of Production droplet (45.55.92.178)
2. Create new droplet from snapshot (or restore to debug server)
3. Update DNS: test-v2.oncalls.com → 159.203.131.40
4. Update .env to use oncalls_stage database (not oncalls_live!)
```

### Deployment Flow

```
V2 Bug Fixes:
  Local → V2-Test (159.203.131.40) → Production (45.55.92.178)

V3 Migration:
  Local → Staging (159.203.167.125) → Eventually Production
```

---

## Key Issues to Fix (V3.1)

| Issue | Priority | Status |
|-------|----------|--------|
| User creation bugs (duplicates) | P0 | To investigate |
| Last-day-of-month bug | P0 | To investigate |
| Production HTTP only (no SSL) | HIGH | To fix |
| Plaintext passwords in DB | CRITICAL | Known, needs fix |

---

## Files Created This Session

| File | Location | Purpose |
|------|----------|---------|
| `prd.md` | oncalls-docs/_bmad-output/ | Complete PRD |
| `architecture.md` | oncalls-docs/_bmad-output/ | Architecture decisions |
| `README.md` | oncalls-docs/ | Repo documentation |
| `.gitignore` | oncalls25_react_Back | Exclude docs from code repo |
| `deploy-production.yml` | .github/workflows/ | Updated for production branch |

---

## GitHub Secrets Configured

```
PRODUCTION_HOST     = 45.55.92.178
PRODUCTION_USER     = root
PRODUCTION_SSH_KEY  = [configured]
STAGING_HOST        = 159.203.167.125
STAGING_USER        = root
STAGING_SSH_KEY     = [configured]
```

---

## Next Steps

1. **Create V2-Test server** (DigitalOcean snapshot)
2. **Run Epics & Stories workflow** - `/bmad:bmm:workflows:create-epics-and-stories`
3. **Investigate bugs:**
   - User creation duplicates
   - Last-day-of-month schedule issue
4. **Fix and deploy to V2-Test first**
5. **Then deploy to Production**

---

## Quick Reference

```bash
# SSH Access
ssh oncalls-direct    # Production
ssh oncalls-staging   # Staging (V3)
ssh root@159.203.131.40  # V2-Test (after setup)

# Repos
cd ~/dev/oncalls-docs           # Documentation
cd ~/dev/Oncalls-debug_prod     # Code (or oncalls-main)

# Deploy to Production
git checkout production
git merge main
git push  # Triggers GitHub Actions
```

---

**Checkpoint Created:** 2025-12-19 ~11:15 PM CT
