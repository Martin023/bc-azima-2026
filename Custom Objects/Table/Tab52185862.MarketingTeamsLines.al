table 52185862 "Marketing Teams Lines"
{
    Caption = 'Marketing Teams Lines';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
        }
        field(3; "Member Name"; Text[2048])
        {
            Caption = 'Member Name';
        }
        field(4; Designation; Text[2048])
        {
            Caption = 'Designatiom';
        }
        field(5; Location; Text[2048])
        {
            Caption = 'Location';
        }
       field(6;Branch)
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
