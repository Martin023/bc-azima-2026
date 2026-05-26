table 52185486 "Sales Route Plans"
{
    Caption = 'Sales Route Plans';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Sales Routes Plan List";

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Desription; Text[1000])
        {
            Caption = 'Desription';
        }
        field(3; "Place to visit"; Code[50])
        {
            Caption = 'Place to visit';
        }
        field(4; Achievements; Integer)
        {
            Caption = 'Achievements';
        }
        field(5; Leads; Decimal)
        {
            Caption = 'Leads';
        }
        field(6; Status; Option)
        {
            OptionMembers = Active,Closed;
            Caption = 'Status';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
