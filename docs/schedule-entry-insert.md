# OnCalls Schedule Entry Insert - Manual Procedure

## Overview

This document describes how to manually add a schedule entry to the OnCalls production database when a user reports they cannot add someone to the schedule through the UI.

## Prerequisites

- Python 3 with `pymysql` and `python-dotenv` installed (`pip install pymysql python-dotenv`)
- Access to production database credentials (stored in `backend_prod/.env`)

## Database Connection Details

Credentials are stored in `/Users/jmr/dev/Oncalls-debug_prod/backend_prod/.env`:
- `DB_SERVER` - Database host
- `DB_PORT` - Database port
- `DB_USERNAME` - Database user
- `DB_PASSWORD` - Database password
- `DB_NAME` - Database name

**NEVER hardcode credentials in scripts or documentation.**

## Schema Reference

### `schedule` table (main table for assignments)
| Column | Type | Description |
|--------|------|-------------|
| dates | DATE | The schedule date |
| DOCID | INT | Doctor/member ID (from `passwords` table) |
| GroupCallID | INT | Shift type ID (from `groupcalls` table) |
| GroupID | INT | Group ID |
| ScheduleID | INT | Unique schedule entry ID |
| pos | INT | Position (usually 1) |

### `passwords` table (members/doctors)
| Column | Type | Description |
|--------|------|-------------|
| docid | INT | Primary key - doctor ID |
| fname | VARCHAR | First name |
| lname | VARCHAR | Last name |
| email | VARCHAR | Email address |
| GroupId | INT | Group membership |

### `groupcalls` table (shift types)
| Column | Type | Description |
|--------|------|-------------|
| id | INT | Shift type ID |
| groupid | INT | Group this shift belongs to |
| callabr | VARCHAR | Abbreviation (e.g., "BABY") |
| callfull | VARCHAR | Full name (e.g., "AMC Attdg Baby Rounder") |

## Step-by-Step Procedure

> **SECURITY WARNING**: The SQL examples below use parameterized queries via Python's `pymysql` library. **NEVER** copy these SQL patterns and manually substitute values in a database client - this creates SQL injection vulnerabilities. Always use the complete Python script provided at the end of this document, which handles parameterization correctly.

### Step 1: Parse the Request

From the user's email, identify:
- **Who** needs to be added (doctor name)
- **What** shift type (e.g., "baby rounder")
- **When** (the date)

Example request:
> "I am unable to add McPhillips as baby rounder on Dec 13"

### Step 2: Find the Doctor ID

```python
cursor.execute(
    "SELECT docid, fname, lname, email, GroupId FROM passwords WHERE lname LIKE %s",
    (f'%{lastname}%',)
)
```

### Step 3: Find the Shift Type ID

```python
cursor.execute(
    "SELECT id, groupid, callabr, callfull FROM groupcalls WHERE callabr LIKE %s OR callfull LIKE %s",
    (f'%{keyword}%', f'%{keyword}%')
)
```

### Step 4: Verify Group Match

**CRITICAL**: The doctor's `GroupId` must match the shift's `groupid`. If they don't match, the wrong doctor or shift was identified.

### Step 5: Get Next ScheduleID

```python
cursor.execute("SELECT MAX(ScheduleID) FROM schedule")
max_id = cursor.fetchone()[0]
new_schedule_id = (max_id if max_id is not None else 0) + 1
```

### Step 6: Check for Existing Entry

```python
cursor.execute(
    "SELECT * FROM schedule WHERE dates = %s AND GroupCallID = %s AND GroupID = %s",
    (schedule_date, shift_id, group_id)
)
```

If entry exists, do NOT insert a duplicate.

### Step 7: Execute INSERT

```python
cursor.execute(
    "INSERT INTO schedule (dates, DOCID, GroupCallID, GroupID, ScheduleID, pos) VALUES (%s, %s, %s, %s, %s, %s)",
    (schedule_date, docid, shift_id, group_id, new_schedule_id, 1)
)
conn.commit()
```

### Step 8: Verify

```python
cursor.execute(
    """SELECT s.dates, s.DOCID, p.fname, p.lname, gc.callfull
       FROM schedule s
       LEFT JOIN passwords p ON s.DOCID = p.docid
       LEFT JOIN groupcalls gc ON s.GroupCallID = gc.id
       WHERE s.ScheduleID = %s""",
    (new_schedule_id,)
)
```

## Complete Python Script

```python
import pymysql
import ssl
import os
from dotenv import load_dotenv

# Load credentials from .env file
load_dotenv('/Users/jmr/dev/Oncalls-debug_prod/backend_prod/.env')

ssl_context = ssl.create_default_context()
ssl_context.check_hostname = False
ssl_context.verify_mode = ssl.CERT_NONE

conn = pymysql.connect(
    host=os.getenv('DB_SERVER'),
    port=int(os.getenv('DB_PORT')),
    user=os.getenv('DB_USERNAME'),
    password=os.getenv('DB_PASSWORD'),
    database=os.getenv('DB_NAME'),
    ssl=ssl_context
)

cursor = conn.cursor()

# === CONFIGURE THESE VALUES ===
DOCTOR_LASTNAME = 'McPhillips'
SHIFT_KEYWORD = 'baby'
SCHEDULE_DATE = '2025-12-13'
# ==============================

# Find doctor (using parameterized query)
print("=== Finding Doctor ===")
cursor.execute(
    "SELECT docid, fname, lname, email, GroupId FROM passwords WHERE lname LIKE %s",
    (f'%{DOCTOR_LASTNAME}%',)
)
doctors = cursor.fetchall()
for d in doctors:
    print(f"  docid={d[0]}, {d[1]} {d[2]}, email={d[3]}, GroupId={d[4]}")

# Find shift (using parameterized query)
print("\n=== Finding Shift Type ===")
cursor.execute(
    "SELECT id, groupid, callabr, callfull FROM groupcalls WHERE callabr LIKE %s OR callfull LIKE %s",
    (f'%{SHIFT_KEYWORD}%', f'%{SHIFT_KEYWORD}%')
)
shifts = cursor.fetchall()
for s in shifts:
    print(f"  id={s[0]}, groupid={s[1]}, {s[2]} - {s[3]}")

# After identifying correct values, update these:
DOCID = None  # Set after reviewing output
GROUP_CALL_ID = None  # Set after reviewing output
GROUP_ID = None  # Set after reviewing output

if DOCID and GROUP_CALL_ID and GROUP_ID:
    # Get next ScheduleID (with None handling)
    cursor.execute("SELECT MAX(ScheduleID) FROM schedule")
    max_id = cursor.fetchone()[0]
    new_id = (max_id if max_id is not None else 0) + 1

    # Check for existing (using parameterized query)
    cursor.execute(
        "SELECT * FROM schedule WHERE dates = %s AND GroupCallID = %s AND GroupID = %s",
        (SCHEDULE_DATE, GROUP_CALL_ID, GROUP_ID)
    )
    if cursor.fetchall():
        print("ERROR: Entry already exists!")
    else:
        # Insert (using parameterized query)
        cursor.execute(
            "INSERT INTO schedule (dates, DOCID, GroupCallID, GroupID, ScheduleID, pos) VALUES (%s, %s, %s, %s, %s, %s)",
            (SCHEDULE_DATE, DOCID, GROUP_CALL_ID, GROUP_ID, new_id, 1)
        )
        conn.commit()
        print(f"SUCCESS: Inserted ScheduleID {new_id}")

cursor.close()
conn.close()
```

## Common Shift Types (Group 46 - AMC)

| ID | Abbreviation | Full Name |
|----|--------------|-----------|
| 1845 | BABY | AMC Attdg Baby Rounder |
| 1815 | SPHD | (check database) |
| 29 | AMCP | (check database) |
| 28 | SPH | (check database) |

## Troubleshooting

### "Entry already exists"
The schedule entry is already in the database. Check if the user is looking at the wrong date or needs a different action (modify vs. add).

### "No doctor found"
- Check spelling variations
- Search by first name instead
- Search by email if known

### "GroupId mismatch"
The doctor and shift type are in different groups. Either:
- Wrong doctor was identified (check for duplicates)
- Wrong shift type was identified
- User is trying to add someone from another group (not allowed)

## Audit Log

Keep a record of manual database changes in `/Users/jmr/dev/Oncalls-debug_prod/docs/schedule-audit-log.md`
