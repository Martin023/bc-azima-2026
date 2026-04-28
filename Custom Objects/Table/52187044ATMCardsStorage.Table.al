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
            Editable = true;
            trigger OnValidate()
            begin
                if not Linked then begin
                    "Card Status" := "Card Status"::Frozen;
                    "Delinked On" := Today();
                    "Delinked By" := UserId();
                end;
            end;
        }
        field(5; "Card Status"; Option)
        {
            OptionMembers = Pending,Active,Frozen;
            OptionCaption = 'Pending,Active,Delinked';
            FieldClass = FlowField;
            CalcFormula = lookup("ATM Linking Applications"."Card Status" where("Card No" = field("Card Number")));
        }
        field(6; "Delinked On"; Date)
        {
            Caption = 'Delinked On';
            Editable = true;
        }
        field(7; "Delinked By"; Code[50])
        {
            Caption = 'Delinked By';
            Editable = false;
        }
        field(8; Reason; Text[100])
        {
            Caption = 'Remarks';
            Editable = true;
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