---
document: architecture
project: OncallsV31
date: 2025-12-19
status: draft
---

# OnCalls V3.1 Architecture Document

## Executive Summary

OnCalls currently runs on **3 servers**, but only **2 are needed**. The debug server should be decommissioned immediately as it contains older, buggier code than production.

**Recommendation:** Shut down debug server, consolidate to production + staging.

---

## Current Server Architecture

### Server Inventory

| Server | IP | Domain | Purpose | Status |
|--------|-----|--------|---------|--------|
| **Production** | 45.55.92.178 | oncalls.com | Live users | ACTIVE |
| **Staging** | 159.203.167.125 | test.oncalls.com | Pre-production testing | ACTIVE |
| **Debug** | 159.203.131.40 | N/A | Was for debugging | **OBSOLETE** |

### Why Debug Server is Obsolete

From code delta analysis (2025-12-19):

| Issue | Production | Staging | Debug |
|-------|------------|---------|-------|
| `data.fget()` bug | ✅ Fixed | ✅ Fixed | ❌ Still buggy |
| Git status | Initialized | Active | Uncommitted mess |
| Code freshness | Current | Current | **Stale** |

**The debug server has OLDER code than production.** It cannot be used for testing production bug fixes.

---

## Target Architecture (V3.1)

### Two-Server Model

```
┌─────────────────────────────────────────────────────────────┐
│                        GitHub Repo                          │
│                  jacobmr/oncalls25_react_Back               │
│                                                             │
│    main branch ──────────────► production branch            │
│         │                            │                      │
│         ▼                            ▼                      │
│   ┌──────────┐                ┌──────────────┐              │
│   │ Staging  │   PR/Merge     │  Production  │              │
│   │ Actions  │ ────────────►  │   Actions    │              │
│   └────┬─────┘                └──────┬───────┘              │
│        │                             │                      │
└────────┼─────────────────────────────┼──────────────────────┘
         │                             │
         ▼                             ▼
┌─────────────────┐          ┌─────────────────┐
│  Staging Server │          │ Production Server│
│ test.oncalls.com│          │   oncalls.com    │
│ 159.203.167.125 │          │  45.55.92.178    │
└─────────────────┘          └─────────────────┘
```

### Deployment Flow

1. **Development:** Push to `main` branch
2. **Staging:** Auto-deploys via GitHub Actions
3. **Testing:** Verify on test.oncalls.com
4. **Production:** Merge `main` → `production` branch
5. **Production Deploy:** Auto-deploys via GitHub Actions

---

## Component Architecture

### Backend (Flask/Python)

```
backend/
├── app/
│   ├── controllers/     # HTTP route handlers (Blueprints)
│   │   ├── AuthController.py      # Login, JWT, OAuth, Stripe webhooks
│   │   ├── MemberController.py    # User CRUD
│   │   ├── ShiftController.py     # Shift management
│   │   ├── RequestController.py   # Coverage requests
│   │   └── ReportController.py    # Analytics
│   ├── services/        # Business logic
│   │   ├── MemberService.py       # User operations (has V3.1 bug fixes)
│   │   ├── ScheduleService.py     # Schedule CRUD
│   │   └── ...
│   ├── models/          # SQLAlchemy ORM
│   │   ├── member.py              # Members (passwords table)
│   │   ├── schedule.py            # Schedule entries
│   │   └── ...
│   └── helpers/         # Utilities, decorators
├── app.py               # Application factory
├── wsgi.py              # Gunicorn entry point
└── requirements.txt
```

### Frontend (React/Vite)

```
frontend/
├── src/
│   ├── pages/           # Route components
│   │   ├── Schedule/    # Monthly, weekly, daily views
│   │   ├── Members/     # User management
│   │   └── ...
│   ├── components/      # Reusable UI
│   ├── services/        # API client (axios)
│   ├── hooks/           # Custom React hooks
│   └── context/         # Auth, theme providers
├── package.json
└── vite.config.js
```

### Database (MySQL)

```
DigitalOcean Managed MySQL
├── oncalls_live     # Production database
└── oncalls_stage    # Staging database

Key Tables:
├── passwords        # Users (Members model) - MISNAMED!
├── groups           # Organizations (tenants)
├── schedule         # Shift assignments
├── groupcalls       # Shift type definitions
├── requests         # Coverage requests
├── user_token       # JWT tokens
└── payments         # Stripe records
```

---

## Infrastructure Decisions

### ID-1: Repurpose Debug Server as V2-Test

**Decision:** Replace debug server contents with production snapshot

**Rationale:**
- Debug server has older, buggier code - useless as-is
- Need a safe place to test V2 bug fixes before production
- Staging is running V3 (React migration) - can't use for V2 testing
- Snapshot of production gives accurate test environment

**New Server Roles:**

| Server | IP | Purpose | Code Version |
|--------|-----|---------|--------------|
| Production | 45.55.92.178 | Live users | V2 |
| **V2-Test** | 159.203.131.40 | Test bug fixes | V2 (prod snapshot) |
| Staging | 159.203.167.125 | V3 migration | V3 |

**Action Items:**
1. Create DigitalOcean snapshot of Production (45.55.92.178)
2. Restore/replace debug droplet with snapshot
3. Update V2-Test .env to use `oncalls_stage` database (NOT oncalls_live!)
4. Optional: Set up DNS test-v2.oncalls.com → 159.203.131.40
5. Test deployment workflow: Local → V2-Test → Production

### ID-2: Enable HTTPS on Production

**Decision:** Enable SSL on production server

**Rationale:**
- Currently running HTTP only (SSL commented out in nginx)
- Security risk - credentials transmitted in clear text
- SEO penalty from Google

**Action Items:**
1. Uncomment SSL configuration in nginx
2. Verify Let's Encrypt certificates are valid
3. Add HTTP→HTTPS redirect

### ID-3: Standardize Deployment Paths

**Decision:** Use `/var/www/oncalls/current/` on both servers

**Rationale:**
- Production uses `/var/www/oncalls/oncalls_react` and `/var/www/oncalls/oncall_backend`
- Staging uses `/var/www/oncalls/current/`
- Inconsistency causes deployment script differences

**Action Items:**
1. Update production nginx to point to `/var/www/oncalls/current/`
2. Deploy using same structure as staging
3. Clean up legacy directories after successful deploy

---

## Security Architecture

### Authentication Flow

```
┌──────────┐     ┌──────────────┐     ┌──────────────┐
│  Client  │────►│   Flask API  │────►│   Database   │
│ (React)  │◄────│  /api/login  │◄────│  passwords   │
└──────────┘     └──────────────┘     └──────────────┘
     │                  │
     │   JWT Token      │
     │◄─────────────────┘
     │
     │   Authorization: Bearer <token>
     │──────────────────────────────────►
```

### Current Security Issues (V3.1 Must Fix)

| Issue | Severity | Status |
|-------|----------|--------|
| Plaintext passwords in DB | CRITICAL | Known, needs fix |
| HTTP only (no SSL) | HIGH | Needs fix |
| JWT secret regenerates on restart | MEDIUM | Known |

---

## Data Architecture

### Multi-Tenancy Model

- **Tenant Discriminator:** `GroupId` column
- **Isolation:** Application-level (shared database, filtered queries)
- **Super Admin:** Can access all groups (GroupId bypass)

### Key Relationships

```
Groups (organizations)
  └── Members (via GroupId)
        └── Schedule entries (via DOCID)
  └── GroupCalls (shift types)
        └── Schedule entries (via GroupCallID)
```

---

## V3.1 Bug Fix Impact

### User Creation Bug

**Affected Components:**
- `MemberService.py` - validation logic
- `MemberController.py` - error handling
- `Members.jsx` - form submission

**Root Cause:** TBD - need to investigate duplicate creation path

### Last-Day-of-Month Bug

**Affected Components:**
- `ScheduleService.py` - date handling
- `schedule.py` model - date storage

**Root Cause:** TBD - likely date boundary calculation issue

---

## Appendix: Server Access

```bash
# SSH Access (from ~/.ssh/config)
ssh oncalls-direct    # Production (45.55.92.178)
ssh oncalls-staging   # Staging (159.203.167.125)

# Service Management (on servers)
systemctl status oncalls_backend_gunicorn
systemctl restart oncalls_backend_gunicorn
nginx -t && systemctl reload nginx

# Logs
tail -f /var/log/gunicorn/error.log
tail -f /var/log/nginx/error.log
```

---

**Document Status:** Draft
**Next Steps:**
1. Approve architecture decisions
2. Create epics/stories for V3.1
3. Begin bug fixes
