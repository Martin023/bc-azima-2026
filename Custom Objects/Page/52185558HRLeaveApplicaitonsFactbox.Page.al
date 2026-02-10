page 52185558 "HR Leave Applications Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            label(Control1102755011)
            {
                CaptionClass = Text1;
                ShowCaption = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
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
            field("Job Title"; Rec."Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
            label(Control1102755005)
            {
                ShowCaption = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            label(Control1102755012)
            {
                CaptionClass = Text2;
                ShowCaption = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            field("Total Leave Taken"; Rec."Total Leave Taken")
            {
                ApplicationArea = Basic;
            }
            field("Total (Leave Days)"; Rec."Total (Leave Days)")
            {
                ApplicationArea = Basic;
            }
            field("Monthly Leave Days"; Rec."Monthly Leave Days")
            {

            }
            field("Available Leave Days"; Rec."Available Leave Days")
            {

            }

            field("Allocated Leave Days"; Rec."Allocated Leave Days")
            {
                ApplicationArea = Basic;
            }
            field("Annual Leave Account"; Rec."Annual Leave Account")
            {
                ApplicationArea = Basic;
            }
            field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
            {

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
        Days := 0;
        DaysWorked := 0;
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


    var
        Text1: Label 'Employee Details';
        Text2: Label 'Employeee Leave Details';
        Days: Integer;
        DaysWorked: Decimal;
        HrLeave: record "HR Leave Ledger Entries";
        HRLeaveCal: record "HR Leave Calendar";


}

