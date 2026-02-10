table 52186143 "Asset Finance Loan"
{
    DrillDownPageID = "Posted End Year Interest";
    LookupPageID = "Posted End Year Interest";

    fields
    {
        field(1; "Loan No."; Code[50])
        {
            NotBlank = true;
            TableRelation = Loans."Loan No.";
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Payee; Text[50])
        {
            NotBlank = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(4; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if Amount < 0 then
                    Error('Amount cannot be less than 0');

                if LoanApp.Get("Loan No.") then begin
                    NetAmt := 0;
                    NetAmt := LoansProcess.ComputeCharges(LoanApp."Approved Amount", LoanApp."Loan Product Type", LoanApp."Loan No.", 0);

                    if NetAmt - Amount <= 0 then
                        Error(Text002);
                end;
            end;
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Bankers Cheque No"; Code[20])
        {
        }
        field(7; "Bankers Cheque No 2"; Code[20])
        {
        }
        field(8; "Bankers Cheque No 3"; Code[20])
        {
        }
        field(9; "Batch No."; Code[20])
        {
        }
        field(10; "Affects 2/3 Rule"; Boolean)
        {
            Editable = false;
        }
        field(11; "Monthly Deduction"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Monthly Deduction" > 0 then
                    "Affects 2/3 Rule" := true
                else
                    "Affects 2/3 Rule" := false;
            end;
        }
        field(12; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No." WHERE("Vendor Type" = FILTER("Asset Finance"));

            trigger OnValidate()
            begin
                if Vend.Get("Vendor No.") then
                    "Vendor Name" := Vend.Name;
            end;
        }
        field(13; "Vendor Name"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Vendor No.", Description, Amount)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; Payee)
        {
        }
        key(Key3; "Batch No.")
        {
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
        Text001: Label 'You cannot modify this since the loan is already %1';
        LoanApp: Record Loans;
        NetAmt: Decimal;
        LoansProcess: Codeunit "Loans Process";
        Text002: Label 'The approved amount is not sufficient to offset commitments';
        Vend: Record Vendor;
}

