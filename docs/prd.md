# OnCalls.com Brownfield Enhancement PRD

## Section 1: Intro Project Analysis and Context

### Existing Project Overview

* **Analysis Source**: User-provided information and analysis of `flattened-codebase.xml`.
* **Current Project State**: OnCalls.com is a web-based scheduling application for medical providers. It allows administrative members to manage group members, define shifts with varying weights, and manually create monthly schedules in a calendar-style interface. Regular members can view schedules and submit time-off or volunteer requests, which require administrative approval. The system also includes a reporting feature to track shifts worked and points accumulated. The backend and database are considered stable, with the primary focus of version 3.0 being a significant front-end and user experience evolution.

### Available Documentation Analysis

* `[x]` Tech Stack Documentation
* `[x]` Source Tree/Architecture
* `[ ]` Coding Standards (Inferred from code)
* `[x]` API Documentation (Inferred from code)
* `[ ]` UX/UI Guidelines
* `[x]` Technical Debt Documentation (Inferred from UX overhaul goal)

### Enhancement Scope Definition

* **Enhancement Type**: UI/UX Overhaul
* **Enhancement Description**: To modernize the front-end user experience of the OnCalls.com application, making it more intuitive and efficient for both administrative and regular members. The initial focus is on improving the scheduling and request processes.
* **Impact Assessment**: Significant Impact (substantial existing code changes on the front-end).

### Goals and Background Context

* **Goals**:
    * Improve the usability and efficiency of the manual scheduling process for administrators.
    * Modernize the overall look and feel of the application to current web standards.
    * Enhance the experience for physicians making time-off and volunteer requests.
    * Streamline the reporting interface for better clarity.
* **Background Context**: The project is a version 2.0 to 3.0 evolution of the OnCalls.com scheduling platform. The core backend logic and database are stable and will not be changed. The primary driver for this enhancement is the need to modernize the user experience. The project will be deployed to a staging server which is already running an early version of 3.0.

---

## Section 2: Requirements (Revised)

### User Stories / Functional Requirements (FR)

1.  **FR1 (Admin)**: As an Admin, I can easily add, edit, and manage user profiles so that the group membership is always up-to-date.
2.  **FR2 (Admin)**: As an Admin, I can intuitively create and modify shifts, defining their names, times, locations, eligible members, and weighted point values, so that the schedule foundation is accurate.
3.  **FR3 (Admin)**: As an Admin, I want a visually clear and highly responsive calendar interface to view and manage the monthly schedule, so that I can quickly identify and fill open shifts.
4.  **FR4 (Admin)**: As an Admin, when filling a shift, I want the system to instantly suggest only eligible physicians as I type, so that I can schedule quickly and prevent errors.
5.  **FR5 (Physician)**: As a Physician, I can clearly see my schedule and submit time-off requests for specific days through a simple interface.
6.  **FR6 (Admin)**: As an Admin, I need a centralized dashboard to view and approve/deny all pending time-off and volunteer requests.
7.  **FR7 (System)**: The system must enforce approved time-off by making it impossible for an Admin to accidentally schedule a physician on their approved day off.
8.  **FR8 (Physician)**: As a Physician, I can see open shifts I am eligible for and volunteer for them with a single click.
9.  **FR9 (Admin)**: When I approve a volunteer request, the system should automatically assign the physician to that shift.
10. **FR10 (Admin)**: As an Admin, I can generate a simple, easy-to-read report showing shifts worked and points accumulated for each member.
11. **FR11 (Admin)**: As an Admin, I can manage the account/group and its billing information.

### User Experience Requirements (UXR)

1.  **UXR1**: The user interface shall be completely redesigned to follow a modern, clean, green-themed aesthetic.
2.  **UXR2**: The number of clicks required for common administrative tasks should be reduced by at least 30%.
3.  **UXR3**: All interactive elements must provide immediate visual feedback.
4.  **UXR4**: The application will provide a "mobile-first" responsive design.

### Non-Functional Requirements (NFR)

1.  **NFR1**: The new front-end shall be a responsive web application.
2.  **NFR2**: The application's user interface must be intuitive.
3.  **NFR3**: Page load times for the main schedule view shall be under 3 seconds.
4.  **NFR4**: The UI shall adhere to WCAG 2.1 AA standards.

### Compatibility Requirements (CR)

1.  **CR1**: The v3.0 front-end must integrate with the existing v2.0 backend APIs and database without requiring any changes.
2.  **CR2**: All existing data must be preserved and correctly displayed.
3.  **CR3**: The enhancement must not disrupt the production or debug servers.

---

## Section 3: Epic and Story Structure

### Epic 1: Foundation & API Discovery
**Epic Goal**: To create the foundational structure for the new v3.0 front-end application, establish a modern development environment, and conduct a thorough investigation of the existing v2.0 backend APIs to create a definitive "API Contract" document.
* **Story 1.1: Project Scaffolding & Setup**
* **Story 1.2: API Contract Discovery & Documentation (CRITICAL SPIKE)**

### Epic 2: Administrator Read-Only Experience & Core Data Management
**Epic Goal**: To deliver a complete, high-performance, read-only view of the entire system for administrators.
* **Story 2.1: Modernized Member & Shift Viewing**
* **Story 2.2: High-Performance Calendar Schedule View**

### Epic 3: Interactive Scheduling for Administrators
**Epic Goal**: To transform the static schedule view into a fully interactive scheduling tool.
* **Story 3.1: Add, Edit, and Delete Shifts on the Calendar**
* **Story 3.2: Assign & Unassign Physicians to Shifts**

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