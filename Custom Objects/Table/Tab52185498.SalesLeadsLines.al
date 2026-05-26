table 52185498 "Sales Leads Lines"
{
    Caption = 'Sales Leads Lines';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Sales Leads Lines";

    fields
    {
        field(1; "Header No"; Code[20])
        {
            Caption = 'Header No';
        }
        field(2; No; Integer)
        {
            Caption = 'No';
        }
        field(3; Name; Text[1000])
        {
            Caption = 'Name';
        }
        field(4; "ID No"; Code[20])
        {
            Caption = 'ID No';
        }
        field(5; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
        }
        field(6; "Lead Status"; Option)
        {
            OptionMembers = New,Contacted,Qualified,Lost;
            Caption = 'Lead Status';
        }
    }
    keys
    {
        key(PK; "Header No", "ID No")
        {
            Clustered = true;
        }
    }
}
