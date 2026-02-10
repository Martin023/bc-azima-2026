table 52186059 "Region Delegates Tariff"
{
    DrillDownPageID = "Region Delegate Tariffs";
    LookupPageID = "Region Delegate Tariffs";

    fields
    {
        field(1; "Code"; Code[10])
        {
            TableRelation = "Delegates Tariff".Code;

            trigger OnValidate()
            begin
                DelegatesTariff.Reset;
                DelegatesTariff.SetRange(DelegatesTariff.Code, Code);
                if DelegatesTariff.Find('-') then begin
                    Description := DelegatesTariff.Description;
                    "Account No." := DelegatesTariff."Account No.";
                    Amount := DelegatesTariff.Amount;
                end; 
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Savings)) "Savings Accounts"
            ELSE
            IF ("Account Type" = CONST(Credit)) "Credit Accounts";
        }
        field(5; CalculationMethod; Option)
        {
            Caption = 'Description';
            OptionCaption = 'Amount,Milleage';
            OptionMembers = Amount,Milleage;
        }
        field(6; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(7; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "Rate Per KM"; Decimal)
        {
        }
        field(15; "Payment Frequency"; Option)
        {
            OptionCaption = ' ,Weekly,Monthly,Quartely,Semi Annual,Annual';
            OptionMembers = " ",Weekly,Monthly,Quartely,"Semi Annual",Annual;
        }
        field(16; "Maximum No Paid"; Decimal)
        {
        }
        field(17; "Region Code"; Code[50])
        {
            TableRelation = "Delegate Region".Code;
        }
        field(18; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Delegates Payment" | "Delegates Special"));
        }
    }

    keys
    {
        key(Key1; "Region Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DelegatesTariff: Record "Delegates Tariff";
}

