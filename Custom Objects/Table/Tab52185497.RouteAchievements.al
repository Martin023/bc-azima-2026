table 52185497 "Route Achievements"
{
    Caption = 'Route Achievements';
    DataClassification = ToBeClassified;

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
        field(3; Description; Text[1000])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Header No", No)
        {
            Clustered = true;
        }
    }
}
