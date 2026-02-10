table 52186500 "CRM API Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Get Token Name"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("Get Token Name");
            end;
        }
        field(3; "App ID"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("App ID");
            end;
        }
        field(4; "Base URL"; Text[100])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Base URL");
            end;
        }
        field(5; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Inactive;
        }

        field(6; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Modified By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Modified At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
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