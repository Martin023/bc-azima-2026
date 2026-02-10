table 52186088 "Mortgage Loans Doc Register"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; "Member No"; Code[20])
        {
        }
        field(3; "Member Name"; Text[70])
        {
        }
        field(4; "Loan Type"; Code[10])
        {
        }
        field(5; "Document Type"; Option)
        {
            OptionCaption = ' ,Lease/Title';
            OptionMembers = " ","Lease/Title";
        }
        field(6; "Document Withheld"; Boolean)
        {
        }
        field(7; "Date Withheld"; Date)
        {
        }
        field(8; "User Registered"; Text[50])
        {
        }
        field(9; "Date Released"; Date)
        {
        }
        field(10; "User Relased"; Text[50])
        {
        }
        field(11; "Withheld Document No"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

