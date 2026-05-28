# HR TICKETS LOG

## TICKET #15 - JOB CARD APPROVAL LEVEL AND STATUS VISIBILITY

**STATUS:** COMPLETED

**REQUIREMENT:**
Show approval level and status on Job List. Display which approval level job is at and whose desk it's pending on.

**WHAT WAS DONE:**

**Files Modified:**
- `Custom Objects\Table\52185508HRJobs.Table.al`
- `Custom Objects\Page\52185517HRJobsList.Page.al`
- `Custom Objects\Page\52185510HRJobsCard.Page.al`

**Changes:**
1. Added 3 fields to HR Jobs table:
   - Current Approval Level (FlowField) - reads from Approval Entry
   - Current Approver ID (FlowField) - reads from Approval Entry
   - Pending At (Text) - formatted display field

2. Added UpdatePendingAtField() procedure to build approval status text

3. Added columns to Job List page showing approval level and pending at info

4. Added fields to Job Card page showing approval level and pending at info

**WHY:**
HR staff need visibility into approval workflow progress without opening approval entries. FlowFields read existing approval data without changing workflow setup or permissions.

**RESULT:**
Job List now shows:
- "New - Not Submitted" for open jobs
- "Level X - Approver Name" for pending jobs
- "Approved/Rejected/Canceled/Deferred" for completed jobs

---

## TICKET #17 - JOB CARD REJECTION REQUIRES COMMENTS

**STATUS:** COMPLETED

**REQUIREMENT:**
System should not allow rejection of job card without remarks/comments. HR should be forced to provide reason for rejection.

**WHAT WAS DONE:**

**Files Modified:**
- `Custom Objects\Page\52185510HRJobsCard.Page.al`

**Changes:**
1. Added validation to Reject action in HR Jobs Card
2. Calls GlobalFunctions.CommentsManagement before allowing rejection
3. CommentsManagement checks if comment exists for current user on the job record
4. If no comment exists, shows error: "Please add a comment before performing this action"

**WHY:**
Rejection without reason creates confusion and lacks audit trail. Comments provide context for why job was rejected and help improve future submissions.

**RESULT:**
- User clicks Reject button
- System checks if comment exists
- If no comment: Error message, rejection blocked
- If comment exists: Rejection proceeds
- User must use Comments action to add comment before rejecting

---

## TICKET #24 - CUSTOMIZABLE FIELDS IN HR JOBS REPORT

**STATUS:** COMPLETED

**REQUIREMENT:**
Enable users to customize which fields appear in HR Jobs report. Allow field selection so users can generate reports with only desired fields.

**WHAT WAS DONE:**

**Files Modified:**
- `Custom Objects\Report\52185463HRJobs.Report.al`

**Changes:**
1. Added request page with field selection options
2. Added 12 boolean fields for show/hide control:
   - Show Job ID
   - Show Job Description
   - Show No. of Posts
   - Show Position Reporting To
   - Show Occupied Positions
   - Show Vacant Positions
   - Show Grade
   - Show Responsibility Center
   - Show Global Dimension 1
   - Show Global Dimension 2
   - Show Status
   - Show Date Created

3. Added additional columns to dataset for new fields (Grade, Responsibility Center, Dimensions, Status, Date Created)

4. Set default to show all fields when report opens

5. SaveValues = true preserves user selections between report runs

**WHY:**
Different users need different information from jobs report. Field selection allows customization without creating multiple report versions. Users can focus on relevant data.

**RESULT:**
- User runs HR Jobs report
- Request page shows field selection checkboxes
- User checks/unchecks desired fields
- Report generates with only selected fields visible
- Selections saved for next run
- RDLC layout needs update to use boolean columns for conditional visibility

**NOTE:** RDLC layout file needs to be updated to use the Show* boolean columns to conditionally show/hide fields in the rendered report.

---

## TICKET #27 - RESTRICT EMPLOYEE REQUISITION TO HOD AND HR STAFF ONLY

**STATUS:** COMPLETED

**REQUIREMENT:**
Only Head of Departments (HODs) and HR staff should be able to create employee requisitions. Other users should receive restriction message.

**WHAT WAS DONE:**

**Files Modified:**
- `Custom Objects\Table\52185519HREmployeeRequisitions.Table.al`

**Changes:**
1. Added CheckUserCanCreateRequisition() procedure
2. Procedure checks two conditions:
   - Is user a HOD? (exists in HR Heads of Departments table)
   - Is user HR staff? (active employee in HR department)
3. Blocks creation if neither condition is met
4. Shows error: "ONLY HEAD OF DEPARTMENTS (HODs) AND HR STAFF CAN CREATE EMPLOYEE REQUISITIONS"
5. Called in OnInsert trigger before document number generation

**HOD Identification:**
- Checks HR Heads of Departments table
- Matches by User ID

**HR Staff Identification:**
- Checks HR Employees table (Status = Active)
- Matches by User ID
- Checks Global Dimension 2 Code for: 'HR', 'HUMAN RESOURCE', or 'HUMAN RESOURCES'

**WHY:**
Employee requisitions should only be created by authorized personnel. HODs request for their departments, HR staff manage recruitment process. Prevents unauthorized requisition creation.

**RESULT:**
- HOD user clicks New on requisition list → Requisition created successfully
- HR staff clicks New on requisition list → Requisition created successfully
- Other user clicks New on requisition list → Error message, creation blocked
- Supervisors (non-HOD) cannot create requisitions

**NOTE:** HR Department identification uses Global Dimension 2 Code. If your HR department uses a different code than 'HR', 'HUMAN RESOURCE', or 'HUMAN RESOURCES', update the CheckUserCanCreateRequisition procedure with the correct code.

**ESTABLISHMENT CONCEPT:**
Establishment = Approved organizational structure (authorized headcount). Currently Job Type field distinguishes Jobs (active recruitment) from Establishment (master structure). Focus is on Jobs for requisitions. Establishment can be enhanced later for budget control and position authorization validation.

---

## TICKET #30 - LIST OF ALL APPLICANTS WITH POSITION APPLIED AND QUALIFICATIONS

**STATUS:** COMPLETED

**REQUIREMENT:**
Generate report showing list of all job applicants with position applied for and their qualifications. HR should be able to access jobs applied and generate report on all jobs applied and applicants.

**WHAT WAS DONE:**

**Files Modified:**
- `Custom Objects\Report\52185469HRJobApplications.Report.al`

**Changes:**
1. Enhanced existing HR Job Applications report to support both detailed and list views
2. Added request page options:
   - Show Detailed View (checkbox) - shows full details with qualifications, referees, hobbies
   - Show Qualifications Summary (checkbox) - shows summary of qualifications in list view

3. Removed mandatory filter requirement - report now works with or without filters

4. Added new columns to dataset:
   - Full Name (applicant full name)
   - Job Applied for Description (job title)
   - Date Applied
   - Status (Application, Shortlisted, Approved, Unqualified)
   - Qualifications Summary (semicolon-separated list of qualifications)

5. Added OnAfterGetRecord trigger to build qualifications summary dynamically

6. Enhanced RequestFilterFields to include Job Applied For, Date Applied, Status for better filtering

**WHY:**
HR needs to see all applicants at once to compare candidates and track applications. Previous report required individual applicant selection. New list view allows bulk reporting while maintaining detailed view option for individual applicant profiles.

**RESULT:**
- User runs HR Job Applications report
- Request page shows two options:
  - Show Detailed View: Unchecked = List view (all applicants), Checked = Detailed view (full info)
  - Show Qualifications Summary: Shows qualifications in list view
- User can filter by Job Applied For, Date Applied, Status, or Application No.
- List view shows: Application No., Full Name, Job Applied For, Job Description, Date Applied, Status, Qualifications Summary
- Detailed view shows: All personal details, contact info, qualifications table, referees table, hobbies
- Report works without filters (shows all applicants) or with filters (shows specific applicants)

**NOTE:** RDLC layout file needs to be updated to:
1. Add new list view layout using ShowDetailedView boolean to switch between views
2. Display new columns: Full Name, Job Applied for Description, Date Applied, Status, Qualifications Summary
3. Use ShowQualificationsSummary boolean to conditionally show qualifications summary column

---

## TICKET #31 - SHORTLISTED CANDIDATES WITH POSITIONS APPLIED FOR

**STATUS:** COMPLETED

**REQUIREMENT:**
Generate report showing shortlisted candidates with positions applied for. HR should be able to generate report on all shortlisted applicants for different jobs during a selected duration.

**WHAT WAS DONE:**

**Files Modified:**
- `Custom Objects\Report\52185591ShortlistingReport.Report.al`

**Changes:**
1. Changed report data source from HR Job Interview to HR Job Applications
2. Added DataItemTableView filter: WHERE(Status = CONST(Shortlisted))
3. Added RequestFilterFields for filtering:
   - Job Application No.
   - Job Applied For
   - Date Applied
   - Employee Requisition No

4. Added columns to dataset:
   - Application No.
   - Full Name (First, Middle, Last names)
   - Job Applied For (Job ID)
   - Job Applied for Description (Job title)
   - Date Applied
   - Status
   - ID Number
   - Gender
   - Cell Phone Number
   - Email
   - Employee Requisition No
   - Total Score After Shortlisting
   - Qualifications Summary (dynamically built)
   - Company information (Name, Address, Phone, Email)

5. Added OnAfterGetRecord trigger to build qualifications summary dynamically

6. Commented out old HR Job Interview dataitem (not needed for shortlisted candidates)

**WHY:**
HR needs to see all shortlisted candidates across different jobs and time periods. Previous report showed interview data, not shortlisted candidates. New report filters by Status = Shortlisted and allows filtering by job, date range, or requisition number.

**RESULT:**
- User runs Shortlisting Report
- Report automatically shows only shortlisted candidates (Status = Shortlisted)
- User can filter by:
  - Job Applied For (see shortlisted candidates for specific job)
  - Date Applied (see shortlisted candidates within date range)
  - Employee Requisition No (see shortlisted candidates for specific requisition)
  - Application No. (see specific shortlisted candidate)
- Report shows: Application No., Full Name, Job Applied For, Job Description, Date Applied, ID Number, Gender, Contact Info, Shortlisting Score, Qualifications Summary
- No filter = All shortlisted candidates across all jobs

**NOTE:** RDLC layout file needs to be updated to:
1. Display new columns from HR Job Applications instead of HR Job Interview
2. Show shortlisted candidates in list/table format
3. Include qualifications summary column
4. Add company information header

---

## TICKET #29 - AUTOMATIC RESPONSES FOR JOB APPLICATIONS

**STATUS:** COMPLETED

**REQUIREMENT:**
Send automatic email responses to applicants when receiving applications, when qualifying/shortlisted, and when not qualifying/not shortlisted. HR Officer should be able to send responses to selected applicants.

**WHAT WAS DONE:**

**Files Modified:**
- `Custom Objects\Table\52185512HRJobApplications.Table.al`

**Changes:**
1. Enhanced Status field OnValidate trigger to detect status changes
2. Added automatic email sending when status changes from one value to another
3. Added four email sending procedures:
   - SendApplicationReceivedEmail() - Sent when Status = Application
   - SendShortlistedEmail() - Sent when Status = Shortlisted
   - SendApprovedEmail() - Sent when Status = Approved
   - SendUnqualifiedEmail() - Sent when Status = Unqualified

4. Email features:
   - HTML formatted emails with company branding
   - Personalized with applicant full name
   - Includes job title and application number
   - For unqualified: Includes rejection reason if provided
   - Uses Business Central Email Message and Email codeunits
   - Updates "Email Sent" and "Sent Email" fields after successful send

5. Email validation:
   - Checks if applicant has email address before sending
   - For Application status: Only sends if "Email Sent" is false (prevents duplicate emails)
   - For other statuses: Sends email on each status change

**WHY:**
Applicants need timely communication about their application status. Automatic emails improve candidate experience, reduce HR workload, and maintain professional communication. Status-based triggering ensures emails are sent at the right time without manual intervention.

**RESULT:**
- Applicant submits application → Status set to Application → Automatic email: "Application Received"
- HR shortlists applicant → Status changed to Shortlisted → Automatic email: "Congratulations! You have been shortlisted"
- HR approves applicant → Status changed to Approved → Automatic email: "Application Approved"
- HR marks as unqualified → Status changed to Unqualified → Automatic email: "Application Status" with rejection reason
- All emails are HTML formatted with company name from Company Information
- Emails only sent if applicant has valid email address
- Email sent status tracked in "Email Sent" and "Sent Email" fields

**EMAIL TEMPLATES:**

**Application Received:**
- Subject: "Application Received - [Job Title]"
- Content: Thank you message, application number, under review notice

**Shortlisted:**
- Subject: "Shortlisted - [Job Title]"
- Content: Congratulations, application number, next steps notice

**Approved:**
- Subject: "Application Approved - [Job Title]"
- Content: Congratulations, application number, employment details notice

**Unqualified:**
- Subject: "Application Status - [Job Title]"
- Content: Thank you, application number, regret message, rejection reason (if provided), best wishes

**NOTE:** Emails are sent automatically when HR changes the Status field. No manual action required. Email sending uses Business Central's built-in Email functionality which requires email account setup in Business Central.

---
