table 52186096 "Loan Mandatory Requirements"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Loan No."; Code[50])
        {
        }
        field(3; "Mandatory Requirement"; Option)
        {
            OptionCaption = ' ,Salary,Business Income,Member Deposits,Collateral or Guarantors';
            OptionMembers = " ",Salary,"Business Income","Member Deposits","Collateral or Guarantors";
        }
        field(4; "Provided ?"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
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
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    trigger OnModify()
    begin
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
        LoanApp: Record Loans;
        Text001: Label 'The loan is already %1 and cannot modify';
}

