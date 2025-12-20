# OnCalls.com v3.0 API Contract Documentation

**Generated:** September 2, 2025  
**Purpose:** Complete API contract for React v3.0 frontend integration  
**Backend:** Flask v2.0 (existing, stable)  

---

## 🔐 Authentication & Authorization

### Core Authentication
All API endpoints (except login/register) require JWT token authentication via `Authorization: Bearer <token>` header.

| Endpoint | Method | Purpose | Auth Required |
|----------|--------|---------|---------------|
| `/api/login` | POST | User authentication | No |
| `/api/refresh` | POST | Token refresh | No |
| `/api/logout` | POST | User logout | Yes |
| `/api/register` | POST | User registration | No |
| `/api/test` | GET | Database connection test | No |

### Social Authentication
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/google_sign_in` | POST | Google OAuth login |
| `/api/google_sign_up` | POST | Google OAuth registration |

---

## 📅 **Core Scheduling APIs**

### Dashboard & Schedule Data
| Endpoint | Method | Parameters | Response |
|----------|--------|------------|----------|
| `/api/home` | GET | `groupId`, `docId`, `stdate`, `viewreq` | Weekly schedule data |
| `/api/schedule_dates` | GET | `date`, `gid` | 7-day header with special day messages |
| `/api/day_schedule` | GET | `groupId`, `docId`, `date` | Single day schedule details |
| `/api/month_schedule` | GET | `groupId`, `date`, `docId`, `weeks`, `viewreq`, `cluster` | Monthly schedule view |

### Schedule Management
| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/add_month_data` | POST | Add single schedule entry | Schedule object JSON |
| `/api/add_month_data_batch` | POST | Bulk schedule operations | Array of schedule objects |
| `/api/get_month_docs` | GET | Get month documents | `group_id`, `sid` |

### Shift Legend & Special Services
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/shiftLegend` | GET | Get shift definitions for group |
| `/api/get_special_services` | GET | Get special services for date |
| `/api/insert_special_services` | POST | Add special service assignments |

---

## 👥 **Member Management APIs**

### Member CRUD Operations
| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/members` | GET | List group members | `groupId` |
| `/api/add_members` | POST | Add new member | Member object JSON |
| `/api/edit_member` | POST | Get member for editing | `docid` |
| `/api/update_member` | PUT | Update member details | Member object JSON |
| `/api/remove_member` | PUT | Soft delete member | `docid`, `gId`, `deleted_by` |

### User Management
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/getUsersDetails` | POST | Get all users data |
| `/api/get_docs` | POST | Get doctors list for group |
| `/api/getUserPassword` | POST | Get user password (admin only) |
| `/api/updateUserPassword` | POST | Update user password |

---

## 🔄 **Shift Management APIs**

### Shift CRUD Operations
| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/shifts` | GET | List group shifts | `groupId` |
| `/api/add_shift` | POST | Create new shift | Shift object JSON |
| `/api/edit_shift` | POST | Get shift for editing | `id` |
| `/api/update_shift` | PUT | Update shift details | Shift object JSON |
| `/api/delete_shift` | PUT | Soft delete shift | `id` |
| `/api/update_shifts_order` | PUT | Reorder shifts | Array of shift objects |

---

## 📋 **Request Management APIs**

### Request Types
| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/request_types` | GET | Get request types for group | `groupid` |
| `/api/add_request_type` | POST | Create request type | Request type JSON |
| `/api/update_request_type` | PUT | Update request type | Request type JSON |
| `/api/del_request_type` | PUT | Delete request type | `recid` |

### Request Processing
| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/get_requests` | GET | Get filtered requests | `groupid`, `approved`, `rejected`, `pending`, `date_type`, `stdate`, `endate` |
| `/api/update_request_status` | PUT | Approve/deny requests | Request status JSON |
| `/api/view_requests` | GET | View requests in date range | `groupid`, `start_date`, `end_date` |
| `/api/get_all_requests` | GET | Get user's requests | `docid`, `groupid`, `start_date`, `end_date` |
| `/api/update_requests` | POST | Update multiple requests | Array of request objects |
| `/api/view_reqs` | GET | View requests dashboard | `groupId`, `docId` |

---

## 🏥 **Volunteer Management APIs**

### Volunteer Operations
| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/volunteers` | GET | Get volunteer requests | `groupid`, `approved`, `rejected`, `pending`, `date_type`, `stdate`, `endate` |
| `/api/update_volunteer_status` | PUT | Approve/deny volunteers | Volunteer status JSON |
| `/api/view_volunteers` | GET | View volunteers in range | `groupid`, `start_date`, `end_date` |
| `/api/get_all_volunteers` | GET | Get user's volunteers | `docid`, `groupid`, `start_date`, `end_date` |
| `/api/update_volunteers` | POST | Update multiple volunteers | Array of volunteer objects |

---

## 📊 **Reporting APIs**

### Report Generation
| Endpoint | Method | Purpose | Parameters |
|----------|--------|---------|------------|
| `/api/schedule_report_shift` | POST | Generate shift reports | Report configuration JSON |
| `/api/volunteer_report` | GET | Volunteer tally report | `groupid`, `stdate`, `endate`, `sort_by`, `mode`, `vol_type` |
| `/api/request_report` | GET | Request summary report | `groupid`, `stdate`, `endate`, `sort_by`, `mode`, `req_type`, `req_ids` |

---

## 💳 **Payment & Billing APIs**

### Payment Processing
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/get_amount` | POST | Get payment amount for group |
| `/api/create-checkout-session` | POST | Create Stripe checkout session |
| `/api/stripe_webhook` | POST | Handle Stripe webhooks |
| `/api/check_payment_status` | POST | Check group payment status |
| `/api/payment_receipts` | GET | Get payment receipts |
| `/api/card_details` | GET | Get stored card details |
| `/api/get_card_details` | GET | Get user card details |
| `/api/activate_card_status` | POST | Activate payment card |
| `/api/delete_stripe_card` | POST | Delete payment card |

### Promotional Codes
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/validate_promo_code` | POST | Validate promo code |
| `/api/apply_promo_code` | POST | Apply promo code to group |

---

## 📧 **Communication APIs**

### Email & Messaging
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/email_schedule` | POST | Email schedule file |
| `/api/get_user_emails` | GET | Get user email addresses |
| `/api/delete_user_emails` | POST | Delete user emails |
| `/api/contact_admin` | POST | Send admin contact message |
| `/api/login_contact` | POST | Send login support message |

---

## ⚙️ **System & Utility APIs**

### Group Management
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/update_group_name` | PUT | Update group name |

### Logging & Analytics
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/add_traffic_logs` | POST | Log user activity |
| `/api/daily_traffic` | POST | Get traffic analytics |

---

## 🔍 **Data Models (TypeScript Interfaces)**

Based on the API responses and database schema:

```typescript
// Core User Model (from passwords table)
interface User {
  docid: number;
  Login: string;
  Admin: boolean;
  GroupId: number;
  fname: string;
  lname: string;
  email: string;
  ViewReqs: number;
  Vpref: number;
  blockstart: number;
  isSuperuser: boolean;
  isdoc: boolean;
}

// Group Model (from groups table)
interface Group {
  GroupID: number;
  GroupName: string;
  accountid: number;
  payment_date?: string;
  auto_payment: boolean;
}

// Shift Model (from groupcalls table)
interface Shift {
  id: number;
  groupid: number;
  callabr: string;
  callfull: string;
  deleted: number;
  sortorder: number;
  call_days?: CallDay[];
}

// Call Day Model (from groupcalldays table)
interface CallDay {
  groupcallid: number;
  dayofweek: string;
  points: number;
  maxsize: number;
  stHour: number;
  stMin: number;
  stAmPm: string;
  etHour: number;
  etMin: number;
  etAmPm: string;
}

// Schedule Model (from schedule table)
interface Schedule {
  ScheduleID: number;
  Dates: string;
  DOCID: number;
  GroupCallID: number;
  GroupID: number;
  pos: number;
}

// Request Model (from requests table)
interface Request {
  ReqID: number;
  DocID: number;
  ReqTypeID: number;
  ReqDate: string;
  DateOfAction: string;
  IsApproved: number;
  isRejected: number;
  ApprovalDate?: string;
  RejectedDate?: string;
}

// Volunteer Model (from volunteers table)
interface Volunteer {
  VolID: number;
  DocID: number;
  GroupcallID: number;
  Voldate: string;
  isapproved?: number;
  isrejected: number;
  approvaldate?: string;
  rejecteddate?: string;
}
```

---

## 🚨 **Critical Integration Notes**

### Authentication Flow
1. **Login** returns `access_token`, `refresh_token`, and user data
2. **All subsequent requests** must include `Authorization: Bearer <access_token>`
3. **Token refresh** available via `/api/refresh` endpoint
4. **Logout** invalidates tokens in database

### Error Handling Pattern
All endpoints follow consistent error response format:
```json
{
  "status": false,
  "message": "Error description"
}
```

Success responses:
```json
{
  "status": true,
  "message": "Success message", 
  "data": {...}
}
```

### Key Business Logic
- **Schedule assignment** requires checking physician eligibility
- **Request approval** automatically updates schedules
- **Payment validation** blocks access if overdue
- **Multi-tenant** architecture via GroupID isolation

---

## 🎯 **Next Steps for v3.0 Frontend**

### Priority 1: Authentication Integration
- Implement JWT token management
- Create login/logout flows
- Handle token refresh automatically

### Priority 2: Core Schedule Views
- `/api/month_schedule` for main calendar
- `/api/shiftLegend` for shift definitions
- `/api/members` for physician data

### Priority 3: Interactive Features
- Schedule assignment via `/api/add_month_data_batch`
- Request management via request APIs
- Real-time feedback with proper error handling

### Priority 4: Supporting Features
- Reporting integration
- Payment status checking
- User profile management

This API contract provides everything needed to build the React v3.0 frontend while maintaining full compatibility with the existing Flask backend.
