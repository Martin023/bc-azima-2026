table 52185774 "Transaction Charges"
{
    LookupPageID = "Transaction Charges";

    fields
    {
        field(1; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types";
        }
        field(2; "Charge Code"; Code[20])
        {
            Editable = false;
            Enabled = false;

            trigger OnValidate()
            begin
                TransactionTypes.Reset;
                TransactionTypes.SetRange(TransactionTypes.Code, "Charge Code");
                if TransactionTypes.Find('-') then
                    Description := TransactionTypes.Description;
            end;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Charge Type"; Option)
        {
            OptionCaption = 'Flat Amount,% of Amount,Staggered';
            OptionMembers = "Flat Amount","% of Amount",Staggered;
        }
        field(5; "Charge Amount"; Decimal)
        {
            Editable = true;
        }
        field(6; "Percentage of Amount"; Decimal)
        {
            Editable = true;
        }
        field(14; "Account Type"; enum "Gen. Journal Account Type")
        {
            ValuesAllowed = "G/L Account", Customer, "Bank Account", vendor;
        }
        field(7; "G/L Account"; Code[20])
        {
            // Editable = false;
            //TableRelation = "G/L Account";
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("Account Type"::"G/L Account")) "G/L Account"
            else
            if ("Account Type" = const("Account Type"::Vendor)) Vendor
            else
            if ("Account Type" = const("Account Type"::Customer)) Customer
            else
            if ("Account Type" = const("Account Type"::"Bank Account")) "Bank Account";
        }
        field(8; "Minimum Amount"; Decimal)
        {
        }
        field(9; "Maximum Amount"; Decimal)
        {
        }
        field(10; "Staggered Charge Code"; Code[20])
        {
            TableRelation = "Tiered Charges Header";
        }
        field(11; "Transaction Charge Category"; Option)
        {
            OptionMembers = Normal,"Stamp Duty","Withdrawal Frequency","Withdrawn Amount","Failed STO Charge";
        }
        field(12; "Recover Excise Duty"; Boolean)
        {
        }
        field(13; "Withholding Tax"; Boolean)
        {

        }

    }

    keys
    {
        key(Key1; "Transaction Type", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Recover Excise Duty" := true;
    end;

    var
        TransactionTypes: Record "Transaction Types";
}

