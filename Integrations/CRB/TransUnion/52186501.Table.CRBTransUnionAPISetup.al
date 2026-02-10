table 52186501 "CRB Trans Union API Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Username; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField(Username);
            end;
        }
        field(12; "WS - Username"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("WS - Username");
            end;
        }
        field(22; "WS - Basic Username"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("WS - Basic Username");
            end;
        }
        field(3; Password; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField(Password);
            end;
        }
        field(13; "WS - Password"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("WS - Password");
            end;
        }
        field(23; "WS - Basic Password"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("WS - Basic Password");
            end;
        }
        field(4; "Infinity Code"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("Infinity Code");
            end;
        }
        field(14; "WS - Infinity Code"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("WS - Infinity Code");
            end;
        }
        field(24; "WS - Code"; Text[100])
        {
            ExtendedDatatype = Masked;

            trigger OnValidate()
            begin
                Rec.TestField("WS - Code");
            end;
        }
        field(5; "Base URL"; Text[100])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Base URL");
            end;
        }
        field(15; "WS - URL"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestField("WS - URL");
            end;
        }
        field(16; "WS - XML NS"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestField("WS - XML NS");
            end;
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
        field(10; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Inactive;
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