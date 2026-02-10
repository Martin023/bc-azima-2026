table 52185503 "Sky Mortgage"
{
    DrillDownPageId = "Mortgage Requisition List";
    LookupPageId = "Mortgage Requisition List";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Session ID"; Code[30])
        {
        }
        field(3; "Product Type"; Code[30])
        {
        }
        field(4; "Full Name"; Text[50])
        {
        }
        field(5; "Age Group"; Text[30])
        {
        }
        field(6; "Source Of Income"; Text[40])
        {
        }
        field(7; "Gross Monthly Income"; Text[30])
        {
        }
        field(8; "County Of Residence"; Text[30])
        {
        }
        field(9; Email; Text[50])
        {
        }
        field(10; Actioned; Boolean)
        {
        }
        field(11; "Entry Time"; Time)
        {
        }
        field(12; "Entry Date"; Date)
        {
        }
        field(13; "Phone Number"; Text[15])
        {
        }
        field(14; "Actioned By"; Code[30])
        {
        }
        field(15; "Date Actioned"; Date)
        {
        }
        field(16; "Time Actioned"; Time)
        {
        }
        field(17; "Member Number"; Code[30])
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

