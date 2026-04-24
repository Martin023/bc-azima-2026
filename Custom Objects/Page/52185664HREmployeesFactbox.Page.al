page 52185664 "HR Employees Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";
    ;

    layout
    {
        area(content)
        {
            // field(PersonalDetails; Rec.PersonalDetails)
            // {
            //     Style = StrongAccent;
            //     StyleExpr = TRUE;
            // }
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic;
            }
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = Basic;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
            field("Company E-Mail"; Rec."Company E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            // field(JobDetails; Rec.JobDetails)
            // {
            //     Style = StrongAccent;
            //     StyleExpr = TRUE;
            // }
            field("Job Title"; Rec."Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = Basic;
            }
            // field(LeaveDetails; Rec.LeaveDetails)
            // {
            //     Style = StrongAccent;
            //     StyleExpr = TRUE;
            // }
            field("Annual Leave Account"; Rec."Annual Leave Account")
            {
                ApplicationArea = Basic;
                Caption = 'Annual Leave Days Acc.';
            }
            field("Allocated Leave Days"; Rec."Allocated Leave Days")
            {
                Caption = 'Allocated Annual Leave Days';
                ApplicationArea = Basic;
            }
            field(LEaveTaken; Rec."Total Leave Taken")
            {
                ApplicationArea = Basic;
                Caption = 'Total Annual Leave Taken';
            }
            field("Total (Leave Days)"; Rec."Total (Leave Days)")
            {
                Caption = 'Available Annual Leave Days';
                ApplicationArea = Basic;
            }
            FIELD("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
            {
                ApplicationArea = Basic;
            }
            field("Compassionate Leave Acc."; Rec."Compassionate Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Maternity Leave Acc."; Rec."Maternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Paternity Leave Acc."; Rec."Paternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Sick Leave Acc."; Rec."Sick Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Study Leave Acc"; Rec."Study Leave Acc")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        if rec.Status = Rec.status::Active then begin
            HRLeaveCal.Reset;
            HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
            if HRLeaveCal.Find('-') then begin

                //Filter by Leave Period from HR Setup
                HRLeave.Reset;
                HRLeave.SetRange(HRLeave."Staff No.", Rec."No.");

                HRLeave.SetRange(HRLeave."Leave Calendar Code", HRLeaveCal."Calendar Code");
                HrLeave.SetRange("Leave Entry Type", HrLeave."Leave Entry Type"::Positive);
                HrLeave.SetRange(Closed, false);

                if HRLeave.Find('-') then begin
                    HrLeave.CalcSums(HrLeave."No. of days");

                    Days := Today - HRLeaveCal."Start Date";
                    //HrLeave.CalcFields("No. of days");
                    DaysWorked := Days * (HrLeave."No. of days" / 365);
                    Rec."Monthly Leave Days" := DaysWorked;
                    rec.modify(true);
                end;
                Rec.calcfields("Reimbursed Leave Days", "Total Leave Taken");
                Rec."Available Leave Days" := (DaysWorked + rec."Reimbursed Leave Days") - ABS(rec."Total Leave Taken");
                rec.modify(true);
            end else
                Error('Leave Calendar not setup');
        end;
    end;

    var
        PersonalDetails: Label 'Personal Details';
        BankDetails: Label 'Bank Details';
        JobDetails: Label 'Job Details';
        LeaveDetails: Label 'Leave Details';
        Days: Integer;
        DaysWorked: Decimal;
        HrLeave: record "HR Leave Ledger Entries";
        HRLeaveCal: record "HR Leave Calendar";

}

