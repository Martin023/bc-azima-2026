table 52186511 "Satellite Branches Setup"
{
    Caption = 'Satellite Branches Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Satellite Branch Code"; Code[20])
        {
            Caption = 'Satellite Branch Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));

            trigger OnValidate()
            var
                theBranch: Record "Dimension Value";
            begin
                theBranch.Reset;

                theBranch.SetRange(Code, Rec."Satellite Branch Code");

                if theBranch.FindFirst then begin
                    Rec."Satellite Branch" := theBranch.Name;
                end;
            end;
        }
        field(2; "Satellite Branch"; Text[50])
        {
            Caption = 'Satellite Branch';
            Editable = false;
        }
        field(3; "Main Branch Code"; Code[20])
        {
            Caption = 'Main Branch Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));

            trigger OnValidate()
            var
                theBranch: Record "Dimension Value";
            begin
                if Rec."Satellite Branch Code" = Rec."Main Branch Code" then begin
                    Error('Satellite branch code and main branch code must be different');
                end;

                theBranch.Reset;

                theBranch.SetRange(Code, Rec."Main Branch Code");

                if theBranch.FindFirst then begin
                    Rec."Main Branch" := theBranch.Name;
                end;
            end;
        }
        field(4; "Main Branch"; Text[50])
        {
            Caption = 'Main Branch';
            Editable = false;
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(6; "Updated By"; Code[50])
        {
            Caption = 'Updated By';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Satellite Branch Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Rec.TestField("Satellite Branch Code");
        Rec.TestField("Main Branch Code");

        "Created By" := UserId;
        "Updated By" := UserId;
    end;
}
