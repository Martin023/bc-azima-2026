table 52185632 "Marketing Teams Header"
{
    Caption = 'Marketing Teams Header';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Marketing Teams Header";

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Name; Text[2048])
        {
            Caption = 'Name';
        }
        field(3; "Type"; Text[2048])
        {
            Caption = 'Type';
        }
        field(4; "No. of Members"; Decimal)
        {
            Caption = 'No. of Members';
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
