Of course. Here is a single, complete markdown file containing all three artifacts we developed for the OnCalls.com v3.0 enhancement.

-----

````markdown
# OnCalls.com v3.0 - Consolidated Project Artifacts

**Generated:** September 2, 2025

**Contents:**
1.  Product Requirements Document (PRD)
2.  UI/UX Specification
3.  Fullstack Architecture Document

---
---

# 1. Product Requirements Document (PRD)

## Section 1: Intro Project Analysis and Context

### Existing Project Overview

* **Analysis Source**: User-provided information and analysis of `flattened-codebase.xml` and `database_schema_complete.sql`.
* **Current Project State**: OnCalls.com is a multi-tenant, web-based scheduling application for medical providers. It allows administrative members to manage accounts and groups, define shifts, and create monthly schedules. Regular members can view schedules and manage their availability via requests. The backend and database are considered stable, with the primary focus of version 3.0 being a significant front-end and user experience evolution.

### Enhancement Scope Definition

* **Enhancement Type**: UI/UX Overhaul.
* **Enhancement Description**: To modernize the front-end user experience of the OnCalls.com application, making it more intuitive and efficient for both administrative and regular members.
* **Impact Assessment**: Significant Impact (substantial existing code changes on the front-end).

### Goals and Background Context

* **Goals**:
    * Improve the usability and efficiency of the manual scheduling process.
    * Modernize the overall look and feel of the application.
    * Enhance the experience for physicians making requests.
    * Streamline the reporting interface for better clarity.
* **Background Context**: This project is a v2.0 to v3.0 evolution. The core backend logic and database are stable. The enhancement will be deployed to a dedicated staging server.

---

## Section 2: Requirements

### User Stories / Functional Requirements (FR)

1.  **FR1 (Admin)**: As an Admin, I can easily add, edit, and manage user profiles so that the group membership is always up-to-date.
2.  **FR2 (Admin)**: As an Admin, I can intuitively create and modify shifts, defining their names, times, locations, eligible members, and weighted point values.
3.  **FR3 (Admin)**: As an Admin, I want a visually clear and highly responsive calendar interface to view and manage the monthly schedule.
4.  **FR4 (Admin)**: As an Admin, when filling a shift, I want the system to instantly suggest only eligible physicians as I type.
5.  **FR5 (Physician)**: As a Physician, I can clearly see my schedule and submit time-off or volunteer requests through a simple interface.
6.  **FR6 (Admin)**: As an Admin, I need a centralized dashboard to view and approve/deny all pending requests.
7.  **FR7 (System)**: The system must enforce approved time-off by preventing an Admin from scheduling a physician on their approved day off.
8.  **FR8 (Admin)**: As an Admin, I can generate a simple, easy-to-read report showing shifts worked and points accumulated for each member.
9.  **FR9 (Admin)**: As an Admin, I can manage the account/group and its billing information.

### User Experience Requirements (UXR)

1.  **UXR1**: The user interface shall be completely redesigned to follow a modern, clean, green-themed aesthetic.
2.  **UXR2**: The number of clicks required for common administrative tasks should be reduced by at least 30%.
3.  **UXR3**: All interactive elements must provide immediate visual feedback.
4.  **UXR4**: The application will provide a "mobile-first" responsive design.

### Compatibility Requirements (CR)

1.  **CR1**: The v3.0 front-end must integrate with the existing v2.0 backend APIs and database without requiring any changes.
2.  **CR2**: All existing data must be preserved and correctly displayed.

---

## Section 3: Epic and Story Structure

### Epic 1: Foundation & API Discovery
**Epic Goal**: To create the foundational structure for the new v3.0 front-end application and conduct a thorough investigation of the existing v2.0 backend APIs to create a definitive "API Contract" document.
* **Story 1.1: Project Scaffolding & Setup**
* **Story 1.2: API Contract Discovery & Documentation (CRITICAL SPIKE)**

### Epic 2: Administrator Read-Only Experience & Core Data Management
**Epic Goal**: To deliver a complete, high-performance, read-only view of the entire system for administrators.
* **Story 2.1: Modernized Member & Shift Viewing**
* **Story 2.2: High-Performance Calendar Schedule View**

### Epic 3: Interactive Scheduling for Administrators
**Epic Goal**: To transform the static schedule view into a fully interactive scheduling tool.
* **Story 3.1: Assign & Unassign Physicians to Shifts**

### Epic 4: Physician Request & Schedule Viewing
**Epic Goal**: To provide a simple, mobile-friendly interface for physicians to view their schedule and manage their availability.
* **Story 4.1: Physician Schedule View**
* **Story 4.2: Submit Time-Off & Volunteer Requests**
* **Story 4.3: View Request Status**

### Epic 5: Reporting & Modernized Login
**Epic Goal**: To deliver the final pieces of core functionality by providing a redesigned reporting view and updating the login experience.
* **Story 5.1: Administrator Reporting View**
* **Story 5.2: Implement Modernized Login Flow**

### Post-MVP / v3.5 Backlog
* **Feature**: Chatbot Capability for natural language queries.

---
---

# 2. UI/UX Specification

## Section 1: Introduction

This document defines the user experience goals, information architecture, user flows, and visual design specifications for the OnCalls.com v3.0 user interface.

### Overall UX Goals & Principles

* **Target User Personas**:
    * **Administrator**: A power user who values efficiency and control.
    * **Physician (Regular Member)**: A busy, mobile user who values simplicity and speed.
* **Design Principles**:
    1.  **Clarity First**: Every screen should be immediately understandable.
    2.  **Progressive Disclosure**: Show only what's necessary for the current task.
    3.  **Mobile is Primary**: Design every feature for mobile first.
    4.  **Immediate Feedback**: Every user action must have a clear visual response.

---

## Section 2: Information Architecture (IA)

### Site Map
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
````

### Navigation Structure

  * **Admin Navigation**: Dashboard, Members, Shifts, Requests, Reports, My Schedule.
  * **Physician Navigation**: My Schedule, Request Time Off / Volunteer.

-----

## Section 3: User Flows

### Flow: Fill a Monthly Schedule

  * **User Goal**: For an administrator to efficiently assign physicians to all open, pre-defined shifts for an upcoming month.
  * **Prerequisite**: All necessary shifts for the year have been created in the "Shift Management" section.

<!-- end list -->

```mermaid
graph TD
    subgraph Setup (Infrequent)
        A[Admin Navigates to 'Shift Management'] --> B[Create/Edit Shift Definitions];
    end

    subgraph Scheduling (Frequent)
        C[Start: Admin on Dashboard] --> D[Selects Month];
        D --> E[Calendar View Loads with All Pre-defined, Unassigned Shifts];
        E --> F[Clicks on an Unassigned Shift];
        F --> G[Assignment UI Appears];
        G --> H[Types Physician Name];
        H --> I[System Shows Autocomplete List of ELIGIBLE Physicians];
        I --> J[Selects Physician & Assigns];
        J --> K{All Shifts Filled?};
        K -->|No| E;
        K -->|Yes| L[End: Schedule is Complete];
    end

    B -.-> E
```

-----

## Section 4: Branding & Style Guide

### Color Palette (Green Theme)

| Color Type | Hex Code  | Usage                            |
| :---       | :---      | :---                             |
| **Primary**| `#22C55E` | Core brand green for primary actions. |
| **Secondary**| `#16A34A` | Darker green for secondary actions. |
| **Accent** | `#FACC15` | Vibrant yellow for highlights.      |
| **Neutral**| `#F8FAFC`, `#334155` | Backgrounds and text.     |

### Typography

  * **Primary Font Family**: Roboto

-----

## Section 5: Accessibility & Responsiveness

### Accessibility

  * **Compliance Target**: WCAG 2.1 Level AA.

### Responsiveness Strategy

  * **Full Scheduling Experience (Tablet/Desktop)**: The interactive monthly grid is for larger screens.
  * **Admin "Companion" Experience (Mobile)**: A streamlined view for quick actions like approvals and lookups.

-----

-----

# 3\. Fullstack Architecture Document

## Section 1: Introduction

This document outlines the architecture for the OnCalls.com v3.0 enhancement, focusing on the new front-end and its integration with the existing backend.

### Existing Project

We are building a modern React application to replace the current front-end while maintaining compatibility with the current Flask backend API.

-----

## Section 2: High Level Architecture

### Technical Summary

The architecture follows a **brownfield, front-end replacement** model. We will develop a modern React SPA that consumes the existing Flask REST API, following a "Strangler Fig" pattern for the UI.

### Platform and Infrastructure

  * **Platform**: Continue using the existing Production, Debug, and Staging server model.
  * **Repository Structure**: A **Poly-repo** structure will be used, with a new, separate repository for the v3.0 front-end codebase.

### High Level Architecture Diagram

```mermaid
graph TD
    subgraph Users
        A[Administrator]
        B[Physician]
    end

    subgraph "Staging Server"
        C[New React SPA <br>(v3.0 Front-end)] --> D{Existing Flask API <br>(v2.0 Backend)};
        D --> E[(Database)];
    end

    A --> C;
    B --> C;
```

-----

## Section 3: Tech Stack

| Category             | Technology    | Version | Purpose                       |
| :---                 | :---          | :---    | :---                          |
| **Frontend Language**| TypeScript    | `~5.0`  | Provides strong typing.         |
| **Frontend Framework**| React         | `~18.2` | Core UI library.              |
| **State Management** | Zustand       | `~4.4`  | Simple global UI state.       |
| **Styling** | Tailwind CSS  | `~3.3`  | Utility-first CSS framework.  |
| **Backend Language** | Python        | `~3.9`  | **Existing** backend language. |
| **Backend Framework**| Flask         | `~2.2`  | **Existing** backend framework.|

-----

## Section 4: Data Models & API Specification

### Data Models (TypeScript)

These interfaces accurately reflect the `database_schema_complete.sql` provided.

```typescript
// Maps to the 'accounts' and 'groups' tables
export interface Group {
  GroupID: number;
  GroupName: string;
  accountid: number;
}

// Maps to the 'passwords' table
export interface User {
  docid: number;
  Login: string;
  Admin: boolean;
  GroupId: number;
  fname: string;
  lname: string;
}

// Maps to the 'groupcalls' and 'groupcalldays' tables
export interface Shift {
  id: number;
  callabr: string;
  points: number;
}
// ... and other models like Schedule, Request, etc.
```

### REST API Specification (OpenAPI 3.0)

A formal YAML document will be created to describe the existing Flask endpoints, such as `/api/group/users` and `/api/group/shifts`, ensuring the front-end knows how to communicate with the backend.

### Database Schema

The architecture will adhere strictly to the provided `database_schema_complete.sql`.

-----

## Section 5: Core Architecture

  * **Components**: The front-end will be built with logical components: Authentication, API Service, State Management, Scheduling, and Request Management.
  * **External APIs**: Google Identity Services and Microsoft Identity Platform for OAuth 2.0 logins.

<!-- end list -->

```
```