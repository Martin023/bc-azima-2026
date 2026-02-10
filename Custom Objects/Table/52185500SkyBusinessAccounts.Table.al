table 52185500 "Sky Business Accounts"
{
    DrillDownPageId = "Sky Business Accounts";
    LookupPageId = "Sky Business Accounts";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Members."No.";
        }
        field(3; "Account No"; Code[30])
        {
            TableRelation = "Savings Accounts"."No.";
        }
        field(4; Status; Option)
        {
            OptionMembers = New,Active,Closed;
        }
        field(5; "Business Name"; Text[50])
        {
        }
        field(6; "Business Location"; Text[50])
        {
        }
        field(7; "Application Date"; DateTime)
        {
        }
        field(8; "Activated At"; DateTime)
        {
        }
        field(9; "Form Submitted"; Boolean)
        {
        }
        field(10; "Paid Initial Amount"; Boolean)
        {
        }
        field(11; "Session ID"; Text[30])
        {
        }
        field(12; "Bussiness Code"; Text[50])
        {
        }
        field(13; "SMS Sent"; Boolean)
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

