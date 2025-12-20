# Add Schedule Entry to OnCalls Production

This skill helps add a schedule entry to the OnCalls production database when a user reports they cannot add someone through the UI.

## Usage

Invoke with: `/add-schedule-entry`

Optionally provide context: `/add-schedule-entry McPhillips as baby rounder on Dec 13`

## Instructions for Claude

When this skill is invoked, follow these steps:

### Step 1: Parse the Request

If the user provided details, extract:
- **Doctor name** (usually last name)
- **Shift type** (e.g., "baby rounder", "attending", etc.)
- **Date** (convert to YYYY-MM-DD format)

If details are missing, ask the user:
```
To add a schedule entry, I need:
1. Doctor/member name (last name is sufficient)
2. Shift type (e.g., "baby rounder", "attending")
3. Date (e.g., "Dec 13" or "2025-12-13")

Please provide the missing information.
```

### Step 2: Connect to Database

Load credentials from the `.env` file - **NEVER hardcode credentials**:

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
```

### Step 3: Find the Doctor

Use parameterized queries to prevent SQL injection:

```python
cursor.execute(
    "SELECT docid, fname, lname, email, GroupId FROM passwords WHERE lname LIKE %s AND deleted = 0",
    (f'%{lastname}%',)
)
```

If multiple results, present them and ask user to confirm which one.

### Step 4: Find the Shift Type

```python
cursor.execute(
    "SELECT id, groupid, callabr, callfull FROM groupcalls WHERE (callabr LIKE %s OR callfull LIKE %s) AND deleted = 0",
    (f'%{keyword}%', f'%{keyword}%')
)
```

### Step 5: Validate Group Match

**CRITICAL**: Verify that the doctor's `GroupId` matches the shift's `groupid`. If not, inform the user there's a mismatch and stop.

### Step 6: Check for Existing Entry

```python
cursor.execute(
    """SELECT s.*, p.fname, p.lname
       FROM schedule s
       LEFT JOIN passwords p ON s.DOCID = p.docid
       WHERE s.dates = %s AND s.GroupCallID = %s AND s.GroupID = %s""",
    (schedule_date, shift_id, group_id)
)
```

If entry exists, inform user and ask what they want to do.

### Step 7: Present Summary and Confirm

Before inserting, present a clear summary:

```
**Proposed Schedule Entry:**
| Field | Value |
|-------|-------|
| Date | {date} |
| Doctor | {fname} {lname} (docid {docid}) |
| Shift | {callfull} (GroupCallID {shift_id}) |
| Group | {group_id} |

Should I execute this INSERT on the production database?
```

Use `AskUserQuestion` to get explicit confirmation.

### Step 8: Execute INSERT

Only after user confirms:

```python
# Get next ScheduleID (with None handling for empty table)
cursor.execute("SELECT MAX(ScheduleID) FROM schedule")
max_id = cursor.fetchone()[0]
new_id = (max_id if max_id is not None else 0) + 1

# Insert using parameterized query
cursor.execute(
    "INSERT INTO schedule (dates, DOCID, GroupCallID, GroupID, ScheduleID, pos) VALUES (%s, %s, %s, %s, %s, %s)",
    (schedule_date, docid, shift_id, group_id, new_id, 1)
)
conn.commit()
```

### Step 9: Verify and Report

```python
cursor.execute(
    """SELECT s.dates, p.fname, p.lname, gc.callfull, s.ScheduleID
       FROM schedule s
       LEFT JOIN passwords p ON s.DOCID = p.docid
       LEFT JOIN groupcalls gc ON s.GroupCallID = gc.id
       WHERE s.ScheduleID = %s""",
    (new_id,)
)
```

Report success with the verification details.

## Credential Management

**IMPORTANT**: Database credentials are stored in `/Users/jmr/dev/Oncalls-debug_prod/backend_prod/.env`

Required environment variables:
- `DB_SERVER` - Database host
- `DB_PORT` - Database port
- `DB_USERNAME` - Database user
- `DB_PASSWORD` - Database password
- `DB_NAME` - Database name

## Key Tables

- `passwords` - Members/doctors (use `docid` as doctor ID)
- `groupcalls` - Shift types (use `id` as GroupCallID)
- `schedule` - Schedule entries

## Common Group 46 (AMC) Shift Types

| ID | Abbr | Full Name |
|----|------|-----------|
| 1845 | BABY | AMC Attdg Baby Rounder |

## Error Handling

- **Multiple doctors found**: Present all matches and ask user to clarify
- **No doctor found**: Suggest searching by first name or email
- **Group mismatch**: Explain the doctor and shift are in different groups
- **Entry exists**: Show existing entry and ask if user wants to modify
- **Database error**: Report error and suggest manual intervention

## Audit Trail

After successful insert, log to `/Users/jmr/dev/Oncalls-debug_prod/docs/schedule-audit-log.md`:

```markdown
| Date | Requestor | Action | ScheduleID |
|------|-----------|--------|------------|
| {today} | {requestor} | Added {doctor} as {shift} on {date} | {schedule_id} |
```
