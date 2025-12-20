# OnCalls Server Infrastructure Audit

**Date:** 2025-12-19
**Auditor:** Claude Code + JMR
**Project:** OncallsV31

---

## Executive Summary

Three DigitalOcean droplets run OnCalls infrastructure. Production was operating **without version control** for 429+ days until this audit initialized git. The debug server had **53 uncommitted changes** containing potential bug fixes.

---

## Server Inventory

| Server | IP | Droplet Name | SSH Alias | Uptime |
|--------|-----|--------------|-----------|--------|
| **Production** | 45.55.92.178 | oncallsprod | `oncalls-direct` | 429+ days |
| **Staging** | 159.203.167.125 | TempDropOncalls | `oncalls-staging` | 142+ days |
| **Debug** | 159.203.131.40 | oncallsprod2025082000debug | `oncalls-debug` | 120 days |

---

## Detailed Server Configuration

### Production Server (45.55.92.178)

```yaml
hostname: debian-s-2vcpu-4gb-nyc3-01
database: oncalls_live  # LIVE PRODUCTION DATA
domain: oncalls.com (assumed)
git_status: INITIALIZED 2025-12-19
git_commit: 914109d
files_tracked: 9,150
path: /var/www/oncalls/
structure:
  - oncall_backend/     # Flask API
  - oncall_frontend/    # Legacy frontend
  - oncalls_react/      # React frontend
```

**CRITICAL NOTES:**
- This is the LIVE production server
- Was running WITHOUT git for 429+ days
- Git initialized during this audit
- Any changes here affect real users

### Staging Server (159.203.167.125)

```yaml
hostname: TempDropOncalls
database: (needs verification)
domain: test.oncalls.com (assumed)
git_status: Has git
path: /var/www/oncalls/current/
structure:
  - current/            # Git-deployed code
```

**NOTES:**
- Used for pre-production testing
- Has proper git-based deployment
- GitHub Actions deploys here on push to main

### Debug Server (159.203.131.40)

```yaml
hostname: oncallsprod2025082000debug
database: oncalls_stage  # SAFE - not production
domain: debug.oncalls.com
git_status: COMMITTED 2025-12-19
git_commit: 5cfc6802
path: /var/www/debug-oncalls/
structure:
  - backend/            # Flask API with fixes
  - frontend/           # React frontend
  - oncallsreact/       # Additional React code
```

**CRITICAL NOTES:**
- Uses `oncalls_stage` database - SAFE for testing
- Had 53 uncommitted changes - NOW COMMITTED
- Contains potential bug fixes not in production
- Includes `MemberService.py.backup` and `.original` files

---

## Database Configuration

| Server | DB_NAME | Safety |
|--------|---------|--------|
| Production | `oncalls_live` | LIVE DATA - CAUTION |
| Staging | TBD | Safe for testing |
| Debug | `oncalls_stage` | Safe for testing |

**Database Host:** `db-mysql-oncalls-do-user-4885460-0.e.db.ondigitalocean.com:25060`

---

## Git Status Summary

| Server | Before Audit | After Audit |
|--------|--------------|-------------|
| Production | NO GIT | Initialized, 9150 files committed |
| Staging | Has git | Unchanged |
| Debug | 53 uncommitted changes | All changes committed |

### Production Initial Commit
```
Commit: 914109d
Message: Initial commit: Production server state as of 2025-12-19
Files: 9,150
```

### Debug Server Commit
```
Commit: 5cfc6802
Message: Sync debug server changes - 2025-12-19
Files: 211 changed
Includes: MemberService fixes, UI updates, various controller changes
```

---

## SSH Access

Add these to `~/.ssh/config`:

```
Host oncalls-direct
    HostName 45.55.92.178
    User root

Host oncalls-staging
    HostName 159.203.167.125
    User root

Host oncalls-debug
    HostName 159.203.131.40
    User root
```

**Quick Access:**
```bash
ssh oncalls-direct    # Production
ssh oncalls-staging   # Staging
ssh oncalls-debug     # Debug
```

---

## Known Issues by Server

### Production (45.55.92.178)
- [ ] User creation bugs (duplicate users reported)
- [ ] "Can't schedule last day of month" issue
- [ ] Plaintext password storage (HIPAA concern)

### Debug (159.203.131.40)
- [x] May contain fixes for user creation bugs
- [x] May contain fix for last-day-of-month issue
- [x] Changes now committed (previously at risk)

### Staging (159.203.167.125)
- [ ] Needs delta analysis with debug server
- [ ] V2→V3 frontend transition in progress

---

## Recommended Actions

### Immediate
1. ~~Initialize git on production~~ ✅ DONE
2. ~~Commit debug server changes~~ ✅ DONE
3. Compare MemberService.py across all three servers
4. Identify and cherry-pick bug fixes to production

### Short-term
1. Set up remote repository for production git
2. Create PR from debug fixes for review
3. Deploy verified fixes to production
4. Merge debug fixes into staging

### Long-term
1. Consolidate to single repository with branches
2. Implement proper CI/CD for all environments
3. Address security issues (password hashing)

---

## File Comparison Needed

Priority files to compare across servers:
- `app/services/MemberService.py` - User creation logic
- `app/services/HomeService.py` - Schedule logic
- `app/controllers/MemberController.py` - User endpoints
- `app/controllers/HomeController.py` - Schedule endpoints

---

**Document Created:** 2025-12-19
**Last Updated:** 2025-12-19
