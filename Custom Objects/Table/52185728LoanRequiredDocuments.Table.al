table 52185728 "Loan Required Documents"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Savings,Loans';
            OptionMembers = " ",Savings,Loans;
        }
        field(3; "Document No."; Code[10])
        {
            TableRelation = "Application Document Setup" WHERE("Document Type" = CONST(Loan));

            trigger OnValidate()
            var
                ApplicationDocumentSetup: Record "Application Document Setup";
            begin
                ApplicationDocumentSetup.Reset();
                ApplicationDocumentSetup.SetRange("Document No.", Rec."Document No.");
                if ApplicationDocumentSetup.Find('-') then begin
                    Rec.Description := ApplicationDocumentSetup.Description;
                end;
            end;
        }
        field(4; Description; Text[250])
        {
            Editable = false;
        }
        field(5; "Single Party/Multiple"; Option)
        {
            OptionCaption = 'Single,Multiple,Business';
            OptionMembers = Single,Multiple,Business;
        }
        field(6; "Product ID"; Code[20])
        {
            TableRelation = "Product Factory";

        }
        field(7; "Product Name"; Text[100])
        {
        }
        field(8; "Loan No."; Code[50])
        {
        }
        field(9; "Provided ?"; Option)
        {
            OptionCaption = ' ,No,Yes,Waived';
            OptionMembers = " ",No,Yes,Waived;
        }
        field(10; "License Expiry Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Loan No.")
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
        Text001: Label 'This loan cannot be modified since it is %1';
}

