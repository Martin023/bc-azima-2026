table 52185606 "HR Perspectives Setup"
{
    Caption = 'HR Perspectives Setup';
    DataClassification = CustomerContent;
    LookupPageId = "HR Perspective Setup List";
    DrillDownPageId = "HR Perspective Setup List";

    fields
    {
        field(1; "Perspective No"; Integer)
        {
            Caption = 'Perspective No';
            AutoIncrement = true;
        }
        field(2; "Perspective Name"; Text[100])
        {
            Caption = 'Perspective Name';
            NotBlank = true;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Scoring Method"; Option)
        {
            Caption = 'Scoring Method';
            OptionCaption = 'Standard (Higher is Better),Inverted (Lower is Better)';
            OptionMembers = Standard,Inverted;
            
            trigger OnValidate()
            begin
                if "Scoring Method" = "Scoring Method"::Inverted then begin
                    if "Result Label" = '' then
                        "Result Label" := 'Actual Result';
                end;
            end;
        }
        field(5; "Result Label"; Text[50])
        {
            Caption = 'Result Label';
        }
        field(6; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; "Perspective No")
        {
            Clustered = true;
        }
        key(Key2; "Perspective Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Perspective No", "Perspective Name", "Scoring Method")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Result Label" = '' then begin
            if "Scoring Method" = "Scoring Method"::Inverted then
                "Result Label" := 'Actual Result'
            else
                "Result Label" := 'Achieved';
        end;
    end;
}

