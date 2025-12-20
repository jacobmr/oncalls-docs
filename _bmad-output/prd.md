---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8]
inputDocuments:
  - _bmad-output/research-oncalls.md
  - _bmad-output/oncalls-v31-technical-documentation.md
  - _bmad-output/server-infrastructure-audit.md
  - _bmad-output/code-delta-analysis.md
documentCounts:
  briefs: 0
  research: 1
  brainstorming: 0
  projectDocs: 3
workflowType: 'prd'
lastStep: 8
project_name: 'OncallsV31'
user_name: 'Jmr'
date: '2025-12-19'
---

# Product Requirements Document - OncallsV31

**Author:** Jmr
**Date:** 2025-12-19

## Executive Summary

OnCalls V3.1 addresses critical production stability issues and completes the UX modernization started in V3, setting the foundation for V4's AI-powered scheduling capabilities.

### Vision Alignment

**Immediate Goals (V3.1):**
- Stabilize production: Fix user creation bugs, duplicate user issues, and schedule edge cases (last day of month)
- Complete V2→V3 UX transition: Modern, intuitive workflows for account creation, shift configuration, and service setup

**Future Direction (V4):**
- AI-assisted conversational onboarding and schedule creation
- Intelligent, equitable monthly schedule generation
- Chatbot UX for natural language interaction with the system

### What Makes This Special

OnCalls transforms from a functional but klunky scheduling tool into an **intelligent scheduling partner**. The V4 vision introduces conversational AI that:

1. **Guides onboarding** - New groups set up through natural dialogue, not confusing forms
2. **Simplifies configuration** - "Tell me about your call schedule" replaces manual shift/service creation
3. **Ensures equity** - AI creates fair schedules considering preferences, history, and burnout prevention
4. **Speaks the language** - Understands medical practice workflows and terminology

The V3.1 work stabilizes the foundation and modernizes the UX to prepare for this AI-first future.

## Project Classification

**Technical Type:** SaaS B2B Web Application
**Domain:** Healthcare (Medical Scheduling)
**Complexity:** HIGH
**Project Context:** Brownfield - extending existing Flask/React system

### Technical Considerations

As a medical scheduling application, this PRD addresses:
- **Security** - Password hashing (critical fix needed), audit logging, input validation
- **Reliability** - 24/7 availability for on-call coordination
- **Data Integrity** - Prevent duplicate users, ensure schedule accuracy

## Success Criteria

### User Success

**V3.1 - "It just works"**
- Zero confusion in core workflows (account creation, shift config, service setup)
- No bug-related frustration - user creation, duplicates, and scheduling issues eliminated
- Task completion rate: 95%+ of admins complete setup without support contact
- Primary user: Physicians who both onboard their group AND create monthly schedules

**V4 - "The schedule makes itself!"**
- Monthly schedule generation requires < 5 minutes of user time
- New group onboarding completes in < 10 minutes (vs current ~30+ minutes)
- AI handles complexity invisibly - users confirm and go
- Physician time reclaimed: Hours per month → Minutes per month

### Business Success

| Milestone | Target | Growth Engine |
|-----------|--------|---------------|
| 3 months post-V3.1 | Revenue begins, 50 new groups | Sales + Advertising |
| 12 months (V4 launched) | $15,000 MRR, 200 total groups | Sales + Advertising + Word of Mouth |

**Growth Hypothesis:** Targeted sales outreach to medical practices combined with digital advertising will drive initial adoption. Product quality and time savings will generate referrals.

### Technical Success

| Metric | Target | Measurement |
|--------|--------|-------------|
| Uptime | 99.9% | Synthetic monitoring |
| Monthly view load time | < 2 seconds | Real User Monitoring (RUM) |
| Day/Week view load time | < 0.5 seconds | Real User Monitoring (RUM) |
| Critical errors | Zero | Error tracking (Sentry or equivalent) |

**Definition of "Critical Error":** Any error that blocks a user from completing their primary task (schedule creation, schedule viewing, or user management).

**Infrastructure:** Will scale with user growth - not a V3.1 blocker but ongoing operational concern.

### Measurable Outcomes

| Metric | Current State | V3.1 Target | V4 Target |
|--------|---------------|-------------|-----------|
| Support tickets for bugs | Unknown | Zero | Zero |
| Group onboarding time | ~30+ min | < 15 min | < 10 min |
| Monthly schedule creation | Unknown | < 15 min | < 5 min |
| Task completion rate (no support) | Unknown | 90% | 95% |
| User churn (UX frustration) | Unknown | Eliminated | Eliminated |

**Observability Required:** Baseline metrics must be established in V3.1 to measure V4 improvements.

## Product Scope

### MVP - V3.1 (Stability + UX)

- Fix all critical production bugs (user creation, duplicates, last-day-of-month)
- Complete UX modernization for all core workflows
- Achieve 99.9% uptime and performance targets
- Revenue-ready: billing works flawlessly
- Establish baseline metrics for task completion and timing

### Growth - V4 (AI Scheduling)

- AI-generated monthly schedules with equity logic
- Conversational onboarding via chatbot UX
- Intelligent scheduling that learns preferences
- "5 minutes a month" schedule creation
- Sales/advertising funnel optimization

### Vision (Future)

- Full chatbot UX for all system interactions
- Predictive scheduling (anticipates needs before asking)
- Mobile app for on-the-go schedule management
- EMR/payroll integrations
- Self-serve growth engine (product-led)

## User Journeys

### User Types

| User Type | In Schedule? | Can Edit? | Scope |
|-----------|--------------|-----------|-------|
| Physician Admin | Yes | Full | Their group |
| Admin User (Practice Manager) | No | Full | Their group |
| Group Member | Yes | View + Request | Their group |
| Read-Only Support Staff | No | View only | Their group |
| Super Admin | N/A | Everything | All groups |
| API Consumer | N/A | Via API | Per integration |

### Journey 1: Dr. Sarah Chen - From Spreadsheet Hell to Schedule Sanity
**The New Prospect / Physician Admin Journey**

Dr. Sarah Chen is the lead physician at a 7-doctor family medicine practice. Every month, she dreads "schedule week" - the 4-5 hours hunched over Excel, trying to remember who worked Thanksgiving last year, who's been stuck with too many weekends, and who complained about equity last time. Her partners trust her, but the job is thankless.

Late one Tuesday, frustrated after another scheduling conflict, she Googles "medical call schedule software fair." OnCalls appears. The landing page mentions "equity-based scheduling" and "weighted shifts." She clicks "Try Free."

Signup takes 90 seconds. A friendly wizard asks about her practice - physicians, shifts, coverage needs. Within 10 minutes, she's configured everything. The breakthrough: she clicks "Generate Schedule" and the system asks about weightings - "Should Thanksgiving count more than a regular Thursday?" Yes! She hits generate, and in 8 seconds, a balanced schedule appears. For the first time in three years, schedule week took 15 minutes instead of 5 hours.

**Requirements Revealed:**
- Frictionless signup (< 2 minutes)
- Conversational onboarding wizard
- Shift weighting configuration (holidays > weekdays, weekends > weekdays)
- Equity-based schedule generation
- Visual equity dashboard

### Journey 2: Wanda Martinez - The Practice Manager Who Orchestrates Everything
**The Admin User Journey**

Wanda Martinez has managed Albany Family Medicine for 12 years. She doesn't take call, but she's responsible for every shift - not just night call, but clinic schedules, hospital rounding, nursing home visits, school sports coverage. Before OnCalls, she had a wall calendar, three spreadsheets, and a prayer.

With OnCalls V4, Wanda opens the conversational interface: "I need to build January. Dr. Chen requested the 15th off, and we need nursing home coverage Tuesdays and Thursdays." The AI responds with suggestions, she tweaks two assignments, done in 20 minutes instead of two days.

When Dr. Patel texts at 6 AM that he can't round, Wanda opens OnCalls, sees who's available, reassigns in 30 seconds, and texts: "You're covering. It's in the app."

**Requirements Revealed:**
- Multi-location/multi-shift-type scheduling (clinic, hospital, nursing home, sports events)
- Time-off request management
- Quick swap/reassignment workflow
- AI-assisted schedule building (V4)
- Preference tracking per physician

### Journey 3: Dr. Marcus Williams - The Group Member Who Just Wants Control
**The View/Request/Trade Journey**

Dr. Marcus Williams doesn't make the schedule, but he lives by it. His phone buzzes every morning: "Today: Clinic AM, Hospital PM. Tomorrow: OFF."

Marcus works the system strategically - volunteering for Super Bowl Sunday (he doesn't watch football) to bank goodwill for his daughter's recitals. When his mother gets sick, he opens OnCalls, finds an available colleague, sends a swap request: "Can you cover Thursday? I'll take Saturday." Accepted within an hour.

His favorite feature: calendar sync. OnCalls shifts appear in his iPhone alongside family events. When his wife texts "Can you come to dinner?", he asks the chatbot: "Am I on call tonight?" Answer: "No, Dr. Patel is on call. You're off."

**Requirements Revealed:**
- Daily schedule notifications
- Advance and emergency time-off requests
- Volunteer/preference system
- Peer-to-peer swap requests with approval workflow
- Calendar sync (iCal, Google Calendar)
- Chatbot queries ("Who's on call tonight?")

### Journey 4: Maria Santos - The Hospital Operator Who Routes Everything
**The Read-Only Support Staff Journey**

Maria works the switchboard at Albany Medical Center. Every few minutes, someone needs a doctor - nurses, ER physicians, pharmacy, families. Her job: connect them fast.

Before OnCalls, she had a laminated paper schedule, always out of date. She'd page the wrong doctor, wait five minutes, get an annoyed callback: "I'm not on call."

Now OnCalls is open in a browser tab. A nurse calls: "I need pediatrics attending." Maria types "peds," sees "Dr. Chen - Peds Rounding - until 5 PM," transfers in 10 seconds. At 3 AM, the ER needs OB consult - she checks, pages the right doctor, done.

The OR scheduler uses the same view: "Who's available for an add-on case tomorrow?" Quick lookup, direct call.

**Requirements Revealed:**
- Fast, searchable schedule lookup
- Real-time accuracy (no stale data)
- Role/location filtering ("who's at AMC?", "who's doing peds?")
- Mobile-friendly for floor staff
- Strict read-only permissions
- Time-aware queries (now vs. tonight vs. tomorrow)

### Journey 5: JMR - The Platform Owner Who Sees Everything
**The Super Admin Journey**

JMR checks the admin dashboard daily: 47 active groups, 3 pending payments, 1 support ticket.

When a group reports "last day of month won't save," he opens their view in super admin mode, replicates the bug in 30 seconds, notes it's the same issue three groups reported, logs and prioritizes.

Payment failures trigger alerts. He checks Stripe, sees an expired card, sends a reminder. Non-responders get access paused - data preserved for when they return.

Password resets are 90% self-service now. He only intervenes for truly locked-out users.

**Requirements Revealed:**
- Cross-group visibility dashboard
- "View as group" impersonation mode for debugging
- Payment/subscription management
- Support ticket tracking
- Self-service password reset
- Non-destructive suspension (preserve data)

### Journey 6: Albany Medical Center IT - The API Integration
**The API Consumer Journey**

AMC's IT team builds a physician portal. When a nurse needs to page on-call pediatrics, the system should know - no phone calls to the front desk.

They discover OnCalls has an API. Integration is simple: authenticate, call `GET /api/v1/schedule?date=today&shift=peds-call`, receive JSON with physician name and contact. The portal now shows "On Call: Dr. Sarah Chen" in real-time.

Later, they extend it: when a physician marks unavailable in HR, it creates a time-off request via `POST /api/v1/requests`. Wanda sees and approves without a phone call.

**Requirements Revealed:**
- RESTful API with authentication
- CRUD for schedules, users, requests
- Webhook notifications for changes
- API documentation (OpenAPI/Swagger)
- Rate limiting and security

### Journey Requirements Summary

| Capability | Journeys | Version |
|------------|----------|---------|
| Frictionless onboarding | 1 | V3.1 |
| Equity-based scheduling with weightings | 1, 2 | V3.1/V4 |
| Multi-location/shift-type support | 2 | V3.1 |
| Time-off requests (advance + emergency) | 2, 3 | V3.1 |
| Peer swap requests | 3 | V3.1 |
| Calendar sync | 3 | V3.1 |
| Chatbot queries | 3 | V4 |
| Fast read-only lookup | 4 | V3.1 |
| Super admin cross-group view | 5 | V3.1 |
| Payment/subscription management | 5 | V3.1 |
| Self-service password reset | 5 | V3.1 |
| RESTful API | 6 | V4 |

## Domain-Specific Requirements

### Healthcare Scheduling - Compliance Overview

OnCalls operates in the healthcare domain but with a **reduced compliance burden**:

| Concern | Applies? | Rationale |
|---------|----------|-----------|
| FDA Approval | No | Not a medical device - scheduling only |
| Clinical Validation | No | No clinical decision-making |
| HIPAA Compliance | No | No PHI stored - only names, schedules, contact info |
| Patient Safety | Indirect | Wrong on-call assignment could delay patient care |
| Liability | Possible | Schedule errors affecting patient outcomes |
| 24/7 Reliability | Yes | On-call coordination is time-critical |

### Key Domain Concerns

**1. Indirect Patient Safety**
- A scheduling error (wrong doctor listed as on-call) could delay patient care
- Mitigation: Real-time accuracy, no stale data, clear visibility for operators
- Requirement: System must reflect current schedule state within seconds of any change

**2. Operational Reliability**
- Hospital operators depend on OnCalls at 3 AM for urgent consults
- Downtime = phone trees, paper schedules, wrong pages, delayed care
- Requirement: 99.9% uptime, graceful degradation, mobile-accessible

**3. Liability Considerations**
- If a patient is harmed due to a schedule display error, liability could arise
- Mitigation: Audit trails, change logs, clear timestamps
- Requirement: Full audit history of schedule changes with who/when/what

**4. Data Accuracy Over Features**
- In healthcare scheduling, correctness beats novelty
- A fancy AI suggestion that's wrong is worse than a manual schedule that's right
- Requirement: V4 AI must have human confirmation before any schedule is published

### Implementation Considerations

- **Audit logging**: Every schedule change tracked with user, timestamp, before/after
- **Read-only access**: Support staff see schedules but cannot modify (prevents accidental changes)
- **Confirmation workflows**: No silent updates - changes require explicit save/confirm
- **Fallback access**: If system is down, cached schedule available offline or via SMS

## Innovation & Novel Patterns

### Detected Innovation Areas

**1. Conversational Onboarding (V4)**
- Traditional approach: 15+ form fields, confusing terminology, high abandonment
- OnCalls V4: "Tell me about your call schedule" → AI extracts structure
- Innovation: LLM understands medical scheduling context without explicit training per practice

**2. Equity-Aware AI Scheduling (V4)**
- Traditional approach: Manual spreadsheet balancing, complaints, politics
- OnCalls V4: AI generates schedules with weighted fairness (holidays > weekdays, weekends > weekdays)
- Innovation: Algorithmic equity that learns practice-specific preferences

**3. Domain-Specific Chatbot (V4)**
- Traditional approach: Search/filter UIs, multiple clicks to find "who's on call"
- OnCalls V4: "Who's rounding at AMC tomorrow?" → instant answer
- Innovation: Natural language queries against live schedule data

### Market Context & Competitive Landscape

| Competitor | AI Features | Price Point | Gap |
|------------|-------------|-------------|-----|
| QGenda | ML scheduling | $$$$ Enterprise | No SMB offering |
| Amion | None | $$$ Mid-market | Manual only |
| OnCall Schedule | None | $$ SMB | No intelligence |
| **OnCalls V4** | Conversational + Equity AI | $ SMB | **First mover** |

**Market Opportunity:** First conversational AI scheduling tool at SMB price point for medical practices.

### Validation Approach

| Innovation | Validation Method | Success Criteria |
|------------|-------------------|------------------|
| Conversational onboarding | A/B test vs. form-based | 50% faster setup, higher completion |
| Equity AI | User satisfaction survey | "Fairer than manual" rating > 80% |
| Chatbot queries | Usage analytics | 50%+ of users try chatbot in first week |

**Pilot Strategy:**
1. Launch AI features to 5 friendly existing groups first
2. Gather feedback, iterate on prompts and UI
3. Measure time-to-schedule vs. manual baseline
4. Expand to new signups after validation

### Risk Mitigation

| Risk | Mitigation |
|------|------------|
| AI generates bad schedule | Human confirmation required before publish |
| LLM hallucination | Validate all AI outputs against actual data |
| Users don't trust AI | "Preview → Adjust → Confirm" workflow |
| AI too slow | Cache common queries, optimize prompts |
| Cost of LLM calls | Monitor usage, implement rate limits |

**Fallback:** If AI features underperform, users can always create schedules manually. AI is additive, not replacing core functionality.

## SaaS B2B Specific Requirements

### Multi-Tenancy Model

- Each **Group** (medical practice) is an isolated tenant
- Groups cannot see or access other groups' data
- Super Admin has cross-tenant visibility for support/debugging
- Database uses `GroupId` as tenant discriminator

### Permission Matrix (RBAC)

| Role | View Schedule | Edit Schedule | Manage Users | Request Swaps | View All Groups |
|------|---------------|---------------|--------------|---------------|-----------------|
| Physician Admin | ✅ | ✅ | ✅ | ✅ | ❌ |
| Admin User | ✅ | ✅ | ✅ | N/A | ❌ |
| Group Member | ✅ | ❌ | ❌ | ✅ | ❌ |
| Read-Only Staff | ✅ | ❌ | ❌ | ❌ | ❌ |
| Super Admin | ✅ | ✅ | ✅ | ✅ | ✅ |
| API Consumer | Per-scope | Per-scope | Per-scope | Per-scope | ❌ |

### Subscription Tiers

| Tier | Price | Staff Limit | Features |
|------|-------|-------------|----------|
| Starter | $99/month | Up to 10 | Core scheduling, calendar sync |
| Professional | $299/month | Up to 50 | + API access, advanced reporting |
| Enterprise | Custom | Unlimited | + SSO, dedicated support, SLA |

### Integration Requirements

| Integration | Version | Priority | Status |
|-------------|---------|----------|--------|
| Stripe Billing | V3.1 | Critical | Existing |
| Calendar Sync (iCal/Google) | V3.1 | High | Existing |
| RESTful API | V4 | High | Planned |
| Webhook Notifications | V4 | Medium | Planned |
| EMR Integration | Future | Low | Vision |
| Payroll Integration | Future | Low | Vision |

### Technical Architecture

- **Backend**: Flask (Python) with SQLAlchemy ORM
- **Frontend**: React 19 with Vite, Tailwind CSS
- **Database**: MySQL (DigitalOcean managed)
- **Authentication**: JWT tokens with refresh mechanism
- **Hosting**: DigitalOcean droplets (scale with growth)

## Release Scoping

### V3.1 - Stability Release (MVP)

**Goal:** Fix critical production bugs. Ship fast, ship stable.

| Priority | Item | Description |
|----------|------|-------------|
| **P0 - MUST** | User creation bugs | Fix duplicate user creation, validation failures |
| **P0 - MUST** | Last-day-of-month bug | Schedule entries failing on month boundaries |

**Explicitly Deferred:**
- UX polish (klunky workflows) → V3.2
- Calendar sync improvements → V3.3
- Self-service password reset → Already implemented

**Success Criteria:** Zero critical bugs in production. Users can create accounts and schedules without errors.

### V3.2 - UX Polish Release

**Goal:** Complete the V2→V3 UX modernization.

| Item | Description |
|------|-------------|
| Account creation workflow | Streamline onboarding flow |
| Shift/service configuration | Make intuitive, reduce confusion |
| Overall UI consistency | Apply modern patterns across all pages |

### V3.3 - Integration Enhancements

| Item | Description |
|------|-------------|
| Calendar sync | Improve iCal/Google Calendar reliability |
| Notification improvements | Better alerts for schedule changes |

### V4 - AI-Powered Scheduling

**Goal:** "The schedule makes itself!"

| Item | Description |
|------|-------------|
| Conversational onboarding | Chat-based group setup |
| AI schedule generation | Equity-aware automatic scheduling |
| Chatbot queries | Natural language schedule questions |

