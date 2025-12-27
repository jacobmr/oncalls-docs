# OnCalls V3.1 PRD: Traditional Onboarding Improvements

**Version:** 3.1  
**Created:** 2025-12-22  
**Status:** Draft  
**Author:** Devin (requested by @jacobmr)

---

## 1. Executive Summary

V3.1 focuses on improving the onboarding experience for new OnCalls users through traditional UX patterns: guided checklists, smart empty states, and role-appropriate welcome flows. The goal is to reduce time-to-first-value for both admins (creating their first usable schedule) and physicians (understanding how to view schedules and make requests).

**Key Outcome:** A new admin can set up their group and publish their first schedule without external documentation or support.

---

## 2. Goals & Success Metrics

### Primary Goals
1. Reduce admin setup abandonment rate
2. Decrease time from registration to first published schedule
3. Eliminate "now what?" confusion for newly invited physicians
4. Enable self-service onboarding without manual or support tickets

### Success Metrics

| Metric | Current State | V3.1 Target |
|--------|---------------|-------------|
| % of new groups with shifts defined within 24h | Unknown (no telemetry) | 60% |
| % of new groups with members added within 24h | Unknown | 70% |
| % of new groups with schedule entries within 7 days | Unknown | 50% |
| Support tickets mentioning "how to start" | Baseline TBD | -50% |
| Physician first-session bounce rate | Unknown | <30% |

---

## 3. User Personas

### Admin (Power User)
- **Role:** Practice manager, chief resident, or scheduling coordinator
- **Goal:** Set up and manage on-call schedules for their group
- **Pain Points:** 
  - Doesn't know where to start after registration
  - Unclear sequence: members first? shifts first? schedule first?
  - No feedback on setup progress

### Physician (End User)
- **Role:** Doctor, resident, or provider who views schedules and makes requests
- **Goal:** See when they're on call, request time off, volunteer for shifts
- **Pain Points:**
  - Lands on home screen after password setup with no guidance
  - Doesn't understand request approval workflow
  - Unclear what actions are available to them vs admin-only

---

## 4. Activation Milestones

These are the key steps in the onboarding funnel that we will track and optimize:

| Milestone | Definition | Persona |
|-----------|------------|---------|
| M0: Account Created | Admin completes registration | Admin |
| M1: First Member Added | At least 1 member exists in group | Admin |
| M2: First Shift Type Created | At least 1 shift type defined | Admin |
| M3: First Schedule Entry | At least 1 schedule assignment exists | Admin |
| M4: First Invite Sent | At least 1 member has pending/completed password setup | Admin |
| M5: Physician Activated | Physician completes password setup and views schedule | Physician |
| M6: First Request Submitted | Physician submits time-off or volunteer request | Physician |

---

## 5. Feature Specifications

### Epic 1: Admin Activation Checklist

**Description:** A persistent "Getting Started" panel on the HomeScreen that guides new admins through setup steps.

**UX Flow:**
1. After login, if group is in "new" state (no members, no shifts, no schedule), show Getting Started panel
2. Panel displays checklist with 4-5 steps, each with status indicator
3. Each step links directly to the relevant screen
4. Steps auto-complete when conditions are met (server-side check)
5. Panel can be dismissed; dismissal state stored in localStorage
6. Dismissed panel shows as collapsed "Setup Progress" indicator

**Checklist Steps:**
1. **Add team members** - Links to /members - Complete when members.count > 0
2. **Create shift types** - Links to /shifts - Complete when shifts.count > 0
3. **Build your schedule** - Links to /month-schedule - Complete when schedule.count > 0
4. **Invite your team** - Links to /members with invite modal - Complete when invites.sent > 0
5. **Review requests** (optional) - Links to /manage-requests - Always available

**Acceptance Criteria:**
- [ ] Panel appears for admins with incomplete setup
- [ ] Each step shows correct completion status
- [ ] Clicking step navigates to correct screen
- [ ] Panel can be dismissed and stays dismissed
- [ ] Panel does not appear for physicians
- [ ] Panel does not appear for groups with complete setup

**Technical Notes:**
- Add `/api/setup-status` endpoint returning: `{ members_count, shifts_count, schedule_count, invites_sent }`
- Store `onboarding_dismissed` in localStorage
- Check `is_admin` from auth context before rendering

---

### Epic 2: Smart Empty States

**Description:** Enhance empty states throughout the app to provide contextual guidance and next-step actions.

**Screens to Update:**

| Screen | Empty State Message | Primary Action |
|--------|---------------------|----------------|
| HomeScreen (no schedule) | "No schedule data yet. Start by creating shift types for your group." | "Create Shift Types" -> /shifts |
| Members (no members) | "Add team members to start building your schedule." | "Add Member" -> opens add modal |
| Shifts (no shifts) | "Define the shift types your group uses (e.g., Day Call, Night Call)." | "Create Shift Type" -> opens add modal |
| MonthSchedule (no entries) | "Your schedule is empty. Click on a cell to assign a provider." | None (inline guidance) |
| ManageRequests (no requests) | "No pending requests. Your team hasn't submitted any time-off or volunteer requests yet." | None (informational) |
| Reports (no data) | "Run a report to see scheduling analytics and trends." | "View Reports" -> /reports |

**Acceptance Criteria:**
- [ ] Each screen shows appropriate empty state when data is empty
- [ ] Empty states use existing EmptyState component
- [ ] Primary actions navigate to correct destination
- [ ] Empty states are role-appropriate (admin vs physician)

**Technical Notes:**
- Reuse existing `EmptyState` component with `action` prop
- Add role check for admin-only actions

---

### Epic 3: Physician Welcome Flow

**Description:** After password setup, route physicians to a welcome screen that explains their available actions.

**UX Flow:**
1. Physician completes set_password form
2. Instead of redirecting to `/` (home), redirect to `/welcome`
3. Welcome screen shows:
   - Greeting with their name
   - 3 primary action cards: "View My Schedule", "Request Time Off", "Volunteer for Shifts"
   - Brief explanation of request workflow
   - "Get Started" button to proceed to home
4. Welcome screen only shows once (tracked in localStorage)

**Welcome Screen Content:**
```
Welcome to OnCalls, Dr. [Name]!

Here's what you can do:

[View My Schedule]
See your upcoming on-call assignments and coverage.

[Request Time Off]  
Submit requests for days you need off. Your admin will review and approve.

[Volunteer for Shifts]
Pick up extra shifts when you're available.

How requests work:
When you submit a request, your group admin reviews it. You'll see the status 
update on your requests page. Approved requests appear on the schedule.

[Get Started ->]
```

**Acceptance Criteria:**
- [ ] Physicians see welcome screen after first password setup
- [ ] Welcome screen shows user's name
- [ ] Action cards link to correct screens
- [ ] "Get Started" navigates to home
- [ ] Welcome screen does not appear on subsequent logins
- [ ] Admins do not see physician welcome screen

**Technical Notes:**
- Create `/welcome` route with `WelcomeScreen.jsx`
- Store `welcome_completed` in localStorage
- Check role before showing welcome vs admin checklist

---

### Epic 4: Invite Flow Improvements

**Description:** Make it easier for admins to invite team members and track invite status.

**Features:**
1. **Invite Button on Members Page** - Prominent "Invite Members" button
2. **Invite Modal** - Enter email addresses, preview invite email, send
3. **Pending Invites List** - Show members with pending password setup
4. **Resend Invite** - Allow resending invite email for pending members

**UX Flow:**
1. Admin clicks "Invite Members" on Members page
2. Modal opens with email input (supports multiple emails)
3. Admin sees preview of invite email
4. Admin clicks "Send Invites"
5. Members page shows "Pending" badge for invited but not activated members
6. Admin can click "Resend" for pending members

**Acceptance Criteria:**
- [ ] Invite button visible on Members page for admins
- [ ] Modal accepts multiple email addresses
- [ ] Invite email preview is accurate
- [ ] Pending status shows for invited members
- [ ] Resend functionality works
- [ ] Non-admins cannot access invite functionality

**Technical Notes:**
- May require new `/api/invite` endpoint or enhancement to existing member creation
- Track invite status in members table or separate invites table

---

## 6. UX Wireframes

### Admin Activation Checklist (HomeScreen)

```
+--------------------------------------------------+
|  Getting Started                            [x]  |
+--------------------------------------------------+
|                                                  |
|  Complete these steps to set up your schedule:   |
|                                                  |
|  [x] 1. Add team members          [View ->]      |
|  [ ] 2. Create shift types        [Create ->]    |
|  [ ] 3. Build your schedule       [Start ->]     |
|  [ ] 4. Invite your team          [Invite ->]    |
|                                                  |
|  Progress: 1 of 4 complete                       |
+--------------------------------------------------+
```

### Smart Empty State (Shifts Page)

```
+--------------------------------------------------+
|                                                  |
|        [icon: calendar-plus]                     |
|                                                  |
|        No Shift Types Yet                        |
|                                                  |
|  Define the shift types your group uses          |
|  (e.g., Day Call, Night Call, Weekend).          |
|                                                  |
|        [Create Shift Type]                       |
|                                                  |
+--------------------------------------------------+
```

---

## 7. Technical Requirements

### New API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/setup-status` | GET | Returns setup completion counts for checklist |

### Frontend Components

| Component | Location | Purpose |
|-----------|----------|---------|
| `GettingStartedPanel` | `components/Onboarding/` | Admin checklist panel |
| `WelcomeScreen` | `pages/WelcomeScreen.jsx` | Physician welcome flow |

### State Management

| State | Storage | Purpose |
|-------|---------|---------|
| `onboarding_dismissed` | localStorage | Track if admin dismissed checklist |
| `welcome_completed` | localStorage | Track if physician completed welcome |

---

## 8. Rollout Plan

### Phase 1: Foundation (Week 1-2)
- Add `/api/setup-status` endpoint
- Create `GettingStartedPanel` component
- Implement admin checklist on HomeScreen

### Phase 2: Empty States (Week 2-3)
- Update all empty states with contextual messaging
- Add action buttons to empty states

### Phase 3: Physician Welcome (Week 3-4)
- Create WelcomeScreen component
- Update set_password redirect logic
- Add welcome flow tracking

### Phase 4: Invite Flow (Week 4-5)
- Add invite modal to Members page
- Implement pending status display
- Add resend functionality

---

## 9. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| No telemetry to measure baseline | Can't prove improvement | Add basic analytics before launch |
| localStorage cleared = repeated onboarding | Minor annoyance | Consider server-side tracking for critical state |
| Checklist feels patronizing to experienced users | User frustration | Make dismissible, remember preference |
| Empty states too verbose | Cluttered UI | Keep messaging concise, test with users |

---

## 10. Dependencies

- Backend endpoint for setup status counts
- Reliable email delivery for invite flow
- Role/permission system working correctly

---

## 11. Out of Scope for V3.1

- AI-assisted onboarding (see V3.1a PRD)
- Video tutorials or interactive walkthroughs
- In-app chat support
- Mobile app onboarding (web only)
- Onboarding analytics dashboard

---

## 12. Estimated Effort

| Epic | Effort | Priority |
|------|--------|----------|
| Epic 1: Admin Activation Checklist | 3-4 days | P0 |
| Epic 2: Smart Empty States | 2-3 days | P0 |
| Epic 3: Physician Welcome Flow | 2-3 days | P1 |
| Epic 4: Invite Flow Improvements | 3-4 days | P2 |

**Total Estimated Effort:** 10-14 days

---

## Appendix A: Comparison with V3.1a

See [PRD-V31a-AI-Onboarding.md](./PRD-V31a-AI-Onboarding.md) for the AI-assisted alternative approach.

| Aspect | V3.1 (Traditional) | V3.1a (AI-Assisted) |
|--------|-------------------|---------------------|
| Implementation Complexity | Low | Medium-High |
| Ongoing Cost | None | LLM API costs |
| Time to Ship | 2-3 weeks | 4-6 weeks |
| User Learning Curve | Familiar patterns | New interaction model |
| Scalability | Excellent | Cost scales with usage |
| Maintenance | Low | Medium (prompt tuning, model updates) |
