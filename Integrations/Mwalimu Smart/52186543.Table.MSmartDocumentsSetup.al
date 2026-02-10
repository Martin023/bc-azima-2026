table 52186543 "M-Smart Documents Setup"
{
    Caption = 'M-Smart Documents Setup';
    DataClassification = SystemMetadata;
    DataPerCompany = false;

    fields
    {
        field(1; "Document Type"; Enum "M-Smart Documents")
        {
            Caption = 'Document Type';
        }
        field(2; "Landing Department"; Enum "Responsibility Center Enum")
        {
            Caption = 'Landing Department';
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(5; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Modified At"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type")
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
