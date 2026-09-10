table 52185981 "SMS Template Token Usage"
{
    Caption = 'SMS Template Token Usage';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            DataClassification = SystemMetadata;
            TableRelation = "Global SMS Template"."Event Code";
        }

        field(2; Token; Code[50])
        {
            Caption = 'Token';
            DataClassification = SystemMetadata;
            TableRelation = "Global SMS Token Registry".Token;
        }

        field(3; "Auto Detected"; Boolean)
        {
            Caption = 'Auto Detected';
            DataClassification = SystemMetadata;
            InitValue = true;
        }

        field(4; "Token Description"; Text[100])
        {
            Caption = 'Token Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Global SMS Token Registry".Description where(Token = field(Token)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Event Code", Token)
        {
            Clustered = true;
        }
        key(Token; Token)
        {
        }
    }
}
