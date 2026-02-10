table 52186278 "IPRS API Setup"
{
    Caption = 'IPRS API Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Base URL"; Text[250])
        {
            trigger OnValidate()
            begin
                Rec.TestField("Base URL");
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
