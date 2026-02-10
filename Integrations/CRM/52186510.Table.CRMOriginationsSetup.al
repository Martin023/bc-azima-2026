table 52186510 "CRM Originations Setup"
{
    Caption = 'CRM Originations Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CRM Origination"; Enum "CRM Originations")
        {
            Caption = 'CRM Origination';
            DataClassification = ToBeClassified;
        }
        field(2; "Landing Department"; Text[50])
        {
            Caption = 'Landing Department';
            // TableRelation = "Dimension Value".Code where("Dimension Code" = Const('ACTIVITY'));
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(3; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Modified By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Modified At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "CRM Origination")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created At" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified At" := CurrentDateTime;
    end;
}

enum 52186517 "CRM Originations"
{
    value(0; "Member Application") { }
    value(1; "Member Readmission") { }
    value(2; "Member Edit") { }
    value(3; "Loan Application") { }
    value(4; "Member Withdrawal") { }
    value(5; "BBF Claim") { }
    value(6; "Loan Guarantor Substitution") { }
    value(7; "Sub Account") { }
    value(8; "Loan Variation") { }
    value(9; "Deposit Variation") { }
    value(10; "Share Transfer") { }
    value(11; "Nominee") { }
    value(12; "BBF Claim - Principle") { }
    value(13; "BBF Claim - Dependant") { }
    value(14; "BBF Claim - Risk") { }
    value(15; "BBF Claim - Insurance") { }
    value(16; "Member Withdrawal - 1st Partial") { }
    value(17; "Member Withdrawal - 2nd Partial") { }
    value(19; "CRM Cases") { }
    value(20; "CRM Parcels") { }
    value(21; "Business Loans Application") { }
    value(22; "M-Hela Whitelist Application") { }
}
