table 52185425 "Loan Closure Line"
{
    
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Product Type"; Code[20])
        {
        }
        field(3; "Product Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = field("Product Type")));
            Editable = false;
        }
        field(4; "Loan No."; Code[20])
        {
            TableRelation = Loans;
        }
        field(5; Name; Text[50])
        {
        }
        field(6; "Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(7; "Outstanding Interest"; Decimal)
        {
            Editable = false;
        }
        
        field(8; "Member No."; Code[20])
        {
        }
        field(9; "Total Loan Balance"; Decimal)
        {
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "No.", "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Membershipclosure.Reset;
        Membershipclosure.SetRange(Membershipclosure."No.", "No.");
        Membershipclosure.SetFilter(Membershipclosure.Status, '<>%1', Membershipclosure.Status::Open);
        if Membershipclosure.Find('-') then begin
            Error(Txt00000);
        end;
    end;

    var
        Membershipclosure: Record "Membership closure";
        Txt00000: Label 'You cannot delete enteries when status is not open';
        SavingsAccounts: Record "Savings Accounts";
}

