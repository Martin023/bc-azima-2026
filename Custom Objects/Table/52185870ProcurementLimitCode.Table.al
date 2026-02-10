table 52185870 "Procurement Limit Code"
{
    // DrillDownPageID = "HR BSC List Qaurter 3";
    // LookupPageID = "HR BSC List Qaurter 3";

    fields
    {
        field(1; "Procurement Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Procurement Type"; Option)
        {
            OptionMembers = " ","Direct Procurement","Requset For Qoute","Low Value Procurement","Restricted Tendering","Open Tendering";
        }
        field(3; "Procurement Amount Type"; Option)
        {
            OptionMembers = " ",Range,"Fixed";
        }
        field(4; "Min. Amount"; Decimal)
        {
        }
        field(5; "Max Amount"; Decimal)
        {
        }
        field(6; "Fixed Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Procurement Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

