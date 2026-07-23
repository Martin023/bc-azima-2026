page 52185592 "HR Setup"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "HR Setup";
    ApplicationArea = Basic;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Default Leave Posting Template"; Rec."Default Leave Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field("Positive Leave Posting Batch"; Rec."Positive Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Negative Leave Posting Batch"; Rec."Negative Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                FIELD("Staff Welfare G/L ";Rec."Staff Welfare G/L ")
                {
                    
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Job ID Nos"; Rec."Job ID Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisition Nos."; Rec."Employee Requisition Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Proffessional Bodies Nos."; rec."Proffessional Bodies Nos.")
                {
                    ApplicationArea = Basic;
                }

                field("Job Application Nos"; Rec."Job Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Induction Nos"; Rec."Induction Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Reimbursment Nos."; Rec."Leave Reimbursment Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Planner Nos."; Rec."Leave Planner Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Traning Needs Nos."; Rec."Traning Needs Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Training Need Request Nos."; Rec."Training Need Request Nos.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Training Need Request Nos.';
                }
                field("Target Assignment Nos."; Rec."Target Assignment Nos.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Target Assignment Nos.';
                }
                field("CEO Goals Nos."; Rec."CEO Goals Nos.")
                {
                    ApplicationArea = Basic;
                    Caption = 'CEO Goals Nos.';
                }
                field("Training Application Nos."; Rec."Training Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Interns Req. Nos"; Rec."Interns Req. Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Transfer Nos."; Rec."Employee Transfer Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Promotion No."; Rec."Employee Promotion No.")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Interview Nos"; Rec."Exit Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Nos"; Rec."Appraisal Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Company Activities"; Rec."Company Activities")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Asset Transfer No."; Rec."Employee Asset Transfer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Req Nos"; Rec."Transport Req Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Allocation Nos."; Rec."Transport Allocation Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Succession Planning Nos."; Rec."Succession Planning Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Claims Nos"; Rec."Medical Claims Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Overtime Req Nos."; Rec."Overtime Req Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Incident Nos."; Rec."Incident Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Investigation Nos."; Rec."Investigation Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Confirmation No."; Rec."Employee Confirmation No.")
                {
                    ApplicationArea = Basic;
                }
                field("PR Deduction Nos."; Rec."PR Deduction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("PR Allowances Nos."; Rec."PR Allowances Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Base Calendar"; Rec."Base Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Advance Nos."; Rec."Salary Advance Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(test; Rec.test)
                {
                    ApplicationArea = Basic;
                }
                field("Back To Office Nos"; Rec."Back To Office Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Withdrawal Nos."; Rec."Disciplinary Withdrawal Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Appeal Nos"; Rec."Appraisal Appeal Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Appeal Nos"; Rec."Disciplinary Appeal Nos")
                {
                    ApplicationArea = Basic;
                }
                field("HR Loan Nos."; rec."HR Loan Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Self Service Loan Nos."; Rec."Self Service Loan Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Establishment ID Nos"; Rec."Establishment ID Nos")
                {

                }
            }
            group(Appraisal)
            {
                Caption = 'Appraisal';
                field("Appraisal Method"; Rec."Appraisal Method")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Template"; Rec."Appraisal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Batch"; Rec."Appraisal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Training Planner Nos."; Rec."Training Planner Nos.")
                {

                }
                field("Appraisal Posting Period[FROM]"; Rec."Appraisal Posting Period[FROM]")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Posting Period[TO]"; Rec."Appraisal Posting Period[TO]")
                {
                    ApplicationArea = Basic;
                }
                field("Target Setting Month"; Rec."Target Setting Month")
                {
                    ApplicationArea = Basic;
                }
                field("Max Appraisal Rating"; Rec."Max Appraisal Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Min Appraisal Rating"; Rec."Min Appraisal Rating")
                {

                }
                field("Appraisal Interval"; Rec."Appraisal Interval")
                {
                    ApplicationArea = Basic;
                }
                field("Welfare No"; Rec."Welfare No")
                {

                }
                field("OverTime Claim"; Rec."OverTime Claim")
                {

                }
                field("Min Leave Days"; Rec."Min Leave Days")
                {

                }
                field("Min Recall Notice Days"; Rec."Min Recall Notice Days")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Minimum number of days notice required before recalling an employee from leave. Set to 0 to allow immediate recalls.';
                }
                
                field(Formula; Rec.Formula)
                {

                }
                field("Weekend Overtime Formula"; Rec."Weekend Overtime Formula")
                {

                }
                field("Weekday Overtime Formula"; Rec."Weekday Overtime Formula")
                {

                }
                field("Revolving Fund"; Rec."Revolving Fund")
                {
                    ApplicationArea = all;
                   

                }
                field("Retirement Age";Rec."Retirement Age")
                {

                }
                field("Disabled Retirement Age";Rec."Disabled Retirement Age")
                {
                    
                }
            }
            group("Notification Settings")
            {
                Caption = 'Employee Notification Settings';
                field("Enable Contract Notifications"; Rec."Enable Contract Notifications")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable automatic email notifications for contract expiry';
                }
                field("Contract Expiry Warning Days"; Rec."Contract Expiry Warning Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of days before contract end date to send notification';
                }
                field("Enable Retirement Notifications"; Rec."Enable Retire Notifications")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable automatic email notifications for retirement';
                }
                field("Retirement Warning Months"; Rec."Retirement Warning Months")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of months before retirement date to send notification';
                }
                field("HR Admin Email"; Rec."HR Admin Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email address of HR Administrator to receive notifications';
                }
            }
            group("Miscellaneous")
            {
                Caption = 'Miscellaneous';
                field("Welfare Advance No.";Rec."Welfare Advance No.")
                {
                    
                }
                field("Clearance No";Rec."Clearance No")
                {
                    
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewNotificationLog)
            {
                ApplicationArea = All;
                Caption = 'View Notification Log';
                Image = Log;
                ToolTip = 'View the history of sent contract and retirement notifications';
                RunObject = page "HR Notification Log";
            }
            action(RunNotificationCheck)
            {
                ApplicationArea = All;
                Caption = 'Run Notification Check Now';
                Image = SendMail;
                ToolTip = 'Manually trigger contract and retirement notification check';

                trigger OnAction()
                var
                    HRNotifMgmt: Codeunit "HR Expiry & Retirement Notif";
                begin
                    if Confirm('Run contract expiry and retirement notification check now?', true) then begin
                        HRNotifMgmt.RunDailyNotificationCheck();
                        Message('Notification check completed. Check the Notification Log for results.');
                    end;
                end;
            }
        }
        area(Promoted)
        {
            actionref(ViewNotificationLog_Promoted; ViewNotificationLog) { }
            actionref(RunNotificationCheck_Promoted; RunNotificationCheck) { }
        }
    }

    trigger OnOpenPage()
    begin

        // Rec.Reset;
        // if not Rec.Get then begin
        //     Rec.Init;
        //     Rec.Insert;
        // end;
    end;
}

