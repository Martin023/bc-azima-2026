table 52185505 "Mobile Transaction Types"
{
    Caption = 'Mobile/ATM Transaction Types';
    DataClassification = ToBeClassified;
    LookupPageID = "Mobile Transaction types List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; enum "Sky M-Banking Trans Types")
        {
            Caption = 'M-Banking Transaction Type';
        }

        field(14; "Upper Limit"; Decimal)
        {
        }
        field(15; "Channel type"; Option)
        {
            OptionMembers = Mobile,ATM,Agency,Portal,"Internet Banking";
            OptionCaption = 'Mobile,ATM,Agency,Portal,Internet Banking';
        }
        field(21; "ATM Transaction Type"; Enum "ATM Transaction Types")
        {
            Caption = 'ATM Transaction Type';
        }
        field(4; "Bank Account"; code[50])
        {
            TableRelation = "Bank Account";
        }
        field(5; "Loan Int. Vendor Account No."; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Loan Interest Vendor Account No.';
            trigger OnValidate()
            begin
                Rec.TestField(Type, Rec.Type::"Loan Disbursement");
            end;
        }
        field(100; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(101; "Updated By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        // Secondary keys for non-primary fields
        key(IdxChannelType; "Channel type")
        {
            Clustered = false;
        }

        key(IdxType; "Type")
        {
            Clustered = false;
        }

        // Composite keys for efficient queries involving multiple fields
        key(IdxChannelTypeType; "Channel type", "Type")
        {
            Clustered = false;
        }

        key(IdxChannelTypeCode; "Channel type", "Code")
        {
            Clustered = false;
        }

        key(IdxTypeCode; "Type", "Code")
        {
            Clustered = false;
        }

        key(IdxChannelTypeTypeCode; "Channel type", "Type", "Code")
        {
            Clustered = false;
        }
    }
    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Updated By" := UserId;
    end;

    trigger OnModify()
    begin
        "Updated By" := UserId;
    end;
}
