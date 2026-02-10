table 52185751 "Partial Disbursement Schedule"
{

    fields
    {
        field(1; "Loan No."; Code[50])
        {
        }
        field(2; "Scheduled Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Scheduled Disbursement Date" < Today then
                    Error(DateErr);
            end;
        }
        field(3; Amount; Decimal)
        {
            MinValue = 0;
        }
        field(4; Posted; Boolean)
        {
            Editable = false;
        }
        field(5; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(6; "Disbursement Destination"; Option)
        {
            OptionCaption = 'Front Office,Cheque,MPesa,Bank Transfer';
            OptionMembers = "Front Office",Cheque,MPesa,"Bank Transfer";
        }
        field(7; "Suggested for Disbursement"; Boolean)
        {
        }
        field(8; "Date Posted"; Date)
        {
        }
        field(9; "Time Posted"; Time)
        {
        }
        field(10; "Posted By"; Text[70])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if LoanApp.Get("Loan No.") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    trigger OnInsert()
    begin
        if LoanApp.Get("Loan No.") then begin
            if LoanApp."Mode of Disbursement" <> LoanApp."Mode of Disbursement"::"Partial Disbursement" then
                Error(PartError, LoanApp."Loan No.", LoanApp."Mode of Disbursement"::"Partial Disbursement");
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);

            PartialDisbursementSchedule.Reset;
            PartialDisbursementSchedule.SetRange(PartialDisbursementSchedule."Loan No.", "Loan No.");
            if PartialDisbursementSchedule.Find('-') then begin
                repeat
                    TotalAmount := PartialDisbursementSchedule.Amount;
                until PartialDisbursementSchedule.Next = 0;
            end;
            TotalAmount := (TotalAmount + LoanApp."Amount To Disburse" + Rec.Amount);
            if TotalAmount > LoanApp."Approved Amount" then
                Error(AmountError, LoanApp."Loan No.");

        end;
    end;

    trigger OnModify()
    begin
        if Posted then
            Error(PostedErr);
        if LoanApp.Get("Loan No.") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    trigger OnRename()
    begin
        if LoanApp.Get("Loan No.") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    var
        DateErr: Label 'Scheduled disbursement date cannot be earlier than today';
        PostedErr: Label 'You cannot modify a posted disbursement';
        Text001: Label 'Loan is already %1 and cannot modify';
        LoanApp: Record Loans;
        PartialDisbursementSchedule: Record "Partial Disbursement Schedule";
        TotalAmount: Decimal;
        PartError: Label 'Mode of dibursment for loan %1 must be %2';
        AmountError: Label 'Total amount cannot be greater than Approved Amount on Loan No %1';
}

