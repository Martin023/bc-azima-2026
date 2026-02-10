table 52186271 "BBF/Nominee Register"
{
    Caption = 'BBF/Nominee Register';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "StartDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Nominee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Identification Type"; Enum "Identification Type")
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Identification Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Relationship"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Date Captured"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Deceased"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}