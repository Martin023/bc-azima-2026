table 52186212 "Update Employer Code"
{

    fields
    {
        field(8; No; Code[10])
        {
        }
        field(9; "Emp Code"; Code[20])
        {
        }
        field(10; "Member Updated"; Boolean)
        {
            Caption = 'Member Updated';
        }
        field(11; "Account Updated"; Boolean)
        {
        }
        field(12; "Loan Updated"; Boolean)
        {
        }
        field(13; "Credit Updated"; Boolean)
        {
        }
        field(14; "Mobile Number"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Members.Reset;
        Members.SetRange("No.", Rec.No);
        if Members.Find('-') then begin
            Members."Employer Code" := "Mobile Number";
            "Member Updated" := true;
            Members.Modify;
        end;

        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", Rec.No);
        if SavingsAccounts.Find('-') then begin
            repeat
                SavingsAccounts."Employer Code" := "Mobile Number";
                "Account Updated" := true;
                SavingsAccounts.Modify;
            until SavingsAccounts.Next = 0;
        end;

        Loans.Reset;
        Loans.SetRange("Member No.", Rec.No);
        if Loans.Find('-') then begin
            repeat
                Loans."Employer Code" := "Mobile Number";
                "Loan Updated" := true;
                Loans.Modify;
            until Loans.Next = 0;
        end;


        CreditAccounts.Reset;
        CreditAccounts.SetRange("Member No.", Rec.No);
        if CreditAccounts.Find('-') then begin
            repeat
                CreditAccounts."Employer Code" := "Mobile Number";
                "Credit Updated" := true;
                CreditAccounts.Modify;
            until CreditAccounts.Next = 0;
        end;
    end;

    var
        Members: Record Members;
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
}

