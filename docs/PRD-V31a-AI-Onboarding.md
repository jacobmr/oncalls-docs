# OnCalls V3.1a PRD: AI-Assisted Onboarding

**Version:** 3.1a  
**Created:** 2025-12-22  
**Status:** Draft  
**Author:** Devin (requested by @jacobmr)

---

## 1. Executive Summary

V3.1a explores an AI-assisted approach to onboarding through a "Setup Copilot" that uses natural language to guide users through setup, answer questions, and generate draft content. This approach augments (or replaces) the traditional checklist-based onboarding with conversational guidance.

**Key Outcome:** Users can ask "How do I...?" questions and receive contextual help, while admins can describe their scheduling needs in plain English and get AI-generated templates and suggestions.

**Philosophy:** AI to reduce uncertainty and cognitive load, not AI to replace user decision-making. The copilot explains, guides, and drafts - but users always confirm before any data is created.

---

## 2. Goals & Success Metrics

### Primary Goals
1. Reduce cognitive load during initial setup
2. Provide instant answers to "how do I...?" questions
3. Accelerate shift type and schedule creation through natural language
4. Create a differentiated, modern onboarding experience

### Success Metrics

| Metric | Current State | V3.1a Target |
|--------|---------------|--------------|
| % of new groups with shifts defined within 24h | Unknown | 75% (+15% vs V3.1) |
| % of new groups with schedule entries within 7 days | Unknown | 65% (+15% vs V3.1) |
| Support tickets mentioning "how to start" | Baseline TBD | -70% |
| User satisfaction with onboarding (survey) | No baseline | >4.0/5.0 |
| Copilot engagement rate (% who use it) | N/A | >50% |

---

## 3. User Personas

### Admin (Power User)
- **Role:** Practice manager, chief resident, or scheduling coordinator
- **Goal:** Set up and manage on-call schedules for their group
- **AI Benefit:** 
  - Can describe shift types in plain English ("We need day call from 7am-7pm and night call from 7pm-7am")
  - Gets instant answers to setup questions
  - Receives smart suggestions based on common patterns

### Physician (End User)
- **Role:** Doctor, resident, or provider who views schedules and makes requests
- **Goal:** See when they're on call, request time off, volunteer for shifts
- **AI Benefit:**
  - Can ask "When am I on call next week?" instead of navigating
  - Gets explanations of how requests work
  - Receives contextual help on any screen

---

## 4. Activation Milestones

Same milestones as V3.1, with AI-assisted paths to each:

| Milestone | Traditional Path | AI-Assisted Path |
|-----------|-----------------|------------------|
| M1: First Member Added | Navigate to Members, click Add | "Add Dr. Smith to my group" |
| M2: First Shift Type Created | Navigate to Shifts, fill form | "Create a night call shift from 7pm to 7am" |
| M3: First Schedule Entry | Navigate to Month Schedule, click cell | "Schedule Dr. Smith for night call on Monday" (Phase C) |
| M4: First Invite Sent | Navigate to Members, click Invite | "Send an invite to dr.smith@hospital.com" |
| M5: Physician Activated | Complete password setup | Same + AI welcome guidance |
| M6: First Request Submitted | Navigate to Requests, fill form | "Request next Friday off" (Phase C) |

---

## 5. Phased Implementation Approach

### Phase A: Explain & Guide (MVP)
**Scope:** Read-only AI assistant that answers questions and provides guidance

**Capabilities:**
- Answer "How do I...?" questions using RAG over product documentation
- Provide contextual help based on current screen
- Explain features and workflows
- Suggest next steps based on setup status

**Example Interactions:**
```
User: "How do I add a new member?"
Copilot: "To add a team member, go to the Members page and click 'Add Member'. 
         You'll need their name and email. Would you like me to take you there?"
         [Go to Members]

User: "What's the difference between a request and a volunteer?"
Copilot: "A request is when someone asks for time off from a scheduled shift. 
         A volunteer is when someone offers to pick up an open or extra shift. 
         Both require admin approval."
```

**Technical Requirements:**
- LLM integration (OpenAI GPT-4 or Claude)
- RAG system with product documentation corpus
- Screen context awareness (current route, user role)
- Chat UI component (collapsible panel or modal)

---

### Phase B: Draft Generation
**Scope:** AI generates structured drafts that users review and confirm

**Capabilities:**
- Generate shift type templates from natural language descriptions
- Draft invite email content
- Suggest schedule patterns based on group size and shift types
- Create report filter presets from descriptions

**Example Interactions:**
```
User: "We have 5 doctors and need 24/7 coverage with day and night shifts"
Copilot: "Based on your needs, I suggest these shift types:
         
         Day Call: 7:00 AM - 7:00 PM
         Night Call: 7:00 PM - 7:00 AM
         
         With 5 doctors, each would average about 3 shifts per week for full coverage.
         
         [Create These Shifts] [Modify] [Cancel]"

User: "Draft an invite email for our new resident"
Copilot: "Here's a draft invite:
         
         Subject: Welcome to [Group Name] On-Call Schedule
         
         Hi [Name],
         
         You've been added to our on-call scheduling system. Click the link 
         below to set up your password and view your schedule.
         
         [Set Up Your Account]
         
         [Send This] [Edit] [Cancel]"
```

**Technical Requirements:**
- Structured output parsing (JSON schemas for shift types, emails, etc.)
- Preview UI for generated content
- Confirmation flow before any database writes
- Existing API endpoints for actual creation

---

### Phase C: Execute with Guardrails (Future)
**Scope:** Natural language commands that create/modify data with confirmation

**Capabilities:**
- "Schedule Dr. Smith for night call on Monday" -> Preview -> Confirm -> Create
- "Request next Friday off" -> Preview -> Confirm -> Submit
- "Show me who's on call this weekend" -> Query -> Display

**Guardrails:**
- Always show preview before any write operation
- Require explicit confirmation ("Create this?" [Yes] [No])
- Log all AI-initiated actions for audit
- Restrict to user's permission scope (physicians can't modify others' schedules)
- Rate limiting to prevent abuse

**Technical Requirements:**
- Intent classification and entity extraction
- Permission-aware action execution
- Undo/rollback capability
- Audit logging

---

## 6. Feature Specifications

### Epic 1: Copilot Chat Interface

**Description:** A persistent, collapsible chat panel available throughout the app.

**UX Flow:**
1. Floating "Ask Copilot" button in bottom-right corner
2. Click to expand chat panel
3. Type question or request
4. Copilot responds with text, links, and action buttons
5. Panel remembers conversation within session
6. Can be minimized or closed

**UI Components:**
```
+------------------+
|  OnCalls Copilot |
+------------------+
| [conversation    |
|  history here]   |
|                  |
| Copilot: How can |
| I help you today?|
|                  |
+------------------+
| Type a message...|
| [Send]           |
+------------------+
```

**Acceptance Criteria:**
- [ ] Chat panel accessible from all authenticated screens
- [ ] Conversation persists within session
- [ ] Panel can be minimized/expanded
- [ ] Copilot responds within 3 seconds
- [ ] Responses include relevant action buttons/links
- [ ] Panel shows typing indicator during response generation

---

### Epic 2: Contextual Help (Phase A)

**Description:** Copilot provides screen-aware guidance and answers questions using product knowledge.

**Knowledge Sources:**
- Product documentation (RAG corpus)
- Current screen context (route, visible data)
- User role and permissions
- Group setup status

**Prompt Engineering:**
```
System: You are the OnCalls Setup Copilot. You help users set up and use 
their medical on-call scheduling system. You have access to:
- Product documentation
- The user's current screen: {current_route}
- The user's role: {user_role}
- Group setup status: {setup_status}

Guidelines:
- Be concise and helpful
- Offer to navigate to relevant screens
- Never make up features that don't exist
- If unsure, say so and suggest contacting support
- For actions that modify data, always explain the steps rather than doing it directly
```

**Acceptance Criteria:**
- [ ] Copilot correctly answers common "how do I" questions
- [ ] Responses reference current screen context when relevant
- [ ] Copilot provides accurate information (validated against docs)
- [ ] Copilot gracefully handles questions it can't answer
- [ ] Response latency < 3 seconds p95

---

### Epic 3: Shift Type Generator (Phase B)

**Description:** Generate shift type configurations from natural language descriptions.

**Input Examples:**
- "Day shift from 7am to 7pm"
- "Night call, 7pm to 7am, weekdays only"
- "Weekend coverage, all day Saturday and Sunday"
- "We need 24/7 coverage with 12-hour shifts"

**Output Schema:**
```json
{
  "shift_types": [
    {
      "name": "Day Call",
      "abbreviation": "DC",
      "start_time": "07:00",
      "end_time": "19:00",
      "days": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    }
  ]
}
```

**UX Flow:**
1. User describes shift needs in chat
2. Copilot generates structured shift type(s)
3. Preview shown in chat with edit option
4. User clicks "Create" to confirm
5. Shift types created via existing API
6. Copilot confirms creation and suggests next step

**Acceptance Criteria:**
- [ ] Copilot correctly parses common shift descriptions
- [ ] Generated shifts use valid time formats
- [ ] Preview clearly shows what will be created
- [ ] User can edit before confirming
- [ ] Creation uses existing shift API endpoint
- [ ] Copilot handles ambiguous input gracefully

---

### Epic 4: Onboarding Guidance Flow

**Description:** Proactive copilot guidance for new users based on setup status.

**Trigger Conditions:**
- New admin logs in for first time
- Group has incomplete setup (no members, shifts, or schedule)
- User has been inactive for >30 seconds on home screen

**Proactive Messages:**
```
[First login, no setup]
Copilot: "Welcome to OnCalls! I'm your setup assistant. Would you like me to 
         help you get started? I can guide you through:
         
         1. Adding your team members
         2. Creating shift types
         3. Building your first schedule
         
         What would you like to start with?"

[Has members, no shifts]
Copilot: "Great, you've added your team! The next step is creating shift types.
         What kinds of shifts does your group use? (e.g., day call, night call)"

[Has shifts, no schedule]
Copilot: "You're almost there! Now let's build your schedule. Would you like to:
         
         - Start with a blank schedule and fill it in manually
         - Tell me your coverage needs and I'll suggest a pattern"
```

**Acceptance Criteria:**
- [ ] Proactive messages appear at appropriate times
- [ ] Messages are not annoying (max 1 per session unless user engages)
- [ ] User can dismiss proactive guidance
- [ ] Guidance adapts to current setup status
- [ ] Physicians see role-appropriate guidance

---

## 7. Technical Architecture

### System Components

```
+------------------+     +------------------+     +------------------+
|   Chat UI        | --> |   Copilot API    | --> |   LLM Provider   |
|   (React)        |     |   (Flask)        |     |   (OpenAI/Claude)|
+------------------+     +------------------+     +------------------+
                               |
                               v
                         +------------------+
                         |   RAG System     |
                         |   (Embeddings +  |
                         |    Vector DB)    |
                         +------------------+
                               |
                               v
                         +------------------+
                         |   Doc Corpus     |
                         |   (Product docs, |
                         |    help content) |
                         +------------------+
```

### New API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/copilot/chat` | POST | Send message, receive response |
| `/api/copilot/context` | GET | Get current screen context for copilot |
| `/api/copilot/generate/shifts` | POST | Generate shift types from description |
| `/api/copilot/feedback` | POST | User feedback on response quality |

### Data Flow

1. User sends message via chat UI
2. Frontend includes context (route, role, setup status)
3. Backend constructs prompt with context + RAG results
4. LLM generates response
5. Backend parses response, extracts actions/links
6. Frontend renders response with interactive elements

### Cost Estimation

| Usage Tier | Monthly Messages | Est. LLM Cost | Notes |
|------------|------------------|---------------|-------|
| Low (10 groups) | 500 | $5-10 | Testing/pilot |
| Medium (100 groups) | 5,000 | $50-100 | Early adoption |
| High (1000 groups) | 50,000 | $500-1000 | Scale |

*Based on GPT-4 pricing (~$0.01-0.03 per message with context)*

---

## 8. Safety & Compliance

### Trust Boundaries

| Action Type | AI Can Do | User Must Confirm |
|-------------|-----------|-------------------|
| Answer questions | Yes | No |
| Navigate to screens | Yes (suggest link) | Click required |
| Generate drafts | Yes | Yes, before creation |
| Create/modify data | No (Phase A-B) | Always |
| Access other groups' data | Never | N/A |

### Privacy Considerations

- Chat logs may contain names, schedules, or sensitive details
- Options:
  - Don't store chat logs (stateless)
  - Store with retention policy (30 days)
  - Anonymize before storage
- Prompts must not leak secrets or tokens
- Tenant isolation: copilot only sees current group's data

### Hallucination Mitigation

- RAG grounds responses in actual documentation
- Structured output schemas for generated content
- "I don't know" responses for out-of-scope questions
- Human review of common Q&A pairs
- Feedback mechanism to flag incorrect responses

---

## 9. Rollout Plan

### Phase A: Explain & Guide (Weeks 1-4)
- Week 1-2: Build chat UI component, copilot API skeleton
- Week 2-3: Set up RAG system with product docs
- Week 3-4: Implement contextual help, test with internal users
- Week 4: Soft launch to select groups

### Phase B: Draft Generation (Weeks 5-8)
- Week 5-6: Implement shift type generator
- Week 6-7: Add invite email drafting
- Week 7-8: Test and refine structured output
- Week 8: Expand to more groups

### Phase C: Execute with Guardrails (Future)
- Depends on Phase A-B success and user feedback
- Estimated 4-6 additional weeks
- Requires more extensive testing and guardrails

---

## 10. Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| LLM hallucinations | High (incorrect guidance) | Medium | RAG, structured output, human review |
| High API costs at scale | Medium | Medium | Caching, rate limiting, model optimization |
| Slow response times | Medium (poor UX) | Low | Streaming responses, loading indicators |
| User over-reliance on AI | Low | Low | Clear messaging that AI assists, doesn't replace |
| Security/data leakage | High | Low | Tenant isolation, prompt injection protection |
| Model API downtime | Medium | Low | Graceful degradation to traditional UI |

### Security Debt Acknowledgment

Per the technical documentation, there are existing security concerns (plaintext passwords) that should be addressed independently of this feature. The copilot feature does not exacerbate these issues but also does not address them.

---

## 11. Dependencies

- LLM API access (OpenAI or Anthropic account)
- Vector database for RAG (Pinecone, Weaviate, or pgvector)
- Product documentation corpus (needs curation)
- Backend infrastructure for copilot API
- Frontend chat component

---

## 12. Out of Scope for V3.1a

- Voice interface
- Mobile app integration
- Multi-language support
- Custom model fine-tuning
- Autonomous scheduling (AI decides without confirmation)

---

## 13. Estimated Effort

| Phase | Effort | Priority |
|-------|--------|----------|
| Phase A: Explain & Guide | 3-4 weeks | P0 |
| Phase B: Draft Generation | 2-3 weeks | P1 |
| Phase C: Execute (Future) | 4-6 weeks | P2 |

**Total Estimated Effort (A+B):** 5-7 weeks

---

## Appendix A: Comparison with V3.1

| Aspect | V3.1 (Traditional) | V3.1a (AI-Assisted) |
|--------|-------------------|---------------------|
| **Implementation Complexity** | Low | Medium-High |
| **Time to Ship (MVP)** | 2-3 weeks | 4-5 weeks |
| **Ongoing Cost** | None | $50-1000/month (usage-based) |
| **Maintenance** | Low | Medium (prompt tuning, model updates) |
| **User Learning Curve** | Familiar patterns | New interaction model |
| **Scalability** | Excellent | Cost scales with usage |
| **Differentiation** | Standard | Competitive advantage |
| **Flexibility** | Fixed flows | Handles edge cases better |
| **Risk** | Low | Medium (hallucinations, costs) |

### Recommendation

**Start with V3.1 (Traditional)** as the foundation, then layer V3.1a (AI) on top:

1. V3.1 provides immediate value with low risk
2. V3.1a Phase A (Explain & Guide) can be added incrementally
3. The checklist and empty states from V3.1 work alongside AI guidance
4. If AI proves valuable, expand to Phase B and C

This hybrid approach gives you:
- Quick wins from traditional onboarding
- Modern AI experience as a differentiator
- Fallback if AI has issues
- Data to measure AI impact vs baseline

---

## Appendix B: Sample Copilot Conversations

### New Admin First Login
```
Copilot: Welcome to OnCalls! I'm here to help you set up your scheduling system.
         
         To get started, you'll need to:
         1. Add your team members
         2. Create your shift types (like "Day Call" or "Night Call")
         3. Build your schedule
         
         Would you like to start by adding team members, or would you prefer 
         to set up your shift types first?

User: Let's do shifts first

Copilot: Great choice! What kinds of shifts does your group use?
         
         For example, you might have:
         - Day shifts (e.g., 7am-7pm)
         - Night shifts (e.g., 7pm-7am)
         - Weekend coverage
         - Holiday shifts
         
         Tell me about your shifts and I'll help you set them up.

User: We have day call from 7am to 7pm and night call from 7pm to 7am

Copilot: Perfect! Here's what I'll create:
         
         **Day Call**
         - Abbreviation: DC
         - Time: 7:00 AM - 7:00 PM
         - Days: All week
         
         **Night Call**
         - Abbreviation: NC
         - Time: 7:00 PM - 7:00 AM
         - Days: All week
         
         [Create These Shifts] [Edit] [Cancel]

User: [clicks Create These Shifts]

Copilot: Done! I've created your Day Call and Night Call shifts.
         
         Next, would you like to:
         - Add team members to your group
         - Start building your schedule
         - Learn more about other features
```

### Physician Asking for Help
```
User: How do I request time off?

Copilot: To request time off:
         
         1. Go to the "Make Requests" page
         2. Select "Time Off Request"
         3. Choose the date(s) you need off
         4. Add any notes for your admin
         5. Submit the request
         
         Your admin will review and approve or deny the request. You can 
         check the status on the "My Requests" page.
         
         [Go to Make Requests] [View My Requests]
```
