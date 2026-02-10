table 52186504 "EDMS API Setup"
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
        field(3; "Source IP"; Text[20])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Source IP");
            end;
        }
        field(4; "Encrypt Key"; Text[50])
        {
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                Rec.TestField("Encrypt Key");
            end;
        }
        field(5; "Username"; Text[50])
        {
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                Rec.TestField("Username");
            end;
        }
        field(6; "Passcode"; Text[50])
        {
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                Rec.TestField("Passcode");
            end;
        }
        field(7; "Status"; Option)
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

        field(20; "Web API POST URL"; Text[100])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Web API POST URL");
            end;
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