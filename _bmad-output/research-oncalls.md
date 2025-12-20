# OnCalls V3.1 - Research & Analysis Report

**Generated:** 2025-12-19
**Project:** OncallsV31 - Medical On-Call Scheduling Platform
**Type:** Brownfield Enhancement Research

---

## Executive Summary

OnCalls is a medical on-call scheduling platform with Flask backend and React frontend, integrated with Stripe billing.

### Key Findings

**Strengths:**
- Modern tech stack (Flask 2.3, React 19, SQLAlchemy)
- Stripe subscription billing
- Multi-facility/group support
- Service-oriented architecture

**Critical Issues:**
- Plaintext password storage (HIPAA violation)
- data.fget() bug pattern (fixed)
- Missing input validation
- Race conditions in billing updates

---

## Domain Research - Medical Scheduling

### Industry Best Practices

1. **24/7 Coverage**: Continuous schedules with handoff mechanisms
2. **Fair Distribution**: Point-based assignment, burnout prevention
3. **Compliance**: State medical board rules, hospital policies
4. **Mobile-First**: Push notifications, shift swaps

### HIPAA Requirements

| Requirement | Status | Risk |
|-------------|--------|------|
| Encryption at rest | Unknown | HIGH |
| Encryption in transit | TLS | MEDIUM |
| Access controls (RBAC) | Partial | HIGH |
| Audit logging | Basic | HIGH |
| Password hashing | NONE | CRITICAL |

---

## Competitive Landscape

| Competitor | Focus | Pricing |
|------------|-------|---------|
| QGenda | Enterprise, ML scheduling | $$$$ |
| Amion | Academic/Hospital | $20-50k/year |
| OnCall Schedule | Mid-market | $299/month |

### Differentiation Opportunities

1. **Specialty-Specific**: Residency/fellowship programs
2. **Mobile-First**: Native apps (competitors weak here)
3. **Integration Depth**: EMR, payroll systems
4. **AI-Powered Fairness**: ML-based shift optimization

---

## Technical Issues (Priority Order)

### CRITICAL

1. **Plaintext Passwords** - Must implement bcrypt hashing
2. **data.fget() Bug** - Change to data.get() - FIXED

### HIGH

3. **Race Conditions** - Add database locking for Stripe updates
4. **Input Validation** - Add Marshmallow schemas
5. **Error Handling** - Standardize patterns

### MEDIUM

6. **Stripe Webhook Verification** - Add signature checking
7. **Frontend State** - Add Zustand/Redux
8. **API Documentation** - Add OpenAPI/Swagger

---

## Recommendations

### Phase 1: Security (1-2 weeks)
- Implement password hashing
- Add input validation
- Fix race conditions

### Phase 2: Architecture (3-4 weeks)
- Add TypeScript to frontend
- Database migrations (Alembic)
- API documentation

### Phase 3: Features (5-8 weeks)
- Mobile-responsive refresh
- Real-time notifications
- Advanced reporting

---

## Pricing Strategy

**Tiered Model:**
- Starter: $99/month (5 staff)
- Professional: $299/month (50 staff)
- Enterprise: Custom pricing

---

**Full research conducted by search-specialist agent.**
