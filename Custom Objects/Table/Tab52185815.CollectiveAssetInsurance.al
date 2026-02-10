table 52185815 "Collective Asset Insurance"
{
    Caption = 'Collective Asset Insurance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Insurance No."; Code[50])
        {
            Caption = 'Insurance No.';
        }
        field(2; "Asset No."; Code[50])
        {
            Caption = 'Asset No.';
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FA.reset;
                FA.SetRange("No.", Rec."Asset No.");
                if FA.Find('-') then
                    Rec."Description" := FA.Description;
                //Rec."Book Value" := FA."Book Value";
                FADepreciationBook.RESET;
                FADepreciationBook.SetRange(FADepreciationBook."FA No.", Rec."Asset No.");
                if FADepreciationBook.FindFirst() then begin
                    FADepreciationBook.CALCFIELDS(FADepreciationBook."Book Value");
                    Rec."Book Value" := FADepreciationBook."Book Value";
                    Rec."FA Location Code" := FA."FA Location Code";
                    Rec."FA Subclass Code" := FA."FA Subclass Code";
                    Rec."FA Class Code" := FA."FA Class Code";
                end

                else
                    Error('Asset No. does not exist');

            end;
        }
        field(3; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(4; "Insurance Type"; Text[200])
        {
            Caption = 'Insurance Type';
        }
        field(5; "Book Value"; Decimal)
        {
            Caption = 'Book Value';
        }
        field(6; "FA Location Code"; Code[20])
        {
            Caption = 'FA Location Code';
        }
        field(7; "FA Subclass Code"; Code[20])
        {
            Caption = 'FA Subclass Code';
        }
        field(8; "FA Class Code"; Code[20])
        {
            Caption = 'FA Class Code';
        }
        field(9; "Insured"; Boolean)
        {
            Caption = 'Insured';
        }
    }
    keys
    {
        key(PK; "Insurance No.", "Asset No.")
        {
            Clustered = true;
        }
    }
    var
        FA: Record "Fixed Asset";
        FADepreciationBook: Record "FA Depreciation Book";
}
