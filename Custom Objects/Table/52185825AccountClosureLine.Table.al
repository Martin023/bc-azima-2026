table 52185825 "Account Closure Line"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = "Savings Accounts";

            trigger OnValidate()
            begin
                if SavingsAccounts.Get("Account No.") then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    Balance := SavingsAccounts."Balance (LCY)";
                    Modify;
                end;
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; "Product Type"; Code[20])
        {
        }
        field(5; Balance; Decimal)
        {
            Editable = false;
        }
        field(6; Close; Boolean)
        {
            trigger OnValidate()
            var
                Membershipclosure: Record "Membership closure";
                ErrClose: Label 'The close option cannot be marked to %1 for %2';
            begin
                if Membershipclosure.Get("No.") then
                    Membershipclosure.UpdateDepositRefundable();

                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                SavingsAccounts.SetRange("No.", "Account No.");
                if SavingsAccounts.FindFirst() then
                    if not Close then
                        Error(ErrClose, Close, SavingsAccounts."Product Category"::"BOSA Deposits");

            end;
        }
        field(7; "Member No."; Code[20])
        {
        }
        field(8; Blocked; Option)
        {
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        //For Business Loans Process
        field(9; "Total Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(10; "Interest Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(11; "Savings Balance"; Decimal)
        {
            Editable = false;
        }
        field(12; "Net Refundable"; Decimal)
        {
            Editable = false;
        }
        field(13; "Product Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = field("Product Type")));
            Editable = false;
        }
        //End of Business loans

    }

    keys
    {
        key(Key1; "No.", "Account No.", "Member No.")
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

