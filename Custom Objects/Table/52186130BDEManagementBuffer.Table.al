table 52186130 "BDE Management Buffer"
{
    DrillDownPageID = "BDE Management Buffer";
    LookupPageID = "BDE Management Buffer";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Editable = false;
        }
        field(2; "Account No"; Code[20])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Credit,Savings,ATM';
            OptionMembers = " ",Credit,Savings,ATM;
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "No Sold"; Decimal)
        {
        }
        field(6; Transfered; Boolean)
        {
        }
        field(7; "Processing Date"; Date)
        {
        }
        field(8; "BDE No."; Code[20])
        {
        }
        field(9; "Product Type"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

