table 52187044 "ATM Card Storage"
{
    Caption = 'ATM Card Storage';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Atm Card";

    fields
    {
        field(1; "Account No."; Code[50])
        {
            Caption = 'Account No.';
            Editable = false;
        }
        field(2; "Card Number"; Code[50])
        {
            Caption = 'Card Number';
            Editable = false;
        }

        field(3; "Member Name"; Text[50])
        {
            Caption = 'Member Name';
            Editable = false;
        }
        field(4; Linked; Boolean)
        {
            Caption = 'Linked';
            Editable = false;
        }
        field(5; DeLinked; Boolean)
        {
            Caption = 'DeLinked';
            Editable = false;
        }

    }
    keys
    {
        key(Key1; "Account No.", "Card Number")
        {
            Clustered = true;
        }
        key(IdxCardNumber; "Card Number")
        {
            Clustered = false;
        }
        key(IdxLinked; Linked)
        {
            Clustered = false;
        }
    }
}