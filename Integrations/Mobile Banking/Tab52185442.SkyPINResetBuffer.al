table 52185442 "Sky PIN Reset Buffer"
{
    Caption = 'Sky PIN Reset Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Savings Account No."; Code[100])
        {
            Caption = 'Savings Account No.';
            TableRelation = "Savings Accounts"."No.";
            Editable = false;
        }
        field(3; "SMP Reference"; Text[100])
        {
            Caption = 'SMP Reference';
            Editable = false;
        }
        field(4; "Is Processed?"; Boolean)
        {
            Caption = 'Is Processed?';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

