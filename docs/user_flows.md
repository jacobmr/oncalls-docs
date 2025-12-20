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