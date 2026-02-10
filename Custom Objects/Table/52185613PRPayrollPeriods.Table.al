table 52185613 "PR Payroll Periods"
{
    LookupPageID = "PR Payroll Periods";

    fields
    {
        field(1; "Period Month"; Integer)
        {
        }
        field(2; "Period Year"; Integer)
        {
        }
        field(3; "Period Name"; Text[30])
        {
            Description = 'e.g November 2009';
        }
        field(4; "Date Opened"; Date)
        {
            NotBlank = true;
        }
        field(5; "Date Closed"; Date)
        {
        }
        field(6; Closed; Boolean)
        {
            Description = 'A period is either closed or open';
        }
        //Opening a period
        field(9; Open;Boolean)
        {
            
        }
        field(7; "Closed By"; Code[100])
        {
        }
        field(8; "Opened By"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Date Opened")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Date Opened", "Period Name")
        {
        }
    }
}

