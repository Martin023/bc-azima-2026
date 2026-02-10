table 52186006 "Property Charges"
{
    // DrillDownPageID = "Property Charges";
    // LookupPageID = "Property Charges";

    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = Charges.Code;

            trigger OnValidate()
            begin
                Charge.Reset;
                Charge.SetRange(Charge.Code, Code);
                if Charge.Find('-') then begin
                    Name := Charge.Name;
                    Vatable := Charge.Vatable;
                    "Uses Rates" := Charge."Uses Rates";
                    "Transaction Type" := Charge."Transaction Type";

                end;
            end;
        }
        field(2; Name; Text[100])
        {
        }
        field(3; "Account No."; Code[20])
        {
            NotBlank = false;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAccount.Get("Account No.");
                GLAccount.TestField(GLAccount."Income/Balance", GLAccount."Income/Balance"::"Income Statement");
                GLAccount.TestField(GLAccount."Account Type", GLAccount."Account Type"::Posting);
            end;
        }
        field(4; Vatable; Boolean)
        {
        }
        field(5; "VAT Code"; Code[30])
        {
            TableRelation = "Tariff Code s";

            trigger OnValidate()
            begin
                Tariffs.Reset;
                Tariffs.Get("VAT Code");
                Amount := Tariffs.Percentage;
            end;
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Uses Rates"; Boolean)
        {
        }
        field(8; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
        field(9; "Property Code"; Code[30])
        {
            TableRelation = "Property Details"."No.";
        }
        field(10; "Charge Management Fee"; Boolean)
        {
        }
        field(11; "Charge Letting Fee"; Boolean)
        {
        }
        field(12; "Charge Reletting Fee"; Boolean)
        {
        }
        field(13; "Mgt on Rent Only"; Boolean)
        {
        }
        field(14; "Charge Management Incl. VAT"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Property Code")
        {
            Clustered = true;
        }
        key(Key2; "VAT Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLAccount: Record "G/L Account";
        Tariffs: Record "Tariff Code s";
        Charge: Record Charges;
}

