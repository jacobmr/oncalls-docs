# OnCalls Code Delta Analysis

**Date:** 2025-12-19
**Project:** OncallsV31

---

## Executive Summary

Analysis reveals the **debug server contains OLDER code with bugs**, not fixes. Production and Staging are synchronized with the most recent fixes from `oncalls-main`.

---

## Code Flow (Correct)

```
oncalls-main (local) → Staging (159.203.167.125) → Production (45.55.92.178)
                                                           ↑
                                                    GitHub Actions
```

**Debug server (159.203.131.40) is a DEAD END - contains old buggy code.**

---

## Bug Status Summary

| Bug | oncalls-main | Staging | Production | Debug |
|-----|--------------|---------|------------|-------|
| `data.fget()` bug | ✅ Fixed (a88bb10) | ✅ Fixed | ✅ Fixed | ❌ **HAS BUG** |
| Last-day-of-month | 🔍 Debug logging added | 🔍 Has logging | 🔍 Has logging | ❌ No logging |
| User creation issues | ✅ Fixed | ✅ Fixed | ✅ Fixed | ❌ Old code |

---

## Key Finding: Debug Server is Obsolete

The debug server (159.203.131.40) still has `data.fget()` bug on line 54:
```python
# DEBUG SERVER - BUGGY
blockStart = data.fget('blockstart')  # WRONG!

# PRODUCTION/STAGING - FIXED
blockStart = data.get('blockstart')   # CORRECT
```

**Recommendation:** Do NOT push debug server code anywhere. It's older than production.

---

## Recent Commits in oncalls-main

```
a88bb10 Fix: data.fget() to data.get() in MemberService.py
78f5edb DEBUG: Add logging for last-day-of-month AMCP field bug
5b74bdd UX: Replace emergency CSS with modern MonthScheduleScreen
a3cebca EMERGENCY: Fix Schedule page layout collapse
6849019 CRITICAL: Fix missing /api prefixes in schedule_service.js
```

---

## Last-Day-of-Month Bug Status

**Status:** Under investigation (debugging only)
**Commit:** 78f5edb
**Issue:** Albany Family Med - AMCP field stays blank on last day of month (Oct 31st)
**Changes:** Console logging added to track date calculations
**Location:** `frontend/pages/ScheduleMonth/ScheduleMonthContent.jsx`

**No actual fix has been implemented yet** - only debugging instrumentation.

---

## Repository Comparison

| Repository | Location | Status | Use For |
|------------|----------|--------|---------|
| **oncalls-main** | `/Users/jmr/dev/oncalls-main/` | PRIMARY | Active development |
| **Production server** | `root@45.55.92.178:/var/www/oncalls/` | LIVE | Deployed code |
| **Staging server** | `root@159.203.167.125:/var/www/oncalls/current/` | STAGING | Pre-prod testing |
| **Debug server** | `root@159.203.131.40:/var/www/debug-oncalls/` | OBSOLETE | Do not use |

---

## Action Items

### Immediate
1. ~~Verify production has data.fget fix~~ ✅ Confirmed
2. ~~Verify staging matches production~~ ✅ Confirmed (identical)
3. Do NOT push debug server code anywhere

### To Fix Last-Day-of-Month Bug
1. Review console logs from production/staging
2. Identify root cause in date calculation logic
3. Implement fix in oncalls-main
4. Deploy to staging for testing
5. Deploy to production

### Debug Server Options
- **Option A:** Delete the droplet (saves $5-10/month)
- **Option B:** Repurpose as a fresh staging environment
- **Option C:** Keep for historical reference only

---

## File Comparison Results

### MemberService.py
- Production = Staging = oncalls-main (all have fix)
- Debug = Old code with `data.fget()` bug

### HomeService.py
- No significant differences found
- Last-day-of-month bug is likely in FRONTEND, not backend

---

**Document Created:** 2025-12-19
