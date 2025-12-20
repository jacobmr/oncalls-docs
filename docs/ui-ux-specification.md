# OnCalls.com v3.0 UI/UX Specification

## Section 1: Introduction

This document defines the user experience goals, information architecture, user flows, and visual design specifications for the OnCalls.com v3.0 user interface.

### Overall UX Goals & Principles

* **Target User Personas**:
    * **Administrator**: A power user who values efficiency, clarity, and control.
    * **Physician (Regular Member)**: A busy, mobile user who values simplicity and speed.
* **Usability Goals**:
    * **Efficiency**: Reduce the time it takes for an administrator to fill a month's schedule by 50%.
    * **Clarity**: A physician can view their schedule and make a request in under 30 seconds.
    * **Learnability**: A new admin can manage members and shifts without a manual.
* **Design Principles**:
    1.  **Clarity First**: Every screen and interaction should be immediately understandable.
    2.  **Progressive Disclosure**: Show only what's necessary for the current task.
    3.  **Mobile is Primary**: Design every feature to work perfectly on mobile first.
    4.  **Immediate Feedback**: Every user action must have a clear visual response.

---

## Section 2: Information Architecture (IA)

### Site Map / Screen Inventory
```mermaid
graph TD
    subgraph Public
        A[Login Page]
    end

    subgraph Authenticated App
        B[Dashboard / Main Schedule View] --> C[Member Management]
        B --> D[Shift Management]
        B --> E[Request Approval Center]
        B --> F[Reporting View]
        B --> G[My Personal Schedule]
        G --> H[Submit Request Form]
    end

    A --> B