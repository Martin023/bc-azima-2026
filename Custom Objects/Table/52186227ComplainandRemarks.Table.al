table 52186227 "Complain and Remarks"
{
    LookupPageID = "Complains and Remarks Page";

    fields
    {
        field(1; "Header No"; Code[30])
        {
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = "Complains and Remarks","Other Remarks";
        }
        field(4; Complain; Text[250])
        {
        }
        field(5; Suggestion; Text[250])
        {
        }
        field(6; "Proposed Resolutions"; Text[250])
        {
        }
        field(7; Numbering; Integer)
        {
        }
        field(8; "Complaint Catagory"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Header No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

