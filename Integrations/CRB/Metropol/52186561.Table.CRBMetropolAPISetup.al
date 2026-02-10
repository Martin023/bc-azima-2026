table 52186561 "CRB Metropol API Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Public Key"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("Public Key");
            end;
        }
        field(3; "Private Key"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("Private Key");
            end;
        }
        field(12; "Public Key - DS"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("Public Key - DS");
            end;
        }
        field(13; "Private Key - DS"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("Private Key - DS");
            end;
        }
        field(4; "API Version"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("API Version");
            end;
        }
        field(14; "API Version - DS"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("API Version - DS");
            end;
        }
        field(5; "Base URL"; Text[250])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Base URL");
            end;
        }
        field(15; "Base URL - DS"; Text[250])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Base URL - DS");
            end;
        }
        field(6; "Port"; Integer)
        {
            trigger OnValidate()
            begin
                Rec.TestField("Port");
            end;
        }
        field(16; "Port - DS"; Integer)
        {
            trigger OnValidate()
            begin
                Rec.TestField("Port - DS");
            end;
        }
        field(100; "The Proxy"; Text[100])
        {
            trigger OnValidate()
            begin
                // Rec.TestField("The Proxy");
            end;
        }
        field(7; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Inactive;
        }
        field(8; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Modified By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Modified At"; DateTime)
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