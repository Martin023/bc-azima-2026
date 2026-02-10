table 52186513 "M-Smart API Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Base URL"; Text[100])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Base URL");
            end;
        }
        field(3; "Auth User"; Text[50])
        {
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                Rec.TestField("Auth User");
            end;
        }
        field(4; "Auth Pass"; Text[50])
        {
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                Rec.TestField("Auth Pass");
            end;
        }
        field(5; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Inactive;
        }

        field(13; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Modified By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Modified At"; DateTime)
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