***

### 🏗️ **3. Fullstack Architecture Document**

**File**: `docs/architecture.md`

```markdown
# OnCalls.com v3.0 Fullstack Architecture

## Section 1: Introduction

This document outlines the fullstack architecture for the OnCalls.com v3.0 enhancement, focusing on the new front-end application and its integration with the existing Flask backend.

### Starter Template or Existing Project
We are working with an existing, custom-built Flask and JavaScript application. The architecture defines how to build a modern React application to replace the current front-end while maintaining compatibility with the current backend API.

---

## Section 2: High Level Architecture

### Technical Summary
The architecture follows a **brownfield, front-end replacement** model. We will develop a modern React SPA that consumes the existing Flask REST API. This new front-end will be deployed independently to the Staging server.

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